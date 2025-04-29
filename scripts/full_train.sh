#!/bin/sh
gpu=( $@ )
gpu_num=$#
echo $gpu_num

data=data/VisDrone.yaml
ID=20250428-180517
yamlID=49
project=runs/train-$ID
name=full_train
cfg=$project/exp/genotypes/$yamlID.yaml
LOG_DIR=test_logs
train_type=from_scratch  

BATCHSIZE=4

gpustr=${gpu[0]}
for i in ${gpu[@]:1:$gpu_num-1};do
gpustr=$gpustr','$i;
done
echo $gpustr

CUDA_VISIBLE_DEVICES=$gpustr python train.py --data $data --cfg $cfg --project $project --name $name --weights '' --train_type $train_type --batch-size $BATCHSIZE > $LOG_DIR/$ID-yaml$yamlID-$train_type.log 2>&1 &

