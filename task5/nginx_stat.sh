
#!/bin/bash


TIME=`date +%d/%b/%Y:%T" "%z`
LOCKFILE=/var/run/nginx_stat.pid

LASTRUNFILE=nginx_stat.lastrun
WORKFILE=workfile
RESULTFILE=resultfile
LT=nginx_stat.logtime

#Блокировка от мультизапуска
set -C
echo $$ > $LOCKFILE 2>/dev/null || { echo "Lockfile $LOCKFILE exists!"; exit 1; }
set +C

BEGINTIME=$TIME

echo "Start analysing from $LASTTIME"

cat $1 > $WORKFILE

#Проверяем наличие лога времени, если нету, то добавляем 1 строку nginx_log для обработки
if [ ! -f  $LT ]; then
   LTR="$(head -1 $1 | awk -F/ '{print$3}' | awk '{print$1}')"
   echo "$LTR" > $LT
else
   LTR="$(tail -1 $LT | awk '{print$1}')"
fi
LLTR="$(tail -1 $LT | awk '{print$1}')"
analyse() {
        FTARGETFILE=$1
        FRESULTFILE=$2
        echo "---" > $2
        echo "Script start time - $BEGINTIME" >> $2
        echo "---" >> $2
        echo "======> Most requests from IPs:" >> $2
        cat $1 | sed -e '1,/'"$LLTR"'/d' | awk '{print $1}' |sort |uniq -c |sort -rn| head >> $2
        echo "---" >> $2
        echo "======> Most popular urls:" >> $2
        cat $1 | sed -e '1,/'"$LLTR"'/d' | awk '{print $7}' |sort |uniq -c |sort -rn| head >> $2
        echo "---" >> $2
        echo "======> Errors:" >> $2
        cat $1 | sed -e '1,/'"$LLTR"'/d' | awk '{print $9}' |grep -E "[4-5]{1}[0-9][0-9]" |sort |uniq -c | sort -rn >> $2
        echo "---" >> $2
        echo "======> HTTP codes:" >> $2
        cat $1 | sed -e '1,/'"$LLTR"'/d' | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -rn | head  >> $2 
        echo "---" >> $2
}
analyse $WORKFILE $RESULTFILE
#сохраняем last time line в log
LTR="$(tail -1 $1 | awk -F/ '{print$3}' | awk '{print$1}')" 
echo "$LTR" > $LT
cp $RESULTFILE nginx_stat_parser-`date +%d%b%Y-%T`.result
cat $RESULTFILE
rm -f $RESULTFILE
trap "rm -f $LOCKFILE $WORKFILE; exit" INT TERM EXIT
exit 0