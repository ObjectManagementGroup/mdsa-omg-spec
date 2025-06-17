The OMG's Model Driven Specification Authoring process is a new technique for authoring OMG specifications, which has three main parts: Document creation, collaboration, and model generated content.

1) LaTeX Document Generation
This is the first eat our own dog food run of a new template, using LaTeX, git, and other tools.  There are many parts to this, but the vast majority of the LaTeX has been provided to, and hidden from, the authors.  The intent is that the authors can concentrate on the content, not the formatting or structure.

- mdsa-omg-core/
The core of the LaTeX definitions and mechanics are found in the mdsa-omg-core directory, which is provided as a git submodule from a stand-alone repository.  None of these files are intended to be edited.  These drive the entire LaTeX process, do *not* attempt to replace or edit these files, unless you are 110% sure of what you are doing.  (And, if you do edit because you need something, let OMG Editing know so they can discuss incorporating it into the main branch.)  If you need to add LaTeX packages, new commands, etc, place them into Submission_AuthorSettings.tex at the top level.  That's your sandbox to do with what you please.  Again, these files are read-only, and only described here as a warning for the curious.  Periodically you may be notified of an update to these files by OMG Staff.  If you are working in the Overleaf environment, select each updated file in the file browser, and click "Refresh" to get the newest version.  If you are working from a git clone, fetch changes to your local repository using `git submodule update` within the mdsa-omg-core directory.

    Submission.tex              The main LaTeX file.  This is what is designated as the 'top' file.
                                It exists solely to give tools a 'real' file to latch onto, and it
                                then passes control to the next file on this list.  While this file
                                is editable, it will do little good to do so, the entire document
                                structure is handled by...

    --- When using Overleaf.com, the files below this line are read-only ---

    Submission_Template.tex     The main core template document. All formatting and structure is controlled
                                starting with this file.

    Style (.sty) files are LaTeX command bundles.
    omg.sty                     omg.sty provides the basics used across all OMG documents.
    omg_rfp.sty                 omg_rfp.sty is for creating an RFP.
    omg_submission.sty          omg_submission.sty is for creating a submission in response to an RFP.

    .bib files are bibliography databases.  These are provided for your convenience.  You can refer to any of these entries via \cite{<entrycode>} and it will build your bibliography for you according to OMG requirements.
    iso.bib         ISO standards
    omg.bib         OMG standards
    w3.bib          W3 standards

- mdsa-tools/
A bundle of custom tools to drive this process, this is another read-only directory provided as a git submodule. There is little need to dive into these if you are only authoring a specification, but if you are curious, the tools are documented and capable of quite a lot. There is also an ongoing project to expand the tool support here, which we invite all tool vendors and users to contribute to if they have a need.

- GeneratedContent/
Files that are generated from your models are placed into the GeneratedContent folder, as described below under Model Driven Specification. You should never have to (or indeed, should not ever) edit these files manually.  Edit the model, regenerate these files.  Again, this is a warning to the curious.

The remaining files are for you to edit:

    - Submission_Setup.tex is for putting in the basics of your Submission document: full specification name, specification acronym, important dates, document number, IPR mode, etc. Take some time to inspect this file, these macros form much of the backbone of the document you're producing. If you are unsure what in the document a setting controls, edit the content and look for changes in the rendered document. Generally speaking, the text in red italics is what is being controlled by the settings in this file.

    - Subsmission_UserPreamble.tex is for customizing your LaTeX system to your needs.  Most users should not have to, but if you find yourself wanting to dive into OMGCore/, make your edits here instead.  Some common useful things have already been added here for you, such as turning on/off DRAFT watermarking, setting a new folder for model generated content instead of the default GeneratedContent/, etc.  This is your place to control LaTeX.

    - All other files in the top level folder are for you to add content to.  These are broken into the required sections of the OMG Specification Template.  The preceding number tells you what section the file belongs in.  If you leave a file blank, or remove it, then the corresponding section is either filled with boilerplate text (for required sections), or simply removed from the document (for optional sections).  All subsequent sections will be renumbered automatically to compensate.

    0_Acknowledgements  Section 0, any nice things you'd like to say about people who helped.
    0_Additional        Section 0, any additional things you'd like to put into Section 0 go here.  Long discussions regarding comparison to other specs, for instance.
    0_Changes_To_Existing   Section 0, are there any required or proposed changes to other OMG specs?
    0_Introduction      Section 0, give a brief introduction to your specification.  Remember, this will *not* be a part of the final formal specification, this is for OMG members.
    0_Issues            Section 0, Issues to be Discussed as required by the RFP.  Discuss them here.
    0_Proof_Of_Concept  Section 0, Discuss a proof of concept, if you have one.
    0_Relation_To_Existing   Section 0, are there any specifications within the OMG (or elsewhere) that this submission relates to?
    0_Resolutions_Mandatory Section 0, list and discuss how you satisfied the mandatory requirements.
    0_Resolutions_Optional  Section 0, list and discuss how you satisfied the optional requirements.
    0_Submitters        Section 0, list the submitters to this spec, including contact info.
    1_Scope             Section 1, Scope of specification.
    2_Basic_Conformance Section 2, What constitutes basic conformance with this specification?
    2_Extended_Conformance  Section 2, Are there any extended conformance items?
    2_Profile_Conformance   Section 2, How are profiles against this spec deemed to be conformant?
    4_Terms             Section 4, Define any terms needed to understand this specification.
    5_Symbols           Section 5, Define any special symbols or glyphs used in this document.
    6_Additional        Section 6, Often a 'how to read this' and acknowledgements, but it is up to the authors.
    7+_Technical_Content    Sections 7 onward, this is the technical description of the specification.
    A_Annexes           Annexes A onward, fill this in if you have supplementary annexes.

    Note that there *is no section 3 Bibliography*.  LaTeX creates a bibliography for you, automatically, based on what sources you cite from the .bib files, and ensures it is formatted according to OMG requirements.

    Note also that if you are converting an already published specification to this system, then there is no reason (other than historical preservation) to fill in the 0 Section files. The 0 Section is only for Submissions being considered for first issuance and publication, and Section 0 is stripped out prior to 1.0 (or 2.0, etc) being released. Leave them untouched, empty them, or remove them, and set \initialsubmission to false in Submission_Setup.tex. 

    - submission.bib is your personal bibliography file, add your non-OMG, non-ISO, non-W3 references here.  For help with creating .bib entries, you can refer to any number of online resources, but we recommend starting with the biblatex documentation at: https://www.overleaf.com/learn/latex/Bibliography_management_in_LaTeX .

    - In addition, you are free to create new files at this level for inclusion, if you would like.  You would include them in your document using \subimport{}{MyFile}



