# DHCP Configuration

## 1. Overview

DHCP Server role was installed on DC01 and authorized within Active Directory, following the standard requirement that any DHCP server in an AD environment must be authorized before it will lease addresses.

| Item | Value |
|---|---|
| DHCP Server | DC01 (192.168.10.10) |
| Authorization status | Authorized in adlab.local |
| Scope name | LAN-Clients-Scope |

## 2. Scope Configuration

| Setting | Value |
|---|---|
| Start IP | 192.168.10.100 |
| End IP | 192.168.10.150 |
| Subnet mask | 255.255.255.0 |
| Lease duration | 8 days (default) |
| Exclusions | None (server's static address, .10, falls outside this range by design) |
| Scope status | Active |

## 3. Scope Options Distributed

| Option Code | Option | Value |
|---|---|---|
| 003 | Router (Default Gateway) | Not configured — no gateway exists in this isolated network |
| 006 | DNS Servers | 192.168.10.10 |
| 015 | DNS Domain Name | adlab.local |

**Design rationale for the address range:** the DHCP pool (192.168.10.100–150) is intentionally kept well away from the server's static address (192.168.10.10) to eliminate any possibility of address conflict, without needing explicit exclusion ranges.

## 4. Validation

| Test | Run From | Result |
|---|---|---|
| `ipconfig /release` + `ipconfig /renew` | CLIENT01 | Successful lease obtained |
| `ipconfig /all` | CLIENT01 | IPv4 address in 192.168.10.100–150 range; Subnet Mask 255.255.255.0; DNS Server 192.168.10.10; DHCP Server 192.168.10.10 |

This confirms DHCP is functioning correctly with a real external client device, not just internally on the server.
