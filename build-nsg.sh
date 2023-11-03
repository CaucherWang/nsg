cd build/
make -j

L=50
C=500
R=32
shuf_postfix=_shuf7

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

./test_nsg_index /home/hadoop/wzy/dataset/deep1M/deep_base.fvecs${shuf_postfix} \
/home/hadoop/wzy/dataset/deep1M/deep.efanna${shuf_postfix} \
${L} ${R} ${C} \
/home/hadoop/wzy/dataset/deep1M/deep_L${L}_R${R}_C${C}.nsg${shuf_postfix}
