cd build/
make -j

L=50
C=500
R=32

cd tests/

./test_nsg_search /home/hadoop/wzy/dataset/deep1M/deep_base.fvecs \
/home/hadoop/wzy/dataset/deep1M/deep_query.fvecs \
/home/hadoop/wzy/dataset/deep1M/deep_L${L}_R${R}_C${C}.nsg \
300 10 \
/home/hadoop/wzy/dataset/deep1M/deep_groundtruth.ivecs \
/home/hadoop/wzy/adsampling/deep1M/deep_groundtruth.ivecs

# ./test_nsg_search /home/hadoop/wzy/dataset/laion1M/laion1M_base.fvecs_norm \
# /home/hadoop/wzy/dataset/laion1M/laion1M_query.fvecs_norm \
# /home/hadoop/wzy/dataset/laion1M/laion1M_L${L}_R${R}_C${C}.nsg \
# 300 10 \
# /home/hadoop/wzy/dataset/laion1M/laion1M_groundtruth.ivecs


# ./test_nsg_search /home/hadoop/wzy/dataset/webvid1M/webvid1M_base.fvecs \
# /home/hadoop/wzy/dataset/webvid1M/webvid1M_query.fvecs \
# /home/hadoop/wzy/dataset/webvid1M/webvid1M_L${L}_R${R}_C${C}.nsg \
# 300 10 \
# /home/hadoop/wzy/dataset/webvid1M/webvid1M_groundtruth.ivecs
