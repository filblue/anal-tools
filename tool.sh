rm -rf anal_derived
mkdir anal_derived

cd anal_derived
git log "$@" --pretty=format:'[%h] %an %ad %s' --date=short --numstat > log.csv

maat -l log.csv -c git -a revisions > changes.csv

cd ..
cloc ./ --exclude-dir=Pods,rider-mobile-common,Specs,CalabashTests,calabash.framework,Supporting\ Files,Scripts --by-file --force-lang=XML,storyboard,xib --csv --quiet --report-file=anal_derived/loc.csv
cd -

python ../../../maat-scripts/merge/merge_comp_freqs.py changes.csv loc.csv > hotspots.csv
python ../../../maat-scripts/transform/csv_as_enclosure_json.py --structure loc.csv --weights changes.csv > hotspot.json
cp ../../../anal_tools/hotspot_d3.html .
cp -r ../../../anal_tools/d3 .

open http://localhost:8888/hotspot_d3.html
python -m SimpleHTTPServer 8888
