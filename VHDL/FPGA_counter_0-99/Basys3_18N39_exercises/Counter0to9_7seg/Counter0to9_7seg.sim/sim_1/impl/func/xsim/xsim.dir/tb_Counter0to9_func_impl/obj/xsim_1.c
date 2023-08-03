/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_360(char*, char *);
IKI_DLLESPEC extern void execute_361(char*, char *);
IKI_DLLESPEC extern void execute_18(char*, char *);
IKI_DLLESPEC extern void execute_20(char*, char *);
IKI_DLLESPEC extern void execute_21(char*, char *);
IKI_DLLESPEC extern void execute_22(char*, char *);
IKI_DLLESPEC extern void execute_23(char*, char *);
IKI_DLLESPEC extern void execute_24(char*, char *);
IKI_DLLESPEC extern void execute_25(char*, char *);
IKI_DLLESPEC extern void execute_26(char*, char *);
IKI_DLLESPEC extern void execute_76(char*, char *);
IKI_DLLESPEC extern void execute_83(char*, char *);
IKI_DLLESPEC extern void execute_119(char*, char *);
IKI_DLLESPEC extern void execute_122(char*, char *);
IKI_DLLESPEC extern void execute_125(char*, char *);
IKI_DLLESPEC extern void execute_128(char*, char *);
IKI_DLLESPEC extern void execute_131(char*, char *);
IKI_DLLESPEC extern void execute_134(char*, char *);
IKI_DLLESPEC extern void execute_138(char*, char *);
IKI_DLLESPEC extern void execute_156(char*, char *);
IKI_DLLESPEC extern void execute_157(char*, char *);
IKI_DLLESPEC extern void execute_158(char*, char *);
IKI_DLLESPEC extern void execute_260(char*, char *);
IKI_DLLESPEC extern void execute_266(char*, char *);
IKI_DLLESPEC extern void execute_267(char*, char *);
IKI_DLLESPEC extern void execute_280(char*, char *);
IKI_DLLESPEC extern void execute_283(char*, char *);
IKI_DLLESPEC extern void execute_286(char*, char *);
IKI_DLLESPEC extern void execute_289(char*, char *);
IKI_DLLESPEC extern void execute_292(char*, char *);
IKI_DLLESPEC extern void execute_295(char*, char *);
IKI_DLLESPEC extern void execute_298(char*, char *);
IKI_DLLESPEC extern void execute_321(char*, char *);
IKI_DLLESPEC extern void execute_323(char*, char *);
IKI_DLLESPEC extern void execute_324(char*, char *);
IKI_DLLESPEC extern void execute_329(char*, char *);
IKI_DLLESPEC extern void execute_332(char*, char *);
IKI_DLLESPEC extern void execute_337(char*, char *);
IKI_DLLESPEC extern void transaction_34(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_36(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_41(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_42(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_43(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_55(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_56(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_57(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_58(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_59(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_60(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_61(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_70(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_72(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_73(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_74(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_75(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_76(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_77(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_78(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_79(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_81(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_83(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_85(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_87(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_89(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_91(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_93(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_94(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_167(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_175(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_183(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_191(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_199(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_207(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_215(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_223(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_231(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_239(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_247(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_255(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_263(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_271(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_279(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_287(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_295(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_303(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_311(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_319(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_327(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_335(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_343(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_351(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_359(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_367(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_375(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_419(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_426(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_433(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_440(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[99] = {(funcp)execute_360, (funcp)execute_361, (funcp)execute_18, (funcp)execute_20, (funcp)execute_21, (funcp)execute_22, (funcp)execute_23, (funcp)execute_24, (funcp)execute_25, (funcp)execute_26, (funcp)execute_76, (funcp)execute_83, (funcp)execute_119, (funcp)execute_122, (funcp)execute_125, (funcp)execute_128, (funcp)execute_131, (funcp)execute_134, (funcp)execute_138, (funcp)execute_156, (funcp)execute_157, (funcp)execute_158, (funcp)execute_260, (funcp)execute_266, (funcp)execute_267, (funcp)execute_280, (funcp)execute_283, (funcp)execute_286, (funcp)execute_289, (funcp)execute_292, (funcp)execute_295, (funcp)execute_298, (funcp)execute_321, (funcp)execute_323, (funcp)execute_324, (funcp)execute_329, (funcp)execute_332, (funcp)execute_337, (funcp)transaction_34, (funcp)transaction_36, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_41, (funcp)transaction_42, (funcp)transaction_43, (funcp)transaction_55, (funcp)transaction_56, (funcp)transaction_57, (funcp)transaction_58, (funcp)transaction_59, (funcp)transaction_60, (funcp)transaction_61, (funcp)transaction_70, (funcp)transaction_72, (funcp)transaction_73, (funcp)transaction_74, (funcp)transaction_75, (funcp)transaction_76, (funcp)transaction_77, (funcp)transaction_78, (funcp)transaction_79, (funcp)transaction_81, (funcp)transaction_83, (funcp)transaction_85, (funcp)transaction_87, (funcp)transaction_89, (funcp)transaction_91, (funcp)transaction_93, (funcp)transaction_94, (funcp)transaction_167, (funcp)transaction_175, (funcp)transaction_183, (funcp)transaction_191, (funcp)transaction_199, (funcp)transaction_207, (funcp)transaction_215, (funcp)transaction_223, (funcp)transaction_231, (funcp)transaction_239, (funcp)transaction_247, (funcp)transaction_255, (funcp)transaction_263, (funcp)transaction_271, (funcp)transaction_279, (funcp)transaction_287, (funcp)transaction_295, (funcp)transaction_303, (funcp)transaction_311, (funcp)transaction_319, (funcp)transaction_327, (funcp)transaction_335, (funcp)transaction_343, (funcp)transaction_351, (funcp)transaction_359, (funcp)transaction_367, (funcp)transaction_375, (funcp)transaction_419, (funcp)transaction_426, (funcp)transaction_433, (funcp)transaction_440};
const int NumRelocateId= 99;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_Counter0to9_func_impl/xsim.reloc",  (void **)funcTab, 99);
	iki_vhdl_file_variable_register(dp + 100704);
	iki_vhdl_file_variable_register(dp + 100760);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_Counter0to9_func_impl/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_Counter0to9_func_impl/xsim.reloc");

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb_Counter0to9_func_impl/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_Counter0to9_func_impl/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_Counter0to9_func_impl/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
