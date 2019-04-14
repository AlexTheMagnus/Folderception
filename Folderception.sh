#! /bin/bash

# Escriba a la derecha del '=' la ruta completa del directorio donde quiera crear
# las carpetas, sin dejar espacios ni entre comillas.
# Escriba '.' (sin las comillas) si quiere ejecutarlo en el directorio donde se ejecuta.
#
ruta=.
cd $ruta

esNumero=^[0-9]+$   #Para comprobar si una variable es un numero

echo "Introduzca los datos con valores numéricos"
echo ""

#Crea carpeta del curso
read -p 'Curso: ' curso

while ! ([[ "$curso" =~ $esNumero ]] && [ $curso -gt 0 ] && [ $curso -lt 5 ]); do
    echo "      Error. Este valor no esta en el rango de cursos [1,4]"
    read -p 'Curso: ' curso
done

if [ $curso -eq 1 ]; then
    curso="Primero"
else
    if [ $curso -eq 2 ]; then
        curso="Segundo"
    else
        if [ $curso -eq 3 ]; then
            curso="Tercero"
        else
            if [ $curso -eq 4 ]; then
                curso="Cuarto"
            fi
        fi
    fi
fi

if [ -d $curso ]; then
    echo "      La carpeta del curso ya existe, accediendo.."
    cd $curso
else
    echo "      Creando carpeta del curso..."
    mkdir $curso
    cd $curso
fi


#Crea carpeta del cuatri cuatrimestre
read -p 'Cuatrimestre (1 o 2): ' cuatri

while ! ([[ "$cuatri" =~ $esNumero ]] && [ $cuatri -gt 0 ] && [ $cuatri -lt 3 ]); do
    echo "      Error. Este valor no esta en el rango de cuatrimestres [1,2]"
    read -p 'Cuatrimestre (1 o 2): ' cuatri
done

cuatri="$cuatriºCuatri"
if [ -d $cuatri ]; then
    echo "      La carpeta del cuatri ya existe, accediendo..."
    cd $cuatri
else
    echo "      Creando carpeta del cuatri..."
    mkdir $cuatri
    cd $cuatri
fi



#Crea carpetas de las asignaturas
read -p 'Asignaturas (nombres separados por espacios): ' asignaturas
for x in $asignaturas
do
    if [ -d $x ]; then
        echo "      La carpeta de $x ya existe"
    else
        mkdir $x
        echo "      Creada carpeta de la asignatura $x"
        if ! [ -f ~/.folder_aliases ]; then
            echo "alias ${x,,}='cd $(pwd)/$x'" > ~/.folder_aliases

            echo "" >> ~/.bashrc
            echo "# Folderception's aliases definition" >> ~/.bashrc
            echo "if [ -f ~/.folder_aliases ]; then" >> ~/.bashrc
            echo "  . ~/.folder_aliases" >> ~/.bashrc
            echo "fi" >> ~/.bashrc
            if [ -f ~/.zshrc ]; then
                    echo "" >> ~/.zshrc
                    echo "# Folderception's aliases definition" >> ~/.zshrc
                    echo "if [ -f ~/.folder_aliases ]; then" >> ~/.zshrc
    	            echo "   source ~/.folder_aliases" >> ~/.zshrc
                    echo "fi" >> ~/.zshrc
            fi
        else
            echo "alias ${x,,}='cd $(pwd)/$x'" >> ~/.folder_aliases
        fi
    fi
done
