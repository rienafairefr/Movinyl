CC = g++
CFLAGS = -g -Wall
SRCS =  page.cpp
PROG = page

OPENCV = `pkg-config opencv4 --cflags --libs`
LIBS = $(OPENCV)
PYBIND = `python3 -m pybind11 --includes`

$(PROG):$(SRCS)
	$(CC) $(CFLAGS) -o $(PROG) $(SRCS) $(LIBS) $(PYBIND)
