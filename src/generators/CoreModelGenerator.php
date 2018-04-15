<?php
namespace polux\CorePHPDb\Generators;

/**
 * CoreDatabaseGenerator
 * 
 * G�n�ration de mod�le interne de base de donn�es
 * 
 * @author PoLuX
 *
 */
class CoreModelGenerator
{
    /**
     * Sch�ma cible
     * 
     * @var string
     */
    private $targetSchema = null;
    
    /**
     * Version de la base de donn�es
     * 
     * @var string
     */
    private $targetVersion = null; 
    
    /**
     * TimeStamp de la g�n�ration
     *
     * @var int
     */
    private $timestampLastGen = null;   
        
    /**
     * Contructeur par d�faut
     * 
     * @param \PDO $dbHandler
     */
    public function __construct($targetSchema,$targetVersion="dev")
    {
        $this->targetSchema  = $targetSchema;
        $this->targetVersion = $targetVersion;
    }
    
    /**
     * G�n�ration du script SQL d'initialisation du sch�ma Core de la base de donn�es
     * 
     * @param string $targetSchema
     * @param string $version
     * @param int    $dateGeneration
     * 
     * @return string Script SQL de cr�ation de la base de donn�es
     */
    public function generateSQLScript(int $dateGeneration=NULL):string
    {
        // Variables locales
        $lObjTemplateGenerator = new \Smarty();
        $lStrSQLGenerated = "";
        
        // D�but de la g�n�ration!
        if($dateGeneration === NULL)
        {
            $lObjDte = new \DateTime();
            $ltsCurrentDate = $lObjDte->getTimestamp(); 
            $this->timestampLastGen = $ltsCurrentDate;
            $lStrGenDate = date('Y-m-d H:i',$ltsCurrentDate);
        }
        else 
            $lStrGenDate =date('Y-m-d H:i', $dateGeneration);
                
        // Pr�paration de la liste des fichier(s) � g�n�rer / traiter. 
        $lsRootPath = dirname(__FILE__);
        $lArrTplFilesToGenerate = [
            $lsRootPath."/../templates/CoreModel/sql/SQL-00-INIT-01.00-INIT_SCHEMA.tpl",
            $lsRootPath."/../templates/CoreModel/sql/SQL-10-TAB-01.00-USERS_TABLES.tpl",
            $lsRootPath."/../templates/CoreModel/sql/SQL-90-INSERT-01.00-USERS_ACCOUNTS.tpl",
            $lsRootPath."/../templates/CoreModel/sql/SQL-10-TAB-01.01-CORE_TABLES.tpl",
            $lsRootPath."/../templates/CoreModel/sql/SQL-10-TAB-01.02-LOGS_TABLES.tpl",
            $lsRootPath."/../templates/CoreModel/sql/SQL-20-ROU-01.01-ROUTINES_LOGS.tpl",
            $lsRootPath."/../templates/CoreModel/sql/SQL-20-ROU-01.02-ROUTINES_CORE.tpl",
            $lsRootPath."/../templates/CoreModel/sql/SQL-30-TRIG-01.01-ALLCORE_TRIGGERS.tpl",            
            $lsRootPath."/../templates/CoreModel/sql/SQL-90-INSERT-02.01-TYPEOBJECTS.tpl"
        ];
        
        // GENERATION DU SCRIPT SQL FINAL
        foreach ($lArrTplFilesToGenerate as $value) {
            $lObjTemplate = $lObjTemplateGenerator->createTemplate($value);
            $lObjTemplate->assign('TARGET_SCHEMA', $this->targetSchema);
            $lObjTemplate->assign('GEN_DATE', $lStrGenDate);
            $lObjTemplate->assign('TARGET_VERSION', $this->targetVersion);
            $lStrSQLGenerated .= $lObjTemplate->fetch();
        }
        
        return $lStrSQLGenerated;        
    }//end generateSQLScript()
    
   /**
    * G�n�ration du script SQL d'initialisation du sch�ma Core de la base de donn�es dans un fichier
    *
    * @param string $targetSchema
    * @param string $version
    * @param string $outputDirectory
    *
    * @return string Chemin du fichier du script g�n�r� !
    */
    public function generateSQLScriptToFile(string $outputDirectory):string
    {
        $lObjDte = new \DateTime();
        $ltsCurrentDate = $lObjDte->getTimestamp();
        $this->timestampLastGen = $ltsCurrentDate;
        $lStrGenDate = date('Ymmd-H:i',$ltsCurrentDate);
        $lStrGenDateForFileName = date('Ymmd-Hi',$ltsCurrentDate);
        $lStrFileName = $lStrGenDateForFileName."_".$this->targetSchema."_".$this->targetVersion.".sql";
        $lStrCompletefilepath = dir($outputDirectory)->path.'/'.$lStrFileName;
        file_put_contents($lStrCompletefilepath, $this->generateSQLScript($ltsCurrentDate));
        
        return $lStrCompletefilepath;
    }//end generateSQLScriptToFile()
  
}//end class

