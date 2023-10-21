#!/bin/bash
# Powered by nestore__

generar_contrasena() {
    longitud_minima=8
    longitud_maxima=63
    caracteres="A-Za-z0-9"
    contrasena=$(cat /dev/urandom | tr -dc "$caracteres" | fold -w $(shuf -i $longitud_minima-$longitud_maxima -n 1) | head -n 1)
    echo "$contrasena"
}

guardar_contrasena_en_archivo() {
    contrasena="$1"
    archivo="passw.txt"
    echo "$contrasena" >> "$archivo"
}

contrasenas_generadas=0
declare -A contrasenas_guardadas

while [ $contrasenas_generadas -lt 1000 ]; do
    contrasena_generada=$(generar_contrasena)
    
    if [ -z "${contrasenas_guardadas[$contrasena_generada]}" ]; then
        echo "Contraseña generada: $contrasena_generada"
        contrasenas_guardadas["$contrasena_generada"]=1
        
        guardar_contrasena_en_archivo "$contrasena_generada"
        echo "Contraseña agregada al archivo 'passw.txt'"
        contrasenas_generadas=$((contrasenas_generadas + 1))
    fi
done

echo "Se generaron 1000 contraseñas. El programa ha terminado."
