# Decentralized Human Resources Talent Verification Network

A blockchain-based system for transparent and immutable verification of employer credentials, employee skills, performance tracking, and background checks using Clarity smart contracts on the Stacks blockchain.

## Overview

This decentralized HR system provides a trustless platform for:
- Employer organization verification
- Employee credential validation
- Background check management
- Performance tracking and reviews
- Skills assessment and certification

## Smart Contracts

### 1. Employer Verification Contract (`employer-verification.clar`)
Manages the registration and verification of employer organizations.

**Key Features:**
- Register new employers with industry classification
- Verify employer legitimacy by authorized verifiers
- Query employer verification status
- Immutable verification records

**Main Functions:**
- `register-employer`: Register a new employer organization
- `verify-employer`: Verify an employer (admin only)
- `get-employer`: Retrieve employer details
- `is-employer-verified`: Check verification status

### 2. Credential Verification Contract (`credential-verification.clar`)
Handles employee educational and professional credentials.

**Key Features:**
- Add employee credentials with institution details
- Verify credentials through authorized verifiers
- Support for credential expiration dates
- Validation of credential authenticity

**Main Functions:**
- `add-credential`: Add new employee credential
- `verify-credential`: Verify credential authenticity
- `get-credential`: Retrieve credential details
- `is-credential-valid`: Check if credential is valid and not expired

### 3. Background Check Contract (`background-check.clar`)
Manages employee background verification processes.

**Key Features:**
- Initiate various types of background checks
- Track check status and completion
- Secure notes and findings storage
- Authorized checker system

**Main Functions:**
- `initiate-background-check`: Start a new background check
- `complete-background-check`: Complete check with results
- `get-background-check`: Retrieve check details
- `get-check-status`: Get current status of a check

### 4. Performance Tracking Contract (`performance-tracking.clar`)
Tracks employee performance metrics and reviews.

**Key Features:**
- Submit comprehensive performance reviews
- Multi-dimensional scoring (1-10 scale)
- Period-based performance tracking
- Reviewer attribution and comments

**Main Functions:**
- `submit-performance-review`: Submit a new performance review
- `get-performance-review`: Retrieve review details
- `calculate-average-score`: Calculate average performance scores

**Scoring Categories:**
- Overall Score (1-10)
- Goals Met (1-10)
- Communication Score (1-10)
- Technical Score (1-10)

### 5. Skills Assessment Contract (`skills-assessment.clar`)
Manages employee skills verification and proficiency tracking.

**Key Features:**
- Record skill assessments with proficiency levels
- Support for certification bodies
- Skill currency tracking with expiration dates
- Proficiency level updates

**Main Functions:**
- `record-skill-assessment`: Record new skill assessment
- `update-skill-level`: Update proficiency level
- `get-skill-assessment`: Retrieve assessment details
- `is-skill-current`: Check if skill assessment is current

**Proficiency Levels:**
- 1: Beginner
- 2: Novice
- 3: Intermediate
- 4: Advanced
- 5: Expert

## Error Codes

Each contract uses specific error code ranges:
- **100-199**: Employer Verification errors
- **200-299**: Credential Verification errors
- **300-399**: Background Check errors
- **400-499**: Performance Tracking errors
- **500-599**: Skills Assessment errors

## Testing

The project includes comprehensive test suites using Vitest:

\`\`\`bash
npm test
\`\`\`

Test files cover:
- Contract function validation
- Error handling
- Data integrity
- Authorization checks

## Deployment

### Prerequisites
- Stacks CLI installed
- Testnet STX tokens for deployment
- Clarinet for local development

### Local Development
\`\`\`bash
clarinet console
\`\`\`

### Testnet Deployment
\`\`\`bash
stx deploy_contract employer-verification contracts/employer-verification.clar --testnet
stx deploy_contract credential-verification contracts/credential-verification.clar --testnet
stx deploy_contract background-check contracts/background-check.clar --testnet
stx deploy_contract performance-tracking contracts/performance-tracking.clar --testnet
stx deploy_contract skills-assessment contracts/skills-assessment.clar --testnet
\`\`\`

## Usage Examples

### Register an Employer
\`\`\`clarity
(contract-call? .employer-verification register-employer "Tech Corp" "Technology")
\`\`\`

### Add Employee Credential
\`\`\`clarity
(contract-call? .credential-verification add-credential
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
"Bachelor of Science"
"MIT"
(some u1000))
\`\`\`

### Submit Performance Review
\`\`\`clarity
(contract-call? .performance-tracking submit-performance-review
'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5
u100 u200 u8 u9 u7 u8
"Excellent performance this quarter")
\`\`\`

## Security Considerations

- All verification functions require proper authorization
- Immutable records prevent tampering
- Time-based validation for expiring credentials
- Role-based access control for sensitive operations

## Future Enhancements

- Integration with external verification APIs
- Multi-signature verification requirements
- Reputation scoring algorithms
- Cross-chain credential portability
- Privacy-preserving verification methods

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add comprehensive tests
4. Submit a pull request

## License

MIT License - see LICENSE file for details
