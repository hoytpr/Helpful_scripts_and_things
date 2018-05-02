index=6
cat Goat3_com_L1_Sex5-copy.ped | awk -F, -v OFS=, '{$'$index'="2"; print }' > Goat3_com_L1_Sex2Pheno2.ped