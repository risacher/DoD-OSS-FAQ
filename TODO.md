# TODO — DoD OSS FAQ refresh for code.mil re-host

Working list from the July 2026 review of `faq.md` against current policy.

## Presentation

- [ ] **Decide whether to adopt USWDS (U.S. Web Design System).**

  *Why it may matter:* 21st Century IDEA (Public Law 115-336) requires executive
  agency websites to conform to federal website standards, and OMB guidance
  implementing it directs agencies toward USWDS. USWDS components are built for
  Section 508 conformance, which would otherwise be work we do by hand — and this
  document is exactly the kind of long, heavily-linked reference page where
  accessible in-page navigation, heading structure, and link styling matter. USWDS
  is itself open source, which is thematically apt. It also solves a problem we
  already have: the existing `Open Source Software FAQ-template.html` is a scraped
  DotNetNuke portal skin (Bootstrap + DoD CIO "DOD2" theme) from the CIO web
  library CMS that no longer hosts this content, so we need a new presentation
  layer regardless.

  *Why it may not:* if code.mil already mandates its own template or design
  system, matching that beats adopting USWDS independently — check first. USWDS
  also normally implies an npm/Sass build, which is heavier than this repo's
  current `pandoc` + `sed` pipeline; vendoring the compiled CSS is the lighter path
  if we go ahead.

  *Verify before deciding:* current status of the OMB digital-experience guidance;
  whether code.mil has a required template; whether DoD has its own overriding
  design standard.

## Policy currency

- [x] Re-baseline on DoD CIO memo "Software Development and Open Source Software"
      (24 Jan 2022), which supersedes the 2009 "Clarifying Guidance" memo.
- [x] Add a SHARE IT Act section (PL 118-187) — six questions added to the
      "OSS and DoD Policy" section.
- [ ] Revisit the "How is the DoD implementing the SHARE IT Act?" answer once
      the implementing memo is signed. It is currently written in deliberately
      general terms and cites no unsigned document; replace with a direct
      citation, the registry location, and the registration deadline when
      those become releasable.
- [ ] Fold in 2022 memo content that has no FAQ counterpart: "Adopt, Buy, Create";
      FAR 13.104 / restriction-of-competition argument; open-by-default (¶3.C);
      the acceptable-license list (Apache-2.0, BSD, GPL, LGPL, MIT); distribution
      statements and the "not CTI, so do not mark CUI" point (¶3.D); the six SCRM
      factors (¶2.C); PL 115-232 §1655 OSS exemption; contribution rules (¶4);
      anti-fork guidance; developer access to repositories (¶2.E); OSS in the Life
      Cycle Product Support Strategy (¶2.F).
- [ ] Confirm whether DoD CIO has issued the SHARE IT Act §3(d)(1) agency-wide
      implementing policy, and cite it if so.
- [ ] Confirm whether the SHARE IT Act §8 FAR revision (due 23 Dec 2025) landed.
- [ ] Check whether OMB M-26-10 (31 Mar 2026) affects M-16-21's status or touches
      source code policy.
- [ ] Check DFARS Case 2018-D018 status (the 2022 memo lists it as pending).

## Citation hygiene

- [ ] Re-verify FAR/DFARS clause citations against the Revolutionary FAR Overhaul.
      Part 27 is being rewritten and the data-rights answers cite it heavily.
- [ ] Sweep for other Title 10 renumbering from PL 116-283 (2377 → 3453 is done;
      the 2022 memo also cites 2322a and 2446a under their old numbers).
