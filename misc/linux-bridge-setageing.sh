#! /bin/bash

export LC_ALL=C

for i in "$@"
do
case $i in

	--project=*)

		PROJECT="${i#*=}"
		shift
		;;

	--stack=*)

		STACK="${i#*=}"
		shift
		;;

esac
done


if [ ! -f /usr/local/etc/$PROJECT-openrc.sh ]
then
	echo
	echo "OpenStack Credentials for "$PROJECT" account not found, aborting!"
	exit 1
else
	echo
	echo "Loading OpenStack credentials for "$PROJECT" account..."
	source /usr/local/etc/$PROJECT-openrc.sh
fi


if heat stack-show $STACK 2>&1 > /dev/null
then
	echo
	echo "Stack found, proceeding..."
else
	echo
	echo "Stack not found! Aborting..."
	exit 1
fi


INSTANCE_ID=$(nova list | grep $STACK-pts | awk $'{print $2}')


if [ -z $INSTANCE_ID ]
then
	echo
	echo "Warning! No compatible Instances was detected on your \"$STACK\" Stack!"
	echo "Possible causes are:"
	echo
	echo " * Missing Instance ID for one or more Sandvine's Instances."
	echo " * You're running a Stack that is not compatbile with Sandvine's rquirements."
	echo
	exit 1
fi


BRIDGES=$(virsh dumpxml $INSTANCE_ID | grep source\ bridge | tail -n 2 | awk -F\' '{print $2}' | xargs)


for X in $BRIDGES; do

	sudo brctl setageing $X 0

	echo
	echo "Linux Bridge $X of L2 NFV Instance is now a dumb hub."

done
