@ECHO off
SETLOCAL
set "thriftExe=thrift-0.13.0.exe"
echo using "%thriftExe%"


echo Generating csharp source code...."
for %%f in (mmi\*.thrift) do %thriftExe% -gen csharp %%f

echo Generating c++ source code...."
for %%f in (mmi\*.thrift) do %thriftExe% -gen cpp %%f

echo Generating java source code...."
for %%f in (mmi\*.thrift) do %thriftExe% -gen java %%f

echo Generating pythonsource code...."
for %%f in (mmi\*.thrift) do %thriftExe% -gen py %%f

echo Generating pythonsource code...."
for %%f in (mmi\*.thrift) do %thriftExe% -gen php %%f