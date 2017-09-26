#!/bin/bash
#  ███╗   ██╗ ██████╗ ██████╗ ███████╗███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ 
#  ████╗  ██║██╔═══██╗██╔══██╗██╔════╝████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗
#  ██╔██╗ ██║██║   ██║██║  ██║█████╗  ██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝
#  ██║╚██╗██║██║   ██║██║  ██║██╔══╝  ██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗
#  ██║ ╚████║╚██████╔╝██████╔╝███████╗██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║
#  ╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
#                                                              ╚╗ @marsmensch 2016-2017 ╔╝                   				           
#
# version: 	0.3-alpha
# date:    	2017-07-25
# function:	part of the masternode scripts, source the proper config file
#
# Twitter: 	@marsmensch
#                                                                      
# 	Instructions:
#               Run this script and wait. After a while you should have a working
#               masternode setup where only the private keys need to be added.
#
#	Platforms: 	
#               - Linux Ubuntu 16.04 LTS ONLY on a Vultr VPS (its by far the cheapest option)
#               - Generic Ubuntu support will be added at a later point in time
#
#	System requirements:
#               - A vultr micro instance works for up to 5 masternodes 
#				- Activate the free IPv6 option
#

usage() {
    echo `basename $0`: ERROR: $* 1>&2
    echo usage: `basename $0` '[pivx] OR [mojo] OR [mue] OR [synx] OR [dash] OR [bitsend]  + HOWMANY' 1>&2
    echo '=> for 5 pivx masternodes run:' `basename $0` 'pivx 5' 1>&2
    echo 'Report bugs to: @marsmensch'
    exit 1
}

source_config() {
	if [ -f ${SETUP_CONF_FILE} ]; then
		echo "read default config"	
		source config/default.env
		echo "apply config file for ${1}"		
		source "${SETUP_CONF_FILE}"
		echo "running installer script"		
		source scripts/masternode_install.sh ${1}
	else
		echo "required file ${SETUP_CONF_FILE} does not exist, abort!"
		exit 1   
	fi
}

SETUP_CONF_FILE="config/${1}/${1}.env"
SETUP_MNODES_COUNT=${2}

case "${1}" in
	pivx)
		echo you picked PIVX
		source_config pivx
		;;
	sib)
		echo you picked SIB
		source_config sib
		;;
	mue)
		echo you picked MUE
		source_config mue
		;;
	synx)
		echo you picked SYNX
		source_config synx
		;;
	bitsend)
		echo you picked BITSEND
		source_config bitsend
		;;		
	dash)
		echo you picked DASH
		source_config dash
		;;  
	* ) usage "bad argument $1"
		;;
esac