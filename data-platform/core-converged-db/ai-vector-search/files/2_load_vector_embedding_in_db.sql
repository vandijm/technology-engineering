REM  load a vector embedding model into the database: we can load a ONNX model inside the database using DBMS_VECTOR package 

/* 
The ONNX file in this example was generated by Oracle OML4Py utility from the all-MiniLM-L6-v2 sentence transformer model. 
It can be downloaded from https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/fro8fl9kuqli/b/AIVECTORS/o/all-MiniLM-L6-v2.onnx
Copy the all-MiniLM-L6-v2.onnx file to the path corresponding to the DM_DUMP directory.
  */ 

-- connect to the VECTOR_USER 

connect vector_user/Oracle_4U@FREEPDB1


-- load the ONNX model in the database

EXECUTE DBMS_VECTOR.LOAD_ONNX_MODEL('DM_DUMP','all-MiniLM-L6-v2.onnx','doc_model');