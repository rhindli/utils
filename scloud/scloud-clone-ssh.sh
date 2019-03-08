#!/bin/bash

#Git repositories
repos=(    \
capi             \
core-business    \
core-framework   \
csec             \
db               \
dev              \
extend           \
installer        \
jclient          \
jclientEar       \
lib              \
paer             \
paur             \
pavg             \
pbit             \
pcsd             \
pf64             \
pirw             \
pmed             \
prds             \
prks             \
prop             \
reporting        \
sagr             \
scld             \
scqm             \
scwi             \
sdei             \
sdwh             \
sedi             \
sele             \
sems             \
server           \
sfhu             \
sfro             \
sfxa             \
sgap             \
shrmWs           \
sicm             \
smag             \
smlm             \
smob             \
smon             \
smrp             \
smstr            \
smstrWS          \
sobk             \
soff             \
sohh             \
spos             \
sprc             \
sprv             \
sprx             \
srpd             \
stln             \
strl             \
sweb             \
sweb-themes      \
swms             \
swss             \
)

#Git repository count
repos_cnt=${#repos[@]}

#get full path of the directory where this script resides
script="$0"
scriptdir="$(dirname $(readlink -f $script))"

for ((n=0; n<repos_cnt; n++)); do
    echo "Cloning ${repos[$n]}"
    git clone git@github.com:BITSoftware/${repos[$n]}.git
done
