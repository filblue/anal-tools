rm -rf anal_derived
mkdir anal_derived

cd anal_derived
maat-log "$@" > log.csv

maat -l log.csv -c git -a entity-churn > churn.csv
churnsum churn.csv > churnsum.csv

cd ..
cloc ./ --exclude-dir=Pods,rider-mobile-common,Specs,CalabashTests,calabash.framework,Supporting\ Files,Scripts,Resources --by-file --force-lang=XML,storyboard,xib --csv --quiet --report-file=anal_derived/loc.csv
cd -

#python ../../../maat-scripts/merge/merge_comp_freqs.py changes.csv churnsum.csv > hotspots.csv
python ../../../maat-scripts/transform/csv_as_enclosure_json.py --structure loc.csv --weights churnsum.csv --weightcolumn 3 > hotspot.json
cp ../../../anal_tools/hotspot_d3.html .
cp -r ../../../anal_tools/d3 .

open http://localhost:8888/hotspot_d3.html
python -m SimpleHTTPServer 8888
