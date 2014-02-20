CPPFLAGS=-I include -Wall -std=c++11 -O2 -lOpenCL
CXX=clang++
SHELL=/bin/bash

EXECUTABLES = src/test_opencl src/make_world src/step_world src/render_world\
	src/ywc110/step_world_v1_lambda src/ywc110/step_world_v2_function\
	src/ywc110/step_world_v3_opencl

all: $(EXECUTABLES)

src/make_world: src/heat.o
src/step_world: src/heat.o
src/render_world: src/heat.o
src/ywc110/step_world_v1_lambda: src/heat.o
src/ywc110/step_world_v2_function: src/heat.o
src/ywc110/step_world_v3_opencl: src/heat.o

heat.o: include/heat.hpp

clean:
	rm -f $(EXECUTABLES)
	rm -f src/*.o

# Use make diff actual=xxx
diff:
	diff <(./src/make_world 10 0.1 | ./src/step_world 0.1 10000)\
		<(./src/make_world 10 0.1 | ./src/ywc110/${actual} 0.1 10000)
