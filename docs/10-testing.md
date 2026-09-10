# Testing & Validation Summary

## Purpose

This document consolidates every validation test performed throughout the project into a single reference, pulling together results that are also documented individually within their respective phase documents.

## 1. Network Layer

| Test | Command | Run From | Result |
|---|---|---|---|
| Connectivity to DC01 | `ping 192.168.10.10` | CLIENT01 | 4/4 packets received, 0% loss |
| Connectivity to DC01 | `ping 192.168.10.10` | CLIENT01 (post DNS fix, Scenario 1) | 4/4 packets received, 0% loss |
| DHCP lease acquisition | `ipconfig /release` + `ipconfig /renew` | CLIENT01 | Address issued from 192.168.10.100–150 range |
| DHCP-provided settings | `ipconfig /all` | CLIENT01 | Correct subnet mask, DNS server (192.168.10.10), DHCP server (192.168.10.10) |

## 2. DNS Layer

| Test | Command | Run From | Result |
|---|---|---|---|
| Forward lookup | `nslookup adlab.local` | DC01 | Resolved to 192.168.10.10 |
| Forward lookup | `nslookup adlab.local` | CLIENT01 | Resolved to 192.168.10.10, correct server |
| Domain name resolution | `ping adlab.local` | CLIENT01 | Resolved and replied successfully |
| Misconfigured DNS (Scenario 1) | `nslookup adlab.local` | CLIENT01 (DNS pointed at 8.8.8.8) | Correctly failed, confirming DNS misconfiguration as root cause |

## 3. Active Directory Layer

| Test | Command | Run From | Result |
|---|---|---|---|
| Domain Controller health | `dcdiag` | DC01 | All AD DS–critical tests passed (Connectivity, Advertising, NetLogons, Replications, RidManager, Services, LocatorCheck); two non-critical failures explained (SYSVOL initial sync, unreachable external time source) |
| Domain identity | `whoami` | DC01 | Returned `techtitans\administrator` → `adlab\administrator` after domain finalized as adlab.local |
| Domain join | GUI (System Properties) | CLIENT01 | "Welcome to the adlab.local domain" confirmed, successful login post-restart with a domain user |
| Domain join (member server) | GUI (System Properties) | WEB01 | Successful join to adlab.local, confirmed reachable via DNS name post-join |

## 4. Group Policy Layer

| Test | Command | Run From | Result |
|---|---|---|---|
| GPO refresh | `gpupdate /force` | CLIENT01 | Completed successfully |
| GPO applied (positive test) | Login as Sales user | CLIENT01 | Control Panel access blocked with restriction message |
| GPO scope confirmation | `gpresult /r` | CLIENT01 (Sales user) | `Sales-Restrict-ControlPanel` listed under Applied GPOs |
| GPO not applied (negative test) | Login as IT user | CLIENT01 | Control Panel opened normally |
| GPO scope confirmation | `gpresult /r` | CLIENT01 (IT user) | Applied GPOs: N/A |

## 5. IIS Layer

| Test | Method | Run From | Result |
|---|---|---|---|
| Local site access | Browser → `http://localhost` | WEB01 | IIS default page loaded |
| Remote access by IP | Browser → `http://192.168.10.11` | CLIENT01 | IIS default page loaded |
| Remote access by DNS name | Browser → `http://web01.adlab.local` | CLIENT01 | IIS default page loaded, confirming automatic DNS registration |
| IP restriction (allowed) | Browser → `http://web01.adlab.local` | DC01 (192.168.10.10, allow-listed) | IIS default page loaded |
| IP restriction (denied) | Browser → `http://web01.adlab.local` | CLIENT01 (not allow-listed) | 403 - Forbidden: Access is denied |

## 6. Security Baseline Layer

| Test | Method | Run From | Result |
|---|---|---|---|
| Account lockout trigger | 5 incorrect password attempts | CLIENT01 | Account locked, login blocked with lockout message |
| Account lockout (admin view) | ADUC → Account tab | DC01 | Confirmed locked-out status, unlock option available |
| Account unlock | ADUC → Unlock account checkbox | DC01 | Account successfully unlocked, subsequent correct login succeeded |

## 7. Summary

Every core service in this lab — network, DNS, DHCP, AD DS, Group Policy, IIS, and the security baseline — has been validated with at least one functional test, and the higher-risk controls (GPO scoping, IIS access restriction, account lockout) were validated with both a positive and a negative test to confirm correct behavior in both directions, not just that a feature is "on."
