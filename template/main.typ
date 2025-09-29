// IMPORTS: Note: these imports need to repeated for every file used in the document.

// Main Import for the template
// Includes wrap-it and equate packages by default.
#import "@local/tudelft-thesis:0.1.0": *

// Extra packages to your liking
// Physics-reltated tools for equations
#import "@preview/physica:0.9.4": *
// Specifying quantities and units
#import "@preview/unify:0.7.0": num, numrange, qty, qtyrange
// Formatting of uncertainties
#import "@preview/zero:0.4.0"


// Base styling, containg the majority of typesetting including fonts, line sizes, heading sizes, styling of references, lists.

#show: base.with(
  title: "My document",
  name: "Your Name",
  email: "yourname@example.com",
  date: "January 2024",
  main-font: "Stix Two Text",
  math-font: "Stix Two Math",
  ref-color: blue,
  cite-color: olive,
)



#show: figures

/* COVER PAGE */

#makecoverpage(
  // supply path to cover image
  img: image("img/cover-image.jpg"),
  // These arguments speak for themselves
  title: [Title of Thesis],
  subtitle: [Subtitle],
  name: [Your Name],
  // optional: change color to big box containing title, subtitle and name. Default is full black with 50% opacity.
  // main_titlebox_fill: color.hsv(0deg, 0%, 63.92%, 50%)
)

/* TITLE PAGE */

#maketitlepage(
  // These first arguments are self-explenatory
  title: [Title of Thesis],
  subtitle: [Subtitle],
  name: "Your Name",
  defense_date: datetime.today().display("[weekday] [month repr:long] [day], [year]") + " at 10:00",
  // These following arguments appear in a small table below the main title, subtitle, author
  student_number: 1234567,
  project_duration: [Starting month and year - Ending month and year],
  daily_supervisor: [Your Daily supervisor],
  cover_description: [Photo by #link("https://unsplash.com/@thejoltjoker?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash", "Johannes Andersson") on #link("https://unsplash.com/photos/two-brown-deer-beside-trees-and-mountain-UCd78vfC8vU?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash", "Unsplash").
  ],
  // Some more options of a publicity statement:
  // publicity-statement: [An electronic version of thesis is available at #link("https://repository.tudelft.nl", [`https://repository.tudelft.nl`]).],
  // publicity-statement: smallcaps[This thesis is confidential and cannot be made public.],
  publicity-statement: none,
  // The final set of arguments form the content of a table outlining all your supervisors. You can add as little or many as you want.
  [Supervisor 1],
  [TU Delft, Supervisor],
  [Committee member 2],
  [TU Delft],
  [Committee member 3],
  [TU Delft.],
)

// This report function contains further styles, setting the formatting of the chapter title, the header

#show: report.with(
  // The Left header of a page is the current chapter title. The Left header you can specify, I reccomend adding your name here.
  rightheader: [Your name],
)


#heading(numbering: none, [Preface])

// Your preface here
// #lorem(250)



#heading(numbering: none, [Abstract])

// Your Abstract here
// #lorem(250)


#outline()

#show: switch-page-numbering

#include "./sections/1introduction.typ"
#include "./sections/2theory.typ"
#include "./sections/3methods.typ"
#include "./sections/4results.typ"
#include "./sections/5conclusion.typ"


#bibliography("references.bib", style: "american-physics-society")


#show: appendix

#include "./sections/6appendix.typ"

