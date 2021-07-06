load data/data1_Jump3
[w,exprMean,exprVar,promState,kinParams,kinParamsVar,trees] = jump3(data1,obsTimes1,noiseVar);

load data/data2_Jump3
[w,exprMean,exprVar,promState,kinParams,kinParamsVar,trees] = jump3(data2,obsTimes2,noiseVar);