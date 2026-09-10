# Changelog

All notable changes to this project are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) principles, adapted for a lab/infrastructure project rather than a software package.

## [Unreleased]

Future work: additional troubleshooting scenarios (DHCP failure, GPO not applying, IIS access issues), further security hardening.

## [1.0.0] - 2026-09-11

### Added
- Isolated VMware Host-only network (VMnet2, 192.168.10.0/24) designed before any service installation
- Domain Controller (DC01) with static IP, AD DS, and DNS (domain: adlab.local)
- DNS reverse lookup zone (10.168.192.in-addr.arpa)
- DHCP server role, authorized in AD, with scoped address pool (192.168.10.100–150)
- Hybrid OU structure: per-department (IT, HR, Sales) Users/Computers OUs, plus a domain-wide Groups OU
- 6 domain users across 3 departments
- 4 security groups (IT-Staff, HR-Staff, Sales-Staff, All-Employees)
- Domain-joined Windows client (CLIENT01)
- Group Policy `Sales-Restrict-ControlPanel`, linked to Sales/Users, validated with positive and negative tests
- Second domain-joined Member Server (WEB01) running IIS
- Domain-wide Password Policy and Account Lockout Policy (Default Domain Policy)
- IIS IP-based access restriction on WEB01's Default Web Site, validated with allowed and denied requests
- Troubleshooting Scenario 1: DNS misconfiguration diagnosis and resolution
- Full documentation set under `docs/` (architecture, network design, AD DS, DNS, DHCP, GPO, IIS, security baseline, testing summary, troubleshooting)
- Visual network architecture diagram (`diagrams/architecture-diagram.svg`), embedded in the README and referenced from the architecture doc
- Validation screenshots (GPO restriction, IIS access/403, account lockout) embedded across `docs/06-group-policy.md`, `docs/07-iis.md`, and `docs/08-security.md`
- PowerShell reporting scripts (`scripts/export-dcdiag-report.ps1`, `scripts/export-gpresult-report.ps1`)
- Project README, LICENSE (MIT), SECURITY.md (scoped for a learning-lab repository)

### Changed
- Domain name finalized as `adlab.local` (initially planned as `TechTitans.local`)

## Notes

This is the first tagged release (`v1.0.0`) of the project: the full core infrastructure is built, secured, tested, and documented. Additional troubleshooting scenarios and further hardening will follow in future releases, tracked in [`ROADMAP.md`](./ROADMAP.md).
