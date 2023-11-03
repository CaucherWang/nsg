cd build/
make -j

L=50
C=500
R=32
shuf_postfix=_shuf7


cd tests/

./test_nsg_performance /home/hadoop/wzy/dataset/deep1M/deep_base.fvecs${shuf_postfix} \
/home/hadoop/wzy/dataset/deep1M/deep_query.fvecs \
/home/hadoop/wzy/dataset/deep1M/deep_L${L}_R${R}_C${C}.nsg${shuf_postfix} \
50 \
/home/hadoop/wzy/dataset/deep1M/deep_groundtruth.ivecs${shuf_postfix} \
/home/hadoop/wzy/ADSampling/results/deep/deep_nsg_L${L}_R${R}_C${C}_perform_variance.log${shuf_postfix} \

