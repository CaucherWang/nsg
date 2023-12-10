cd build/
make -j

L=200
C=500
R=100
ds=rand
# L=50
# C=500
# R=32
shuf_postfix=_shuf9

cd tests/

# ./test_nsg_index /home/hadoop/wzy/dataset/laion1M/laion1M_base.fvecs_norm \
# /home/hadoop/wzy/dataset/laion1M/laion1M_norm.efanna \
# ${L} ${R} ${C} \
# /home/hadoop/wzy/dataset/laion1M/laion1M_L${L}_R${R}_C${C}.nsg

# ./test_nsg_index /home/hadoop/wzy/dataset/webvid1M/webvid1M_base.fvecs \
# /home/hadoop/wzy/dataset/webvid1M/webvid1M.efanna \
# ${L} ${R} ${C} \
# /home/hadoop/wzy/dataset/webvid1M/webvid1M_L${L}_R${R}_C${C}.nsg

# ./test_nsg_index /home/hadoop/wzy/dataset/yandex-text2image1M/yandex-text2image1M_base.fvecs \
# /home/hadoop/wzy/dataset/yandex-text2image1M/yandex-text2image1M.efanna \
# ${L} ${R} ${C} \
# /home/hadoop/wzy/dataset/yandex-text2image1M/yandex-text2image1M_L${L}_R${R}_C${C}.nsg

# ./test_nsg_index /home/hadoop/wzy/dataset/${ds}1M/${ds}_base.fvecs${shuf_postfix} \
# /home/hadoop/wzy/dataset/${ds}1M/${ds}1M.efanna${shuf_postfix} \
# ${L} ${R} ${C} \
# /home/hadoop/wzy/dataset/${ds}1M/${ds}_L${L}_R${R}_C${C}.nsg${shuf_postfix}

# ./test_nsg_index /home/hadoop/wzy/dataset/rand100/rand100_base.fvecs${shuf_postfix} \
# /home/hadoop/wzy/dataset/rand100/rand100.efanna${shuf_postfix} \
# ${L} ${R} ${C} \
# /home/hadoop/wzy/dataset/rand100/rand100_L${L}_R${R}_C${C}.nsg${shuf_postfix}

# ./test_nsg_index /home/hadoop/wzy/dataset/gauss100/gauss100_base.fvecs${shuf_postfix} \
# /home/hadoop/wzy/dataset/gauss100/gauss100.efanna${shuf_postfix} \
# ${L} ${R} ${C} \
# /home/hadoop/wzy/dataset/gauss100/gauss100_L${L}_R${R}_C${C}.nsg${shuf_postfix}

./test_nsg_index /home/hadoop/wzy/dataset/gauss100/gauss100_base.fvecs${shuf_postfix} \
/home/hadoop/wzy/dataset/gauss100/gauss100_self_groundtruth.ivecs_clean${shuf_postfix} \
${L} ${R} ${C} \
/home/hadoop/wzy/dataset/gauss100/gauss100_L${L}_R${R}_C${C}.nsg${shuf_postfix}
