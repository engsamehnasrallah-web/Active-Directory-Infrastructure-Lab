# Roadmap

**v1.0.0 released:** the core infrastructure — network, AD DS, DNS, DHCP, OUs/users/groups, client and member server domain join, Group Policy, IIS, and a validated security baseline — is complete, tested, and documented. Remaining work (additional troubleshooting scenarios, further hardening) is tracked below for future releases.

This roadmap tracks the project's phases from initial network design through to a portfolio-ready GitHub repository. Completed phases are checked off; each links to its corresponding documentation.

## Phases

- [x] **Phase 0 — Lab Architecture & VMware Networking**
  Host-only network design (192.168.10.0/24), IP addressing plan. See [`docs/02-network-design.md`](./docs/02-network-design.md).

- [x] **Phase 1 — Windows Server Foundation**
  DC01 built, static IP, Administrator password set. See [`docs/01-architecture.md`](./docs/01-architecture.md).

- [x] **Phase 2 — Active Directory Domain Services**
  Forest/domain `adlab.local` created, validated with `dcdiag`. See [`docs/03-active-directory.md`](./docs/03-active-directory.md).

- [x] **Phase 3 — DNS**
  Forward and reverse lookup zones configured. See [`docs/04-dns.md`](./docs/04-dns.md).

- [x] **Phase 4 — DHCP**
  Authorized, scoped, validated against a real client. See [`docs/05-dhcp.md`](./docs/05-dhcp.md).

- [x] **Phase 5 — OU / Users / Groups**
  Hybrid OU structure, 6 users, 4 security groups. See [`docs/03-active-directory.md`](./docs/03-active-directory.md).

- [x] **Phase 6 — Windows Client Domain Join**
  CLIENT01 joined and validated with a domain user login.

- [x] **Phase 7 — Group Policy**
  `Sales-Restrict-ControlPanel`, validated with positive and negative tests. See [`docs/06-group-policy.md`](./docs/06-group-policy.md).

- [x] **Phase 8 — IIS**
  Dedicated member server (WEB01), validated by IP and DNS name. See [`docs/07-iis.md`](./docs/07-iis.md).

- [x] **Phase 9 — Security Baseline**
  Password/lockout policy and IIS IP restriction, both validated. See [`docs/08-security.md`](./docs/08-security.md).

- [x] **Phase 10 — Testing & Validation**
  Consolidated summary of every test performed. See [`docs/10-testing.md`](./docs/10-testing.md).

- [ ] **Phase 11 — Troubleshooting Scenarios**
  Scenario 1 (DNS misconfiguration) complete. See [`docs/09-troubleshooting.md`](./docs/09-troubleshooting.md). Additional scenarios (DHCP failure, GPO not applying, IIS access issues) planned.

- [x] **Phase 12 — Documentation**
  Core docs complete, including a visual architecture diagram (`diagrams/architecture-diagram.svg`) and key validation screenshots embedded across the relevant docs.

- [ ] **Phase 13 — GitHub Repository**
  README, LICENSE, CHANGELOG, ROADMAP in place; final structure review pending.

- [x] **Phase 14 — Final Review / Portfolio Readiness**
  Definition of Done reviewed; `v1.0.0` released with the core infrastructure complete. Additional troubleshooting scenarios remain open for future releases.

## Definition of Done

- [x] VMware network documented
- [x] Server network configuration documented
- [x] AD DS works
- [x] DNS works
- [x] DHCP works
- [x] OUs are organized
- [x] Users/groups are configured
- [x] Client is domain joined
- [x] Domain authentication works
- [x] GPOs work
- [x] IIS works
- [x] IP/domain restrictions work
- [x] Security baseline is applied and validated
- [x] Connectivity tests pass
- [x] AD/DNS/DHCP/GPO tests pass
- [ ] Troubleshooting scenarios completed (1 of several planned)
- [x] Documentation completed
- [x] Architecture diagram completed
- [x] GitHub repository organized
- [x] README completed
- [x] Changelog completed
- [x] Security documentation completed
- [ ] Final project review completed
