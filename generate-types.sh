#!/bin/bash

set -ex

mkdir -p ./dist
indexFile='./dist/index.d.ts'
if [[ -f ${indexFile} ]]; then
    rm ${indexFile}
fi

cat <<EOF >> ${indexFile}

// This file was generated. You probably should not edit it.
import { Parser } from 'lezer'

export const parser: Parser
$(sed -E 's/ = [0-9]+/: number/' src/parser.terms.js)
EOF
