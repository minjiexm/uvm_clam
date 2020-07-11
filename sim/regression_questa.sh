#compile command
vlog -64  -timescale "1ns/1ps" -L $QUESTA_HOME/uvm-$UVM_VERSION -f $PROJECT_LOC/tb/filelist.f -writetoplevels questa.tops -l questa_compile.log

#simulation command
vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_oop_default.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_object_oop_args_default \
	+ARGS_TRACE


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_oop_global.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_object_oop_args_global \
	+ARGS_TRACE +pkt_num=16


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_oop_diff.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_object_oop_args_diff_value\
	+ARGS_TRACE +pkt_num=16 +uvm_test_top.sequence_port0.pkt_num=11 +uvm_test_top.sequence_port1.pkt_num=23


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_comp_default.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_component_oop_args_default \
	+ARGS_TRACE


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_comp_global.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_component_oop_args_global \
	+ARGS_TRACE +axi_uvc_num=16


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_comp_diff.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_component_oop_args_diff_value \
	+ARGS_TRACE +axi_uvc_num=16 +uvm_test_top.usb_axi_env.axi_uvc_num=6 +uvm_test_top.pcie_axi_env.axi_uvc_num=8


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_comp_diff_cfgdb_args.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_component_oop_args_diff_value \
	+ARGS_TRACE +axi_uvc_num=16 +uvm_set_config_int='uvm_test_top.usb_axi_env,axi_uvc_num,6' +uvm_set_config_int='uvm_test_top.pcie_axi_env,axi_uvc_num,8'


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_comp_cfgdb.log -wlf vsim.wlf -f questa.tops -c \
        +UVM_TESTNAME=uvm_clam_test_component_oop_args_cfg_db \
	+ARGS_TRACE +axi_uvc_num=16 +uvm_set_config_int='uvm_test_top.usb_axi_env,axi_uvc_num,6' +uvm_set_config_int='uvm_test_top.pcie_axi_env,axi_uvc_num,8'


vsim -64 -L $QUESTA_HOME/uvm-$UVM_VERSION -do "log -r /*; run -all; q" -l questa_factory_sim.log -wlf vsim.wlf -f questa.tops -c -sv_seed random +UVM_VERBOSITY=UVM_DEBUG \
        +UVM_TESTNAME=uvm_clam_test_factory_override_with_args \
	+ARGS_TRACE +uvm_set_type_override='usb_env_config,usb_env_config_with_args' +usb_dev_num=99

#+UVM_CONFIG_DB_TRACE \

egrep "ERROR" questa*.log
