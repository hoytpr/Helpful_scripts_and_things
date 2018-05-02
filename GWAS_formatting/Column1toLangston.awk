index=1
cat Goat3copycomma-Copy.ped | awk -F, -v OFS=, '{$'$index'="langston"; print }' > langston1.txt