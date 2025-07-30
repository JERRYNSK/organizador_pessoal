#!/bin/bash	

#variaveis de diretorios, usados para encurtar o acminho da digitação
dir_desordem=arquivos_para_organizar
dir_img=organizados/imagens
dir_doc=organizados/documentos
dir_others=organizados/outros
dir_log=organizados/logs

#cria um novo log com o dia atual
#se o log nesse dia especifico nao existir, entao ele cria, senao, passa as informações para esse log

data=$(date +%Y%m%d) #data é uma variavél que recebe a data parametrizada em ano, mes e dia
cd $dir_log #vai ao diretorio do log
touch organização_$data.log #nesse mesmo diretório cria o arquivo log
cd ..
cd .. #sobe até o diretório inicial



if ! [ -z "$(ls -A "$dir_desordem")" ]; then #essa condicao testa se $() é vazio, se for vazio retorna verdadeiro, mas o ! nega isso
	#for arquivos com extensão
	for arq in $dir_desordem/*; do #um for que passa por todos os arquivos desse diretório

			nome=$(basename "$arq") #pra ficar mais legível, coloquei a variavel no nome(nome do arquivo), esse basename retira a porçao diretorio heheheheh

			if [[ "$nome" == *.jpg || "$nome" == *.png || "$nome" == *.gif ]]; then #testa se esse nome tem extensao de uma imagem, se sim move e bota no log a movimentacao
				mv "$arq" "$dir_img"
				echo "Arquivo $nome movido para $dir_img" >> "$dir_log/organização_$data.log"

			elif [[ "$nome" == *.pdf || "$nome" == *.pptx || "$nome" == *.doc || "$nome" == *.xlsx ]]; then #se conter extensao de documento, move e bota no log a movimentação
				mv "$arq" "$dir_doc"
				echo "Arquivo $nome movido para $dir_doc" >> "$dir_log/organização_$data.log"

			else #caso contrario, bota tudo na pasta outros e registra no log
				mv "$arq" "$dir_others"
				echo "Arquivo $nome movido para $dir_others" >> "$dir_log/organização_$data.log"

			fi
	done
else
	#retorna caso esteja vazio
	echo "O diretório está vazio:3"
fi
