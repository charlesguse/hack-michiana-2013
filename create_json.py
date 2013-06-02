# -*- coding: utf8 -*-
# https://groups.google.com/forum/#!msg/d3-js/L3UeeUnNHO8/cQklzYbMWEcJ
import csv, itertools, json, sys

def cluster(rows):
    result = []
    data = sorted(rows, key=lambda r: r[1])
    for k, g in itertools.groupby(rows, lambda r: r[0]):
        group_rows = [row[1:] for row in g]
        if len(row[1:]) == 1:
               result.append({"name": row[0],"size": int(float(row[1]))})
        else:
               result.append({"name": k,"children":cluster(group_rows)})
    return result

with open(sys.argv[1], 'r') as csvfile:
    rows = list(csv.reader(csvfile, delimiter='|'))
    with open(sys.argv[2], 'w') as outfile:
        outfile.write(json.dumps(cluster(rows),indent=2))
