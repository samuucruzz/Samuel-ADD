function Menu{
    Write-Host "===== Menu Eleccion Script ====="
    Write-Host "16. Pizza"
    Write-Host "17. Dias"
    Write-Host "18. Menu_usuarios"
    Write-Host "19. Menu_grupos"
    Write-Host "20. Diskp"
    Write-Host "==== ==== ==== ==== ==== ==== ===="
    }


function pizza {
   $vegetariana = "Pimiento", "Tofu" 
   $carnivora = "Peperoni", "Jamon", "Salmon"
   $respuesta = Read-Host "Quieres una pizza Vegetariana?"

   if ($respuesta -eq 'Si'){
    
    Write-Host "Ingredientes a elegir (Solo 1 Ingrediente):"
    Write-Host " "

    $vegetariana

    Write-Host " "
    $eleccion = Read-Host "Que ingrediente quiere? (Tomate y Mozarrella Incluidos)"
    

        if (($eleccion -eq "Pimiento") -Or ($eleccion -eq "Tofu")){

            Write-Host " "
            Write-Host "La pizza es vegetariana, y los ingredientes son : Tomate, Mozarrella, $eleccion"
            Write-Host " "
        }
    }
    elseif ($respuesta -eq "No"){
        
    Write-Host "Ingredientes a elegir (Solo 1 Ingrediente):"
    Write-Host " "

    $carnivora

    Write-Host " "
    $eleccion = Read-Host "Que ingrediente quiere? (Tomate y Mozarrella Incluidos)"

    if (($eleccion -eq "Peperoni") -Or ($eleccion -eq "Jamon") -Or ($eleccion -eq "Salmon")){

            Write-Host " "
            Write-Host "La pizza no es vegetariana, y los ingredientes son : Tomate, Mozarrella, $eleccion"
            Write-Host " "
        }
    }
   


}


function dias{


Write-Host "Calcular el número de días pares e impares que hay en un año bisiesto: "
$meses = 31,29,31,30,31,30,31,31,30,31,30,31
$pares = 0
$impares = 0
foreach ($diasMes in $meses) {
    for ($dia = 1; $dia -le $diasMes; $dia++) {
        if ($dia % 2 -eq 0) { 
             $pares++ 
        }else{ 
             $impares++ 
         }
    }
}

    Write-Host "Dias Pares:$pares || Dias Impares:$impares"
    
}

function menu_usuarios{

do{
    Write-Host "============================"
    Write-Host "1. Listar Usuarios"
    Write-Host "2. Crear Usuarios"
    Write-Host "3. Eliminar usuario"
    Write-Host "4. Modificar"
    Write-Host "5. Salir"
    Write-Host "============================"
    
    $opcion = Read-Host "Elige"

    if($opcion -eq "1"){
        
        $listar = Get-LocalUser -Name "*"

        Write-Host $listar
    }elseif($opcion -eq "2"){

        $nombre = Read-Host "Nombre de Usuario Nuevo"
        $contraseña = Read-Host "Escriba la Contraseña del usuario (9 caracteres, 1 mayúscula y 1 número (complejidad) )" -AsSecureString
        
        New-LocalUser -Name $nombre -Password $contraseña

        Write-Host "Usuario Creado"
    }elseif($opcion -eq "3"){

        $del = Read-Host "Que usuario quieres eliminar?"

        Remove-LocalUser -Name $del

        Write-Host "Usuario $del Eliminado"
    }elseif($opcion -eq "4"){

        $nombre_ex = Read-Host "Indica el nombre a reemplazar"
        $n_nombre = Read-Host "Indica el nuevo nombre"

        Rename-localuser -Name $nombre_ex -NewName $n_nombre
        Write-Host "El usuario $nombre_ex pasó a llamarse $n_nombre"

    }


}

while ($opcion -ne 5)

}

function menu_grupos {

do{ 
    Write-Host "============================"
    Write-Host "1. Listar grupos y miembros"
    Write-Host "2. Crear grupo"
    Write-Host "3. Eliminar grupo"
    Write-Host "4. Crea miembro de un grupo"
    Write-Host "5. Elimina miembro de un grupo"
    Write-Host "0. Salir"
    Write-Host "============================"

    $opcion = Read-Host "Elige una opción"

    if($opcion -eq "1"){

    Get-ADGroup -Filter * | ForEach-Object {
    Write-Host "Grupo: $($_.Name)"
    Get-ADGroupMember -Identity $_.Name | ForEach-Object {
    Write-Host " $($_.Name)"
    }
    }

    }elseif($opcion -eq "2"){

    $nom = Read-Host "Introduce el nombre del grupo" 
    New-LocalGroup -Name $nom

    Write-Host "Has creado el grupo $nom"

    }elseif($opcion -eq "3"){

    $nom = Read-Host "Introduzca el nombre del grupo que quieres eliminar"
    Remove-ADGroup $nom

    Write-Host "Has eliminado el grupo $nom"

    }elseif($opcion -eq "4"){

    $nom = Read-Host "Introduzca el nombre del usuario que vas a crear"
    $grupo = Read-Host "Introduzca el nombre del grupo al que quieras añadir el miembro $nom"
   
    New-ADUser -Name $nom
    Add-ADGroupMember -Identity $grupo -Members $nom


    Write-Host "Has añadido el usuario $nom en el grupo $grupo"
    
    }elseif($opcion -eq "5"){

    $gr = Read-Host "Introduce el nombre del grupo en el que esta dicho usuario"
    $nom = Read-Host "Introduce el nombre del usuario que quieras eliminar del grupo $gr"

    Remove-ADGroupMember -Identity $gr -Members $nom

    Write-Host "Has eliminado el usuario $nom del grupo $gr"

    }
}

while ($opcion -ne 0)

}

function diskp {


$op = Read-Host "¿Quieres ver la lista de discos que tienes (Sí/No) ?"

if($op -eq "Si"){

$lista_discos = Get-PhysicalDisk -ObjectId *

Write-Host = $lista_discos
$discos = Read-Host "Introduce el numero de discos a utilizar"







elseif($op -eq "No"){

Write-Host "Saliendo..."}

}








}





















    
do{
    Menu
    $seleccion = Read-Host "Elije una opcion del 16-30 (0 Para Salir)"

    switch($seleccion){
        "16"{Pizza}
        "17"{dias}
        "18"{menu_usuarios}
        "19"{menu_grupos}
        "20"{diskp}
    }
}
while ($seleccion -ne "0")