# Active Directory Domain Services (AD DS)

## 1. Domain Details

| Item | Value |
|---|---|
| Forest / Domain (FQDN) | adlab.local |
| NetBIOS name | ADLAB |
| Domain Controller | DC01 (192.168.10.10) |
| Forest/Domain functional level | Default (latest available) |
| Global Catalog | Enabled on DC01 |

**Naming decision note:** the domain was initially planned as `TechTitans.local` but changed to `adlab.local` during implementation for a cleaner, more professional documentation footprint. This is reflected consistently throughout the lab and its documentation.

## 2. Server Foundation (Pre-AD DS)

| Setting | Value |
|---|---|
| Server hostname | DC01 |
| IP configuration | Static — 192.168.10.10 / 255.255.255.0 |
| Preferred DNS (self) | 192.168.10.10 |
| Local Administrator password | Set manually post-installation (was blank by default on first login — corrected before any further configuration) |

## 3. Organizational Unit (OU) Structure

A hybrid OU design was used: a top-level company OU containing per-department OUs, each split into `Users` and `Computers` sub-OUs, plus a company-wide `Groups` OU at the domain root.

```
adlab.local
├── adlab
│   ├── IT
│   │   ├── Users
│   │   └── Computers
│   ├── HR
│   │   ├── Users
│   │   └── Computers
│   └── Sales
│       ├── Users
│       └── Computers
└── Groups
```

**Design rationale:**
- Objects live outside the AD default containers (`Users`, `Computers`), since default containers cannot be linked with Group Policy.
- Separating `Users` from `Computers` within each department allows user-targeted and computer-targeted GPOs to be applied independently without overlap.
- `Groups` sits at the domain root because some security groups span multiple departments (e.g., an all-staff group).

## 4. Domain Users

| Department | Full Name | Username | OU Path |
|---|---|---|---|
| IT | Omar Hassan | ohassan | adlab/IT/Users |
| IT | Laila Fathy | lfathy | adlab/IT/Users |
| HR | Mona Ahmed | mahmed | adlab/HR/Users |
| HR | Karim Adel | kadel | adlab/HR/Users |
| Sales | Youssef Tarek | ytarek | adlab/Sales/Users |
| Sales | Nour Samir | nsamir | adlab/Sales/Users |

All accounts were created with **"User must change password at next logon"** enabled, following least-privilege / good password hygiene practice for a first login.

## 5. Security Groups

| Group Name | Scope | Type | Members | Purpose |
|---|---|---|---|---|
| IT-Staff | Global | Security | ohassan, lfathy | IT department–specific permissions |
| HR-Staff | Global | Security | mahmed, kadel | HR department–specific permissions |
| Sales-Staff | Global | Security | ytarek, nsamir | Sales department–specific permissions |
| All-Employees | Global | Security | all 6 users | Company-wide policies |

**Design rationale:** permissions are always assigned to groups, never directly to individual users, to keep administration scalable as the organization grows.

## 6. Validation — `dcdiag`

`dcdiag` was run immediately after promotion. Summary of results:

| Test | Result | Notes |
|---|---|---|
| Connectivity | Passed | |
| Advertising | Passed | |
| NetLogons | Passed | |
| Replications | Passed | |
| RidManager | Passed | |
| Services | Passed | |
| LocatorCheck | Passed | |
| DFSREvent | Failed (expected) | SYSVOL replication warnings are normal immediately after promotion on a first DC; resolves after initial sync completes |
| SystemLog | Failed (expected) | Warnings almost entirely due to failed attempts to reach `time.windows.com`, an external NTP source unreachable from an isolated, internet-less network. DC01 correctly self-elected as the authoritative internal time source (PDC emulator behavior) |

**Conclusion:** all AD DS–critical tests passed. The two failing categories are attributable to environment isolation (no internet) and first-boot replication timing, not to configuration errors.

## 7. Client Domain Join

| Item | Value |
|---|---|
| Client | CLIENT01 |
| Join method | System Properties → Computer Name → Change → Domain: adlab.local |
| Credentials used | Domain Administrator |
| Result | "Welcome to the adlab.local domain" — successful join, confirmed post-restart login with a domain user account |

## 8. Known Cosmetic Notes (Non-Issues)

- `nslookup` on DC01 shows `Server: UnKnown` / `Address: ::1` for its own reverse lookup — caused by IPv6 loopback querying an IPv4-only reverse zone. Forward resolution (the functionally important part) works correctly in all tests. Documented and intentionally not pursued further, as it has no operational impact.
