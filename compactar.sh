#!/bin/bash

#variaveis dos diretorios
dir_img=organizados/imagens
dir_log=organizados/logs
dir_bck=organizados/backups

#cria uma data
data=$(date +%Y%m%d)
#cria um log
touch "$dir_log/limpeza_e_backup_$data.log" 
can_mv=false #variavel de controle

#condicao que verifica se o diretorio tá vazio
if ! [ -z "$( ls -A "$dir_img")" ]; then

    #lista todos os arquivos q vão ser comprimidos
    for arq in $dir_img/*; do
        #deixxxxxxxxo só o nome do arquivo e retiro seu path:3
        name=$(basename "$arq")
        echo "arquivo $name foi comprimido" >> "$dir_log/limpeza_e_backup_$data.log"
        
    done
    #vou caminhar até os arquivos de lá, fiz isso pra evitar a cópia de diretórios
    cd organizados/imagens
    tar -czf "imagens$data.tar.gz" ./*
    #vou voltar a minha origem
    cd ..
    cd ..
    can_mv=true
else 
echo "A pasta tá vazia;-;"
fi
#só quando tudo aquilo terminar é q eu vou mover o tar 
if [[ $can_mv == true ]]; then
    mv "$dir_img/imagens$data.tar.gz" $dir_bck
    rm -f $dir_img/* #remove as imagens que estavam lá
fi