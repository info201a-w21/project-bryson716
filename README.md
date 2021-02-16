# Final Project
Use this `REAMDE.md` file to describe your final project (as detailed on Canvas).

## Project Proposal

### Domain of Interest
* Why are you interested in this field/domain?
> We feel that investigating mental health is important because it directly impacts people's lives and has become a growing issue in the U.S. It is also important to acknowledge the effect intersectionality has on an individual's mental health.
* What other examples of data driven project have you found related to this domain (share at least 3)?
  * [“Mental Health”](https://ourworldindata.org/mental-health) is a data visualization project that focuses on breaking down world data on mental health by disorder, gender, and country. It also explores the link between mental health disorders and suicide, as well as its relationship with factors such as employment status, education level, and life satisfaction.
  * [“OSMI Mental Health Data Visualization”](https://nidhi729.github.io/DataVis-Mental-Health/) is a project that works to demonstrate the prevalence of mental health within the IT industry. Through charts, interactive maps, and more, the project covers data on everything from age range to willingness to discuss mental health disorders with peers.
  * [“Behavioral Health Conditions in the United States”](https://www.recoverymonth.gov/sites/default/files/toolkit/2017-data-visualizations.pdf) is an infographic that educates its audience on the number of Americans that deal with mental health issues relative to the number that get the treatment they need. Likewise, the infographic points out that many depression and substance abuse cases remain untreated in the US.
  * [“GBD Compare”](https://vizhub.healthdata.org/gbd-compare/) is an interactive data project that allows the user to compare different disability and mortality rates from diseases, injuries, and risk factors in the world. The data can be filtered by cause, deaths, years lived with disability, age, sex, and more.
* What data-driven questions do you hope to answer about this domain (share at least 3)?
  * How does mental health affect different demographics of people?
  * Are there any disparities between different groups of people and mental health outcomes (specifically gender and race)?
  * Are there disparities in the type of treatment different groups of people receive?
  * What are the most prevalent mental illnesses in society?

  ### Finding Data
* **2018 Mental Health Client-level Data**
  * We downloaded the data from [SAMHDA](https://www.datafiles.samhsa.gov/study-dataset/mental-health-client-level-data-2018-mh-cld-2018-ds0001-nid19104), a data archive for the Substance Abuse and Mental Health Services Administration.
  * The data was collected from clients who receive mental health services provided/funded by state mental health agencies (SMHA).
  * The data focuses on clients as individual rows. It is meant to show what services people are receiving for mental health through the state. Data was collected by each state's SMHA individually and combined to form a record of 2018. It is important to note that some states and territories were excluded from data collection (see note on website).
  * There are 6213791 observations in this dataset.
  * There are 40 features in this dataset.
  * This dataset can be used to help answer questions relating to demographic disparities in mental illness diagnosis and treatment.
* **OMSI Mental Health in Tech Surveys**
  * A series of OSMI Mental Health in Tech Survey datasets were downloaded via the [Kaggle website](https://www.kaggle.com/osmihelp).
  * OSMI collected online surveys from random people who work in the tech industry.  
  * Open Sourcing Mental Illness (OSMI) is a non-profit organization that helps raise awareness about mental health in the tech industry. The data helps offer the perspectives of the mental health issues that many tech people face.
  * There were 180-1433 observations from OSMI Mental Health in Tech Surveys 2016-2020.
  * There were 82-123 features in the data.
  * This dataset can help us find the answers on how many people who work in the tech industry are affected by mental illnesses, whether there are disparities in race, and what types of mental illnesses these tech people face.

* **Unemployment and mental illness survey**
  * The data was downloaded from Kaggle.com at [this URL](https://www.kaggle.com/michaelacorley/unemployment-and-mental-illness-survey)
  * The data was collected through a paid research study on Survey Monkey, with a general population sampling. The general population sampling is thought to be accurate because the number of people who identified as having mental illness was consistent with larger samples.
  * The data was collected by Michael Corley in an attempt to explore the linkage between mental illness and unemployment. The data contains demographic and socioeconomic data paired with the mental health status of several hundred respondents. This data will be able to show the prevalence and severity of mental health issues due to many of these demographic and socioeconomic factors.
  * There are __334__ observations (rows) in this dataset.
  * There are __31__ features (columns) in this dataset.
  * The data within "Unemployment and mental illness survey" will help answer questions about how mental health affects different demographics and if there's any patterns in severity. This data can also help answer the question of which mental illnesses are most prevalent among a population.
* **GBD Results Tool**
  * The data CSV was downloaded using a [web URL](https://s3.healthdata.org/gbd-api-2019-public/c96f6bc830512de44d86f3d5d38ff0f9_files/IHME-GBD_2019_DATA-c96f6bc8-3.zip).
  * The data was collected through a variety of methods, including censuses, vital registrations, surveys, and registries. GBD prides itself on the diversity of its data, also citing sources like verbal interviews.
  * Because the GBD draws data from over 90,000 sources, the data has been collected by people ranging from those who work under major organizations like the World Health Organization (WHO) to local collaborators that are part of the GBD's network. This specific dataset revolves around the different mental illnesses people suffer from worldwide and includes factors such as their ethnicity, sex, and age.
  * There are 500,000 observations.
  * There are 10 features.
  * This data can be used to answer the two questions regarding the demographics of those that suffer from mental illnesses, as well as the one asking which mental illness is the most prevalent globally.

## Exploratory Analysis

### Team Member Responsibilities
Unlike other assignments, you'll keep your code organized in multiple different files. This helps keep your project more modular and clear. You'll create six different files for this project:

* An index.Rmd file that renders your report - **Morgan**
* A file that calculates summary information to be included in your * report - **Adrian**
* A file that creates a table of summary information to be included in your report - **Adrian**  
* A file that creates your first chart - **Caroline**
* A file that creates your second chart - **Nina**
* A file that creates your third chart - **Morgan**

**Summary Information (Adrian)**
* Proportion of ages in MHCLD dataset
* Proportion of races/ethnicities in MHCLD dataset
* Proportion of sex in MHCLD dataset

**Visual 1 (Caroline)**
> Creating map of mental health facilities in the U.S.

**Visual 2 (Nina)**
> Creating a stacked bar chart of the mental illness among gender and unemployment 

**Visual 3 (Morgan)**
> Creating bar graph of common mental illnesses among different races/ethnicities.


You should save your .R files in the same folder as yourindex.Rmd file. There's more information below about how these files interact.
