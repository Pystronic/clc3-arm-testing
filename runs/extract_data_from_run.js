// Requires node.js installation
// Imports & constants
const fs = require('fs');
const path = require('path');
const range = n => [...Array(n).keys()]
const RUNS_PER_FILE = 4;


// By mortb: https://stackoverflow.com/a/38327540
function groupBy(list, keyGetter) {
    const map = new Map();
    list.forEach((item) => {
         const key = keyGetter(item);
         const collection = map.get(key);
         if (!collection) {
             map.set(key, [item]);
         } else {
             collection.push(item);
         }
    });
    return map;
}


const args = process.argv.slice(2);
const input_file = args[0];
const output_dir = args[1];

if (input_file == null || output_dir == null) {
    console.log(`Usage: node extract_data_from_run.js <input file> <output directory>`);
    process.exit(-1);
} else if (!fs.existsSync(input_file)) {
    console.log("Input file does not exist!");
    process.exit(-1);
}


console.log("Reading input...");
const input_text = String(fs.readFileSync(input_file)).replace(/, \"labels\"[^}]*}/g, "},");
const last_colon = input_text.lastIndexOf(",");
const input_norm = `[${input_text.substring(0, last_colon)}]`;
const metric_array = JSON.parse(input_norm);


console.log("Extracting benchmarks...");
let bechmark_map = groupBy(metric_array, (metric) => metric.test);


console.log("Creating CSV content...");
const headers = `Metrics;${range(RUNS_PER_FILE).map(i => `Run ${1+i}`).join(';')};AVG;Unit;Test`
let lines = [];

for (const [test, metrics] of bechmark_map) {
    const metrics_map = groupBy(metrics, (metric) => metric.metric);
    for (const [name, values] of metrics_map) {
        let sorted_values = values.sort((a, b) => a.timestamp - b.timestamp)
                                    .map(val => val.value);
        const avg = sorted_values.map(val => Number(val ?? 0))
                                 .reduce((partialSum, a) => partialSum + a, 0)
                                 / sorted_values.length;
        if (sorted_values.length < RUNS_PER_FILE) {
            sorted_values = [
                ...sorted_values,
                ...range(RUNS_PER_FILE - sorted_values.length).map(_ => "")
            ];
        }

        lines.push(`${name};${sorted_values.join(';')};${avg};${sorted_values[0].unit ?? ''};${test}`); 
    }
}


console.log("Writing result...");
const output_file = path.resolve(output_dir, `${path.basename(input_file)}.csv`);
const result_content = [headers, ...lines].join("\r\n");
fs.writeFileSync(output_file, result_content);