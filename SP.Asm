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
mensaje4 db "HOY NO TIENE CLASES",0

docente1 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA",0
materia1 db "MATERIA: INGLES I",0
aula1 db "AULA: 693B",0
hora11 db "HORARIO: MARTES 8:15 - 9:45",0
hora12 db "HORARIO: VIERNES 8:15 - 9:45",0

docente2 db "DOCENTE: VALENZUELA MIRANDA ROBERTO",0
materia2 db "MATERIA: FISICA GENERAL",0
aula21 db "AULA: 651",0
aula22 db "AULA: 692C",0
hora21 db "HORARIO: MARTES 11:15 - 12:45",0
hora22 db "HORARIO: MIERCOLES 14:15 - 15:45",0

docente3 db "DOCENTE: USTARIZ VARGAS HERNAN",0
materia3 db "MATERIA: INTRODUCCION A LA PROGRAMACION",0
aula31 db "AULA: 607",0
hora31 db "HORARIO: LUNES 12:45 - 14:15",0
hora32 db "HORARIO: MIERCOLES 12:45 - 14:15",0

docente4 db "DOCENTE: AGREDA CORRALES LUIS ROBERTO",0
materia4 db "MATERIA: ARQUITECTURA DE COMPUTADORAS II",0
aula4 db "AULA: 651",0
hora41 db "HORARIO: MARTES 15:45 - 17:15",0
hora42 db "HORARIO: JUEVES 15:45 - 17:15",0

docente5 db "DOCENTE: ACHA PEREZ SAMUEL",0
materia5 db "MATERIA: ARQUITECTURA DE COMPUTADORAS I",0
aula5 db "AULA: 693B",0
hora51 db "HORARIO: JUEVES 6:45 - 8:15",0
hora52 db "HORARIO: SABADO 6:45 - 8:15",0

numero dd 0
numero2 dd 0
vardia dd 0
varhora dd 0
varmin dd 0
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
	je fechaD1
	cmp eax,87654
	je fechaD2
	cmp eax,76543
	je fechaD3
	cmp eax,65432
	je fechaD4
	cmp eax,54321
	je fechaD5
	jne noregistrado
	mov eax,1
	jmp finish
	
fechaD1:	;primerdocente
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 2
	je fechaH1
	cmp [vardia], 5
	je fechaH1
	jne falta2
	mov eax,1
	jmp finish
	
fechaD2:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 2
	je fechaH2
	cmp [vardia], 3
	je fechaH21
	jne falta2
	mov eax,1
	jmp finish
fechaD3:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 1
	je fechaH3
	cmp [vardia], 3
	je fechaH3
	jne falta2
	mov eax,1
	jmp finish

fechaD4:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 4
	je fechaH4
	cmp [vardia], 6
	je fechaH4
	jne falta2
	mov eax,1
	jmp finish

fechaD5:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 2
	je fechaH5
	cmp [vardia], 4
	je fechaH5
	jne falta2
	mov eax,1
	jmp finish
	
fechaH1:	;primer docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],8
	je fechaM1
	jne falta
	mov eax,1
	jmp finish
fechaM1:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	invoke SetDlgItemInt,[hWnd],1005,[varmin],1
	cmp [varmin],15
	jg horamax
	jne falta
	mov eax,1
	jmp finish

horamax:
	cmp [varmin],29
	jng mostrar1
	jne falta
	mov eax,1
	jmp finish

fechaH2:	;segundo docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],11
	je fechaM2
	jne falta
	mov eax,1
	jmp finish
fechaM2:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	invoke SetDlgItemInt,[hWnd],1005,[varmin],1
	cmp [varmin],15
	jg horamax2
	jne falta
	mov eax,1
	jmp finish

fechaH21:	;segundo docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],14
	je fechaM2
	jne falta
	mov eax,1
	jmp finish
	
horamax2:
	cmp [varmin],29
	jng mostrar2
	jne falta
	mov eax,1
	jmp finish
	
fechaH3:	;tercer docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],12
	je fechaM3
	jne falta
	mov eax,1
	jmp finish
fechaM3:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	invoke SetDlgItemInt,[hWnd],1005,[varmin],1
	cmp [varmin],45
	jg horamax3
	jne falta
	mov eax,1
	jmp finish

horamax3:
	cmp [varmin],59
	jng mostrar3
	jne falta
	mov eax,1
	jmp finish
	
fechaH4:	;cuarto docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],15
	je fechaM4
	jne falta
	mov eax,1
	jmp finish
fechaM4:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	invoke SetDlgItemInt,[hWnd],1005,[varmin],1
	cmp [varmin],45
	jg horamax4
	jne falta
	mov eax,1
	jmp finish

horamax4:
	cmp [varmin],59
	jng mostrar4
	jne falta
	mov eax,1
	jmp finish
	
fechaH5:	;quinto docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],6
	je fechaM4
	jne falta
	mov eax,1
	jmp finish
fechaM5:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	invoke SetDlgItemInt,[hWnd],1005,[varmin],1
	cmp [varmin],45
	jg horamax5
	jne falta
	mov eax,1
	jmp finish

horamax5:
	cmp [varmin],59
	jng mostrar5
	jne falta
	mov eax,1
	jmp finish

mostrar1:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente1
	jmp finish
mostrar2:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente2
	jmp finish
mostrar3:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente3
	jmp finish
mostrar4:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente4
	jmp finish
mostrar5:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente5
	jmp finish
	
falta:
	invoke MessageBox,[hWnd],mensaje2,caja,MB_OK
	jmp finish
	
falta2:
	invoke MessageBox,[hWnd],mensaje4,caja,MB_OK
	jmp finish
	
error:
	invoke MessageBox,[hWnd],mensaje3,caja,MB_OK
	jmp finish
	
noregistrado:
	invoke MessageBox,[hWnd],mensaje1,caja,MB_OK
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
