# Security Policy

## Scope

This repository documents a **learning lab** — an isolated Active Directory / Windows Server environment built for personal, hands-on practice. It does not run as a live, internet-facing service, and this repository contains **documentation and configuration notes**, not deployable production infrastructure.

Because of that, the usual open-source "report a vulnerability, get a fix and a CVE" process doesn't really apply here — there's no live system for a vulnerability to affect.

## Reporting a Documentation or Practice Issue

If you notice something in this repo that reflects an incorrect or unsafe security practice — for example, a misconfigured setting that's documented as a best practice when it isn't, or a mistake in the reasoning behind a security control — please open a [GitHub Issue](../../issues). I'm actively learning, and corrections are genuinely welcome.

## Lab Security Notes

A few things worth being explicit about, given this is a public repository:

- All passwords, credentials, and secrets referenced in this project were used only within the isolated lab environment and are not real production credentials.
- The lab network is intentionally isolated (VMware Host-only) with no internet exposure.
- Security controls documented here (password policy, account lockout, IP restrictions, etc.) were configured and validated for learning purposes, within the scope of this lab — they are not a certification of production-readiness for any real environment.
