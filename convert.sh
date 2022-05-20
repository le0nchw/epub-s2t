mkdir -p temp
mkdir -p out
cd in
find . -iname "*.epub" -o -iname "*.docx" -o -iname "*.xlsm" -o -iname "*.xlsx"|while read fname; do
  unzip -qq -O big5 -o "$fname" -d "../temp/$fname" # unzip to temp
  cd ../temp
  cd "$fname"
  tcname=$(echo "$fname" | opencc -c s2t)
  find ./ -type f -iname "*.html" -o -iname "*.xhtml" -o -iname "*.xml" -o -iname "*.opf" -o -iname "*.ncx"|while read conv; do # convert every file
    opencc -i "$conv" -c s2hk -o "$conv"
  done
  zip -q -r "../../out/$tcname" .
  cd ../../in
done
rm -rf ../temp