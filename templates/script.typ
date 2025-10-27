// ===========================================================
// THWS-Script-Template v0.2
// Autor: Prof. Dr. Christian Kraus
// Stand: Oktober 2025
//
// Zweck:
// - Einheitliches Layout für Reader, Skripte, Kapitelzusammenfassungen
// - THWS-Branding: Orange (#ff6a00)
// - Automatisches Deckblatt, Inhaltsverzeichnis & optionale Bibliographie
// ===========================================================

#let thws_orange = rgb("#ff6a00")

#let script(
  script_title: [Titel des Skripts],
  subtitle: none,
  authors: (),
  course: none,
  semester: none,
  faculty: [Fakultät Wirtschaftsingenieurwesen],
  university: [Technische Hochschule Würzburg-Schweinfurt],
  version: none,
  date: none,
  lang: "de",
  outline-depth: 2,
  bib-file: none,
  citation-style: none,
  body,
) = {

  //----------------------------
  // Dokument-Metadaten
  //----------------------------
  set document(
    title: script_title,
    author: authors.map(a => a.name),
  )

  //----------------------------
  // Seite / Header / Footer
  //----------------------------
  set page(
    paper: "a4",

    // Fußzeile wie gehabt
    footer: context {
      let page_number = counter(page).display("1")
      align(
        center,
        text(thws_orange, size: 7pt, weight: "regular")[ #page_number ]
      )
    },

    margin: (
      left: 32mm,
      right: 20mm,
      top: 30mm,
      bottom: 20mm,
    ),

    // Header mit Logo ab Seite 2
  header: context {
  // aktuelle Seite als Zahl holen (nicht als Array)
  let page_number = counter(page).get().first()

  // nur ab Seite 2 Logo anzeigen
  if page_number > 1 [
    #place(
      top + left,
      dx: 0mm,
      dy: 5mm,
      image("thws-logo_vert_de_orange-rgb.png", width: 20%)
    )
  ] else [
     // Deckblatt: kein Header-Logo
  ]
},
  )

  //----------------------------
  // Grundtypografie
  //----------------------------
  set text(font: "Inter", size: 11pt, lang: lang)
  set par(leading: 8pt, spacing: 10pt, justify: true)

  set quote(block: true, quotes: true)
  show quote: set text(style: "italic")
  show math.equation: set text(weight: 400)

  set heading(numbering: "1.1 ")
  show heading: set text(fill: thws_orange, weight: "regular")
  show heading: set block(sticky: true)

  //----------------------------
  // Tabellen-Design (THWS-Orange)
  //----------------------------
  set table(
    stroke: (
      x: (paint: thws_orange, thickness: 0.5pt),
      y: (paint: thws_orange, thickness: 0.5pt),
    ),
    inset: (x: 4pt, y: 3pt),
    align: left,
  )

  show table.cell: it => {
    if it.y == 0 {
      set text(fill: thws_orange, weight: "semibold", size: 10pt)
      it
    } else {
      set text(fill: black, size: 10pt)
      it
    }
  }

  //----------------------------
  // DECKBLATT (Seite 1)
  //----------------------------
  align(center,
    block[
      #set par(leading: 6pt, spacing: 8pt)
      #set align(center)

      // Haupttitel
      #set text(size: 24pt, fill: thws_orange, style: "italic", weight: "regular")
      *#script_title*

      // Untertitel (optional)
      #if subtitle != none [
        #v(6pt)
        #set text(size: 14pt, fill: black, weight: "regular")
        #subtitle
      ]

      // LOGO (jetzt zentriert unter dem Titelblock)
      #v(12pt)
      #image("thws-logo_vert_de_orange-rgb.png", width: 50%)

      #v(2cm)

      // Kurs, Semester etc.
      #set text(size: 11pt, fill: black, weight: "regular")
      #if course != none [
        #course
        #linebreak()
      ]
      #if semester != none [
        #semester
        #linebreak()
      ]

      #v(1cm)

      // Autoren
      #for a in authors {
        text(weight: "regular")[#a.name]
        linebreak()

        if "role" in a [
          #text(style: "italic")[#a.role]
          #linebreak()
        ]

        if "organization" in a [
          #text()[#a.organization]
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

        v(10pt)
      }

      #v(2cm)

      // Fakultät & Hochschule
      #set text(size: 10pt, fill: black)
      #faculty
      #linebreak()
      #university

      #v(1cm)

      // Version / Datum (optional)
      #set text(size: 9pt, fill: gray)
      #if version != none [
        #version
        #linebreak()
      ]
      #if date != none [
        #date
      ]
    ]
  )

  pagebreak()

  //----------------------------
  // INHALTSVERZEICHNIS (Seite 2)
  //----------------------------
  let outline_title = if lang == "de" { "Inhalt" } else { "Contents" }
  outline(title: outline_title, depth: outline-depth)

  pagebreak()

  //----------------------------
  // INHALT (ab Seite 3)
  //----------------------------
  body

 // ----------------------------
// LITERATURVERZEICHNIS (optional)
// ----------------------------
if bib-file != none [
  #pagebreak()

  // Ab hier enger gesetzte Literaturangaben
  #set par(spacing: 10pt, leading: 5pt)
  #set text(size: 9pt)

  // Bibliographie rendern – mit oder ohne CSL
  #if citation-style != none {
    bibliography(bib-file, style: citation-style)
  } else {
    bibliography(bib-file)
  }
]
}
