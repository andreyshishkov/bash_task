#!/bin/bash

logs_file=access.log

echo "Отчет о логе веб-сервера" > report.txt
echo "========================" >> report.txt

total_requests="$(awk 'END {print NR}' $logs_file)"
echo -e "Общее количество запросов:\t${total_requests}" >> report.txt

unique_ip_count="$(awk '!U[$1]++{count++} END {print count}' $logs_file)"
echo -e "Количество уникальных IP-адресов:\t${unique_ip_count}" >> report.txt

echo -e "" >> report.txt

echo "Количество запросов по методам:" >> report.txt
awk '{sub(/"/, "", $6); counts[$6]++} END {for (val in counts) print "\t", counts[val], val}' $logs_file >> report.txt

echo "" >> report.txt

most_popular_url="$(awk '{counts[$7]++} END {
    max_count=0; max_value=""; 
    for (val in counts) {
        if (counts[val] > max_count) {max_count = counts[val]; max_value = val}
        }
    print max_count, "\t", max_value
    }' $logs_file
)"

echo -e "Самый популярный URL:\t${most_popular_url}" >> report.txt

echo "Отчет сохранен в файл report.txt"
