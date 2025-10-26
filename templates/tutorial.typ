// ===========================================================
// THWS-Tutorial-Template v0.5
// Autor: Prof. Dr. Christian Kraus
// Stand: Oktober 2025
//
// Zweck:
// - Einheitliches Layout für Übungsblätter & Tutorials
// - Kein Deckblatt, keine Outline, keine Literatur
// - Kompakter Kopfbereich mit Titel / Kurs / Info
// - THWS-Branding: Orange (#ff6a00)
// ===========================================================

#let thws_orange = rgb("#ff6a00")

#let tutorial(
  sheet_title: [Titel des Tutorials],  // z. B. "Übungsblatt 3 – Regelbasierte KI"
  course: [Kursbezeichnung],           // z. B. "KI in der Lehre (WS 25/26)"
  info: [Weitere Angaben],             // z. B. "Fakultät Wirtschaftsingenieurwesen · THWS · Prof. Dr. X"
  subject: "",                         // optional, erscheint rechts oben im Header
  lang: "de",
  body,
) = {

  //----------------------------
  // Metadaten (PDF-Viewer)
  //----------------------------
  set document(
    title: sheet_title,
    author: ("THWS Tutorial",),
  )

  //----------------------------
  // Seite / Header / Footer
  //----------------------------
  set page(
    paper: "a4",

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

      // Subject (optional) rechts oben in THWS-Orange
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
  // Grundtypografie im Dokument
  //----------------------------
  set text(font: "Inter", size: 11pt, lang: lang)
  set par(leading: 8pt, spacing: 10pt, justify: true)

  set quote(block: true, quotes: true)
  show quote: set text(style: "italic")

  show math.equation: set text(weight: 400)

  // Überschriften-Nummerierung für Aufgaben
  set heading(numbering: "1 ")
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
      set text(
        fill: thws_orange,
        weight: "semibold",
        size: 10pt,
      )
      it
    } else {
      set text(
        fill: black,
        size: 10pt,
      )
      it
    }
  }

  //----------------------------
  // KOPFBEREICH: Titel / Kurs / Info
  //----------------------------
  align(center,
    block[
      // enger Zeilenabstand in diesem Block, damit es kompakt wirkt
      #set par(leading: 4pt, spacing: 4pt)

      // 1. Sheet-Titel (groß, orange, italic)
      #set text(
        size: 16pt,
        fill: thws_orange,
        style: "italic",
        weight: "regular",
      )
      *#sheet_title*

      #linebreak()

      // 2. Kurs (leicht hervorgehoben, aber schwarz)
      #set text(
        size: 10pt,
        fill: black,
        weight: "semibold",
      )
      #course

      #linebreak()

      // 3. Infozeile (noch kleiner, neutral)
      #set text(
        size: 9pt,
        fill: black,
        weight: "regular",
      )
      #info
    ]
  )

  v(1cm)

  //----------------------------
  // INHALT
  //----------------------------
  body
}
