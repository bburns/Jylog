
# Makefile for Jylog


# Get classpath separator
# this doesn't work! OSTYPE is empty within make, even though it's set in environment!
#ifeq ($(OSTYPE),linux-gnu)
# under windows, echo %os% returns Windows_NT, while under linux it 
# doesn't return anything useful, but it doesn't give an error message either.  
@OS = $(shell echo %OS%)
ifeq ($(OS),Windows_NT)
  X = ;
else
  X = :
endif


# set environment variables
ANTLR=lib/antlr-3.2.jar
TUPROLOG=lib/2p.jar
YPROLOG=lib/YProlog.jar
#JUNIT=lib/junit-4.8.1.jar

# set java classpath
#CLASSPATH=".$(X)$(ANTLR)$(X)$(TUPROLOG)"
CLASSPATH=".$(X)$(ANTLR)$(X)$(TUPROLOG)$(X)$(YPROLOG)"


.DEFAULT_GOAL=jylog


# test prolog
testProlog: Prolog.class
	java -cp $(CLASSPATH) Prolog
Prolog.class: Prolog.java
	javac -cp $(CLASSPATH) Prolog.java

# tuProlog console
tu:
	java -cp lib/2p.jar alice.tuprologx.ide.CUIConsole

# yprolog console
#yprolog:
#	java lib/YProlog.jar


# this needs the antlr runtime in the classpath
jylog: Jylog.class
	java -cp $(CLASSPATH) Jylog

# compile the harness program, which loads and runs the Parser
Jylog.class: Jylog.java JylogParser.class
	javac -cp $(CLASSPATH) Jylog.java

# compile the generated parser program
JylogParser.class: JylogLexer.java JylogParser.java
	javac -cp $(CLASSPATH) Jylog*.java

# build JylogLexer.java, JylogParser.java, Jylog.tokens from the grammar file
JylogLexer.java: Jylog.g 
	java -cp $(CLASSPATH) org.antlr.Tool Jylog.g

clean:
	rm *.class JylogParser.java JylogLexer.java Jylog.tokens


# grammar gui
ANTLRWORKS=C:/apps/Java/antlr/antlrworks-1.3.1.jar
gui:
	start java -jar $(ANTLRWORKS)

edit:
	$(EDITOR) Makefile readme.txt project.txt Jylog.g Jylog.java test.jylog



