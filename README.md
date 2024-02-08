# CIP scripts and automation
## DISCLAIMER
This repository is provided without any warranty or gurantee of accuracy.  As the maintainer, I cannot ensure the accuracy of the information generated by these tools and do not take responsibility for impacts to you or your organization if these tools are used in a Production setting.

## Introduction
Critical Infrastructure Protection (CIP) is a set of standards designed to protect the North American Bulk Electric System (BES).  CIP is a reliability standard, so while it has a lot of focus on security, proper documentation, and change management procedures, the underlying motive is to ensure the power grid stays up.  CIP is a complex set of standards and leaves a lot open to interpretation with regards to technical requirements.  There's no common tooling to ensure CIP requirements are met, so the aim of this project is to ease many of the simple but time-consuming tasks.

### The CIP Standards
Note that the standards are designated by a number followed by another number.  These are the ID of the standard and the version of the standard.  For example, CIP-010-4 is CIP Standard number 10, version 4.  When talking about CIP, this Standard would be called "sip ten" or "sip zero ten".

| Standard Name | Title | Summary |
|---------------|-------|---------|
| CIP-002-5.1a | Cyber Security - BES Cyber System Categorization |This standard requires assets to be categorized when commissioned and again every 15 calendar months (a "CIP year").|
| CIP-003-8 | Cyber Security - Security Management Controls | CIP-003 is focused on policy.  It requires specific policies to be created and reviewed every 15 calendar months.  It also requires naming (by name) a CIP Senior Manager who is accountable for these policies.|
| CIP-004-7 | Cyber Security - Personnel & Training | This one defines requirements for background checks, onboarding and offboarding,  training, and managing access. |
| CIP-005-7 | Cyber Security - Electronic Security Perimeter(s) | This Standard requires implementing one or more Electronic Security Perimiters (ESP), i.e. behind a firewall.  Certain systems are required to reside in an ESP based on their Category from CIP-002. |
| CIP-006-6 | Cyber Security - Physical Security of BES Cyber Systems | This Standard outlines requirements for Physical Access Control Systems (PACS), handling visitors, and testing the Physical Security Perimiter (PSP) every 24 calendar months. |
| CIP-007-6 | Cyber Security - Systems Security Management | While we all might love Agent 007, CIP-007 is a little less thrilling.  This Standard covers ports and services as well as patch management.  It requires documented processes and requires applicable patches to be installed or a mitigation plan created within 35 days of patch evaluation. |
| CIP-008-6 | Cyber Security - Incident Reporting and Response Planning | This Standard is a big one.  It requires documenting processes for discovering, responding to, and reporting cyber incidents.  It requires testing Cyber Security Incident Response Plans every 15 months and documenting lessons learned.  CIP-008 requires reporting a Reportable Cyber Incident within one hour once identified. |
| CIP-009-6 | Cyber Security - Recovery Plans for BES Cyber Systems | As you can guess, CIP-009 requires plans in case anything hits the fan.  Utilities must define when they activate their Recovery Plans, who responds, processes to backup and recover, and required testing. | 
| CIP-010-4 | Cyber Security - Configuration Change Management and Vulnerability Assessments | CIP-010 requires a baseline configuration to be captured for each system/group of systems and updating that baseline if it changes.  For High systems, you must monitor for configuration changes every 35 days.  Additionally, it defines requirements to perform vulnerability assessments for High and Medium assets and their EACMS, PACS, and PCAs. |
| CIP-011-3 | Cyber Security - Information Protection | This Standard sets out to identify, protect, and handle BES Cyber System Information (BCSI).  It also defines requirements for sanitization or disposal of devices that contain BCSI. |
| CIP-012-1 | Cyber Security - Communications between Control Centers | This Standard requires a plan to mitigate risk of disclosing real-time data while it's being transmitted between Control Centers, including for voice transmission. |
| CIP-013-2 | Cyber Security - Supply Chain Risk Management | CIP-013 probably isn't anyone's favorite, but following breaches like SolarWinds in 2020 it's become important.  It requires a plan to document risk management processes used when buying equipment and software.  It also requires notification from vendors regarding incidents that pose a cyber security risk, disclosure of vulnerabilities, and integrity validation. |
| CIP-014-3 | Physical Security | As you can guess, this Standard defines things like risk assessments of physical assets such as Transmission stations and substations.  It requires evaluating potential threats to physical assets and developing a security plan. |


## Tools to build
- [ ] Build a questionnaire tool to ensure repetetive CIP tasks are taking place. Possible yearly calendar mock-up?
- [ ] Build a tool to capture configuration baselines (CIP-010-4 R1.1)
- [ ] Build a tool to run vulnerability assessments (CIP-010-4 R3)