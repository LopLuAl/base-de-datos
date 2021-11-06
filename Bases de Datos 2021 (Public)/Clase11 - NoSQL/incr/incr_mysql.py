import MySQLdb as mdb
from threading import Thread, get_ident

## MySQL non-atomic issues

## DB Config
HOST="localhost"
USER="apptest"
PASSWD='k9s,!)Kow4*2C?5%O}".Wc(6.4{+c8C1cyG%KhE[=~lABn.>Q^=5|LXZdj:Xb*!'
DB="incr"

## Channel pattern
KEY = "incr-this"
COUNT = 2000

def cur():
  return mdb.connect(host=HOST, user=USER, passwd=PASSWD, db=DB).cursor()

def count():
  c = cur()
  c.execute("SELECT val FROM incr WHERE name = %s", (KEY,))
  (val,) = c.fetchone()
  c.execute("UPDATE incr SET val = %s WHERE name = %s", (val+1, KEY))
  print("Thread: %i, Value: %i" % (get_ident(), val))

def reset():
  # Reset counter
  cur().execute("UPDATE incr SET val=0 WHERE name = %s", (KEY,))

def run():
  reset()
  for i in range(COUNT):
    Thread(target=count).start()

if __name__ == '__main__':
  run()
