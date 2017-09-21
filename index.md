---
output:
  html_document: default
  pdf_document: default
---
#  DATA SCIENCE 101


The course  provides a solid introduction to data science, both exposing students to computational tools they can proficently use to analyze data and exploring the conceptual challenges of inferential reasoning. Each module/week represents a new "data adventure," analyzing real datasets, exploring different questions and trying out tools.

There will be three traditional lectures per week and two labs with active students participation. Data analysis and computations will be carried out in R, a language that will be introduced during the course. There is no calculus prerequisite. Lecture notes, datasets, and labs markdowns will be available via the class web-page. Additional reading material and references will be made available.
There will be a weekly homework and an in class final exam.

Stats101 is a new course, and as such it does not appear in the lists of required classes for majors. The statistics department believes that the materials in Stats101 cover the topics traditionally taught in  Stats60. If your major requires Stats60, we invite you to ask your advisors if Stats101 could be accepted as a substitute.

[![Travis-CI Build Status](https://travis-ci.com/jonathan-taylor/datascience101.svg?branch=master)](https://travis-ci.com/jonathan-taylor/datascience101)

## Topics

1. Data science: what is the buzz about?

2. Data munging and wrangling

3. Numerical summaries of data

4. Visualization tools

5. Sampling variability and uncertainty of statistical estimates

6. Testing statistical hypotheses

7. Linear regression and prediction

8. High dimensional data and principal component analysis

9. Nonparametric statistics (transformations of the data, ranking, etc.)

10. Safegurding reproducibility: the challenges of multiple comparisons and data snooping

## Instructor & TAs

#### Instructors for Autumn 2017

- [Peter Mohanty](https://statistics.stanford.edu/people/peter-mohanty)

- [Jonathan Taylor](https://statistics.stanford.edu/people/jonathan-taylor)

- [Lucy Xia](https://statistics.stanford.edu/people/lucy-xia)


#### Teaching Assistants

- [Wenfei Du](wdul@stanford.edu), [Theodore Misiakiewicz](misiakie@stanford.edu)

 and 

#### Email list

The course has an email list that reaches all TAs as well as the professors: [stats101-aut1718-staff@lists.stanford.edu](mailto:stats101-aut1718-staff@lists.stanford.edu)

**As a general rule, you should send course related to this email list.**

Note that we will not respond to e-mails about the homework due on Friday if they are sent after 6pm on Thursday night. Office hours (which do not require an appointment) are often better for technical questions.

#### Office hours

- Tuesday 10:30-12:30 (Jonathan, Sequoia Hall 137)
- Wednesday 10:30-12:30 (Lucy, Sequoia Hall 207)
- Thursday 2:00-4:00 (Peter, Sequoia Hall 202 or by appointment)

## Schedule & Location

M-F 9:30-10:20, 200-205

## Prerequisites and credits

Some familiarity with elementary algebraic notation at the high school level
is assumed, but there is no calculus prerequisite. There is no computer science prerequisite either, but students must be willing to engage in computational and data analysis examples using software that will be introduced in class.

Datascience 101 fullfills the following undergraduate requirements GER: DB-NatSci, WAY-AQR.
If you are interested in a major that has Stats60 or Stats190 as a requirement, we encourage you to enquire with your advisors about the possibility of substituting this with Stats101.

## Evaluation

The grade in the class will be determined on the basis of

* weekly homework assignments (60%) (worse grade will be dropped)
* final in class exam. (40%)

#### Homework

- Text will be available on the class web-page, for solutions you will log into CANVAS.

- You may discuss homework problems with other students and with TAs in office hours, but you have to prepare the solutions yourself.

- As a general rule, we ask students NOT to complete the assignments during TAs' in office hours. This will be easier if students do not use laptops while in TAs' office hours.

- We do not accept late homework unless there is a documented medical/family emergency or an OAE letter.

## Modules materials

#### 0. If you want a head start

In this class, we will be using the
[R language](https://www.r-project.org) heavily in class notes,
examples and lab exercises. R is free and you can install it like any
other program on your computer.

1. Go to the [CRAN](https://cloud.r-project.org/) website and download
it for your Mac or PC.

2. Install the free version of the
[RStudio](https://www.rstudio.com/products/rstudio/download/) Desktop Software.

3. Go through our [install instructions](install.html)

#### 1. Introduction to Data Science

- Lecture Notes
    * [Lecture 1](intro/intro-lecture01.html-OPEN_NEWTAB), [Lecture 2](intro/intro-lecture02.html-OPEN_NEWTAB)

<!-- - [Homework](intro/intro-HW.html) -->
- Labs and markdowns as a [zip](intro/intro.zip)
- Reading Materials
    * [Introduction to R for Data Science](http://r4ds.had.co.nz/introduction.html)
    * [The big data religion](https://www.forbes.com/sites/gilpress/2014/09/09/the-government-academia-complex-and-big-data-religion/#4f84b89c2a10
)
    * [Google flu](https://www.ncbi.nlm.nih.gov/pubmed/19020500)
    * [Google flu revisited](https://www.ncbi.nlm.nih.gov/pubmed/24626916)
    * [The effectiveness of data](http://ieeexplore.ieee.org/document/4804817/)
    * [Snow on cholera](https://www.inferentialthinking.com/chapters/02/causality-and-experiments.html)
    * [An invitation to reproducible computational research](https://academic.oup.com/biostatistics/article-lookup/doi/10.1093/biostatistics/kxq028)

#### 2. Manipulation of Data

- Lecture notes
    * [Lecture 1](data/data-lecture01.html-OPEN_NEWTAB), [Lecture 2](data/data-lecture02.html-OPEN_NEWTAB), [Lecture 3](data/data-lecture03.html-OPEN_NEWTAB)
<!-- - [Homework](data/data-HW.html-OPEN_NEWTAB) -->
- Labs and markdowns as in [zip](data/data.zip)
- Reading materials
    * [R for data science](http://proquest.safaribooksonline.com/book/programming/r/9781491910382), especially chapters 3,7,8.
    
#### 3. Data summaries


- Lecture notes
    * [Lecture 1](summaries/summaries-lecture01.pdf-OPEN_NEWTAB), [Lecture 2](summaries/summaries-lecture02.pdf-OPEN_NEWTAB), [Lecture 3](summaries/summaries-lecture03.pdf-OPEN_NEWTAB)
- [Homework](summaries/summaries-HW.html-OPEN_NEWTAB)
- Labs and markdowns as in [zip](summaries/summaries.zip)
- Reading materials
    * [How to Compute a Mean? The Chisini Approach and Its Applications](http://www.tandfonline.com/doi/pdf/10.1198/tast.2009.0006)
    * [Inequality in the long run](http://science.sciencemag.org/content/344/6186/838)
    * [Genetic Structure of Human Populations](http://science.sciencemag.org/content/298/5602/2381.full?ijkey=veI1vMttkE%255CTr.&keytype=ref&siteid=sci)


#### 4. Visualization

- Lecture notes
    * [Lectures 1 and 2](visualization/visualization-lecture01.html-OPEN_NEWTAB), [Lecture 3](visualization/visualization-lecture02.html-OPEN_NEWTAB)
<!-- -[Homework](visualization/visualization-HW.html-OPEN_NEWTAB) -->
- Labs and markdowns as in [zip](visualization/visualization.zip)
- Reading materials
    * [R for data science](http://proquest.safaribooksonline.com/book/programming/r/9781491910382), especially chapters 1,5.

#### 5. Sampling variability

- Lecture notes
    * [Lecture 1](sampling/sampling-lecture01.pdf-OPEN_NEWTAB), [Lecture 2](sampling/sampling-lecture02.pdf-OPEN_NEWTAB), [Lecture 3](sampling/sampling-lecture03.pdf-OPEN_NEWTAB)
<!-- - [Homework](sampling/sampling-HW.html-OPEN_NEWTAB) -->
- Labs and markdowns as in [zip](sampling/sampling.zip)
- Reading materials
    * Efron and Tibshirani (1980) "Introduction to the Bootstrap": [Introduction](https://books.google.com/books?id=gLlpIUxRntoC&pg=PA1&source=gbs_toc_r&cad=3#v=onepage&q&f=false), [Accuracy of the sample mean](https://books.google.com/books?id=gLlpIUxRntoC&pg=PA10&source=gbs_toc_r&cad=3#v=onepage&q&f=false).
    * Stigler (1989) [Francis Galton's Account of the Invention of Correlation](https://projecteuclid.org/download/pdf_1/euclid.ss/1177012580)

#### 6. Inference

- Lecture notes
    * [Lectures 1 and 2](inference/inference-lecture01.html-OPEN_NEWTAB), [Lecture 3](inference/inference-lecture02.html-OPEN_NEWTAB), 
<!-- -[Homework](inference/inference-HW.pdf-OPEN_NEWTAB) -->
- Labs and markdowns as in [zip](inference/inference.zip)

#### 7. Prediction

- Lecture notes
    * [Lecture 1](prediction/prediction-lecture01.html-OPEN_NEWTAB), [Lecture 2](prediction/prediction-lecture02.html-OPEN_NEWTAB), [Lecture 3](prediction/prediction-lecture03.html-OPEN_NEWTAB)

<!-- - [Homework](prediction/prediction-HW.pdf-OPEN_NEWTAB) -->
- Labs and markdowns as in [zip](prediction/prediction.zip)

#### 8. Principal Component Analysis

- Lecture notes
    * [Lecture 1](principal_components/principal_components-lecture01.pdf-OPEN_NEWTAB), [Lecture 2](principal_components/principal_components-lecture02.pdf-OPEN_NEWTAB), [Lecture 3](principal_components/principal_components-lecture03.pdf-OPEN_NEWTAB)
<!-- - [Homework](principal_components/principal_components-HW.html) -->
- Labs and markdowns as in [zip](principal_components/principal_components.zip)
- Reading materials
    * [Stack exchange on PCA](https://stats.stackexchange.com/questions/2691/making-sense-of-principal-component-analysis-eigenvectors-eigenvalues)
    * Stigler (1997) [Regression towards the mean, historically considered](http://smm.sagepub.com/content/6/2/103.full.pdf+html)
    * Handout distributed in class
    * [Genes mirror geography within Europe](https://www.nature.com/nature/journal/v456/n7218/pdf/nature07331.pdf)

#### 9. Non parametric statistics and review

- [Lecture notes](https://canvas.stanford.edu/courses/64451/files-OPEN_NEWTAB)
- Labs and markdowns as in [zip](https://canvas.stanford.edu/courses/64451/files-OPEN_NEWTAB)

#### 10. Reproducibility

- Lecture notes
    * [Lecture 1](replicability/replicability-lecture01.pdf-OPEN_NEWTAB), [Lecture 2](replicability/replicability-lecture02.pdf-OPEN_NEWTAB), [Lecture 3](replicability/replicability-lecture03.pdf-OPEN_NEWTAB)
- Reading materials
    * The Economist (October  2013) How science goes wrong
    * NYT (2014) [New Truths That Only One Can See](https://www.nytimes.com/2014/01/21/science/new-truths-that-only-one-can-see.html)
    * [Science isn't broken, a blog entry from fivethirtyeight.com](http://fivethirtyeight.com/features/science-isnt-broken/#part1)
