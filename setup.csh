#Set current dir as CSV Home
setenv PROJECT_LOC "${cwd}"

setenv QUESTA_HOME $QUESTASIM_PATH/questasim
setenv UVM_VERSION 1.1d
setenv UVM_HOME $QUESTA_HOME/verilog_src/uvm-$UVM_VERSION

echo "UVM_VERSION is $UVM_VERSION"
echo "UVM_HOME is $UVM_HOME"

