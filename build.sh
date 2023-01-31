set -ex

lezer-generator src/statement.grammar -o src/parser

cat src/parser.terms.js >> src/parser.js

bash ./generate-types.sh

rollup -c
