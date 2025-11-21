// ===========================================================
// THWS-Dokumenttemplate
// Version: 1.3 (Fix: Sicherheitsabstand zur Blattkante im Footer)
// ===========================================================

#let thws_orange = rgb("#ff6a00")

#let project(
  title: "",
  authors: (), 
  subject: "",
  topic: "",
  department: "",
  date: none,
  body,
) = {

  // -------------------------------------------------------
  // 1. HEADER (Vorbereitet)
  // -------------------------------------------------------
  let header_content = block[
    #v(5mm)
    #grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      image("thws-logo_vert_de_orange-rgb.png", width: 20%),
      text(fill: thws_orange, size: 10pt)[#subject]
    )
  ]

  // -------------------------------------------------------
  // 2. PAGE SETUP & FOOTER
  // -------------------------------------------------------
  set page(
    paper: "a4",
    // Wir reservieren 35mm für den Footer-Bereich
    margin: (left: 32mm, right: 20mm, top: 26mm, bottom: 35mm),
    header: header_content,
    
    footer: context {
      // -- DATEN VORBEREITEN --
      let page-num = counter(page).get().first()
      
      // Autoren-Liste bereinigen (Dictionary/Array/String safe)
      let auth-list = if type(authors) == array { authors } else { (authors,) }
      let names = auth-list.map(it => {
        if type(it) == dictionary and "name" in it { it.name } else { it }
      })
      let author-string = names.filter(n => n != "" and n != none).join(", ")
      if author-string == "" { author-string = "THWS" }

      // Datum
      let date-string = if date != none { date } else { datetime.today().display("[day].[month].[year]") }

      // -- DARSTELLUNG MIT SICHERHEITSABSTAND --
      // HIER IST DER FIX: pad(bottom: 10mm) schiebt den Footer vom physischen Rand weg!
      pad(bottom: 10mm)[
        #if page-num == 1 {
          // -- Footer Seite 1 --
          align(bottom)[
             #block(width: 100%)[
               #line(length: 100%, stroke: 0.5pt + thws_orange)
               #v(0.5em)
               #set text(size: 8pt, fill: rgb("#666666"))
               
               #grid(
                 columns: (1fr, auto),
                 column-gutter: 1em,
                 align: (left + top, right + top),
                 
                 // Links: Department + Namen
                 [
                   #if department != "" { 
                      text(weight: "semibold")[#department] 
                      h(0.5em); text(fill: thws_orange)[|]; h(0.5em)
                   }
                   #author-string
                 ],
                 
                 // Rechts: Datum
                 [ #date-string]
               )
             ]
          ]
        } else {
          // -- Footer Folgeseiten --
          align(center + bottom)[
            #text(size: 9pt, fill: thws_orange)[ #page-num]
          ]
        }
      ] // Ende Padding
    }
  )

  // -------------------------------------------------------
  // 3. TYPOGRAFIE
  // -------------------------------------------------------
  set text(font: "Inter", size: 10pt, lang: "de")
  set par(leading: 5pt, spacing: 12pt, justify: true)
  show math.equation: set text(weight: 400)

  // Listen (Orange)
  set list(marker: (
    text(fill: thws_orange)[•],
    text(fill: thws_orange)[–],
    text(fill: thws_orange)[◦]
  ))
  set enum(numbering: (..nums) => {
    text(fill: thws_orange)[#numbering("1.", ..nums)]
  })

  // Überschriften
  set heading(numbering: "1.1 ")
  show heading: set text(fill: thws_orange, weight: "regular")
  show heading.where(level: 2): it => {
    set text(fill: thws_orange, weight: "regular", size: 11pt)
    pad(left: 0cm, it)
  }

  // Tabellen
  set table(
    stroke: (x: (paint: thws_orange, thickness: 0.5pt), y: (paint: thws_orange, thickness: 0.5pt)),
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

  // -------------------------------------------------------
  // 4. TITELBLOCK
  // -------------------------------------------------------
  v(1.5cm)
  align(center)[
    #block(text(fill: thws_orange, weight: 700, size: 1.75em)[#topic])
  ]

  if title != "" {
    v(4pt)
    align(center)[
      #text(fill: thws_orange, size: 15pt, weight: "semibold")[#title]
    ]
  }

  v(1cm)

  body
}
