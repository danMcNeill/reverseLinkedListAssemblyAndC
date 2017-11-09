.intel_syntax noprefix
.text
.global reverse_asm

reverse_asm:
	push ebx

	# headptr = nextptr = new_headptr = NULL
	# We use eax as scratch register
	mov eax, 0x0
	mov ebx, eax
	mov ecx, eax
	mov edx, eax
	#here if(head == NULL) return NULL
	mov eax, [esp + 8]
	cmp eax, 0
	je null_ret

	add eax, [esp + 12]
	#ebx is headptr
	mov ebx, eax

    while_start:
	# while (headptr)
	cmp ebx, 0x0
	je while_done

	# nextptr = (void*)(*((unsigned long*)headptr));
	mov ecx, [ebx]

	# *(unsigned long *)headptr = (unsigned long) new_headptr
	mov [ebx], edx

	# new_headptr = headptr
	mov edx, ebx

	# headptr = nextptr
	mov ebx, ecx

	# next iteration
	jmp while_start

    while_done:
	# ... code that follows while loop
	mov eax, edx
	sub eax, [esp + 12]

    null_ret:
	pop ebx
	ret


	pop ebx
	ret
