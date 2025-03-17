#import "@preview/physica:0.9.4": *
#import "@preview/unify:0.7.0": num,qty,numrange,qtyrange
#import "@preview/equate:0.3.1": equate

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
  leftheader: none,
  rightheader: none,
  body,
) = {
  set document(
    title: title, 
    author: name, 
    date: none
  )
  
  set page(
    paper: "a4",
    margin: (x: 1in, y: 1in, top: 1in + 10pt),
    header: context {
      if leftheader != none or rightheader != none {
        let currpage = counter(page).get().first()
        if currpage > 1 [
          #leftheader #h(1fr) #rightheader
          #v(-3pt)
          #line(length: 100%)
        ]
      }
    },
    numbering: "1"
  )
  
  set text(
    size: normal,
    lang: "en"
  )



  /* === FONTS === */
  /* OPTION 1 */
  
  set text(font: "XCharter")
  show math.equation: set text(font: "STIX Two Math")

  /* OPTION 2 */
  
  // set text(font: "Lora")
  // show math.equation: set text(font: "New Computer Modern Math", size: 11.2pt)

  /* === END FONTS === */
  
  show: equate.with(breakable: true, sub-numbering: false)
  set math.equation(numbering: "(1)", supplement: "Eq.")
    
  set par(
    justify: true,
    first-line-indent: 1.8em,
    spacing: 0.7em,
    leading: .77em
  )

  set heading(
    numbering: "1.1.1"
  )
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

    show regex("[\d]+"): set text(fill: olive)

    // First check if it.element has "kind", which is not the case for footnotes.   
    if (it.element.has("kind")) and it.element.kind == math.equation {
      show regex("[\d]+"): (x) => "(" + x + ")" 
      it
    } else {
      it
    }
  }

  body

}

#let maketitle(title: none,
  name: none,
  email: none,
  date: datetime.today().display("[day] [month repr:long] [year]")
) = {
  v(-15pt)
  show par: set align(center)
  set par(spacing: 1.3em)
  
    text(20pt)[#title]
    parbreak()
    text(14pt)[#name]
    parbreak()
    text(12pt)[
     #link("mailto:" + email)
    ]
    v(3pt)
    date
    v(10pt)
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
      #context {text(weight: "bold")[
        #c.supplement #c.counter.display(getNumbering(c))#c.separator
      ]} 
      #c.body
    ]
  }

  show figure.caption: c => context {
    if measure(c).width > (page.width - page.margin.left - page.margin.right) {
      set align(left)
      c
    } else {
      c
    }
  }
  
  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  body
}

#let report(body) = {
  
  set page(
    header: context {
      let currpage = counter(page).get().first()
      let chapterpages = query(heading.where(level: 1)).map(chapter => {
        chapter.location().page()
      })
      let headings = query(heading.where(level: 1).before(here())).map(it => {
        let num = if it.numbering != none {
          numbering(it.numbering, ..counter(heading).at(it.location()))
        }
      smallcaps[Chapter #num: #it.body]
      })

      
      if currpage not in chapterpages [
       #headings.last() #h(1fr) Victor Vreede
      #v(-3pt)
      #line(length: 100%)
      ]
    
    },
    numbering: "1"
  )

  show heading.where(level: 1): it => {
    let chapternum = counter(heading).get().first()
    
    pagebreak()
    v(-30pt)
    set par(justify: false)
    box(
    text(size: 25pt)[
      #it.body
    ], width: 80%)
    h(1fr)

    if it.numbering != none {
      text(size: 70pt, fill: rgb(80,80,80), weight: "semibold")[
        #numbering(it.numbering, chapternum)
      ]
    }
    line(length: 100%)
  }
  
  // Rendered obselete as of typst 13.0
  // show outline.entry: it => context {
  //   if it.element.func() == heading {
  //     let head = it.element 

  //     let spacings = (0em, 2em, 4.3em, 6.9em)
  //     let number_start = spacings.at(it.level - 1)
  //     let body_start = spacings.at(it.level)

  //     let number = if head.numbering != none {
  //       numbering(head.numbering, ..counter(heading).at(head.location()))
  //     } else {
  //       ""
  //     }

  //     if head.numbering == none {
  //       body_start = 0em
  //     }
      
  //     let fill = box(width: 1fr, it.fill)
      
      
  //     [#h(number_start) #link(head.location())[#box()[#number #h(body_start - number_start - measure(number).width - 3pt) #head.body]] #fill #it.page() #linebreak()] 
  //   }
  // }

  show outline.entry: it => {
    link(it.element.location())[
      #it.indented(
        it.prefix(),
        it.inner(),
        gap: 1.4em
    )]
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
  body
}

#let chem(body) = {
  show regex("[\d]+"): sub
  body 
}


#let switch-page-numbering() = {

  // to do: get updated page numbers to work
  counter(page).update(1)
  set page(numbering: "1",)
  
}

  

