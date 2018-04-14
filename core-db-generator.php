<?php

require_once 'vendor/autoload.php';

use polux\CorePHPDb\Generators\CoreModelGenerator;


function main($argc,$argv)
{
    // "action" => [nbAttributeMin,nbAttributeMax,"Usage : 'php core-db-generator.php action'","Liste des actions"]
    $lArrActions = [
      "noload"      => [2,2,"[action] [params...]. list for more details.",""],
      "list"        => [2,2,"list","Liste des Actions"],
      "help"        => [3,3,"action","Affiche l'aide de l'action"],
      "genout"      => [5,6,"core|business [business:fromCsvFile] [core|business:targetSchema] [core|business:targetVersion]","Génération de script SQL Core ou Business sur la sortie standard. Combinaison d'options multiples..."],
      "genfile"     => [6,7,"core|business [business:fromCsvFile] [core|business:targetSchema] [core|business:targetVersion] [core|business:targetDirectory]","Génération de script SQL Core ou Business en fichier. Combinaison d'options multiples..."],
      "gendb"       => [7,9,"core|business [business:fromCsvFile] [core|business:targetSchema] [core|business:targetVersion] [core|business:dsn] [core|business:login] [core|business:password]","Génération de script SQL Core ou Business en fichier. Combinaison d'options multiples..."]
    ];
    
    
    try{
        // Nb Args < 2
        $action = "noload";
        // At least, an action ..
        if($argc <2)
        {
            throw new \Exception(
                sprintf(
                    "core-db-generator : Nombre d'argument invalid ! (Nb Arguments : %d).\n",
                    $argc-1
                )
            );
        }
        
        $script = array_shift($argv);
        $action = array_shift($argv);
        $action = strtolower($action);
        
        // Action exists ?
        if(!array_key_exists($action, $lArrActions))
        {
            $lStrAction = $action;
            $action = 'noload';
            throw new \Exception(
                sprintf(
                    "Action inconnue : '%s' - action 'list' pour voir les actions.\n",
                    $lStrAction
                    )
                );
        }
        
        // Validation du nombre de paramètres
        if($lArrActions[$action][0] > $argc || $lArrActions[$action][1] < $argc)
        {
            throw new \Exception(
                sprintf(
                    "Nombre de paramètres invalid pour l'action '%s' => %d (Min:%d|Max:%d).\n",
                    $action,
                    $argc-1,
                    $lArrActions[$action][0]-1,
                    $lArrActions[$action][1]-1
                    )
                );
        }       
        
        // Action 'list'.
        if(strtolower($action) == 'list')
        {
            echo "Liste des actions : \n";            
            foreach($lArrActions as $lStrAction => $lArrActionParam)
            {
                echo sprintf("- %s : %s. Usage : php core-db-generator.php %s\n",$lStrAction ,$lArrActionParam[3],$lArrActionParam[2]);
            }
        }
        
    }
    catch(\Exception $ex)
    {
        echo $ex->getMessage();
        echo sprintf("Usage : php core-db-generator.php %s",$lArrActions[$action][2]);
    }
    
    
   // $lObjGen = new CoreModelGenerator('COREDEV02');
    
    //echo $lObjGen->generateSQLScript();
    
}

main($argc,$argv);
?>