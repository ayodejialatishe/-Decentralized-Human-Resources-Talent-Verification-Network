;; Credential Verification Contract
;; Manages verification of employee credentials

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u200))
(define-constant ERR_CREDENTIAL_EXISTS (err u201))
(define-constant ERR_CREDENTIAL_NOT_FOUND (err u202))

;; Data structures
(define-map credentials
  { credential-id: uint }
  {
    employee: principal,
    credential-type: (string-ascii 50),
    institution: (string-ascii 100),
    verified: bool,
    verifier: principal,
    issue-date: uint,
    expiry-date: (optional uint)
  }
)

(define-data-var next-credential-id uint u1)

;; Public functions
(define-public (add-credential
  (employee principal)
  (credential-type (string-ascii 50))
  (institution (string-ascii 100))
  (expiry-date (optional uint))
)
  (let ((credential-id (var-get next-credential-id)))
    (map-set credentials
      { credential-id: credential-id }
      {
        employee: employee,
        credential-type: credential-type,
        institution: institution,
        verified: false,
        verifier: tx-sender,
        issue-date: block-height,
        expiry-date: expiry-date
      }
    )
    (var-set next-credential-id (+ credential-id u1))
    (ok credential-id)
  )
)

(define-public (verify-credential (credential-id uint))
  (let ((credential (unwrap! (map-get? credentials { credential-id: credential-id }) ERR_CREDENTIAL_NOT_FOUND)))
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_NOT_AUTHORIZED)
    (map-set credentials
      { credential-id: credential-id }
      (merge credential { verified: true })
    )
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-credential (credential-id uint))
  (map-get? credentials { credential-id: credential-id })
)

(define-read-only (is-credential-valid (credential-id uint))
  (match (map-get? credentials { credential-id: credential-id })
    credential
    (and
      (get verified credential)
      (match (get expiry-date credential)
        expiry (> expiry block-height)
        true
      )
    )
    false
  )
)
