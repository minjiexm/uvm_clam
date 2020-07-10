#compile command
vlog -64  -timescale "1ns/1ps" -L $QUESTA_HOME/uvm-$UVM_VERSION -f $PROJECT_LOC/tb/filelist.f -writetoplevels questa.tops -l questa_compile.log

#simulation command
vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_sim.log -wlf vsim.wlf -f questa.tops -c -sv_seed random +UVM_VERBOSITY=UVM_DEBUG \
        +UVM_TESTNAME=uvm_clam_test_object_oop_args +ARGS_TRACE +TEST_ARG=13
#       +UVM_TESTNAME=uvm_clam_test_factory_override_with_args

#+ARGS_TRACE +uvm_set_type_override='my_config,my_config_with_args' +uvm_set_config_int='uvm_test_top.args_component_1,TEST_ARG,12' +uvm_test_top.args_object_1.TEST_ARG=13\
#+ARGS_TRACE +uvm_set_type_override='my_config,my_config_with_args' +uvm_test_top.cfg.TEST_ARG=13\
#+UVM_CONFIG_DB_TRACE \
