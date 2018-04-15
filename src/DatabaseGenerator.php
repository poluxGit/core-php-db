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
     * D�ploiement du sch�ma de base de donn�es Core Model g�n�r� � la vol�e
     * 
     * @internal php core-db-generator.php gendb core COREDEVXX dev3 'mysql:host=coredbdev_01;port=3306;dbname=COREDEV01' polux polux
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
     * Deploi�ment du CoreModel sur l'instance de base pass�e en apram�tres
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

