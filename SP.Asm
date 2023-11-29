format PE GUI 4.0
entry inicio

include 'Win32a.inc'


ventana_1	equ		1
salir_btn	equ		1000

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
entrada dd 0
mifecha SYSTEMTIME ?
mifecha2 SYSTEMTIME ?
mifecha3 SYSTEMTIME ?
midia SYSTEMTIME ?


caja db "Caja de mensaje",0
mensaje1 db "NO HAY CLASE EN CURSO",0
mensaje2 db "FALTA",0
mensaje3 db "ERROR",0

docente1 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA",0
materia1 db "MATERIA: INGLES I",0
aula1 db "AULA: 693B",0
hora11 db "HORARIO: 8:15 - 9:45",0


docente2 db "DOCENTE: VALENZUELA MIRANDA ROBERTO",0
materia2 db "MATERIA: FISICA GENERAL",0
aula21 db "AULA: 651",0
aula22 db "AULA: 692C",0
hora21 db "HORARIO: 11:15 - 12:45",0
hora22 db "HORARIO: 14:15 - 15:45",0

docente3 db "DOCENTE: USTARIZ VARGAS HERNAN",0
materia3 db "MATERIA: INTRODUCCION A LA PROGRAMACION",0
aula31 db "AULA: 607",0
hora31 db "HORARIO: 12:45 - 14:15",0

docente4 db "DOCENTE: AGREDA CORRALES LUIS ROBERTO",0
materia4 db "MATERIA: ARQUITECTURA DE COMPUTADORAS II",0
aula4 db "AULA: 651",0
hora41 db "HORARIO: 15:45 - 17:15",0
hora42 db "HORARIO: 17:15 - 18:45",0

docente5 db "DOCENTE: ACHA PEREZ SAMUEL",0
materia5 db "MATERIA: ARQUITECTURA DE COMPUTADORAS I",0
aula5 db "AULA: 693B",0
hora51 db "HORARIO: 6:45 - 8:15",0

numero dd 0
numero2 dd 0
var dd 0
;Agregar aqui el registro de memoria correspondiente
section '.code' code readable executable

inicio:
	invoke GetModuleHandle,0
	mov [Ist],eax
	invoke DialogBoxParam,eax,ventana_1,0,DlgProc,0 
fin:
	invoke ExitProcess,0

proc DlgProc,hWnd,uMsg,wParam,lParam
	push edi esi ebx
	
	mov eax,[uMsg]
	cmp	eax,WM_COMMAND
	je	jCOMMAND
	cmp	eax,WM_INITDIALOG
	je	jINITDIALOG
	cmp	eax,WM_CLOSE
	je	jCLOSE
	xor eax,eax
	jmp finish

jINITDIALOG:
	mov eax,[hWnd]
	mov [pWnd],eax
	
	mov eax,1
	jmp finish
	
jCOMMAND:
	mov eax,[wParam]
	cmp	eax,salir_btn
	je	salir
	cmp	eax,1004
	je	registrar
	xor eax,eax
	jmp finish
	
salir:
	invoke SendMessage,[hWnd],WM_CLOSE,0,0
	mov eax,1
	jmp finish
	
registrar:
	invoke GetDlgItemInt,[hWnd],1001,entrada,1
	cmp [entrada],0
	je error
	mov dword [numero],eax
	cmp eax,98765
	je fechaM
	cmp eax,87654
	je verhora2
	cmp eax,76543
	je verhora3
	cmp eax,65432
	je verhora4
	cmp eax,54321
	je verhora5
	jne noregistrado
	mov eax,1
	jmp finish
	
verhora1:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente1
	jmp finish
verhora2:
	invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,10,docente2
	jmp finish
verhora3:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente3
	jmp finish
verhora4:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente4
	jmp finish
verhora5:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente5
	jmp finish
	
falta:
	invoke MessageBox,[hWnd],mensaje2,caja,MB_OK
	jmp finish
	
error:
	invoke MessageBox,[hWnd],mensaje3,caja,MB_OK
	jmp finish
	
noregistrado:
	invoke MessageBox,[hWnd],mensaje1,caja,MB_OK
	jmp finish
	
fechaH:
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	invoke SetDlgItemInt,[pWnd],1005,eax,1
	cmp ax,1
	je verhora1
	jne falta
	mov eax,1
	jmp finish
fechaM:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	invoke SetDlgItemInt,[hWnd],1005,eax,1
	cmp eax, 1
	je verhora1
	jne falta
	;mov eax,1
	jmp finish
jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1
	
finish:
	pop ebx esi edi
	ret
endp

section '.idata' import data readable writeable
  ;importamos solo los procedimientos basicos para abrir una ventana

  ;otra forma para importar los procedimientos importando archivos INC
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'
  

section '.rsrc' resource from 'SP.res' data readable
