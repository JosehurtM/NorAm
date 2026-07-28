# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`NorAm Extension` — an AL extension for Microsoft Dynamics 365 Business Central (publisher: MS Cloud Experts). Target application `23.0.0.0`, runtime `12.0`, object ID range **54100–54149**, `NoImplicitWith` enabled.

The extension is almost entirely **document/report customization**: custom RDLC and Word layouts for standard sales/purchase documents, extra dataset columns feeding those layouts, plus a few small page and table tweaks. There are no codeunits, no new tables, and no test project.

## Build and deploy

Normal workflow is the VS Code AL extension: `F5` publishes to a sandbox, `Ctrl+Shift+B` packages. `.vscode/launch.json` defines two Business Central sandbox targets against the same tenant — `NorAm` (environment `NEWNORAM`) and `NoramSanbox` (environment `NoramSanbox`), both `schemaUpdateMode: ForceSync`.

Command-line compile (verified working; use it to check that a change builds without publishing):

```powershell
& "$env:USERPROFILE\.vscode\extensions\ms-dynamics-smb.al-17.0.2273547\bin\win32\alc.exe" `
  /project:"c:\Users\Usuario\Documents\TRABAJO\REPOSITORIOS\NORAM\NorAm" `
  /packagecachepath:"c:\Users\Usuario\Documents\TRABAJO\REPOSITORIOS\NORAM\NorAm\.alpackages" `
  /out:"<scratch>\test.app"
```

Symbols are **committed** in `.alpackages/` (both 23.0 and 23.5 sets), so no symbol download is needed. Expect exactly one warning: `AL0606` (deprecated `with`) at `src/Report/Rep54100.CommercialInvoice.al:558`, inherited from the base report this file was cloned from. Treat any *other* diagnostic as a regression.

## Release convention

There is no `.gitignore` — build output is deliberately tracked. Each release bumps `version` in [app.json](app.json) and commits the built `MS Cloud Experts_NorAm Extension_<version>.app` at the repo root alongside the source change. Current version: `1.0.0.21`.

## Architecture

### Report extensions (`src/ReportExt/`) — the bulk of the codebase

Each `reportextension` does two things: `add`/`modify` dataset columns on the base report, and attach a custom layout in a `rendering` block. The layout file sits next to the `.al` file (`.rdl` for RDLC, `.docx` for Word) and is referenced by a project-root-relative path (`'./src/ReportExt/Foo.rdl'`).

Layout names are a convention, not cosmetic: `"RDLC-MscloudExperts"` / `"WORD-MscloudExperts"`. Renaming a layout creates a *new* layout in BC, so the environment's Report Selections / user layout selection must be re-pointed — avoid renaming.

**The company-logo pattern.** Standard BC report datasets don't expose the company logo, so nearly every extension here repeats:

```al
add("Header")            { column(Picture; CompanyInfo2.Picture) { } }
modify("Header")
{
    trigger OnBeforeAfterGetRecord()
    begin
        CompanyInfo2.GET;
        CompanyInfo2.CALCFIELDS(Picture);
    end;
}
var
    CompanyInfo2: Record "Company Information";
```

The variable name is inconsistent across files (`CompanyInfo`, `CompanyInfo2`, `CompanyInfoBlanket`) — match the file you are editing rather than "fixing" it. Report extensions can also reference the base report's own globals (e.g. `PickingListByOrder.al` binds `column(Picture; CompanyInfo.Picture)` to the base report's variable while its trigger fills a local one).

Other recurring additions: `Description 2` and `Line No.` on line dataitems, the full Ship-to address block on sales headers, `External Document No.` on picking documents.

**US localization matters.** Purchase report extensions extend the NA variants — `"Purchase Invoice NA"`, `"Purchase Credit Memo NA"`, `"Purchase Quote NA"` — not the W1 names. `"Purchase Order"` and `"Blanket Purchase Order"` have no NA variant and are extended directly.

### Commercial Invoice (`src/Report/Rep54100.CommercialInvoice.al`)

The only new (non-extension) object. It is a **verbatim clone of the base `Standard Sales - Pro Forma Inv` report**, then edited to add Tariff No., Country/Region of Origin, Net Weight / Total Weight, and customs declaration labels. Base-report artifacts are still present and are not bugs to clean up casually: `DocumentTitleLbl = 'Pro Forma Invoice'`, the `OnInitReportForGlobalVariable` integration event, `#if not CLEAN23`, and the `with SalesHeader` block.

**How it actually gets printed is indirect.** `pageextension 54101 SalesOrder` and `pageextension 54102 SalesOrderList` hide the base `ProformaInvoice` action and add a `CommercialInvoice` action — but that action calls:

```al
ReportSelections.PrintForCust(ReportSelections.Usage::"Pro Forma S. Invoice", SalesHeader, ...)
```

So the report that runs is whatever is configured under **Report Selections → Pro Forma S. Invoice** in the target environment. Switching between the Pro Forma extension (`reportextension 54107`) and report 54100 is a BC configuration change, not a code change. Both exist and are maintained in parallel — a change requested for "the Commercial Invoice" may need to land in either or both.

### Page and table extensions

Small and surgical. Notable: `Tab-Ext54101.PurchaseHeader.al` forces `"Posting No." := "No."` on insert for purchase orders (so the order number carries into the posted document). `Pag-Ext54101.SalesOrder.al` references the base control ID `Control297` to reveal the Ship-to group — fragile against Base Application updates; re-verify after a BC version bump.

### Dead code

`src/Report/GeneralJournalTestMSCE.al` (report 54101 "Consigment Report MSCE") and `src/PageExt/PurchaseJournalExt.al` are fully commented out but retained, along with `GeneralJournalTestMSCE.rdl`. Leave them alone unless the task is to revive or remove them.

## Conventions

- Inline comments and several commit messages are in Spanish; commit messages are short and descriptive (`ShipToCounty Visible`, `Update Sales Order Layout`).
- `.docx` and `.rdl` layouts are edited outside VS Code (Word / Report Builder). The AL side only declares the columns the layout consumes — adding a column here does nothing until the layout is updated too, and vice versa.
- `NoImplicitWith` is on: qualify all record references in new code.