2) Local Filespace Integration and Online Collaboration

Overleaf.com is a fantastic resource, but it has two drawbacks.  First, it requires internet access, and secondly, while it allows files to be uploaded, it doesn't have the tight integration we'd like for working with model-generated files.

Overleaf offers three sync options: Dropbox, Git, and Github.  Of these, I prefer the Git solution.  Full documentation can be found at: https://v2.overleaf.com/learn/how-to/Working_Offline_in_Overleaf

- Setting up git
    Install git on your local machine.  This is going to be completely dependent on your system, but download and install from https://git-scm.com as appropriate.

- Get the Overleaf git URL
    Within your Overleaf project, click on the Menu, top left of the Overleaf window.  Select Git.  Copy the URL provided in the resulting dialog.

- Clone with git
    Use the URL to clone the repository using git.

You will now have a local copy that you can edit, push back to Overleaf, and render.  Be careful, however, as just like any other git repository, it's possible to edit on both local and Overleaf copies, and end up with conflicts.

This is most common when working with colleagues on a project.  No more sending around copies of Word files with arcane tags to try and keep track of which is newest.  All changes are available to all editors at all times online, and one repository sync away when using the offline approaches listed above.  For full documentation, visit https://v2.overleaf.com/learn/how-to/Sharing_your_work_with_others



3) Model Driven Specification
There is a lot of interest at the OMG for producing specification documents directly from models of those specs.  This can save a tremendous amount of time, in that there is no (or little) chance of diagrams and descriptions getting out of sync, for instance.

There is no OMG requirement for use of any particular, or indeed *any* modeling tool, this is simply a step towards a goal that many would like to see come to pass.  You are always free to write your specification manually, and create any required diagrams manually as well.

If you choose to go this route, then the OMG is providing assistance for common tools.  Our first attempt at this supports users of MagicDraw, and we are offering the md2LaTeX.py Python script, which uses the MagicDraw Report Generation functionality to emit LaTeX and SVG files directly from the model.  This Python script was created to run on a Unix system (Linux, macOS, etc), but should also work under Windows with a Python install.  Another approach we are investigating is to convert XMI files to LaTeX/SVG, in the hopes that it can be used by more tools.  As we move forward, if you have a tool that you would like to see supported, let us know.  If you have a conversion tool on hand, again, let us know and we can provide it to OMG members.

Each class, attribute, diagram and so forth in the MagicDraw model has a Documentation string that gets emitted into the document.  Anything in the ToDo string for an element is emitted in red.  Images are handled similarly, the Documentation string turns into the caption.

There are two steps to using this tool.  First, you must import the supplied report generation templates into your MagicDraw installation.  Import OMGPackage.txt and OMGLaTeXStyle.txt as new templates into MagicDraw using the Report Wizard (https://docs.nomagic.com/display/MD190/Importing+a+template+to+MagicDraw+using+Report+Wizard).  You need to leave the files where you This step only has to be done once.

Next, you will use the md2LaTeX.py command line tool to do the conversion to LaTeX.

md2LaTeX.py --help will give you the basics:

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


It is highly useful to create a SPECNAME.config file for your use.  The config file contains the same flags as the command line, it's just a lot less typing.  An example would be:

[DEFAULT]
app=<PATH TO MAGICDRAW generate.sh SCRIPT>
model=<SPECNAME>.mdzip
texoutput=<SPECNAME>_LaTeX/GeneratedContent
pkgs=Base Syntax Semantics Examples
imgoutput=<SPECNAME>_LaTeX/GeneratedContent/Images

This is equivalent to:

md2LaTeX.py --model <SPECNAME>.mdzip --pkgs Base Syntax Semantics Examples --texoutput <SPECNAME>_LaTeX/GeneratedContent --imgoutput <SPECNAME>_LaTeX/GeneratedContent/Images
--app <PATH TO MAGICDRAW generate.sh SCRIPT>

and can be invoked as:

md2LaTeX.py --config SPECNAME.config

In both cases, md2LaTeX will look for a <SPECNAME>.mdzip file (you can also specify an XML file), and then generate LaTeX files only for the packages named as given.  (Spaces in package names can be a problem, obviously, try to avoid if you can.)  Output is placed into texoutput and imgoutput directories.

That's it.  It can take a couple of minutes for the MagicDraw Report Generation Wizard to launch in Java, but hopefully this isn't a step you need to do often.


Finally, if you have any questions, please ask.

Jason McC. Smith
jason@elementalreasoning.com

