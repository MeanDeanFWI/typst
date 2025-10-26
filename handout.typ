// ===========================================================
// THWS-Handout-Template v0.4
// Autor: Prof. Dr. Christian Kraus
// Stand: Oktober 2025
//
// Zweck:
// - Einheitliches Layout für Handouts, Reader & Workshopmaterial
// - THWS-Branding: Orange (#ff6a00)
// - Automatische Metadaten, Outline, Literatur, Tabellenstil
// - Better BibTeX + CSL für Zitation
// ===========================================================

#let thws_orange = rgb("#ff6a00")

#let handout(
  title: [Titel des Handouts],
  intro: none,
  authors: (),
  subject: "",
  lang: "de",
  show-outline: true,
  outline-depth: 2,
  bib-file: none,           // z. B. "literatur.bib"
  citation-style: none,     // z. B. "apa.csl" oder "ieee.csl"
  body,
) = {

  //----------------------------
  // Metadaten
  //----------------------------
  set document(
    title: title,
    author: authors.map(a => a.name),
  )

  //----------------------------
  // Seite / Header / Footer
  //----------------------------
  set page(
    paper: "a4",

    // Fußzeile: Seitenzahl klein & orange, zentriert
    footer: context {
      let page_number = counter(page).display("1")
      align(
        center,
        text(
          thws_orange,
          size: 7pt,
          weight: "regular",
        )[ #page_number ]
      )
    },

    margin: (
      left: 32mm,
      right: 20mm,
      top: 30mm,
      bottom: 20mm,
    ),

    header: [
      // Logo links
      #place(
        top + left,
        dx: 0mm,
        dy: 5mm,
        image(
          "thws-logo_vert_de_orange-rgb.png",
          width: 20%,
        )
      )

      // Subject rechts (optional)
      #if subject != "" [
        #place(
          top + right,
          dx: -5mm,
          dy: 5mm,
          text(
            fill: thws_orange,
            size: 10pt,
            weight: "regular",
          )[*#subject*]
        )
      ]
    ],
  )

  //----------------------------
  // Grundtypografie
  //----------------------------
  set text(font: "Inter", size: 11pt, lang: lang)
  set par(leading: 12pt, spacing: 5pt, justify: true)

  set quote(block: true, quotes: true)
  show quote: set text(style: "italic")

  show math.equation: set text(weight: 400)

  set heading(numbering: "1.1 ")
  show heading: set text(fill: thws_orange, weight: "regular")
  show heading: set block(sticky: false)

  //----------------------------
  // Tabellen-Design (THWS-Orange)
  //----------------------------
  // Globales Tabellenlayout:
  // - Orange Linien
  // - kompaktere Schrift in Tabellen
  // - Kopfzeile: Orange Text, semibold
  //   (kein Hintergrund, weil .with(alpha: ...) in deiner Typst-Version nicht geht)
  set table(
    stroke: (
      x: (paint: thws_orange, thickness: 0.5pt),
      y: (paint: thws_orange, thickness: 0.5pt),
    ),
    inset: (x: 4pt, y: 3pt),
    align: left,
    // keine automatische Füllfarbe mehr -> neutral
  )

  show table.cell: it => {
    if it.y == 0 {
      // Kopfzeile (erste Zeile):
      set text(
        fill: thws_orange,
        weight: "semibold",
        size: 10pt,
      )
      it
    } else {
      // normale Zellen:
      set text(
        fill: black,
        size: 10pt,
      )
      it
    }
  }

  //----------------------------
  // TITELBLOCK
  //----------------------------
  block[
    #set align(center)
    #set par(leading: 0.5em, spacing: 0pt)
    #set text(
      size: 20pt,
      fill: thws_orange,
      style: "italic",
      weight: "regular",
    )
    *#title*
  ]

  v(1cm)

  //----------------------------
  // AUTORENBLOCK
  //----------------------------
  align(center,
    block[
      #set align(center)
      #set par(leading: 0.6em, spacing: 4pt)
      #set text(size: 11pt, fill: black, style: "normal", weight: "regular")

      #for a in authors {
        text(size: 11pt, weight: "regular")[#a.name]
        linebreak()

        set text(size: 9pt)

        if "role" in a [
          #text(style: "italic")[#a.role]
          #linebreak()
        ]

        if "department" in a [
          #text()[#a.department]
          #linebreak()
        ]

        if "organization" in a [
          #text()[#a.organization]
          #linebreak()
        ]

        if "location" in a [
          #text()[#a.location]
          #linebreak()
        ]

        if "email" in a [
          #if type(a.email) == str [
            #link("mailto:" + a.email)[#a.email]
          ] else [
            #a.email
          ]
          #linebreak()
        ]

        v(12pt, weak: true)
      }
    ]
  )

  v(1cm)

  //----------------------------
  // OPTIONALER INTRO-ABSATZ
  //----------------------------
  if intro != none [
    #block[
      #set align(center)
      #set text(style: "italic", size: 11pt)
      #intro
    ]
    #v(1.5cm)
  ] else [
    #v(1cm)
  ]

  //----------------------------
  // SEITENUMBRUCH NACH DECKBLATT
  //----------------------------
  pagebreak()

  //----------------------------
  // OUTLINE (optional)
  //----------------------------
  if show-outline [
    #let outline_title = if lang == "de" { "Inhaltsübersicht" } else { "Contents" }

    #outline(
      title: outline_title,
      depth: outline-depth,
    )

    #pagebreak()
  ]

  //----------------------------
  // INHALT
  //----------------------------
  body

  //----------------------------
  // LITERATURVERZEICHNIS (optional)
  //----------------------------
  if bib-file != none [
    #pagebreak()

    #let bib_title = if lang == "de" { "Literatur" } else { "References" }

    // Abschnittsüberschrift fürs Literaturverzeichnis:
    block[
      #set text(fill: thws_orange, weight: "regular", size: 11pt)
      #set align(left)
      *#bib_title*
    ]

    // Literaturverzeichnis kompakter setzen:
    #set par(spacing: 3pt, leading: 10pt)
    #set text(size: 9pt)

    if citation-style != none {
      bibliography(bib-file, style: citation-style)
    } else {
      bibliography(bib-file)
    }
  ]
}
