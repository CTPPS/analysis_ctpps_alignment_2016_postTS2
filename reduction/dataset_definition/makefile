all: make_json

make_json: make_json.cc
	g++ `root-config --libs` -lMinuit `root-config --cflags` --std=c++11 -Wall -g \
		make_json.cc -o make_json
