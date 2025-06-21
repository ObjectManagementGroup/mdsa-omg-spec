# OMG MDSA - SPECIFICATION
The OMG's Model Driven Specification Authoring process is a new technique for creating OMG specifications. There are three main parts: Document creation, collaboration, and model generated content. The latter two are optional, but strongly suggested.

## tl;dr
 -- _*DO NOT CLONE THIS REPOSITORY*_ --

"Patience, yeah, yeah, how long is that going to take?"

Assuming that you're reading this on the github site, here is your list of steps to specification authoring.

1. Click the "Use this template" green button top right of the repository landing page. Enter in the name of the repository you'd like to create. It is suggested you use the acronym for the specification (no explicit version number needed in most cases).

2. Clone your new repository to your local machine, with one extra flag:
```
git clone --recurse-submodules https://github.com/acmecorp/ABCD.git
```

3. Change directory in your local machine shell to your cloned repository and execute `make`.

Congratulations, you've just created a valid OMG specification PDF named NOTSET_NOTSET.pdf.  (I said it is valid, not useful. That's up to you.) As you fill in the needed information to flesh out the metadata for your new specification, the document will fill in the info where needed, when needed. Right now it is a shell submission, suitable for responding to an RFP.

Your next step will be to edit `_Specification_Setup.tex` to provide the needed metadata and make this document start to look like an actual specification.

## 1. Document Creation
This is the first eat our own dog food run of a new template, using LaTeX, git, and other tools.  There are many parts to this, but the vast majority of the LaTeX has been provided to, and hidden from, the authors.  The intent is that the authors can concentrate on the content, not the formatting or structure. We'll start with the content you need to create, and then give some background on the read-only submodules. See the submodules' READMEs for further details if you're curious, or want to assist with the MDSA project.

### `mdsa-omg-spec` Template
`mdsa-omg-spec` is a template repository that is used to generate stand-alone clones for authoring that have no connection back to the official template. You can push changes to the below files to your liking, that repository is now yours.

### Building your document with Make
LaTeX is a massively complex system, and the OMG styles and templates are designed to buffer you from the vast majority of the complexity.  We've attempted to make the process as painless as possible by providing a fairly standard `Makefile`. (Other build configurations may be provided in the future as requested but this is a lowest common denominator that most authors comfortable with git will also have available to them.)

Typing `make` is all that is needed to kick off the process, whether you are generating LaTeX from a model, or have hand edited the files.

A `build/` directory will be created if has not already, and all required files from `mdsa_omg_core`, `GeneratedFiles/`, and `Images/` will be copied to that directory for processing. `pdflatex` is then executed within that directory to create the PDF, which is then copied back to the top level and renamed according to your specification metadata: ACRONYM_VERSION.pdf

That's it. `build/` can be deleted at any time, or, in the case of curiousity or debugging, you can dive into it to track down problems or questions.

The Make targets include:

- `spec`: the default target. Copies necessary files to `build/` and creates the PDF.
- `gen`: Re-generates content from a modeling tool into `GeneratedContent/`. Performed if needed as part of `spec`.
- `clean`: Deletes `build/` and the resulting PDF. At this time it leavew `GeneratedContent/` alone.

When you first run `make` in a fresh repository you will get a valid shell of an OMG specification document. All formatting, boilerplate, etc, is prepared for you. (Not only should you not have to worry about these things, you cannot alter these things without significant work. Any necessary changes should be coordinated with OMG editorial staff at editor@omg.org.)

If you open this NOTSET_NOTSET.PDF, you will notice that much of the body is red, italicized, and explanatory text. These are instructions to your team on what needs to be done to create a full specification.

The first thing to do is set up your metadata.

### Setting up your specification
The first task towards a working specification is to edit the `_Specification_Setup.tex` file. This file contains the metadata for your specificaiton that will be used to fill in much of the red text you see in the freshly built PDF. Most of this should be self-explanatory even if you are not familiar with LaTeX, and is fully documented within that file. Lines beginning with `%` are comments, and most of this file is simply setting values to be used in the build process. As an example, the first three items you will need to edit are:

``` LaTeX
\setvalue{\specname}{\REPLACEME{Test Spec}}
\setvalue{\specacro}{\REPLACEME{TS}}
\setvalue{\version}{\REPLACEME{0.9}}
```

