#import "@local/tudelft-thesis:0.1.0": *

#show: base.with(
  title: "My document",
  name: "Your Name",
  email: "yourname@example.com",
  date: "January 2024",
)



#show: figures

/* COVER PAGE */

#makecoverpage(
  img: image("img/cover-image.jpg"),
  title: [My Document],
  name: [Your Name],
)

/* TITLE PAGE */

#maketitlepage(
  title: [My Document],
  name: "Your Name",
  defense_date: datetime.today().display("[weekday] [month repr:long] [day], [year]") + " at 10:00",
  student_number: 1234567,
  project_duration: [Starting month and year - Ending month and year],
  daily_supervisor: [Your Daily supervisor],
  cover_description: [Space and stuff],
  [Supervisor 1],
  [TU Delft, Supervisor],
  [Committee member 2],
  [TU Delft],
  [Committee member 3],
  [TU Delft.],
)


#show: report


#heading(numbering: none, [Preface])
#lorem(250)



#heading(numbering: none, [Abstract])
#lorem(250)


#outline()

= Introduction

== Equations and packages

Here follows a small overview of how different report elements look in this template.

For example, here is a new paragraph containing two aligned equations:
$
  e^(pi i) & = -1 #<eulers_formula> \
    (n+1)! & = integral_0^infinity t^n e^(-t) dif t #<cauchy_factorial>
$
Here @eulers_formula is Euler's formula, and @cauchy_factorial is Cauchy's formula for a factorial. Note that the ability to refer to them individually is via the `equate` package. If I want to specify certain quantities, this can be done via the `#qty` function. For example, an A4 paper is #qty("210", "mm") wide. To make writing frequently occurring physics notation easier, use shortcuts provided by the `physica` package:
$
  laplacian u = 1/c^2 dv(u, t, 2)
$ <eq:wave_equation>
@eq:wave_equation is also known as the wave equation.

== Floating elements
Tables and images can be inserted into the document via the `#figure` function. Here follow some examples, which are @fig:large-image and @fig:small-image.

#figure(
  image("img/sample-image.svg"),
  caption: [An example of a large figure. Illustration by #link("https://unsplash.com/@fezeikahapra?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash")[karem adem] on #link("https://unsplash.com/illustrations/planets-stars-and-space-aPazlNkm25o?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash")[Unsplash].],
) <fig:large-image>



#let fig = [
  #figure(
    image("img/sample-image.svg", width: 7cm),
    caption: [An example of a small figure. Illustration by #link("https://unsplash.com/@fezeikahapra?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash")[karem adem] on #link("https://unsplash.com/illustrations/planets-stars-and-space-aPazlNkm25o?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash")[Unsplash].],
  ) <fig:small-image>
]

#wrap-content(
  fig,
  [For smaller figures, it is also possible wrap them within text. For example, @fig:small-image. #lorem(65)],
  alignment: top + right,
)

== Referencing stuff



== Motivation
#lorem(100)

Here is some more text. #strong[This is bold text]


// Adding a figure

#figure(
  image("img/stress_field.svg"),
  caption: [Stress fields of the Hertz model],
  placement: auto,
) <hertz-field>

#figure(
  image("img/stress_field.svg"),
  caption: [Stress fields of the Hertz model with a very long caption spanning multiple words if I keep writting sufficiently much.],
  placement: auto,
) <hertz-field2>



#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [Timing results],
)


=== Approach
#lorem(100) Stress fields of ther Hertz model are shown in @hertz-field. I make a cool remark, #footnote[This is a footnote] <fn1> which I repeat. @fn1

Here is are chemical formulae: #chem[CuCrP2S6] #chem[H2O]. I learned this from @yamanaka_nanoscale_2000. I have many references @asmatulu_characterization_2019@binnig_atomic_1986@boussinesq_application_1885


= A new chapter #sym.dash investigation into nature

#lorem(100)



#bibliography("references.bib", style: "american-physics-society")


#show: appendix

= The first Appendix

= The second Appendix
