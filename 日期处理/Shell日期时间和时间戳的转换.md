### Linux下时间转换的一些命令：
 
##### date +%s   可以得到UNIX的时间戳;   

+ 用shell将日期时间与时间戳互转：   
      date -d "2015-08-04 00:00:00" +%s     输出：1438617600

+ 而时间戳转换为字符串可以这样做：   
      date -d @1438617600  "+%Y-%m-%d"    输出：2015-08-04

+ 如果需要得到指定日期的前后几天：   
      seconds=`date -d "2015-08-04 00:00:00" +%s`       #得到时间戳   
      seconds_new=`expr $seconds + 86400`                   #加上一天的秒数86400    
      date_new=`date -d @$seconds_new "+%Y-%m-%d"`   #获得指定日前加上一天的日前    
