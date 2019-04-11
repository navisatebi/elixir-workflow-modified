#!/usr/bin/env bash
set -euoEx pipefail

echo "＼(＾O＾)／ Setting up convenience OS_ENV"

export APP="${PORTAL_APP_REPO_FOLDER}"
export DEPLOYMENTSFOLDER="${PORTAL_DEPLOYMENTS_ROOT}/${PORTAL_DEPLOYMENT_REFERENCE}/"
export KEY_PATH=$PUBLIC_KEY
export PRIV_KEY_PATH=$PRIVATE_KEY
export DPL="${PORTAL_DEPLOYMENTS_ROOT}/${PORTAL_DEPLOYMENT_REFERENCE}/"

export NETWORK=$OS_NETWORK  # Elixir-Proteomics_private

export BASTION_KEY=$(echo -e $BASTION_KEY_VALUE)
echo "${BASTION_KEY}" >> "${DEPLOYMENTSFOLDER}.letmein"
chmod 600 "${DEPLOYMENTSFOLDER}.letmein"
export BASTION_KEY="${DEPLOYMENTSFOLDER}.letmein"
echo BASTION_KEY
#export PRIVATE_KEYPATH="/Users/navis/.ssh/bastion_id"
#export KEYPATH="/Users/navis/.ssh/bastion_id.pub"

export PRIVATE_KEYPATH=$PRIVATE_KEY
export KEYPATH=$PUBLIC_KEY

export BASTION_IP=$TF_VAR_BASTION_IP  # 193.62.55.220
export BASTION_USER=$TF_VAR_BASTION_USER  # sshuser
export IMAGE=$TF_VAR_IMAGE  # slurm-glusterfs-nextflow-ubuntu-16.04
export FLAVOR=$TF_VAR_FLAVOR  # s1.small
export REDIS_HOST=$TF_VAR_REDIS_HOST  #192.168.0.16
export REDIS_PORT=$TF_VAR_REDIS_PORT  # 6379
export REDIS_DB=$TF_VAR_REDIS_DB  # 1

export CLUSTER_NAME=$PORTAL_DEPLOYMENT_REFERENCE  #cluster-deployment-1

echo "＼(＾O＾)／ Applying workflow playbooks"
cd $DPL
echo "cwd=$PWD"

export PXD="PXD011124"

# Deploy cluster
ansible-playbook --flush-cache \
    $APP/ansible-slurm-cluster/playbook.yml -e "{'host_key_checking':false }" -vvv
