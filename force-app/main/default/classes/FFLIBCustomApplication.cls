public with sharing class FFLIBCustomApplication {
    public static final fflib_Application.UnitOfWorkFactory UNITOFWORK = new fflib_Application.UnitOfWorkFactory(new List<SObjectType>{
        Account.SObjectType,
        Contact.SObjectType,
        Case.SObjectType,
        Task.SObjectType,
        Opportunity.SObjectType
});

    public static final fflib_Application.ServiceFactory SERVICE = new fflib_Application.ServiceFactory(new Map<Type, Type>{
            Task_Service_Interface.class => Task_Service_Impl.class
});

    public static final fflib_Application.SelectorFactory SELECTOR = new fflib_Application.SelectorFactory(new Map<SObjectType, Type>{
        Case.SObjectType => Case_Selector.class,
        Contact.SObjectType =>Contact_Selector.class
});

    public static final fflib_Application.DomainFactory DOMAIN = new fflib_Application.DomainFactory(FFLIBCustomApplication.SELECTOR, new Map<SObjectType, Type>{
        Case.SObjectType => Cases.Constructor.class,
        Contact.SObjectType => Contacts.Constructor.class
});

    public static final fflib_Application.ServiceFactory SERVICEBYRECORDTYPE = new fflib_Application.ServiceFactory(new Map<String, Type>{
        'Gaming Laptop Case' => Gaming_Rigs_Laptop_Service_Impl.class,
        'Gaming Consoles Case' => Gmaing_Rigs_Console_Service_Impl.class,
        'Gaming Chair Case' => Gaming_Rigs_Chair_Service_Impl.class

});
    
}