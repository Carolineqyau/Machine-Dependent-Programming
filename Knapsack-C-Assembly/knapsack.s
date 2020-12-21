/*
unsigned int knapsack(int* weights, unsigned int* values, unsigned int num_items, 
												int capacity, unsigned int cur_value){
  /*
  solves the knapsack problem
  @weights: an array containing how much each item weighs
  @values: an array containing the value of each item
  @num_items: how many items that we have
  @capacity: the maximum amount of weight that can be carried
  @cur_weight: the current weight
  @cur_value: the current value of the items in the pack
  
  unsigned int i;
  unsigned int best_value = cur_value;
  
  for(i = 0; i < num_items; i++){//for each remaining item
    if(capacity - weights[i] >= 0 ){//if we can fit this item into our pack
      //see if it will give us a better combination of items
      best_value = max(best_value, knapsack(weights + i + 1, values + i + 1, num_items - i - 1, 
                     capacity - weights[i], cur_value + values[i]));
    }//if we can fit this item into our pack   
  }//try to find the best combination of items among the remaining items
  return best_value;*/

#-------------------------------------------------------------------------------------------------------------

/*unsigned int max(unsigned int a, unsigned int b){
  //computes the max of a and b
  return a > b ? a : b;
}
*/

.global knapsack
.global max
.equ ws,4

.text

max:
	prologue_max:
		push %ebp
		movl %esp,%ebp
		push %ebx
		#stack after prologue
		#+12	b
		#+8	a
		#+4	return address
		#ebp 	old stack frame pointer
		
		.equ a, 2*ws	#ebp
		.equ b, 3*ws	#ebp
		if_:
			# a > b == a - b >0
			# neg: a - b <= 0, b>= a, b - a>= 0
			movl a(%ebp), %ebx			
			cmpl %ebx, b(%ebp)
			jge else
			movl a(%ebp), %eax
			jmp else_end
		else:
			movl b(%ebp), %eax
		else_end:
	epilogue_max:
		pop %ebx
		movl %ebp, %esp
		pop %ebp
		ret

knapsack:
	prologue:
		push %ebp
		movl %esp, %ebp
		subl $2*ws, %esp

		
		#stack after prologue
		#+24	cur_value
		#+20	capacity
		#+16	num_items
		#+12	values
		#+8	weights
		#+4	return address
		# ebp old stack frame pointer
		#-4	i
		#-8	best_value
		
		.equ weights, 2*ws	#ebp
		.equ values, 3*ws	#ebp
		.equ num_items, 4*ws	#ebp
		.equ capacity, 5*ws	#ebp
		.equ cur_value, 6*ws	#ebp
		.equ i,	-1*ws		#ebp
		.equ best_value, -2*ws	#ebp

		#unsigned int best_value = cur_value;
		movl cur_value(%ebp), %eax  #eax = cur_value
		movl %eax, best_value(%ebp) #best_value = eax = curvalue
		
		# i = 0
		movl $0, i(%ebp) # set i = 0
		# ECX will be i
		#for(i = 0; i < num_items; i++)
 		movl i(%ebp), %ecx # ecx = i
		for_start:
			# i < num_items == i - num_items < 0
			# neg: i - num_itmes >= 0
			cmpl num_items(%ebp), %ecx
			jge for_end
			#if(capacity - weights[i] >= 0 )
			# EAX will be weights[i]
			movl weights(%ebp), %eax 	#EAX = weights 
			movl (%eax,%ecx,ws), %eax	#EAX = weights[i]
			cmpl %eax, capacity(%ebp)
			jl end_if
			if:
				/*best_value = max(best_value, knapsack(weights + i + 1, values + i + 1, num_items - i - 1, 
                     capacity - weights[i], cur_value + values[i]));*/
				#----------------------------------------------------------------------------------------------
				#EDX will be cur_value + values[i]
				#EAX will be values[i]
				movl values(%ebp), %eax			#EAX = values
				movl (%eax, %ecx,ws), %eax		#EAX = values[i]
				movl cur_value(%ebp), %edx		#EDX = cur_value
				addl %eax, %edx					#EDX = cur_value + values[i]
				push %edx
				
				#EDX will be capacity - weights[i]
				#EAX will be weights[i]
				movl weights(%ebp), %eax		#EAX = weights
				movl (%eax, %ecx,ws), %eax		#EAX = weights[i]
				movl capacity(%ebp), %edx		#EDX = capacity
				subl %eax, %edx
				push %edx				
				
				# EDX will be num_items - i -1
				movl num_items(%ebp), %edx		#EDX = num_items
				subl %ecx, %edx					#EDX = num_items - i
				decl %edx						#EDX = num_items - i - 1
				push %edx

				# EDX will be values + i + 1
				movl values(%ebp), %edx			#EDX = values
				leal 4(%edx, %ecx, ws), %edx	#EDX = values + i + 1
				push %edx

				# EDX will be weights + i + 1
				movl weights(%ebp), %edx		#EDX = weights
				leal 4(%edx, %ecx, ws), %edx    #EDX = weights + i + 1
				push %edx
				#-------------------------------------------------------------------------------------------------------------
                movl %ecx, i(%ebp)
				call knapsack
                movl i(%ebp), %ecx
				movl best_value(%ebp), %edx		#EDX = best_value
				push %edx
				push %eax	#current EAX = knapsack recursive value
				call max
				movl %eax, best_value(%ebp)
				
			end_if:

			incl %ecx # i++
			movl %ecx, i(%ebp)
			jmp for_start
		for_end:
		movl best_value(%ebp), %eax

	epilogue:
		movl %ebp, %esp #clear locals
		pop %ebp #restore ebp
		ret
		









