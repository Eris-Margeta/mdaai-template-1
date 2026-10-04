# CLASSIFICATION-REGULATIONS.md

---

FACTORY OF ELECTRONIC UNITS AND LOGIC - TEJL d.o.o.
Board for Standardization and Normalization

**Class:** 003-01/25-01
**Reference Number:** 251-01-02-25-01 (Rev. 1.1)
**Date:** 23.12.2025.

SUBJECT: Regulation on the Unified System of Classification and Referencing of Official Documents and Projects, Version 1.1

---

## **Article 1: Purpose and Scope**

(1) This Regulation establishes a unified, unambiguous, and strictly hierarchical system for the designation, tracking, and archiving of all projects, documents, and business processes within TEJL d.o.o.

(2) The purpose of this Regulation is to ensure absolute traceability, systemic order, and bureaucratic correctness of all business operations. With a correctly formed Classification Code and Reference Number, it must be possible to instantly identify the nature of a project and a document.

(3) The provisions of this Regulation are binding for all employees, associates, and information systems of the Organization.

## **Article 2: Structure of the Classification Code (CLASS)**

(1) The Classification Code (CLASS) is a unique identifier assigned to each project upon its creation. It defines the nature and position of the project within the organization.

(2) The structure of the CLASS is `MAIN.SUBGROUP/YEAR-FILE_NUMBER`. Example: `310-10/25-001`.

* **MAIN GROUP (3 digits):** Defines the fundamental nature and origin of the project.
  * `100`: **INTERNAL OPERATIONS**
  * `300`: **BUSINESS WITH DOMESTIC ENTITIES (REPUBLIC OF CROATIA)**
  * `400`: **BUSINESS WITH FOREIGN ENTITIES (EU AND WORLDWIDE)**
  * `500`: **PUBLIC PROCUREMENT AND BUSINESS WITH GOVERNMENT INSTITUTIONS**

* **SUBGROUP (2 digits):** More precisely defines the type of service or product within the Main Group.
  * *Within 100 (INTERNAL):*
    * `02`: Development of internal tools and systems.
  * *Within 300 (DOMESTIC) and 400 (FOREIGN):*
    * `10`: **Digital Services - Standard** (websites, CMS)
    * `20`: **Digital Services - E-Commerce** (web shops)
    * `30`: **Digital Services - Custom Applications** (custom software)
    * `70`: **Production and Sale of Hardware** (electronic units)
  * *Within 500 (PUBLIC PROCUREMENT):*
    * `02`: Contract execution

* **YEAR (2 digits):** The last two digits of the calendar year in which the project was initiated.

* **FILE NUMBER (3 digits):** A strictly sequential number, unique within the `MAIN.SUBGROUP/YEAR` combination. The first such project in a given year receives the number `001`, the second receives `002`, and so on.

## **Article 3: Structure of the Reference Number (URBROJ)**

(1) The Reference Number (URBROJ) is a unique identifier assigned to every official outgoing document.

(2) The structure of the URBROJ is `CLASS-DOC_TYPE.VERSION-SEQUENCE`. Example: `310-10/25-001-PO.01-001`.

* **CLASS:** The full and unchanged Classification Code of the project to which the document pertains.

* **DOCUMENT TYPE (2 letters):**
  * `PO`: Quote
  * `PR`: Proforma Invoice
  * `RA`: Invoice
  * `MM`: Memorandum
  * `RN`: Work Order

* **VERSION (2 digits):** The revision number of the document. The first version is always `01`. Any modification creates a new version (`02`, `03`, and so on).

* **SEQUENCE (3 digits):** A unique global counter of all official documents issued in the current calendar year, independent of the project or class.

## **Article 4: Procedure and Automation (Rev. 1.1)**

(1) **CLASS Assignment:**
    * When entering a new associate, the operator specifies whether the associate is domestic or foreign.
    * When creating a new project, the operator selects the associate and service type.
    * Based on these inputs, the information system automatically determines the `MAIN GROUP` and `SUBGROUP`.
    * The information system then assigns the next available `FILE_NUMBER` within the exact `MAIN.SUBGROUP/YEAR` category.
    * Manual modification of the CLASS is not permitted.

(2) **URBROJ Assignment:**
    * When generating a new document, the information system automatically:
        1. Retrieves the CLASS of the associated project.
        2. Sets the DOCUMENT TYPE based on the operator's selection.
        3. Sets the VERSION to `01`.
        4. Retrieves, increments, and assigns the current year's global SEQUENCE counter.
    * Generating a new version of an existing document retains all parts of the URBROJ but increments the VERSION number.
