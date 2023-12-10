cd build/
make -j

# L=500
# C=2000
# R=100
L=200
C=500
R=100

# L=50
# C=500
# R=32

recall=0.86
dataset=rand100
shuf_postfix=_shuf7

cd tests/

# ./test_nsg_performance /home/hadoop/wzy/dataset/${dataset}1M/${dataset}_base.fvecs${shuf_postfix} \
# /home/hadoop/wzy/dataset/${dataset}1M/${dataset}_query.fvecs \
# /home/hadoop/wzy/dataset/${dataset}1M/${dataset}_L${L}_R${R}_C${C}.nsg${shuf_postfix} \
# 50 \
# /home/hadoop/wzy/dataset/${dataset}1M/${dataset}_groundtruth.ivecs${shuf_postfix} \
# /home/hadoop/wzy/ADSampling/results/${dataset}/${dataset}_nsg_L${L}_R${R}_C${C}_perform_variance${recall}.log${shuf_postfix} \

./test_nsg_performance /home/hadoop/wzy/dataset/${dataset}/${dataset}_base.fvecs${shuf_postfix} \
/home/hadoop/wzy/dataset/${dataset}/${dataset}_query.fvecs \
/home/hadoop/wzy/dataset/${dataset}/${dataset}_L${L}_R${R}_C${C}.nsg${shuf_postfix} \
50 \
/home/hadoop/wzy/dataset/${dataset}/${dataset}_groundtruth.ivecs${shuf_postfix} \
/home/hadoop/wzy/nsg/results/${dataset}/${dataset}_nsg_L${L}_R${R}_C${C}_perform_variance${recall}.log${shuf_postfix} \
