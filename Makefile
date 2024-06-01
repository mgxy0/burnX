CXX = g++
CXXFLAGS = -Wall -std=c++11
LIBS = -lisofs -lburn

all: burnX

burnX: main.o functions.o
	$(CXX) $(CXXFLAGS) -o burnX main.o functions.o $(LIBS)

main.o: main.cpp functions.h
	$(CXX) $(CXXFLAGS) -c main.cpp

functions.o: functions.cpp functions.h
	$(CXX) $(CXXFLAGS) -c functions.cpp

clean:
	rm -f burnX *.o