If your specification is named "Abstract Bundles of Coding Definitions", has the acronym "ABCD", and you are creating version 1.2, then you would edit that block to read as:

``` LaTeX
\setvalue{\specname}{Abstract Bundles of Coding Definitions}
\setvalue{\specacro}{ABCD}
\setvalue{\version}{1.2}
```

Rebuild your PDF with `make`, and you'll see that your PDF is now named ABCD_1.2.pdf. Open it, and you'll see that the data you provided has been used to fill in every place within the docuemnt that it is needed.

The remainder of this file is self-documented, but as always if any questions arise contact editor@omg.org. Once you have completed filling out this file, you will notice that the amount of red text in your PDF is considerably less.

NOTE: A future goal of the MDSA project is to have this `_Specification_Setup.tex` file be unnecessary or generated from metadata stored in OMG's document database. For now, manual input is required.

### Customizing your LaTeX environment
If you are a LaTeX power user, `_Specification_AuthorSettings.tex` is for customizing your LaTeX system to your needs.  Most users should not have to, but if you find yourself wanting to dive into `mdsa_omg_core/`, make your edits here instead if you can.  Some common useful things have already been added here for you, such as turning on/off DRAFT watermarking, setting a new folder for model generated content instead of the default `GeneratedContent/`, etc.  This is your place to customize LaTeX... if you dare.

### Authoring the Technical Content
All other files in the top level folder are for you to add content to.  These are broken into the required sections of the OMG Specification Template.  The preceding number tells you what section the file belongs in.  

If you do not need to fill out a particular section, such as 5_Symbols.tex, you may leave a file blank by deleting the contents, or remove it entirely. The corresponding section is either filled with boilerplate text (for required sections), or simply removed from the document (for optional sections).  All subsequent sections will be renumbered automatically to compensate.

#### Section 0 (Submissions only)
Section 0 content is only required for the initial Submission in response to an RFP. Removing these files, however, will result in boilerplate being inserted as if it were an initial Submission. To eliminate Section 0 entirely (regardless of the content of the files), set the boolean `initialsubmission` in `_Specification_Setup.tex` to false. This will ensure that any other modifications needed for moving from a Submission to a Specification are performed, while allowing a continuity of commit history from initial submission by a Submission Team to sunsetting of a specification years later.

- `0_Acknowledgements`: Any nice things you'd like to say about people who helped.
- `0_Additional`: Any additional things you'd like to put into Section 0 go here.  Long discussions regarding comparison to other specs, for instance.
- `0_Changes_To_Existing`: Are there any required or proposed changes to other OMG specs?
- `0_Introduction`: Give a brief introduction to your specification.  Remember, this will *not* be a part of the final formal specification, this is for OMG members only.
- `0_Issues`: Issues to be Discussed as required by the RFP.  Discuss them here.
- `0_Proof_Of_Concept`: Discuss a proof of concept, if you have one.
- `0_Relation_To_Existing`: Are there any specifications within the OMG (or elsewhere) that this submission relates to?
- `0_Resolutions_Mandatory`: List and discuss how you satisfied the mandatory requirements.
- `0_Resolutions_Optional`: list and discuss how you satisfied the optional requirements.
- `0_Submitters`: list the submitters to this spec, including contact info.

#### Technical Content
Finally, this is the meat of the specification, and where you will make the bulk of your edits.

Each remaining file is self-documented, and contains instructions on how it should be filled according to OMG best practices, and the advice of the Architecture Board. If at any time you have questions about the technical content, please contact your Technical Director (bennett@omg.org), and/or your friendly AB member.

- `1_Scope`             Section 1, Scope of specification.
- `2_Basic_Conformance` Section 2, What constitutes basic conformance with this specification?
- `2_Extended_Conformance`  Section 2, Are there any extended conformance items?
- `2_Profile_Conformance`   Section 2, How are profiles against this spec deemed to be conformant?
- `4_Terms`             Section 4, Define any terms needed to understand this specification.
- `5_Symbols`           Section 5, Define any special symbols or glyphs used in this document.
- `6_Additional`        Section 6, Often a 'how to read this' and acknowledgements, but it is up to the authors.
- `7+_Technical_Content`    Sections 7 onward, this is the technical description of the specification.
- `A_Annexes`           Annexes A onward, fill this in if you have supplementary annexes.

