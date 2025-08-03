#import "@preview/physica:0.9.4": *
#import "@preview/unify:0.7.0": num, numrange, qty, qtyrange
#import "@preview/equate:0.3.1": equate
#import "@preview/mitex:0.2.5": *
#import "@preview/wrap-it:0.1.1": wrap-content as wrap_content_original

#let small = 10pt
#let normal = 11pt
#let large = 13pt
#let Large = 15pt
#let LARGE = 18pt
#let huge = 25pt

#let base(
  title: none,
  name: none,
  email: none,
  date: datetime.today().display("[day] [month repr:long] [year]"),
  body,
) = {
  set document(title: title, author: name, date: none)

  set page(
    paper: "a4",
    margin: (x: 1in, y: 1in, top: 1in + 5pt),
    numbering: "1",
  )

  set text(size: normal, lang: "en", region: "GB")


  /* === FONTS === */
  /* OPTION 1 */

  set text(font: "STIX Two Text")
  show math.equation: set text(font: "STIX Two Math")

  /* OPTION 2 */

  // set text(font: "Lora")
  // show math.equation: set text(font: "New Computer Modern Math", size: 11.2pt)


  /* OPTION 3 */
  // set text(font: "XCharter")
  // show math.equation: set text(font: "XCharter Math")
  // set text(font: "PT Serif")

  /* === END FONTS === */

  show: equate.with(breakable: true, sub-numbering: false)
  set math.equation(supplement: "Eq.")

  set math.equation(numbering: (..num) => numbering("(1.1)", counter(heading).get().first(), num.pos().first()))

  set figure(numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()))

  set par(
    justify: true,
    first-line-indent: 1.8em,
    spacing: 0.7em,
    leading: .77em,
  )

  set heading(numbering: "1.1.1")
  show heading: set block(above: 1em, below: .5em + 5pt)

  show heading.where(level: 2): it => {
    set text(size: LARGE)
    it
  }

  show heading.where(level: 3): it => {
    set text(size: Large)
    it
  }

  show heading: it => {
    if (it.depth >= 2) {
      block(counter(heading).display(it.numbering) + h(1em) + it.body)
    } else {
      it
    }
  }

  show cite: it => {
    // Only color the number, not the brackets.
    show regex("\d+"): set text(fill: blue)
    // or regex("[\p{L}\d+]+") when using the alpha-numerical style
    it
  }

  show ref: it => {
    if it.element == none {
      // This is a citation, which is handled above.
      return it
    }

    show regex("([0-9]+\.[0-9]+\.[0-9]+)|([0-9]+\.[0-9]+)|([0-9]+)"): set text(fill: olive)

    // First check if it.element has "kind", which is not the case for footnotes.
    if (it.element.has("kind")) and it.element.kind == math.equation {
      show regex("^(\d+)(\.(\d+))*(\/(\d+))*-(\d+)$"): x => "(" + x + ")"
      it
    } else {
      it
    }
  }

  show regex(" - "): [ #sym.dash ]

  body
}

#let figures(body) = {
  let getNumbering(it) = {
    if it.kind == table {
      "I"
    } else {
      it.numbering
    }
  }

  show figure.caption: c => {
    text(size: small)[
      #context {
        text(weight: "bold")[
          #c.supplement #c.counter.display(getNumbering(c))#c.separator
        ]
      }
      #c.body
    ]
  }

  // if caption size is longer than page, justify left

  show figure.caption: c => context {
    if measure(c).width > (page.width - page.margin.left - page.margin.right) {
      set align(left)
      c
    } else {
      c
    }
  }

  show figure.where(kind: table): set figure.caption(position: top)

  body
}

#let wrap-content(
  fixed,
  to-wrap,
  alignment: top + left,
  size: auto,
  ..grid-kwargs,
) = {
  // Modifying the wrap-content function from the wrap-it package for extra styling.
  // Wrap caption to figure width and text align left

  show figure: it => {
    let w = measure(it.body).width

    show figure.caption: cap => box(width: w, [
      #set par(justify: true)
      #set align(left)
      #cap
    ])
    it
  }

  wrap_content_original(fixed, to-wrap, align: alignment, size: size, ..grid-kwargs)
}

