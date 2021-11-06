import cProfile
from incr_redis import run as rcount
from incr_mysql import run as mcount

if __name__ == "__main__":
  print("################# REDIS #################")
  cProfile.run("rcount()")
  print("################# MYSQL #################")
  cProfile.run("mcount()")
