from datetime import datetime
import time

start = '11:13:08'
date_2 = '11:14:18'
date_format_str = '%H:%M:%S'
end=time.strftime("%H %M %S")
#start = datetime.strptime(date_1, date_format_str)
#end =   datetime.strptime(date_2, date_format_str)
# Get interval between two timstamps as timedelta object
diff = end - start
# Get interval between two timstamps in hours
#diff_in_hours = diff.total_seconds() / 3600
#
