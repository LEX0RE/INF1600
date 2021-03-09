.text
.globl check
check :
   movl 4(%esp), %ecx
   leal adr_z,%eax
   addl %ecx,%eax
   movl (%eax),%eax
   ret
	
# dernier 4 octet MSB de z  : 0xf3170090
# avec un CF errone :  0xf317008f

# premier 4 octet LSB de z : 0xeb9116bb  

