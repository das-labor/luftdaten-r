# luftdaten-r
Analysis in R of the data of luftdaten.info

* Download of city boundaries in OSM via overpass-turbo.eu: `type:relation and id:62713`.


### Folder structure

* evaluation
    - create a new subfolder for each independend analysis
    - copy or link reusable codes or scripts into `scripts`

<pre>
├── evaluation
│   └── scripts
│       ├── clean.R
│       ├── do.R
│       ├── func.R
│       └── load.R
├── LICENSE
</pre>

* literature
    - if you have literature to share or is used in Rmd-files put a corresponding bibliography into `literature`

<pre>
├── literature
│   ├── citation-320290135.bib
│   ├── citation-320290219.bib
│   ├── citation-320474792.bib
│   ├── citation-320537200.bib
│   ├── citation-321098824.bib
│   ├── citation-322628807.bib
│   └── citation-329809390.bib
</pre>

* main project file with settings

<pre>
├── luftdaten-r.Rproj
</pre>

* paper
    - Rmd-files for each possible chapter

<pre>
├── paper
│   ├── abstract.Rmd
│   ├── discussion.Rmd
│   ├── introduction.Rmd
│   ├── methods.Rmd
│   ├── paper.Rmd
│   └── results.Rmd
└── README.md
</pre>
4 directories, 20 files
