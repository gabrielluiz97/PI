#!/bin/bash
 #while-menu:a menu-driven system information program
 #incicio
 #funções

DIALOG_CANCEL=1
DIALOG_ESC=255
HEIGHT=0
WIDTH=0

 display_result() {
  dialog --title "$1" \
      --no-collapse \
      --msgbox "$result" 0 0
 }

carregar_menu(){
while true; do
	exec 3>&1
	selection=$(dialog \
		--backtitle "opções do sistema" \
		--title "Menu" \
		--clear \
		--cancel-label "Voltar" \
		--menu "Selecione uma opção:" $HEIGHT $WIDTH 4 \
		"1" "instalar squid3" \
		"2" "instalar iptables" \
		"3" "instalar o vim" \
		"4" "instalar tudo" \
		2>&1 1>&3)
	exit_status=$?
	exec 3>&-
	case $exit_status in
		$DIALOG_CANCEL)
		echo "MenuPrincipal."
		menu_principal
		exit
		;;
	$DIALOG_ESC)
		clear
		echo "programa abortado.">&2
		exit 1
		;;
	esac
	case $selection in
		0 )
		   ;;
		1 )
		   if ! apt-get install squid3
			display_result "squid3 instalado"
			clear
		   then
		   	clear  
	         fi
		   ;;
		2 ) 
		   if ! apt-get install iptables
		        display_result "iptables instalado"
			clear
		   then
			clear
		   fi	
		   ;;

		 3) if !apt-get install vim
			display_result "vim instalado"
			clear
	 	    then
			    clear
	            fi
	        	;;
		    
		4) 
		  if ! apt-get install squid3 iptables apache2 sarg vim
		  display_result "squid3, iptables, apache2 , sarg e vim foram instalado"
	 	 then
			clear
		  fi	
	  	   ;;	  
   		
	esac
    done			
 }
 menu_principal(){
   while true; do
	exec 3>&1
	selection=$(dialog \
		--backtitle "opções do sistema" \
		--title "Menu" \
		--clear \
		--cancel-label "Sair" \
		--menu "Selecione uma opção:" $HEIGHT $WIDTH 4 \
		"1" "instalar programas" \
		"2" "informações do sistema" \
		"3" "espaço do disco" \
		2>&1 1>&3)
	exit_status=$?
	exec 3>&-
	case $exit_status in
		$DIALOG_CANCEL)
		clear
		echo "programa encerrado."
		exit
		;;
	$DIALOG_ESC)
		clear
		echo "programa abortado.">&2
		exit 1
		;;
	esac
	case $selection in
		0 )
		   clear
		   echo "programa encerrado"
		   ;;
		1 )
		   carregar_menu
		   ;;
		2 ) 
		  display_result "Não funciona ainda"
		   ;;
 
   		3 )
	           result=$(df -h)
		   display_result "Espaço do disco"
		   clear
		   ;;

	esac
    done		
 }
 #fim das funçõe
#apt-get install dialog
menu_principal

