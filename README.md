process-mime-emails
===================

A script for processing mime emails into a single folder for further processing (e.g. printing). The input expected is a folder containing a set of email files (e.g. *.eml):

Edit INDIR and OUTDIR as appropriate then run the script.

INDIR/
  application1.eml
  application2.eml
  
This structure can easily be created by e.g. saving all attachments from an email that someone has sent you by attaching lots of emails as attachments (e.g. job applications, or tender responses, etc.). This seems to be a popular form of communication in corporate settings.
  
The output is a folder containing subfolders for each email the parts extracted, and all a subfolder 'all' that contains all the subparts of all the emails, prepended with numbers so that an alphanumeric sort will keep the parts in order.

This makes it relatively easy to further process the emails.

Requires munpack (e.g. brew install munpack) to do the actual MIME part extraction.
