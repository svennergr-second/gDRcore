#/bin/sh

echo "Executing $0"
echo "Environment: ${rp_env}"
echo "Working directory: `pwd`"
echo "Working directory contains: `ls | tr '\n' ' '`"

# exit when any command fails
set -e

echo ">>>>> RUNNING CHECK"
Rscript -e "devtools::test(pkg = '/mnt/vol/gDR', stop_on_failure = TRUE)"


echo ">>>>> RUNNING DEVTOOLS::CHECK()"
sudo R CMD check --no-build-vignettes --no-manual --no-tests /mnt/vol/gDR
