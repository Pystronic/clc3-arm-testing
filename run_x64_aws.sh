#!/usr/bin/env bash

# Should be executed within the root of the repository
CLOUD=AWS
ARCH=x64
NUM_RUNS=2
RUN_URI=$(uuidgen | head -c8)
PERFKIT_PATH=PerfKitBenchmarker
CONFIG_PATH="configs/${ARCH}_config.yaml"
OUTPUT_FILE="runs/${CLOUD}_${ARCH}_$(date +%FT%T).json"

RESULTS_FILE="/tmp/perfkitbenchmarker/runs/${RUN_URI}/perfkitbenchmarker_results.json"

# Enable venv
source $PERFKIT_PATH/.venv/bin/activate

echo "Cloud: ${CLOUD} - Arch: ${ARCH}"
echo "Executing bechmarks..."
$PERFKIT_PATH/pkb.py --cloud=$CLOUD \
                                            --benchmarks=coremark,scimark2 \
                                            --benchmark_config_file=$CONFIG_PATH \
                                            --num_benchmark_copies="$NUM_RUNS" \
                                            --run_uri="$RUN_URI"
                                            
echo "Copying results..."
echo "From: ${RESULTS_FILE}"
echo "To: ${OUTPUT_FILE}"
cp $RESULTS_FILE $OUTPUT_FILE

                                            
                                            
