#! /bin/bash

for d in `ls -la | grep ^d | awk '{print $NF}' | egrep -v '^\.'`; do

  rm -f $d/install.sh

  case $d in 
    *cli* )
      cp .src/install-cli.sh $d ;;
    *desktop* )
      cp .src/install-cli.sh $d ;;
    *web* )
      cp .src/install-web.sh $d ;;
  esac

  if [[ -e $d/Dockerfile ]]; then
    #statements
    rm -f $d/Dockerfile
    cp .src/Dockerfile $d
  else
    rm -f $d/py-srv/Dockerfile
    cp .src/Dockerfile $d/py-srv
  fi

  if [[ -e $d/bin/requirements.txt ]]; then
    #statements
    cp .src/requirements.sh $d/bin
    if [[ -e $d/bin/app.py ]]; then
      mv $d/bin/app.py $d/bin/main.py
    fi
  else
    #statements
    cp .src/requirements.sh $d/py-srv/bin
    if [[ -e $d/py-svr/bin/app.py ]]; then
      mv $d/py-svr/bin/app.py $d/py-svr/bin/main.py
    fi
  fi

  python3 $PWD/.src/pybuild/pyall.py $PWD/$d

  ./folder.sh $d

done
