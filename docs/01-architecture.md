# Architecture Overview — AD Infrastructure Lab

## 1. Project Summary

This lab simulates a small organization's core Windows Server infrastructure, built from scratch inside VMware Workstation using an isolated Host-only virtual network. The goal is to demonstrate practical, hands-on understanding of Active Directory Domain Services (AD DS), DNS, DHCP, and their interdependencies — not just isolated configuration steps.

The environment represents a small fictional company (**adlab**) with three departments: IT, HR, and Sales.

## 2. High-Level Components

| Component | Role | Status |
|---|---|---|
| DC01 | Domain Controller, DNS Server, DHCP Server | Completed |
| CLIENT01 | Domain-joined Windows client | Completed |
| VMnet2 (Host-only) | Isolated virtual network, 192.168.10.0/24 | Completed |

## 3. Design Principles Followed

- **Static addressing for infrastructure servers.** The Domain Controller must have a fixed, predictable IP, since DNS and AD DS both depend on it being reachable at a known address.
- **DNS is foundational to AD.** AD DS was installed with DNS integrated on the same server; no client is configured to use a public DNS resolver as primary.
- **DHCP is authorized and scoped deliberately**, distributing addresses from a dedicated pool that is intentionally separate from statically assigned infrastructure addresses.
- **Isolation by design.** The lab uses a VMware Host-only network, disconnected from the physical/home network, to avoid any interference with or from the real network.
- **Least-surprise naming.** All hostnames, domain names, and OU structures are decided *before* implementation to avoid rework (e.g., renaming a Domain Controller after AD DS is installed is disruptive and was avoided).

## 4. Environment Details

| Item | Value |
|---|---|
| Hypervisor | VMware Workstation |
| Windows Server ISO | 26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso |
| AD Domain (FQDN) | adlab.local |
| NetBIOS Domain Name | ADLAB |
| Domain Controller | DC01 |
| Client machine | CLIENT01 (Windows 10/11) |

## 5. Related Documents

- [Network Design](./02-network-design.md)
- [Active Directory Configuration](./03-active-directory.md)
- [DNS Configuration](./04-dns.md)
- [DHCP Configuration](./05-dhcp.md)

## 6. Lessons Learned So Far

- A `nslookup` reverse-lookup warning against `::1` (IPv6 loopback) is cosmetic and unrelated to the health of AD DS or forward DNS resolution — confirmed by successful forward queries.
- `dcdiag` warnings related to `time.windows.com` and SYSVOL replication immediately after promotion are expected in an isolated, single-DC environment with no internet access; they do not indicate a faulty AD DS installation.
