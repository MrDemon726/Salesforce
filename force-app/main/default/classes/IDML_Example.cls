/**
 * Created by gerry on 4/2/2021.
 */
//Implementing this class allows you to overcome to limitations of the regular unit of work class.
public with sharing class IDML_Example implements fflib_SObjectUnitOfWork.IDML
{
    public static void dmlInsert(List<SObject> objList){
        //custom insert logic here
    }
    public static void dmlUpdate(List<SObject> objList){
        //custom update logic here
    }
    public static void dmlDelete(List<SObject> objList){
        //custom delete logic here
    }
    public static void eventPublish(List<SObject> objList){
        //custom event publishing logic here
    }
    public static void emptyRecycleBin(List<SObject> objList){
        //custom empty recycle bin logic here
    }
}