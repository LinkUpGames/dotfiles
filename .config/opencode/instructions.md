# Instructions

## Setup
To start of opencode in a new machine, make sure that you set the context hight enough in order to run the models that we want. For example, we can update the following model to use this.

```bash
$ ollama show granite3.3:8b
  Model
    architecture        granite    
    parameters          8.2B       
    context length      131072     
    embedding length    4096       
    quantization        Q4_K_M     

  Capabilities
    completion    
    tools         

  License
    Apache License               
    Version 2.0, January 2004    
    ...                          

And edit it so that it has a fixed num_ctx:

```terminal
$ ollama run qwen3:latest
>>> /set parameter num_ctx 16384
Set parameter 'num_ctx' to '16384'
>>> /save qwen3:latest
Created new model 'qwen3:latest'
>>> /bye
```