#let report(body) = {
  set page(
    header: context {
      let currpage = counter(page).get().first()
      let chapterpages = query(heading.where(level: 1)).map(chapter => {
        chapter.location().page()
      })
      let headings = query(heading.where(level: 1).before(here())).map(it => {
        if it.numbering != none {
          let num = numbering(it.numbering, ..counter(heading).at(it.location()))
          smallcaps[Chapter #num: #it.body]
        } else {
          smallcaps[#it.body]
        }
      })


      if currpage not in chapterpages [
        #headings.at(-1, default: "") #h(1fr) Victor Vreede
        #v(-3pt)
        #line(length: 100%)
        #v(-5pt)
      ]
    },
    numbering: "1",
  )

  show heading.where(level: 1): it => {
    let chapternum = counter(heading).get().first()

    pagebreak()
    v(-30pt)
    set par(justify: false)
    box(
      text(size: 25pt)[
        #it.body
      ],
      width: 80%,
    )
    h(1fr)

    if it.numbering != none {
      text(size: 70pt, fill: rgb(80, 80, 80), weight: "semibold", font: "Lora")[
        #numbering(it.numbering, chapternum)
      ]
    }
    line(length: 100%)
  }

  // For some reason, this needs to be after we have function for our fancy heading. Very weird.

  show heading.where(level: 1): it => {
    counter(figure.where(kind: raw)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(math.equation).update(0)
    it
  }

  show outline.entry: it => {
    link(it.element.location())[
      #it.indented(it.prefix(), it.inner(), gap: 1.4em)]
  }

  show outline.entry.where(level: 1): it => {
    show repeat: none
    v(11pt)
    strong(it)
  }

  set outline.entry(fill: repeat([#h(2pt).#h(2pt)]))

  body
}

#let appendix(body) = {
  set heading(numbering: "A", supplement: [Appendix])
  counter(heading).update(0)

  set math.equation(numbering: (..num) => numbering("(A.1)", counter(heading).get().first(), num.pos().first()))

  set figure(numbering: (..num) => numbering("A.1", counter(heading).get().first(), num.pos().first()))


  body
}

#let chem(body) = {
  show regex("[\d]+"): sub
  body
}

#let switch-page-numbering() = {
  // to do: get updated page numbers to work
  counter(page).update(1)
  set page(numbering: "1")
}

#let makecoverpage(
  img: image("../template/img/cover-image.jpg"),
  title: none,
  name: none,
) = context {
  let pw = page.width
  let ph = page.height
  set image(width: pw, height: ph, fit: "cover")
  set page(background: img, margin: 0pt)
  set par(first-line-indent: 0pt, justify: false, leading: 1.5em)

  place(left + horizon, dx: 12pt, rotate(-90deg, origin: center, reflow: true)[
    #text(fill: white, font: "Roboto Slab")[Delft University of Technology]])


  place(dy: 2cm, rect(width: 100%, inset: 30pt, fill: color.hsv(
    0deg,
    0%,
    0%,
    50%,
  ))[
    #text(fill: white, size: 45pt, font: "Roboto Slab", weight: "light")[
      #title
    ]
    #linebreak()
    #v(10pt)
    #text(fill: white, size: 30pt, font: "Roboto Slab", weight: "light")[
      #name
    ]
  ])


  set image(width: 6cm)
  place(
    bottom,
    dx: 1cm,

    image(
      "../template/img/TUDelft_logo_white.svg",
      width: 6cm,
      height: auto,
      fit: "contain",
    ),
  )
}

#let maketitlepage(
  title: none,
  name: none,
  defense_date: datetime.today().display("[weekday] [month repr:long] [day], [year]") + " at 10:00",
  student_number: none,
  project_duration: none,
  daily_supervisor: none,
  cover_description: none,
  ..thesis_committee,
) = {
  show par: set align(center)
  set par(spacing: 1.3em, justify: false)
  set page(numbering: none, margin: (bottom: 0pt))

  text(size: 40pt, font: "Roboto Slab", weight: "light")[#title]
  v(-15pt)

  [by]
  parbreak()
  text(size: 25pt, font: "Roboto Slab", weight: "light")[#name]
  parbreak()
  [to obtain the degree of Master of Science]
  //ter verkrijging van de graad van Master of Science
  parbreak()
  [at the Delft University of Technology,]
  //aan de Technische Universiteit Delft,
  parbreak()
  [to be defended publicly on #defense_date]
  //in het openbaar de verdedigen op maandag 1 januari om 10:00 uur.
  v(40pt)
  // [..#thesis_committee]
  // let thesis_committee = ([p1], [p2], [p3], [p4])

  // place(
  //   auto,
  //   float: true,
  align(center)[#table(
      columns: (4cm, 4cm, 4cm),
      stroke: none,
      align: (right, left, left),
      [Student number:], table.cell(colspan: 2)[#student_number],
      [Project Duration:], table.cell(colspan: 2)[#project_duration],
      [Daily Supervisor:], table.cell(colspan: 2)[#daily_supervisor],
      [Thesis Committee:],
      table.cell(rowspan: 3, colspan: 2)[#table(columns: (
            4cm,
            4cm,
          ), stroke: none, align: (
            left,
            left,
          ), inset: 0pt, row-gutter: 10pt, ..thesis_committee)],
    )]
  // )

  v(20pt)

  [Cover: #cover_description]

  v(1fr)
  [An electronic version of this thesis is available at #link(" http://repository.tudelft.nl").]
  // v()

  align(center)[#image("../template/img/TUDelft_logo_black.svg", width: 4.5cm)]
}
