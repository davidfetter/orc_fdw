CC			 = gcc
LIBS		+= `pkg-config --libs libprotobuf-c zlib`
INCLUDES	+= `pkg-config --cflags libprotobuf-c zlib`
CFLAGS		 = -Wall
SNAPPY_FOLDER = snappy-c

EXEC_FOLDER				= out
READMETADATA_OBJECTS	= readMetadata.o orc_proto.pb-c.o
TEST_OBJECTS			= test.o recordReader.o
TESTFILEREADER_OBJECTS	= testFileReader.o recordReader.o orc_proto.pb-c.o util.o fileReader.o $(SNAPPY_FOLDER)/snappy.o 
EXECUTABLES				= readMetadata test testFileReader


all:			$(EXECUTABLES) snappy_c
				mv $(EXECUTABLES) $(EXEC_FOLDER)/

snappy_c:
				cd snappy-c && make

.SUFFIXES: 		.c .o

.c.o:	
				$(CC) -g $(CFLAGS) $(INCLUDES) -c $<

.o:		
				$(CC) -g $(CFLAGS) $^ -o $@ $(LIBS)

readMetadata:	$(READMETADATA_OBJECTS)

test:			$(TEST_OBJECTS)

testFileReader:	$(TESTFILEREADER_OBJECTS)

.PHONY:			clean

clean:	
				rm -f $(EXEC_FOLDER)/* *.o
