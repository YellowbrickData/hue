
DataDefinition
 : ExternalDefinition
 ;

DataDefinition_EDIT
 : ExternalDefinition_EDIT
 ;

ExternalDefinition
 : ExternalStorageDefinition
 | ExternalLocationDefinition
 | ExternalFormatDefinition
 ;

ExternalDefinition_EDIT
 : 'CREATE' 'EXTERNAL' 'CURSOR'
 {
   parser.suggestKeywords(['STORAGE', 'LOCATION', 'FORMAT']);
 }
 | ExternalStorageDefinition_EDIT
 | ExternalLocationDefinition_EDIT
 | ExternalFormatDefinition_EDIT
 ;

// EXTERNAL STORAGE

ExternalStorageDefinition
 : 'CREATE' 'EXTERNAL' 'STORAGE' OptionalIfNotExists ExternalStorageDefinitionRightPart
 ;

ExternalStorageDefinition_EDIT
 : 'CREATE' 'EXTERNAL' 'STORAGE' OptionalIfNotExists 'CURSOR'
   {
     if (!$4) {
       parser.suggestKeywords(['IF NOT EXISTS']);
     }
     parser.suggestDatabases({ appendDot: true });
   }
 | 'CREATE' 'EXTERNAL' 'STORAGE' OptionalIfNotExists 'CURSOR' ExternalStorageDefinitionRightPart
   {
     if (!$4) {
       parser.suggestKeywords(['IF NOT EXISTS']);
     }
   }
 | 'CREATE' 'EXTERNAL' 'STORAGE' OptionalIfNotExists ExternalStorageDefinitionRightPart_EDIT
 | 'CREATE' 'EXTERNAL' 'STORAGE' OptionalIfNotExists_EDIT
 ;

ExternalStorageDefinitionRightPart
 : SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType OptionalIdentityAndCredential
 ;

StorageType
 : RegularIdentifier
 ;

EndpointType
 : SingleQuotedValue
 ;

EndpointType_EDIT
 : SingleQuotedValue_EDIT
 ;

RegionType
 : SingleQuotedValue
 ;

RegionType_EDIT
 : SingleQuotedValue_EDIT
 ;

OptionalIdentityAndCredential
 :
 | 'IDENTITY' SingleQuotedValue 'CREDENTIAL' SingleQuotedValue
 ;

IdentityAndCredential_EDIT
 : 'IDENTITY' SingleQuotedValue_EDIT
 | 'IDENTITY' SingleQuotedValue 'CURSOR'
 {
   parser.suggestKeywords(['CREDENTIAL']);
 }
 | 'IDENTITY' SingleQuotedValue 'CREDENTIAL' SingleQuotedValue_EDIT
 ;

ExternalStorageDefinitionRightPart_EDIT
 : SchemaQualifiedIdentifier 'CURSOR'
 {
   parser.suggestKeywords(['TYPE']);
 }
 | SchemaQualifiedIdentifier 'TYPE' 'CURSOR'
 {
   parser.suggestKeywords(['S3', 'NFS']);
 }
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'CURSOR'
 {
   parser.suggestKeywords(['ENDPOINT']);
 }
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType_EDIT
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'CURSOR'
 {
   parser.suggestKeywords(['REGION']);
 }
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType_EDIT
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType 'CURSOR'
 {
   parser.suggestKeywords(['IDENTITY']);
 }
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType IdentityAndCredential_EDIT
 ;
