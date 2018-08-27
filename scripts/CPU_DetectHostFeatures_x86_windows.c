#include<stdio.h>

#define REG_EAX 0
#define REG_EBX 1
#define REG_ECX 2
#define REG_EDX 3

int cpuInfo[4];
int nCPUIds;

int isbitset(int function_id, int register_idx, int bit_num)
{
	if(nCPUIds >= function_id)
	{
		__cpuid(cpuInfo, function_id);
		int mask = 1 << bit_num;
		return cpuInfo[register_idx] & mask;
	}
	return 0;
}

void print_if_supported(const char *str, int supported)
{
	if(supported)
		printf("%s ", str);
}

int main()
{
	__cpuid(cpuInfo, 0);
	nCPUIds = cpuInfo[0];
	
	print_if_supported("sse2", isbitset(1, REG_EDX, 26));
	print_if_supported("sse3", isbitset(1, REG_ECX, 0));
	print_if_supported("sse4.1", isbitset(1, REG_ECX, 19));
	
	return 0;
}
