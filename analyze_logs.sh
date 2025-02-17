#!/bin/bash

logs_file=access.log

echo "Отчет о логе веб-сервера" > report.txt
echo "========================" >> report.txt

total_requests="$(awk 'END {print NR}' $logs_file)"
echo -e "Общее количество запросов:\t${total_requests}" >> report.txt
