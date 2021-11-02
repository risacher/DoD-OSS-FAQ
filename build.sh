#!/bin/bash
pandoc -f markdown --toc -t html faq.md -s -o faq.html
xmlstarlet sel -t -c '/_:html/_:body/child::node()' faq.html > body.html
sed  '/INSERT/e cat body.html' index-template.html  > index.html
sed  '/INSERT/e cat body.html' "Open Source Software FAQ-template.html"  > "Open Source Software FAQ.html"


