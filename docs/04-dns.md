# DNS Configuration

## 1. Overview

DNS was installed automatically as part of the AD DS promotion process on DC01, since Active Directory depends heavily on DNS for domain locator (SRV) records, replication, and client/server communication.

| Item | Value |
|---|---|
| DNS Server | DC01 (192.168.10.10) |
| Primary forward lookup zone | adlab.local (AD-integrated) |
| Reverse lookup zone | 10.168.192.in-addr.arpa (IPv4, AD-integrated) |
| DNS Forwarders | None configured (intentional) |

## 2. Why No Forwarders Are Configured

This lab runs on an isolated Host-only VMware network with no internet access. Forwarders are used to resolve external names (e.g., public websites) by relaying queries to an upstream DNS server. Since there is no upstream connectivity, forwarders were intentionally left unconfigured, and this is documented rather than treated as an oversight.

## 3. Reverse Lookup Zone

A reverse lookup zone was added after initial promotion to complete the DNS setup:

| Setting | Value |
|---|---|
| Zone type | Primary, AD-integrated |
| Replication scope | All DNS servers in this domain |
| Network ID | 192.168.10 |
| Dynamic updates | Secure only |

## 4. Validation

| Test | Command | Run From | Result |
|---|---|---|---|
| Forward lookup (server) | `nslookup adlab.local` | DC01 | Resolved to 192.168.10.10 |
| Forward lookup (client) | `nslookup adlab.local` | CLIENT01 | Resolved to 192.168.10.10, correct server reported |
| Connectivity pre-join | `ping 192.168.10.10` | CLIENT01 | 4/4 successful |

## 5. Known Cosmetic Note

On DC01 itself, `nslookup` without arguments (or when resolving its own reverse record) initially reported `Server: UnKnown` with an `::1` (IPv6 loopback) address. This is because the local resolver's self-lookup used IPv6 loopback while only an IPv4 reverse zone was configured. All forward-resolution queries — the functionally important test — succeeded both from the server and from the domain-joined client, confirming DNS is healthy. This was evaluated and consciously not pursued further, as it has no impact on AD DS, DHCP, or client functionality.
