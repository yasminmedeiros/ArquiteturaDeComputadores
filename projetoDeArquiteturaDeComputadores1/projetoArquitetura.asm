extern printf
extern scanf
global main
section .data
        requestElementos db "Digite o numero de elementos a serem selecionados:",0H,0AH
        requestSelecoes db "Digite o numero de selecoes:",0H,0AH
        message db "O resultado eh = %d", 0AH,0H
        message0 db "O resultado 0 eh = %d", 0AH,0H
        message1 db "O resultado 1 eh = %d", 0AH,0H

        formatin db "%d",0H
        eleFatorial dq 0
        seleFatorial dq 0
        npFatorial dq 0

section .bss
        number resd 1
        numeroDeElementos resd 1
        numeroDeSelecionaveis resd 1
        np resd 1


section .text

main:
        push rbp

        ;exibe text1 no console
        mov rdi, requestElementos
        xor rax, rax
        call printf

        ;ler o numero informado na console
        mov rsi, numeroDeElementos
        mov rdi, formatin
        xor rax,rax
        call scanf

        ;exibe text1 no console
        mov rdi, requestSelecoes
        xor rax, rax
        call printf
        

        ;ler o numero informado na console
        mov rsi, numeroDeSelecionaveis
        mov rdi, formatin
        xor rax,rax
        call scanf

        ;Calculo de fatorial
        xor rdi, rdi
        mov rdi, QWORD[numeroDeSelecionaveis]
        xor rax, rax
        xor rbx,rbx
        call calculoFatorial
        mov QWORD[seleFatorial],rax
        
        xor rdi,rdi
        mov rdi, QWORD[numeroDeElementos]
        xor rax, rax
        xor rbx,rbx
        call calculoFatorial
        mov QWORD[eleFatorial],rax

        xor rax, rax
        mov rax, [numeroDeElementos] 
        sub rax, [numeroDeSelecionaveis]
        mov [np], rax
        
        xor rdi, rdi
        mov rdi, QWORD[np]
        xor rax, rax
        xor rbx,rbx
        call calculoFatorial
        mov QWORD[npFatorial],rax

        ;exibe o resultado
        mov rsi,[npFatorial]
        mov rdi,message
        xor rax, rax
        call printf

        pop rbp

        _exit:
        mov rax, 60
        mov rdi, 0
        syscall


calculoFatorial:
        ;Prólogo
        push rbp
        mov rbp,rsp
        mov rbx,QWORD[rbp+16]

        xor rcx,rcx
        xor rax,rax

        
        ;if n==0 return 0
        cmp QWORD[rbp+16],0
        je _ret0

        ;else if n==1 return 1
        cmp QWORD[rbp+16],1
        je _ret1

        ;else
        
        mov rcx, 1
        mov rax, 1 
        jmp _laco

        _laco:
                inc rcx
                mul rcx
                cmp rcx, QWORD[rbp+16]
                jb _laco
                jmp _end

        _ret1:
                mov rax,1
                jmp _end

        _ret0:
                
                mov rax,0
                jmp _end

        ;epílogo
        _end:
                mov rsp,rbp
                pop rbp
                ret 