#### Bibliography
Note that there *is no section 3 Bibliography*.  LaTeX creates a bibliography for you, automatically, based on what sources you cite from the .bib files, and ensures it is formatted according to OMG requirements.


`specification.bib` is your team's bibliography file, add your non-OMG, non-ISO, non-W3 references here.  For help with creating .bib entries, you can refer to any number of online resources, but we recommend starting with the biblatex documentation at: https://www.overleaf.com/learn/latex/Bibliography_management_in_LaTeX .

#### Additional Files
While this template structure is designed to handle most use cases possible, there is always that one team that breaks things and... I mean innovates. They innovate.

In those cases, you can always add new files to this top level directory, and include them in your document with a single LaTeX command: `\subimport{}{MyFile}` would include the contents of `MyFile.tex`. Note the lack of file suffix in the command. This is most commonly used to gather files into `7+_Technical_Content.tex` and `A_Annexes.tex` but can be used for any purpose (as long as it doesn't break the OMG template, boilerplate, or other required elements!)

### Model Generated Content Support
If you are generating content from a model by way of a modeling tool, then files that are generated from your models are saved into the `GeneratedContent/` folder, as described below under Model Driven Specification. You should never have to (or indeed, should not ever) edit these files manually.  Edit the model, regenerate these files.  Again, this is a warning to the curious. You may think to add this directory to your .gitignore because your team plans on a disciplined use of the model as the authoritative source of truth at all times, as it can help prevent accidental manual edits. We advise against this, instead check in the generated content (.tex and .svg files), this will greatly facilitate the creation of changebar documents on demand later.


### Submodules
There are two git submodules in this repository. If you have not used submodules before, they are effectively independent repositories that are pulled in on demand based on dependencies. This allows OMG staff to update the formatting and boilerplate as needed, and all specification authoring teams can pull updates to imporove their documents, without interfering with their technical content version control. You can find a good primer on submodules at: https://git-scm.com/book/en/v2/Git-Tools-Submodules 

#### `mdsa-omg-core/` Submodule
The core of the LaTeX definitions and mechanics are found in the mdsa-omg-core directory, which is provided as a git submodule from a stand-alone repository. This repository should be considered read-only. There is nothing in here that should need editing except under extremely rare circumstances. If you find yourself in those circumstances, contact OMG editorial staff (editor@omg.org) for guidance. It may be that you have uncovered a need for updating the core template, and your effort will help all OMG authors.

#### `mdsa-tools/` Submodule
A bundle of custom tools to drive this process, this is another read-only directory provided as a git submodule. There is little need to dive into these if you are only authoring a specification, but if you are curious, the tools are documented and capable of quite a lot. There is also an ongoing project to expand the tool support here, which we invite all tool vendors and users to contribute to if they have a need. Contact editor@omg.org for details and information on how you can assist the community.



## Local Filespace Integration and Online Collaboration

Overleaf.com is an online collaborative LaTeX editing system that is widely popular, and honestly it is a fantastic resource... but it has two drawbacks.  First, it requires internet access at all times to perform editing, and secondly, while it allows files to be uploaded, it doesn't have the tight integration we'd like for working with model-generated files.

If you are not planning on generating content from models (or other sources such as ontologies), and you do not foresee ever needing to work offline, then Overleaf is a recommended solution for teams that want that workflow.

Overleaf offers three sync options: Dropbox, Git, and Github.  Of these, we recommend the Git solution.  Full documentation can be found at: https://v2.overleaf.com/learn/how-to/Working_Offline_in_Overleaf

- Setting up git
    Install git on your local machine.  This is going to be completely dependent on your system, but download and install from https://git-scm.com as appropriate.

- Get the Overleaf git URL
    Within your Overleaf project, click on the Menu, top left of the Overleaf window.  Select Git.  Copy the URL provided in the resulting dialog.

- Clone with git
    Use the URL to clone the repository using git.

You will now have a local copy that you can edit, push back to Overleaf, and render.  Be careful, however, as just like any other git repository, it's possible to edit on both local and Overleaf copies, and end up with conflicts.

This is most common when working with colleagues on a project.  No more sending around copies of Word files with arcane tags to try and keep track of which is newest.  All changes are available to all editors at all times online, and one repository sync away when using the offline approaches listed above.  For full documentation, visit https://v2.overleaf.com/learn/how-to/Sharing_your_work_with_others



## Model Driven Specification
There is significant interest at the OMG for producing specification documents directly from models of those specs.  This can save a tremendous amount of time, in that there is no (or little) chance of diagrams and descriptions getting out of sync, for instance.

There is no OMG requirement for use of any particular, or indeed *any* modeling tool, this is simply a step towards a goal that many would like to see come to pass.  You are always free to write your specification manually, and create any required diagrams manually as well.

If you choose to go this route, then the OMG is providing assistance for common tools.  Our first attempt at this supports users of MagicDraw, and we are offering the `md2LaTeX.py` Python script, which uses the MagicDraw Report Generation functionality to emit LaTeX and SVG files directly from the model.  This Python script was created to run on a Unix system (Linux, macOS, etc), but should also work under Windows with a Python install.  Another approach we are investigating is to convert XMI or KerML files to LaTeX/SVG, in the hopes that it can be used by more tools.  As we move forward, if you have a tool that you would like to see supported, let us know.  If you have a conversion tool on hand, again, let us know and we can provide it to OMG members.

### MagicDraw support
Each class, attribute, diagram and so forth in the MagicDraw model has a Documentation string that gets emitted into the document.  Anything in the ToDo string for an element is emitted in red.  Images are handled similarly, the Documentation string turns into the caption.

There are two steps to using this tool.  First, you must import the supplied report generation templates into your MagicDraw installation.  Import OMGPackage.txt and OMGLaTeXStyle.txt as new templates into MagicDraw using the Report Wizard (https://docs.nomagic.com/display/MD190/Importing+a+template+to+MagicDraw+using+Report+Wizard).  You need to leave the files where you This step only has to be done once.

Next, you will need to set up a configuration for `md2LaTeX.py` to use to generate your specification files.

`md2LaTeX.py --help` will give you the basics:

```
usage: md2LaTeX.py [-h] [--verbose] [--debug] [--test] [--nowrite]
                   [--app APPPATH] [--config CONFIGFILE] [--model MODELFILE]
                   [--pkgs [PACKAGE [PACKAGE ...]]] [--texoutput DIR]
                   [--imgoutput DIR]

Default python template

optional arguments:
  -h, --help            show this help message and exit
  --app APPPATH         Path of MagicDraw generate.sh script
  --config CONFIGFILE   Read from INI style config file. CLI options override
                        config file.
  --model MODELFILE     The MagicDraw model file to convert to LaTeX (may be
                        .mdzip or .xml)
  --pkgs [PACKAGE [PACKAGE ...]]
                        Add a package to the to-be-processed list
  --texoutput DIR       Directory to place generated .tex files into.
  --imgoutput DIR       Directory to place generated images into.

Debug:
  Commands to assist debugging

  --verbose
  --debug
  --test                Run unit tests
  --nowrite             Don't write files or run converter through MagicDraw
```

If you are going to use the Make build, create a file named `SPECACRO.config` for it to hand off to `md2LateX.py`.  The config file contains the same flags as the command line, so you can experiment at the command line until you have it exactly the way you want it, and then you can save it to `SPECACRO.config`.  An example would be:

```Ini
[DEFAULT]
app=<PATH TO MAGICDRAW generate.sh SCRIPT>
model=<SPECACRO>.mdzip
texoutput=./GeneratedContent
pkgs=Base Syntax Semantics Examples
imgoutput=./GeneratedContent/Images
```
This is equivalent to:

```
md2LaTeX.py --model <SPECACRO>.mdzip --pkgs Base Syntax Semantics Examples --texoutput ./GeneratedContent --imgoutput ./GeneratedContent/Images
--app <PATH TO MAGICDRAW generate.sh SCRIPT>
```

and can be invoked as:

```
md2LaTeX.py --config SPECACRO.config
```

In both cases, `md2LaTeX.py` will look for a <SPECACRO>.mdzip file (you can also specify an XML file), and then generate LaTeX files only for the packages named as given.  (Spaces in package names can be a problem, obviously, try to avoid if you can.)  Output is placed into `texoutput` and `imgoutput` directories.

That's it.  It can take a couple of minutes for the MagicDraw Report Generation Wizard to launch in Java, but hopefully this isn't a step you need to do often.

## Changebar Creation
TBD

Finally, if you have any questions, please ask.

Jason McC. Smith
jason@elementalreasoning.com

