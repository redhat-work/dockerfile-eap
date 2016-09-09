#!/bin/sh

#@MNGT_USER@
#@MNGT_PWD@

#add a user that is specified in the environment variable 
 ${JBOSS_HOME}/bin/add-user.sh --silent -e -u ${MNGT_USER} -p ${MNGT_PWD}

MNGT_PWD64=$(echo ${MNGT_PWD} | base64)
#replace the flags with the right environment variables 
sed -i 's/@MNGT_USER@/'"${MNGT_USER}"'/g'  ${JBOSS_HOME}/domain/configuration/host-slave.xml
sed -i 's/@MNGT_PWD@/'"${MNGT_PWD64}"'/g'  ${JBOSS_HOME}/domain/configuration/host-slave.xml

echo ${MNGT_PWD64} >> oi.txt

#sed -i 's/fea/asd/g'  hello.tx
exec ${JBOSS_HOME}/bin/domain.sh "$@"