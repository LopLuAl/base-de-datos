chmod +x serialize.py
chmod +x deserialize.py
mkfifo channel

./serialize.py "Metallica"	# Solo hace un pretty print
./serialize.py "Metallica" xml
./serialize.py "Metallica" json
./serialize.py "Metallica" yaml

./serialize.py "Metallica" xml | ./deserialize.py xml
./serialize.py "Metallica" json | ./deserialize.py json
./serialize.py "Metallica" yaml | ./deserialize.py yaml

./serialize.py "Metallica" xml >> channel
cat channel | ./deserialize.py xml

./serialize.py "Metallica" json >> channel
cat channel | ./deserialize.py json

./serialize.py "Metallica" yaml >> channel
cat channel | ./deserialize.py yaml