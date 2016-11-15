:: initialize environment variables and java classpath to include necessary libraries

@echo off

:: i already have java_home set, and seems to be okay without javacc_home
:: set JAVA_HOME="C:\Program Files\Java\jdk1.6.0_13"
:: set JAVACC_HOME="C:\Program Files\Java\javacc-4.2\javacc-4.2\bin\lib"

:: add TDB jarfiles to classpath - works with relative paths like this
set TDB_HOME=lib\TDB-0.8.4
set CLASSPATH=.
set CLASSPATH=%TDB_HOME%\lib\jena-2.6.2.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\arq-2.8.2-tests.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\arq-2.8.2.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\icu4j-3.4.4.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\iri-0.8.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\jena-2.6.2-tests.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\junit-4.5.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\log4j-1.2.14.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\lucene-core-2.3.1.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\slf4j-api-1.5.8.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\slf4j-log4j12-1.5.6.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\stax-api-1.0.1.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\tdb-0.8.4.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\wstx-asl-3.2.9.jar;%CLASSPATH%
set CLASSPATH=%TDB_HOME%\lib\xercesImpl-2.7.1.jar;%CLASSPATH%

:: add YProlog to classpath
set CLASSPATH=lib\YProlog.jar;%CLASSPATH%
