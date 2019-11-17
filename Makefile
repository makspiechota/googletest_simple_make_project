IDIR=libs/googletest/googletest/include/ 
CXX=g++
CXXFLAGS=-I$(IDIR) -I. -g

ODIR=src
OTESTDIR=unit_tests
LDIR=libs

LIBS=-lm -Llibs -lgtest_main -lgtest -lpthread 

_OBJ = first_module.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

_TESTOBJ = first_test.o
TESTOBJ = $(patsubst %,$(OTESTDIR)/%,$(_TESTOBJ))

$(ODIR)/%.o: %.cpp $(DEPS)
	$(CXX) -c -o $@ $< $(CXXFLAGS)
$(OTESTDIR)/%.o: %.cpp $(DEPS)
	$(CXX) -c -o $@ $< $(CXXFLAGS)

OUTPUT_DIR=bin

production: $(OBJ)
	$(CXX) -o $(OUTPUT_DIR)/$@ $^ $(CXXFLAGS) $(LIBS)

test: $(OBJ) $(TESTOBJ)
	$(CXX) -o $(OUTPUT_DIR)/$@ $^ $(CXXFLAGS) $(LIBS)

debug_test: $(OBJ) $(TESTOBJ)
	$(CXX) -o $(OUTPUT_DIR)/$@ $^ -g -ggdb $(CXXFLAGS) $(LIBS) 

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 
	rm -f $(OTESTDIR)/*.o *~ core $(INCDIR)/*~ 
	rm -f $(OUTPUT_DIR)/* *~ core $(INCDIR)/*~ 

run:
	./bin/test
