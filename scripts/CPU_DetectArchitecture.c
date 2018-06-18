int main()
{
#if defined(__x86_64__) || defined(_M_X64)
	printf("x86_64");
#else
	#error "unknown architecture"
#endif
	return 0;
}
