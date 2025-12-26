# FileMaster Pro Documentation

This repository contains the **AsciiDoc source and CI pipeline** used to generate **platform-specific PDF manuals** (Android and iOS) for **FileMaster Pro** from a **single documentation source**.

The goal is simple:  
**write once → build multiple manuals automatically**.

---

## Why AsciiDoc (not Markdown)

This project uses **AsciiDoc + Asciidoctor** because it supports:

- Conditional content (`ifdef::android[]`, `ifdef::ios[]`)
- File reuse via `include::`
- Professional PDF output
- Deterministic CI builds

Markdown cannot do this cleanly without duplication.

---

## Repository Structure

```
docs/
├─ main.adoc
├─ installation/
│  ├─ android.adoc
│  └─ ios.adoc
├─ usage/
│  └─ app-usage.adoc
├─ images/
│  └─ app-logo.png
├─ build/
```

---

## Platform-Specific Content

Platform differences are handled using **AsciiDoc attributes**:

```adoc
ifdef::android[]
include::installation/android.adoc[]
endif::[]

ifdef::ios[]
include::installation/ios.adoc[]
endif::[]
```

Attributes are never hard-coded for production builds.

---

## CI / GitHub Actions

The CI pipeline automatically:

1. Builds Android PDF
2. Builds iOS PDF
3. Uploads both as artifacts

---
