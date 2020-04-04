#! /bin/zsh

NAME=$1
PATH_FILE=${2:-$PWM}

mkdir -p ./$NAME/.vscode

cd ./$NAME/.vscode
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
        \"cwd\": \"${workspaceFolder}\",
        \"environment\": [],
        \"externalConsole\": false,
        \"MIMode\": \"gdb\",
        \"setupCommands\": [{
            \"description\": \"Enable pretty-printing for gdb\",
            \"text\": \"-enable-pretty-printing\",
            \"ignoreFailures\": true
        }]
    }]
}" > launch.json

cd .. 
echo '' > $NAME.c
code .
echo 'Done'