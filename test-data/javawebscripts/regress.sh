#!/bin/bash

echo "pushd ../../../alfresco-view-repo; python test-data/javawebscripts/waitOnServer.py; python test-data/javawebscripts/regression_test_harness.py $@ | tee regress.out; popd"
pushd ../../../alfresco-view-repo; python test-data/javawebscripts/waitOnServer.py; python test-data/javawebscripts/regression_test_harness.py $@ | tee regress.out; popd


