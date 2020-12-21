.global matMult
.equ ws, 4

/*

int** matMult(int **a, int num_rows_a, int num_cols_a, int** b, int num_rows_b, int num_cols_b){
    int** c;
    int i,j,k;
    c = (int**)malloc(num_rows_a * sizeof(int*));
    
    for (i = 0; i < num_rows_a;i++) { //find the first element in each row of a
        (c)[i] = (int*)malloc(num_cols_b * sizeof(int));
        for (j = 0; j < num_cols_b; j++) { // find the first element in each col of b
            c[i][j] = 0;
            for(k = 0; k < num_cols_a; k++) {//go through the elements in the same row of a and col of b
                (c)[i][j] += a[i][k]*b[k][j];
            }
        }
    }
    return c;
}

*/

.text

matMult:
	prologue:
		push %ebp
		movl %esp, %ebp
		subl $5 *ws, %esp #make space for locals
		push %ebx
		push %esi
		push %edi
		
	# +28: num_cols_b
	# +24: num_rows_b
	# +20: b
	# +16: num_cols_a
	# +12: num_rows_a
	# +8: a	
	# +4: return address
	#ebp: old stack frame pointer
	# -4: i
	# -8: j
	# -12: k
	# -16/esp: c
	
	.equ a, 2*ws 			#%ebp
	.equ num_rows_a, 3*ws   #%ebp
	.equ num_cols_a, 4*ws   #%ebp
	.equ b, 5*ws 			#%ebp
	.equ num_rows_b, 6*ws	#%ebp
	.equ num_cols_b, 7*ws	#%ebp
	.equ i, -1*ws			#%ebp
	.equ j, -2*ws			#%ebp
	.equ k, -3*ws			#%ebp
	.equ c, -4*ws			#%ebp
	.equ old_edx, -5*ws
		
	#ECX will be i
	#EDX will be j
	#ESI will be k
	
	#int** c = (int**)malloc(num_rows_a * sizeof(int*));
	movl num_rows_a(%ebp), %eax	#eax = num_rows_a
	shll $2, %eax			#eax = num_rows_a * sizeof(int*)
	push %eax			#push malloc's argument to the stack
	call malloc	
	movl %eax, c(%ebp)		#eax = (int**) malloc(num_rows_a * sizeof(int*))
	addl $1*ws, %esp 		# clear the argument to malloc
						
	#movl %eax, c(%ebp)
	
	#for (i = 0; i < num_rows_a;i++)
	movl $0, %ecx #i = 0
	outer_for_start:
		# i < num_rows_a == i - num_rows_a <0
		# neg: i - num_rows_a >= 0
		cmpl num_rows_a(%ebp), %ecx
		jge outer_for_end
		
		#(c)[i] = (int*)malloc(num_cols_b * sizeof(int));
		movl num_cols_b(%ebp), %edx 	# edx = num_cols_b
		shll $2, %edx 					# edx = num_cols_b * sizeof(int)
		push %edx 						# set arguement for malloc
		movl %ecx, i(%ebp) 				#save i
		call malloc # eax ~~ c[i]
		addl $1*ws, %esp 				# clear the argument of malloc
		movl i(%ebp), %ecx				# restore ecx back to i 
		movl c(%ebp), %edx				# edx = c
		movl %eax, (%edx,%ecx,ws) 		
		
		# eax ~~ c[i]

		#for (j = 0; j < num_cols_b; j++)
		movl $0, %edx 	# j = 0		
		middle_for_start:
			# j<num_cols_b == j - num_cols_b < 0
			# neg: j - num_cols_b >= 0
			cmpl num_cols_b(%ebp), %edx
			jge middle_for_end
			
			# c[i][j] = 0
			# *(*(c+i)+j) = 0
			# ebx will be c[i][j]			
			movl c(%ebp), %ebx		#ebx = 
			movl (%ebx,%ecx,ws), %ebx	#ebx = c[i]
			movl $0, (%ebx,%edx,ws)         #c[i][j] = 0	
			
			#for(k = 0; k < num_cols_a; k++)
			# ESI will be k
				movl $0, %esi
				inner_for_start:
					cmpl num_cols_a(%ebp), %esi
					jge inner_for_end
					#(c)[i][j] += a[i][k]*b[k][j];					
					movl %edx, old_edx(%ebp)	# save old edx value
									
					#eax will be a[i][k]
					movl a(%ebp), %eax 		# eax = a
					movl (%eax,%ecx,ws), %eax	# eax = a[i]
					movl (%eax,%esi,ws), %eax	# eax = a[i][k]
					
					#ebx will be b[k][j]
					movl b(%ebp), %ebx		# ebx = b
					movl (%ebx,%esi,ws), %ebx	# ebx = b[k]
					movl (%ebx,%edx,ws), %ebx	# ebx = b[k][j]
					
					imull %ebx 			# eax = a[i][k]*b[k][j]
					
					#edi will be c[i][j]
					movl c(%ebp), %edi		# edi = c
					movl (%edi,%ecx,ws), %edi	# edi = c[i]
					movl old_edx(%ebp), %edx	# move back the old edx
									# otherwise j value be changed				
					#movl (%edi,%edx,ws), %edi	# edi = c[i][j]			
					
					addl %eax,(%edi,%edx,ws)	#(c)[i][j] += a[i][k]*b[k][j];			
					
					incl %esi
					jmp inner_for_start
				inner_for_end: 
			movl old_edx(%ebp), %edx
			incl %edx
			jmp middle_for_start
		middle_for_end:
	
		
		incl %ecx #++i
		jmp outer_for_start
	outer_for_end:
	
	# return c;
	movl c(%ebp), %eax #set the return value
	
	epilogue:
		pop %edi
		pop %esi
		pop %ebx
		movl %ebp, %esp
		pop %ebp
		ret

