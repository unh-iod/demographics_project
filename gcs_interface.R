cloud_prep <- function(){
  library(googleAuthR)
  getwd()
  if(Sys.getenv("DOMAINNAME") == "MSI"){
    Sys.setenv("GCS_DEFAULT_BUCKET" = "demographics-384020",
               "GCS_AUTH_FILE" = paste(str_replace_all(getwd(),"/","\\\\"),"\\demographics-384020-821b645ce957.json",sep=""))
  }
  if(Sys.getenv("DOMAINNAME") != "MSI"){
    Sys.setenv("GCS_DEFAULT_BUCKET" = "demographics-384020",
               "GCS_AUTH_FILE" = paste(getwd(),"/","/demographics-384020-821b645ce957.json",sep=""))
  }
  library(googleCloudStorageR)
  buckets <- gcs_list_buckets("demographics-384020")
  bucket <- buckets$name[1]
  objects <- gcs_list_objects(bucket)
  return(list(bucket = bucket,objects = objects))
}

get_object <- function(objname,bucket){
  raw_download <- gcs_get_object(objname,
                                 bucket = bucket,
                                 saveToDisk = "_downloaded_.csv",
                                 overwrite = TRUE)
}

send_object <- function(objname,bucket,name){
  gcs_upload(objname, bucket = bucket, name=name,
             predefinedAcl='bucketLevel')
}
