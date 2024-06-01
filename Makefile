CXX = g++
CXXFLAGS = -Wall -I/usr/include/libisofs -I/usr/include/libburn
LDFLAGS = -lisofs -lburn

all: burnX

burnX: main.o functions.o
	$(CXX) -o burnX main.o functions.o $(LDFLAGS)

main.o: main.cpp functions.h
	$(CXX) $(CXXFLAGS) -c main.cpp

functions.o: functions.cpp functions.h
	$(CXX) $(CXXFLAGS) -c functions.cpp

clean:
	rm -f burnX *.o
