#!/bin/bash
set -eo pipefail
set -o pipefail

touch ~/jupyter-notebook.log
nohup jupyter notebook --ip=0.0.0.0 --no-browser --allow-root > ~/jupyter-notebook.log 2>&1 &

exec "$@"