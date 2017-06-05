#!/bin/bash

# Scenario 1: test if installation completed

chmod 0666 ./test-results.txt
if [ -f "./test-results.txt" ] ; then
  > test-results.txt
fi

echo "Execution local time: $(date "+%F %T")" | tee -a test-results.txt

RESULT=1

if [ -d "installation" ] ; then
  echo "PASSED: Scenario 1: 'does installation directory exists'" | tee -a test-results.txt
  if [ $(find installation -type f | wc -l) -gt 1 ] ; then
    		echo "PASSED: Scenario 2: 'does installation directory contain files'" | tee -a test-results.txt
  fi
else
    RESULT=0
  	echo "FAILED: Scenario 1: 'does installation directory exists'" | tee -a test-results.txt
    echo "FAILED: Scenario 2: 'does installation directory contain files'" | tee -a test-results.txt
fi

if [ -f "installation/run-wsagent.sh" ]; then
  echo "PASSED: Scenario 3: 'is run-wsagent copied to installation directory'" | tee -a test-results.txt
else
  RESULT=0
  echo "FAILED: Scenario 3: 'is run-wsagent copied to installation directory'" | tee -a test-results.txt
fi

for f in ./profiles/* ; do
  f=$(basename $f)
  t1=$(du -b ./profiles/$f | cut -f1)
  t2=$(du -b ./installation/server/conf/profiles/$f | cut -f1)

  if [ -d "./installation/server/conf/profiles" ] && [ $(ls -A ./profiles | wc -l) -ne 0 ] ; then
    if [ $t1 != $t2 ] ; then
      RESULT=0
      echo "FAILED: Scenario 4: 'is $f profile copied to installation profiles directory'" | tee -a test-results.txt
    else
      echo "PASSED: Scenario 4: 'is $f profile copied to installation profiles directory'" | tee -a test-results.txt
    fi

  else
    RESULT=0
    echo "FAILED: Scenario 4: 'directory(ies) with Profiles don't exists'" | tee -a test-results.txt
  fi
done

if [ $(sudo cmp -b ./license/dtlicense.lic ./installation/server/conf/dtlicense.lic | grep -c differ) == 0 ] ; then
  echo "PASSED: Scenario 5: 'is dtlicense.lic copied to installation'" | tee -a test-results.txt
else
  RESULT=0
  echo "FAILED: Scenario 5: 'is dtlicense.lic copied to installation'" | tee -a test-results.txt
fi

if [ -f "./installer/dtlicense.lic" ]; then
  RESULT=0
  echo "FAILED: Scenario 6: 'is dtlicense.lic removed from installer directory'" | tee -a test-results.txt
else
  echo "PASSED: Scenario 6: 'is dtlicense.lic removed from installer directory'" | tee -a test-results.txt
fi

# testing docker services
if [ $(docker-compose ps | grep -E 'appmon.*Up' | wc -l) -ge 2 ] ; then
  echo "PASSED: Scenario 7: 'is appmon server and collector running'" | tee -a test-results.txt
else
  RESULT=0
  echo "FAILED: Scenario 7: 'is appmon server and collector running'" | tee -a test-results.txt
fi


if [ $RESULT == 0 ]  ; then
  exit 1
fi
