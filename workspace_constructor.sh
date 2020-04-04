#! /bin/zsh

#Este automatiza la construcción de un workspace simple para la programación de archivos en C++ en VScode

#Atento a la necesidad de '&&' a veces una tarea termina antes que otra, por lo que se genera una falla (ej: la escritura de archivos termina después de que el vscode abre el workspace; entonces abre, pero necesita recargar para ver los cambios)

#Nombre de Archivos
NAME=$1
#Prefijo para carpeta
PREFIX=$2
#Dirección donde estoy corriendo el script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR_PATH=${3:-$DIR}
#Dirección donde quedarán los archivos json
PATH_FILE=$DIR_PATH/`echo $PREFIX`$NAME/.vscode

#CReación de la carpeta para los json
mkdir -p $PATH_FILE

#Revisa si efectivamente se creó la carpeta; sino detiene
[ ! -d $PATH_FILE ] && echo "This directory don't exists!" && exit 1

#Se mueve a esa carpeta
cd $PATH_FILE

#crea los archivos...#... y retrocede al workspace
echo "{
    \"configurations\": [
        {
            \"name\": \"Linux\",
            \"compilerPath\": \"/usr/bin/gcc\",
            \"cStandard\": \"c11\",
            \"cppStandard\": \"c++17\",
            \"intelliSenseMode\": \"gcc-x64\"
        }
    ],
    \"version\": 4
}" > c_cpp_properties.json

echo "{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    \"version\": \"2.0.0\",
    \"tasks\": [{
        \"label\": \"build $NAME\",
        \"type\": \"shell\",
        \"command\": \"gcc\",
        \"args\": [\"-g\", \"-o\", \"$NAME.out\", \"$NAME.c\"],
        \"group\": {
            \"kind\": \"build\",
            \"isDefault\": true
        }
    }]
}" > tasks.json

echo "{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    \"version\": \"0.2.0\",
    \"configurations\": [{
        \"name\": \"(gdb) Launch\",
        \"type\": \"cppdbg\",
        \"request\": \"launch\",
        \"program\": \"\${workspaceFolder}/$NAME.out\",
        \"args\": [],
        \"stopAtEntry\": true,
        \"cwd\": \"\${workspaceFolder}\",
        \"environment\": [],
        \"externalConsole\": false,
        \"MIMode\": \"gdb\",
        \"setupCommands\": [{
            \"description\": \"Enable pretty-printing for gdb\",
            \"text\": \"-enable-pretty-printing\",
            \"ignoreFailures\": true
        }]
    }]
}" > launch.json && cd .. 

#crea el main source y #Abre el Workspace
echo '' > $NAME.c && code .


echo 'Done'