- [x] Link rot: all known dead links repaired (July 2026). Of 162 links, 146
      return 200, 11 are user-agent-blocked but live, and the rest are
      extraction artifacts of the checking regex. Where a document had moved it
      was relinked; where the host was gone it was pointed at the Internet
      Archive; the Defense Digital Service link was removed. Re-run the sweep
      periodically — see the caveats below, which explain why a passing sweep
      is weaker evidence than it looks.

      **Status codes are not sufficient — check content.** CMS-driven `.mil` and
      `.gov` sites return soft 404s: HTTP 200 with an empty or placeholder body.
      The DON CIO 2007 OSS memo (`doncio.navy.mil/ContentView.aspx?id=312`)
      returned 200 with no document at all, only a tag list, and passed the
      automated sweep clean; it was caught only by reading the page. Treat the
      "~15 confirmed dead" figure as a floor, not a count. The manual pass should
      look for a document title, date, and body on each page, not just a response
      code.

      Note also that several `.mil` sites reject non-browser user agents. The
      403s in the sweep are mostly bot-blocking, not dead links, and
      `doncio.navy.mil` needs both a browser UA and `curl -k` (DoD PKI chain)
      to fetch from a non-DoD host. Any automated re-check should send a
      realistic UA before concluding anything.

      A third failure mode: authentication walls that return 200. `jasm.apps.mil`
      answers 200 with a plausible response but redirects an unauthenticated
      visitor to a BIG-IP APM error page. Since this FAQ is read by the public
      and by contractors as well as by DoD staff, CAC/PKI-gated destinations
      should be labeled as such in the text rather than merely linked. Worth a
      pass to identify any other authenticated-only links.
- [ ] code.gov appears to have been wound down (redirects to digital.gov;
      `GSA/code-gov-web` marked deprecated). The 2022 memo's reporting chain
      points at code.gov — needs a footnote or an updated destination.
- [ ] `dau.edu` now redirects to `waru.edu`; expect similar churn across `.mil`
      and `.gov` links from the department renaming.

## Content currency

- [ ] **Update and validate the military-specific OSS examples.** The list under
      "What are some military-specific open source software programs?" has eight
      entries: DDF, OSSIM, OMAR, BRL-CAD, Opticks, Delta3D, Ozone Widget
      Framework, and REDHAWK SDR. Several date from the DCGS/OWF era and may be
      dormant or archived even where the URL still resolves — Ozone in
      particular. Check each for actual project activity (recent commits,
      releases, a maintained site) rather than a 200 response, drop the dead
      ones, and add current examples. Note that a stale list here is worse than
      a short one: this is the answer a skeptic uses to argue the Department
      does not really do this.

- [ ] **Refresh the malicious-code examples.** Every example in "Is there a risk
      of malicious code becoming embedded into OSS?" is from 2001–2003: the
      Linux kernel subversion attempt (2003), SourceForge/Apache (2001), Debian
      (2003), and Borland InterBase/Firebird. The argument is sound but the
      evidence looks antique.

      Candidates: **xz-utils / liblzma (CVE-2024-3094, March 2024)** for OSS,
      and **SolarWinds SUNBURST (2020)** for proprietary. Others worth
      considering: event-stream (npm, 2018), Codecov (2021), and 3CX (2023).

      xz deserves care rather than avoidance. It cuts both ways — a multi-year
      social-engineering campaign that won maintainer trust and nearly shipped a
      backdoor into major distributions, but it was caught before wide
      deployment, by an outsider investigating a performance anomaly, because
      the source and build were inspectable. It also illustrates maintainer
      burnout as an attack surface, which the current answer does not address.
      Presenting it honestly is more persuasive than omitting it, and it maps
      directly onto the 2022 memo's SCRM factors on trusted sources, component
      integrity, and dependencies.

      Keep the distinction between malicious code and mere vulnerabilities
      clear: Log4Shell and Heartbleed are not examples of malicious code and
      belong in the unintentional-vulnerabilities answer if used at all.

## Structure and naming

- [ ] Decide DoD vs. DoW convention. Recommended: prospective/organizational voice
      uses DoW; titles, citations, and historical references keep the name as
      published. Add a short note early in the document explaining the convention.
- [ ] Decide the authoring authority line. `faq.md` currently reads "Office of the
      DoD CIO" — needs a decision for code.mil.
- [ ] Build the condensed "Start Here" summary tier from DeWayne's GenAI-condensed
      draft, with each answer linking into the corresponding full FAQ entry.
      Fix the accuracy issues in that draft before using it (notably the GPL
      mixing and government-employee-release answers), and restore the endorsement
      disclaimer since the summary names specific products.
- [ ] Future contributions in Markdown or as PRs, not `.docx`. If Word is
      unavoidable, require real heading styles and live hyperlink fields.

## Style

- [ ] Simplify the tortured language that David & I have used.