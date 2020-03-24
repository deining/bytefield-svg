#!/usr/bin/env bash

# This script is run by Netlify continuous integration to build the
# Antora site hosting the bytefield-svg user guide.

# Install dependencies needed only on Netlify.
npm install yarn
npm run release

cd doc

# Build the unreleased branch of Antora that supports plugins
if [ ! -d "antora" ]
then
    git clone https://gitlab.com/djencks/antora.git
    cd antora
    git checkout issue-585-with-377-582-git-credential-plugin
    ../../node_modules/.bin/yarn
    cd ..
fi

# Use it to build the documentation site.
cd ..
DOCSEARCH_ENABLED=true DOCSEARCH_ENGINE=lunr doc/antora/node_modules/.bin/antora doc/netlify.yml