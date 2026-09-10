# Troubleshooting Scenarios

## Methodology

Each scenario follows a layered diagnostic approach rather than guessing at fixes: identify the affected layer, verify the simplest dependency first, run one diagnostic step at a time, and only apply a fix once the root cause is confirmed.

```
Physical/Virtual Network → IP Configuration → Connectivity → DNS → DHCP →
Windows Services → AD DS → Authentication → GPO → Applications/IIS
```

---

## Scenario 1 — Client Cannot Resolve the Domain Name

### Setup

`CLIENT01`'s Preferred DNS server was intentionally changed from `192.168.10.10` (DC01) to `8.8.8.8` (a public DNS resolver), to simulate a common real-world misconfiguration.

### Unplanned Incident (Before the Planned Test)

Before the DNS test even began, an unrelated issue surfaced organically: `DC01` had not yet been powered on when `CLIENT01` was started. Attempting to open Network Adapter Properties (which requires elevation) triggered a UAC prompt for domain administrator credentials, which failed with:

> *"We can't sign you in with this credential because your domain isn't available..."*

**Diagnosis:** this was resolved by checking the first layer of the hierarchy — the virtual network/host itself — which revealed `DC01` was powered off. Once `DC01` was started and `CLIENT01` was refreshed, elevation succeeded normally. This is a useful real-world reminder: authentication and elevation for a domain-joined machine depend on the Domain Controller actually being reachable, which is worth checking before assuming a deeper configuration problem.

### Diagnostic Steps (Planned Scenario)

With DC01 confirmed running, the DNS misconfiguration was tested using three commands, isolating one layer at a time:

| Command | Result | Layer Tested |
|---|---|---|
| `ping 192.168.10.10` | Success (0% packet loss) | Connectivity |
| `nslookup adlab.local` | Failed — `*** UnKnown can't find adlab.local: No response from server`, server shown as `8.8.8.8` | DNS |
| `ping adlab.local` | Failed — `Ping request could not find host adlab.local` | DNS (name resolution) |

### Root Cause Analysis

Since the IP-based ping succeeded but every name-based operation failed, the problem was isolated to DNS specifically — not connectivity, not AD DS, not authentication. The `nslookup` output confirmed the client was querying `8.8.8.8` (a public internet DNS server with no knowledge of the internal `adlab.local` domain) instead of the internal Domain Controller.

**Conclusion:** the client's DNS server pointed at the wrong resolver. Connectivity was never the issue — this confirms the project principle of testing name resolution before suspecting Active Directory itself.

### Fix

Reverted the client's Preferred DNS server from `8.8.8.8` back to `192.168.10.10`.

### Validation

| Command | Result |
|---|---|
| `ping adlab.local` | Resolved to `192.168.10.10`, 0% packet loss |
| `nslookup adlab.local` | Server correctly shown as `DC01.adlab.local` / `192.168.10.10` |

---

## Next Scenarios

Additional scenarios (e.g., DHCP failure, GPO not applying, IIS access issues) will be added here as they are performed.
