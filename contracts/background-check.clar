;; Background Check Contract
;; Manages employee background verification

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u300))
(define-constant ERR_CHECK_EXISTS (err u301))
(define-constant ERR_CHECK_NOT_FOUND (err u302))

;; Data structures
(define-map background-checks
  { check-id: uint }
  {
    employee: principal,
    check-type: (string-ascii 50),
    status: (string-ascii 20),
    conducted-by: principal,
    completion-date: uint,
    notes: (string-ascii 500)
  }
)

(define-data-var next-check-id uint u1)

;; Public functions
(define-public (initiate-background-check
  (employee principal)
  (check-type (string-ascii 50))
)
  (let ((check-id (var-get next-check-id)))
    (map-set background-checks
      { check-id: check-id }
      {
        employee: employee,
        check-type: check-type,
        status: "pending",
        conducted-by: tx-sender,
        completion-date: block-height,
        notes: ""
      }
    )
    (var-set next-check-id (+ check-id u1))
    (ok check-id)
  )
)

(define-public (complete-background-check
  (check-id uint)
  (status (string-ascii 20))
  (notes (string-ascii 500))
)
  (let ((check (unwrap! (map-get? background-checks { check-id: check-id }) ERR_CHECK_NOT_FOUND)))
    (asserts! (is-eq tx-sender (get conducted-by check)) ERR_NOT_AUTHORIZED)
    (map-set background-checks
      { check-id: check-id }
      (merge check {
        status: status,
        completion-date: block-height,
        notes: notes
      })
    )
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-background-check (check-id uint))
  (map-get? background-checks { check-id: check-id })
)

(define-read-only (get-check-status (check-id uint))
  (match (map-get? background-checks { check-id: check-id })
    check (get status check)
    "not-found"
  )
)
