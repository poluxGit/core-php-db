<?php
namespace polux\CorePHPDb;

use polux\CorePHPDb\Generators\CoreModelGenerator;

/**
 *
 * @author PoLuX
 *        
 */
class DatabaseGenerator
{

    // TODO - Insert your code here
    
    /**
     */
    public function __construct()
    {
        
        // TODO - Insert your code here
    }

    /**
     */
    function __destruct()
    {
        
        // TODO - Insert your code here
    }
    
    /**
     * Déploiement du schéma de base de données Core Model généré à la volée
     * 
     * @param \PDO $dbHandler
     */
    public function deployCoreModelToDatabase(\PDO $dbHandler,string $schema)
    {
        $lObjCoreModelGen = new CoreModelGenerator($schema);
        
        try {
            // SQL Script Generation !!!
            $lStrSQLScriptToDeploy = $lObjCoreModelGen->generateSQLScript();
            
            // Database Execution
            $dbHandler->exec($lStrSQLScriptToDeploy);
        }
        catch (\Exception $ex)
        {
            echo $ex->getMessage();
        }
    }//end deployCoreModelToDatabase()
    
    /**
     * Deploiément du CoreModel sur l'instance de base passée en apramètres
     * 
     * @param \PDO $dbHandler
     * @param string $schema
     */
    public function deployModelToDatabase(\PDO $dbHandler,string $schema)
    {
       
    }//end deployModelToDatabase()
    
    public function deployModelToScript(string $outputfile){
        
    }
}

