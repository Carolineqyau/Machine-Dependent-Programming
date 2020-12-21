.global get_combs
.global combAux
.equ ws,4

.text


/*int** get_combs(int* items, int k, int len) {
    int counter = 0;
    int num_comb = num_combs(len, k);
    int* cur_row = (int*) malloc(sizeof(int) * k);
    int ** output = malloc(sizeof(int *) * num_comb);
    for (int i = 0; i < num_comb; i++){
        output[i] = malloc(sizeof(int) * k);
    }
    combAux(0, 0, len, k, &counter, cur_row, output, items);
    return output;
}
*/

/*void combAux(int num, int selected, int len, int k, int* counter, int* cur_row, int** output, int* items){
    if(selected == k){
        for(int i = 0; i < k; i++) {
            output[*counter][i] = cur_row [i];
        }
        *counter ++;
        return;
    }
    for(int i = num; i < len; i++) {
        cur_row[selected] = items[i];
        combAux(i+1,selected+1, len, k, counter, cur_row, output, items);
    }
}
*/

combAux:
	prologue_1:
	push %esp
	movl %esp, %ebp
	subl $1*ws, %esp	#make space for locals
	push %ebx
	push %edi
	
	#stack after prologue
	#+36	items
	#+32	output
	#+28	cur_row
	#+24	counter
	#+20	k
	#+16	len
	#+12	selected
	#+8	num
	#+4	return address
	# ebp old stack frame pointer
	#-4	i
	#
	.equ num, 2*ws		#ebp
	.equ selected, 3*ws 	#ebp
	.equ len, 4*ws		#ebp
	.equ k, 5*ws		#ebp
	.equ counter, 6*ws	#ebp
	.equ cur_row, 7*ws	#ebp
	.equ output, 8*ws	#ebp
	.equ items, 9*ws	#ebp	
	.equ  i, -1*ws		#ebp
	.equ  j, -2*ws
	
	 #if(selected == k)
	movl selected(%ebp), %edx
	cmpl k(%ebp), %edx
	jne if_end
	if:
		#for(int i = 0; i < k; i++)
		#ECX will be i
		movl $0, i(%ebp)  #i=0
		for_1:
			# i < k == i - k <0
			# neg: i - k >= 0
			movl i(%ebp),%ecx
			cmpl k(%ebp), %ecx
			jge for_1_end
			#--------------------------------------------------------------
			#output[*counter][i] = cur_row [i];
			# EDX will be cur_row[i]
			movl cur_row(%ebp), %edx	# EDX = cur_row
			movl (%edx, %ecx, ws), %edx	# EDX = cur_row[i]
			# EBX will be *counter
			movl counter(%ebp), %ebx	# EBX = &counter
			movl (%ebx), %ebx		# EBX = couner
			# EDI will be output[*counter]	
			movl output(%ebp), %edi		# EDI = output
			movl (%edi,%ebx,ws), %edi	# EDI = output[*counter]
			movl %edx, (%edi, %ecx,ws) 
			#----------------------------------------------------------------
			incl %ecx  #i++
			movl %ecx, i(%ebp)
			jmp for_1
		for_1_end:
		
		# *counter ++
		movl counter(%ebp), %edx
		movl (%edx), %edx		# EDX = *counter
		incl %edx
		movl counter(%ebp), %eax
		movl %edx, (%eax) 		#counter = counter+1
		# return
		jmp epilogue_1
	if_end:
	# for(int j = num; j < len; j++)
	# ECX will be j
	movl num(%ebp), %ecx  # j = num
	movl %ecx, j(%ebp)	
	for_2:
		# j < len == i - len <0
		# neg: i - len >= 0	
		movl j(%ebp), %ecx	
		cmpl len(%ebp), %ecx
		jge for_2_end

		#-------------------------------------------------------
		#cur_row[selected] = items[i]
		movl items(%ebp), %eax
		movl (%eax, %ecx, ws), %eax	#EAX = items[i]
		movl cur_row(%ebp), %ebx	#EBX = cur_row
		movl selected(%ebp), %edx	#EDX = selected
		movl %eax, (%ebx,%edx,ws) 	#cur_row[selected] = items[i]
		
		#-------------------------------------------------------------
		#combAux(j+1,selected+1, len, k, counter, cur_row, output, items);
		movl items(%ebp), %edx
		push %edx
		
		movl output(%ebp), %edx
		push %edx
		
		movl cur_row(%ebp), %edx
		push %edx
		
		movl counter(%ebp), %edx
		push %edx
	
		movl k(%ebp), %edx
		push %edx
		
		movl len(%ebp), %edx
		push %edx
		
		movl selected(%ebp), %edx
		addl $1, %edx
		push %edx
		
		movl j(%ebp), %edx
		addl $1, %edx
		push %edx
		
		call combAux
		addl $8*ws, %esp	#clear the arguments of combAux

		#------------------------------------------------------		
		incl %ecx #j++
		movl %ecx, j(%ebp) #save i
	for_2_end:
		
	epilogue_1:
		movl output(%ebp), %eax
		pop %edi
		pop %ebx
		movl %ebp, %esp
		pop %ebp
		ret

