
// EXTERNAL OBJECTS

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
     parser.suggestSchemas({ appendDot: true });
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
 : SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType IdentityAndCredential
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

IdentityAndCredential
 : 'IDENTITY' SingleQuotedValue 'CREDENTIAL' SingleQuotedValue
 ;

IdentityAndCredential_EDIT
 : 'IDENTITY' 'CURSOR'
 {
   parser.suggestKeywords(["''"]);
 }
 | 'IDENTITY' SingleQuotedValue_EDIT
 | 'IDENTITY' SingleQuotedValue 'CURSOR'
 {
   parser.suggestKeywords(["CREDENTIAL ''"]);
 }
 | 'IDENTITY' SingleQuotedValue 'CREDENTIAL' 'CURSOR'
 {
   parser.suggestKeywords(["''"]);
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
   parser.suggestKeywords(["ENDPOINT ''"]);
 }
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType_EDIT
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'CURSOR'
 {
   parser.suggestKeywords(["REGION ''"]);
 }
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType_EDIT
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType 'CURSOR'
 {
   parser.suggestKeywords(["IDENTITY ''"]);
 }
 | SchemaQualifiedIdentifier 'TYPE' StorageType 'ENDPOINT' EndpointType 'REGION' RegionType IdentityAndCredential_EDIT
 ;


// EXTERNAL LOCATION

ExternalLocationDefinition
 : 'CREATE' 'EXTERNAL' 'LOCATION' OptionalIfNotExists ExternalLocationDefinitionRightPart
 ;

ExternalLocationDefinition_EDIT
 : 'CREATE' 'EXTERNAL' 'LOCATION' OptionalIfNotExists 'CURSOR'
   {
     if (!$4) {
       parser.suggestKeywords(['IF NOT EXISTS']);
     }
     parser.suggestSchemas({ appendDot: true });
   }
 | 'CREATE' 'EXTERNAL' 'LOCATION' OptionalIfNotExists 'CURSOR' ExternalLocationDefinitionRightPart
   {
     if (!$4) {
       parser.suggestKeywords(['IF NOT EXISTS']);
     }
   }
 | 'CREATE' 'EXTERNAL' 'LOCATION' OptionalIfNotExists ExternalLocationDefinitionRightPart_EDIT
 | 'CREATE' 'EXTERNAL' 'LOCATION' OptionalIfNotExists_EDIT
 ;

ExternalLocationDefinitionRightPart
 : SchemaQualifiedIdentifier 'PATH' PathType 'EXTERNAL' 'STORAGE' SchemaQualifiedIdentifier
 | SchemaQualifiedIdentifier 'PATH' PathType 'EXTERNAL' 'STORAGE' SchemaQualifiedIdentifier 'EXTERNAL' 'FORMAT' SchemaQualifiedIdentifier
 ;

PathType
 : SingleQuotedValue
 ;

ExternalLocationDefinitionRightPart_EDIT
 : SchemaQualifiedIdentifier 'CURSOR'
 {
   parser.suggestKeywords(["PATH ''"]);
 }
 | SchemaQualifiedIdentifier 'PATH' PathType 'CURSOR'
 {
   parser.suggestKeywords(['EXTERNAL STORAGE']);
 }
 | SchemaQualifiedIdentifier 'PATH' PathType 'EXTERNAL' 'STORAGE' 'CURSOR'
 {
   parser.suggestExternalStorage();
 }
 | SchemaQualifiedIdentifier 'PATH' PathType 'EXTERNAL' 'STORAGE' SchemaQualifiedIdentifier_EDIT
 | SchemaQualifiedIdentifier 'PATH' PathType 'EXTERNAL' 'STORAGE' SchemaQualifiedIdentifier 'CURSOR'
 {
   parser.suggestKeywords(['EXTERNAL FORMAT']);
 }
 | SchemaQualifiedIdentifier 'PATH' PathType 'EXTERNAL' 'STORAGE' SchemaQualifiedIdentifier 'EXTERNAL' 'FORMAT' 'CURSOR'
 {
   parser.suggestExternalFormats();
 }
 | SchemaQualifiedIdentifier 'PATH' PathType 'EXTERNAL' 'STORAGE' SchemaQualifiedIdentifier 'EXTERNAL' 'FORMAT' SchemaQualifiedIdentifier_EDIT
 ;


// EXTERNAL FORMAT

ExternalFormatDefinition
 : 'CREATE' 'EXTERNAL' 'FORMAT' OptionalIfNotExists ExternalFormatDefinitionRightPart
 ;

ExternalFormatDefinition_EDIT
 : 'CREATE' 'EXTERNAL' 'FORMAT' OptionalIfNotExists 'CURSOR'
   {
     if (!$4) {
       parser.suggestKeywords(['IF NOT EXISTS']);
     }
     parser.suggestSchemas({ appendDot: true });
   }
 | 'CREATE' 'EXTERNAL' 'FORMAT' OptionalIfNotExists 'CURSOR' ExternalFormatDefinitionRightPart
   {
     if (!$4) {
       parser.suggestKeywords(['IF NOT EXISTS']);
     }
   }
 | 'CREATE' 'EXTERNAL' 'FORMAT' OptionalIfNotExists ExternalFormatDefinitionRightPart_EDIT
 | 'CREATE' 'EXTERNAL' 'FORMAT' OptionalIfNotExists_EDIT
 ;

ExternalFormatDefinitionRightPart
 : SchemaQualifiedIdentifier 'TYPE' FormatType 'WITH' WithClause
 ;

FormatType
 : RegularIdentifier
 ;

ExternalFormatDefinitionRightPart_EDIT
 : SchemaQualifiedIdentifier 'CURSOR'
 {
   parser.suggestKeywords(['TYPE']);
 }
 | SchemaQualifiedIdentifier 'TYPE' 'CURSOR'
 {
   parser.suggestKeywords(['CSV', 'TEXT', 'BCP', 'PARQUET']);
 }
 | SchemaQualifiedIdentifier 'TYPE' FormatType 'CURSOR'
 {
   parser.suggestKeywords(['WITH']);
 }
 | SchemaQualifiedIdentifier 'TYPE' FormatType 'WITH' WithClause_EDIT
 ;
