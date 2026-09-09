# Network Design

## 1. VMware Virtual Network

| Setting | Value |
|---|---|
| Network name | VMnet2 |
| Type | Host-only |
| Subnet | 192.168.10.0/24 |
| Subnet mask | 255.255.255.0 |
| VMware DHCP service | **Disabled** (intentional — DHCP is provided by DC01, not by VMware) |
| Internet access | None (isolated by design) |

**Why Host-only instead of NAT/Bridged:** the lab is intentionally isolated from the physical/home network. This avoids any risk of the lab's internal DHCP or DNS interfering with real devices, and keeps the addressing scheme fully predictable and self-contained.

## 2. IP Addressing Plan

| Device | IP Address | Assignment | Role |
|---|---|---|---|
| DC01 | 192.168.10.10 | Static | Domain Controller / DNS / DHCP |
| CLIENT01 | 192.168.10.100–150 (DHCP pool) | Dynamic | Domain-joined client |
| DHCP Scope | 192.168.10.100 – 192.168.10.150 | Dynamic pool | Reserved for clients |

The DHCP pool is deliberately kept separate from the server's static address to avoid any possibility of address conflict.

## 3. DHCP Scope Options Distributed to Clients

| Option | Value |
|---|---|
| 003 Router (Default Gateway) | *Not configured* — no gateway exists in this isolated Host-only network |
| 006 DNS Servers | 192.168.10.10 |
| 015 DNS Domain Name | adlab.local |
| Lease Duration | 8 days (default) |

## 4. Connectivity Validation

| Test | From | To | Result |
|---|---|---|---|
| `ping 192.168.10.10` | CLIENT01 | DC01 | 4/4 packets received, 0% loss |
| `nslookup adlab.local` | CLIENT01 | DC01 | Resolved to 192.168.10.10 |
| `ipconfig /all` (post DHCP renew) | CLIENT01 | — | Address in 192.168.10.100–150 range, correct subnet mask, DNS = 192.168.10.10 |

## 5. Network Topology (Text Diagram)

```
                    VMnet2 (Host-only)
                    192.168.10.0/24
                           │
        ┌──────────────────┴──────────────────┐
        │                                      │
   DC01 (192.168.10.10)               CLIENT01 (DHCP-assigned)
   - AD DS / Domain Controller         - Windows 10/11
   - DNS Server                        - Domain-joined to adlab.local
   - DHCP Server
```

*(A visual diagram will be added under `/diagrams` as the project matures.)*
