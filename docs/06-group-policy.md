# Group Policy (GPO)

## 1. Overview

Group Policy was used to demonstrate centralized management of domain-joined computers and users — specifically, restricting Control Panel access for a department, and validating that the restriction is scoped correctly (applies only where intended, and nowhere else).

## 2. GPO: Sales-Restrict-ControlPanel

| Item | Value |
|---|---|
| GPO Name | Sales-Restrict-ControlPanel |
| Linked to | `adlab.local/adlab/Sales/Users` (OU-level link, not domain-wide) |
| Setting | User Configuration → Administrative Templates → Control Panel → "Prohibit access to Control Panel and PC settings" = **Enabled** |

### Design Decision: Why Sales, Not IT

The first candidate considered for this test was the IT OU, since it was the most convenient to control. This was deliberately reconsidered: restricting Control Panel access for IT staff is not realistic, since they typically need full access to troubleshoot machines. The GPO was instead linked to `Sales/Users`, which reflects a realistic real-world scenario — restricting general end users while leaving technical staff unrestricted.

### Why Linked to `Sales/Users` and Not `Sales`

The OU structure separates `Users` from `Computers` within each department specifically so that user-targeted policies (like this one) don't unintentionally apply to computer objects, and vice versa. Linking at the `Users` sub-OU level keeps the policy's scope precise.

## 3. Validation

### Positive test (Sales user — policy should apply)

| Step | Result |
|---|---|
| `gpupdate /force` on CLIENT01 | Completed successfully (both Computer and User policy) |
| Logged in as a Sales user (`ytarek`/`nsamir`) | Control Panel access blocked with: *"This operation has been cancelled due to restrictions in effect on this computer. Please contact your system administrator."* |
| `gpresult /r` | `Sales-Restrict-ControlPanel` listed under Applied Group Policy Objects |

### Negative test (IT user — policy should NOT apply)

| Step | Result |
|---|---|
| Logged in as an IT user (`ohassan`) | Control Panel opened normally, no restriction |
| `gpresult /r` | Applied Group Policy Objects: **N/A** — confirms no unintended policy leakage to other OUs |

**Conclusion:** the GPO's scope was validated in both directions — it correctly restricts its intended target and does not affect any other part of the domain. This two-sided validation (positive + negative test) is what confirms the GPO linking and OU design are both working as intended, not just that a restriction happens to be active somewhere.

## 4. Next Steps

Additional GPOs (e.g., password/account policies, desktop restrictions for other departments) will be added under Phase 9 (Security Baseline) and documented separately.
