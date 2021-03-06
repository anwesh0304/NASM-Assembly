section .data 
	inputInt: db "%d", 0  
	outputInt: db "Output: %d", 10, 0
	inputPrompt : db "Enter an integer : " , 0
 
section .text 
	global main 
	extern scanf 
	extern printf 
 
main: 
	push rbp 
	mov rbp, rsp

	mov WORD [rbp-4], 4
	sub rsp, 6

	mov rax, rsp
	and rax, 15				; subtraction amount is in rax

	push rax				; printing subtraction amount
	mov rdi, outputInt
	mov rsi, rax
	xor rax, rax
	call printf
	pop rax

	; ---- Input prompt ------ ;

	push rax
	mov rdi, inputPrompt
	xor rax, rax
	xor rsi, rsi
	call printf
	pop rax

	; ---- Scanf start ------ ;

	add rax, 8
	sub rsp, rax				; currently at rsp mod 16 = 0

	mov rdi, inputInt
	mov rsi, rsp
	sub rsi, 4

	push rdx
	push rcx
	push rbx
	push rax
	push rsi
	call scanf
	pop rsi
	pop rax
	pop rbx
	pop rcx
	pop rdx

	mov bx, [rsp-4]
	mov [rbp-4], bx

	add rsp, rax

	; ---- Scanf end ------ ;

	mov rdi, outputInt
	movsx rsi, bx
	xor rax, rax
	call printf

	mov rsp, rbp
	pop rbp
	ret