format PE GUI 4.0
entry inicio

include 'Win32a.inc'

ventana_1	equ		1
salir_btn	equ		1000

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
entrada dd 0
codigo_doc1 dd "3546"
docente_doc1 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA"
;materia_doc1  db "MATERIA: INGLES I"
;aula_doc1  db "AULA: 693B"
;hora_doc1  db "HORARIO: 8:15-9:45"

;codigo_doc2 dd "3546"
;docente_doc2 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA"
;materia_doc2  db "MATERIA: INGLES I"
;aula_doc2  db "AULA: 693B"
;hora_doc2  db "HORARIO: 8:15-9:45"

;codigo_doc3 dd "3546"
;docente_doc3 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA"
;materia_doc3  db "MATERIA: INGLES I"
;aula_doc3  db "AULA: 693B"
;hora_doc3  db "HORARIO: 8:15-9:45"

;codigo_doc4 dd "3546"
;docente_doc4 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA"
;materia_doc4  db "MATERIA: INGLES I"
;aula_doc4  db "AULA: 693B"
;hora_doc4  db "HORARIO: 8:15-9:45"

;codigo_doc5 dd "3546"
;docente_doc5 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA"
;materia_doc5  db "MATERIA: INGLES I"
;aula_doc5  db "AULA: 693B"
;hora_doc5  db "HORARIO: 8:15-9:45"

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
	invoke SendDlgItemMessage,[hWnd],1001,WM_GETTEXT,10,entrada
	
	;hasta aqui registra en memoria, realizar la logica necesaria para comparar los codigos y luego los horarios
	
	mov eax,entrada
	;comparacion codigo de docentes con la entrada
	;cmp eax,codigo_doc1
	;je verhora1
	;sino existe codigo mostrar no existe
	mov eax,1
	jmp finish
	
;mostrar por depende de hora y codigo
verhora1:
	mov eax,1
	;pedir hora del sistema y compararlo con el del docente con maximo de dif de 14 min
	;si es imprime
	;invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente
	;invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,0,materia
	;invoke SendDlgItemMessage,[hWnd],1006,WM_SETTEXT,0,aula
	;invoke SendDlgItemMessage,[hWnd],1007,WM_SETTEXT,0,horario	
	;sino mostrar mensaje de falta
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
