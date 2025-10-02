

This repository provides a Typst template to write a thesis in the TU Delft style. This is an unofficial template, not affiliated with the TU Delft.

| Cover page               | Title page               | Main text                |
|--------------------------|--------------------------|--------------------------|
| ![Cover page](https://raw.githubusercontent.com/Vector04/tudelft-thesis-template/refs/heads/master/docs/example-p1.png) | ![Title Page](https://raw.githubusercontent.com/Vector04/tudelft-thesis-template/refs/heads/master/docs/example-p2.png) | ![Main Text Page](https://raw.githubusercontent.com/Vector04/tudelft-thesis-template/refs/heads/master/docs/example-p6.png) |

## How to use
Initialize the template, either via the web app directly or using

```
typst init @preview/tudelft-thesis:0.1.0
```
A small example of the template in action is given below. Please consult this document for a larger example of the thesis template in action. In addition, the default project also contains sufficient comments/annotations to get you started.
```typst
#import "@local/tudelft-thesis:0.1.0": *

// Main styling, containg the majority of typesetting including document layout, fonts, heading styling, figure styling, outline styling, etc. Some parts of the styling are customizable.
#show: base.with(
  title: "My document",
  name: "Your Name",
  rightheader: "Your name",
)

#makecoverpage(
  img: image("img/cover-image.jpg"),
  title: [Title of Thesis],
  subtitle: [Subtitle],
  name: [Your Name],
)

#maketitlepage(
  title: [Title of Thesis],
  subtitle: [Subtitle],
  name: "Your Name",
  defense_date: datetime.today().display("[weekday] [month repr:long] [day], [year]") + " at 10:00",
  student_number: 1234567,
  project_duration: [Starting month and year - Ending month and year],
  daily_supervisor: [Your Daily supervisor],
  cover_description: [Photo by ...],
  publicity-statement: none,
  // The final set of arguments form the content of a table outlining all your supervisors. You can add as little or many as you want.
  [Supervisor 1],
  [TU Delft, Supervisor],
  [Committee member 2],
  [TU Delft],
  [Committee member 3],
  [TU Delft.],
)

#heading(numbering: none, [Preface])
#heading(numbering: none, [Abstract])

#outline()

#show: switch-page-numbering

/* Your content here */

#bibliography(
  "references.bib",
  title: [References],
  style: "american-physics-society",
)

#show: appendix

/* Appendix content here */
```

## License

The template code and starting template files are licensed under the MIT-0 License. 

I do not own the copyright to the TU Delft logo. 

The assets used as placeholders in the template are by [Johannes Andersson]("https://unsplash.com/@thejoltjoker?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash") and [karem adem]("https://unsplash.com/@fezeikahapra?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash").