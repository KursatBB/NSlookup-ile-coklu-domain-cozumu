#!/bin/bash
# nslookup ile toplu şekilde dns çözümü yapıp çözülmeyenleri geri döndürür.

file=$1

if [[ ! -f "$file" ]]; then
    echo "Domain dosyası bulunamadı: $file"
    exit 1
fi
echo "Aşağıdaki domainler çözülemedi:"
while IFS= read -r domain || [[ -n "$domain" ]]; do
    if [[ -n "$domain" ]]; then
        nslookup_result=$(nslookup "$domain" 2>/dev/null)
        if echo "$nslookup_result" | grep -qi "can't find\|non-existent domain"; then
            echo "$domain"
        fi
    fi
done < "$file"