#---------------------------------------------------------------------------------------------------------------------

get_combs:
	prologue:
        push %esp
        movl %esp, %ebp
	subl $5*ws, %esp
	push %ebx
	#stack after prologue
	#+16	len
	#+12	k
	#+8	items
	#+4	return address
	# ebp old stack frame pointer
	#-4 	counter
	#-8	num_comb
	#-12	cur_row
	#-16	output
	#-20 	i
		
	.equ items, 2*ws	#ebp
	.equ k, 3*ws		#ebp
	.equ len, 4*ws		#ebp
	.equ counter, -1*ws	#ebp
	.equ num_comb, -2*ws	#ebp
	.equ cur_row, -3*ws	#ebp
	.equ output, -4*ws	#ebp
	.equ i, -5*ws		#ebp
		
	#int counter = 0;
	movl $0, counter(%ebp)	
		
	#int num_comb = num_combs(len, k);
	movl k(%ebp), %edx
	push %edx
	movl len(%ebp),%edx
	push %edx
	call num_combs					# clear the argument of num_combs
	addl $2*ws, %esp				
	movl %eax, num_comb(%ebp)
	
	#int* cur_row = (int*) malloc(sizeof(int) * k);
	movl k(%ebp), %edx 	# edx = k
	shll $2, %edx 		# edx = (sizeof(int) * k)	
    	push %edx
	call malloc
	addl $1*ws, %esp 				# clear the argument of malloc
	movl %eax, cur_row(%ebp)
	
	#int ** output = malloc(sizeof(int *) * num_comb);
	movl num_comb(%ebp), %edx	#edx = num_comb
	shll $2, %edx			#edx = sizeof(int *) * num_comb
	push %edx
	call malloc
	addl $1*ws, %esp				 # clear the argument of malloc
	movl %eax, output(%esp)
	
	#for (int i = 0; i < num_comb; i++)
	#ECX will be i
	movl $0, %ecx 		#i = 0
	# i < num_comb == i - num_comb <0
	# neg: i - num_comb >= 0
	for:
		cmpl num_comb(%ebp), %ecx
		jge for_end	
		#----------------------------------------------------
		#output[i] = malloc(sizeof(int) * k)
		movl k(%ebp), %edx	# edx = k
		shll $2, %edx		# edx = sizeof(int) *k
		push %edx
		movl %ecx, i(%ebp)	#save i
		call malloc
		movl i(%ebp), %ecx	#restore ecx
		addl $1*ws, %esp	#clear argument
		movl output(%ebp), %ebx #ebx = output
		movl %eax, (%ebx,%ecx,ws) #output[i] = malloc(sizeof(int) * k)
		#----------------------------------------------------
		incl %ecx # i++
		movl %ecx, i(%ebp)
		jmp for
	for_end:	
	# combAux(0, 0, len, k, &counter, cur_row, output, items);
	movl items(%ebp), %edx
	push %edx

	movl output(%ebp), %edx
	push %edx

	movl cur_row(%ebp), %edx
	push %edx

	leal counter(%ebp), %edx
	push %edx

	movl k(%ebp), %edx
	push %edx

	movl len(%ebp), %edx
	push %edx

	movl $0, %edx
	push %edx

	movl $0, %edx
	push %edx

	call combAux
	movl %eax, output(%ebp)
	addl $8*ws, %esp
	

	epilogue:
	movl output(%ebp), %eax #return output
	pop %ebx
        movl %ebp, %esp #clear locals
        pop %ebp #restore ebp
        ret
