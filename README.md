## The Idea  
The similarity between JSON objects + arrays and Globals in IRIS or Caché is evident.    
With small and medium size JSON objects navigation across %Dynamic Objects is comfortable.  
But with **large** and/or deep cascaded objects it becomes a challenge.   

The presented tool offers 3 variants   
- loading an already existing %Dyamic Object or Array into a global of your choice   
- loading a %Stream containing a JSON object into a global of your choice   
- loading an external File containing a JSON object into a global of your choice   

### How to use it
```
UESR>read str
{"id":306904,"last_star_ts":0,"completion_day_level":{},"global_score":0,"local_score":0,"stars":0,"name":"name_1"}
USER>set jsn={}.%FromJSON(str)
USER>write ##class(rcc.jstog).toglobal(jsn,"^jsn")
1
USER>zwrite ^jsn
^jsn("global_score")=0
^jsn("id")=306904
^jsn("last_star_ts")=0
^jsn("local_score")=0
^jsn("name")="name_1"
^jsn("stars")=0

USER>zzjson jsn
{
  "id":306904,
  "last_star_ts":0,
  "completion_day_level":{
  },
  "global_score":0,
  "local_score":0,
  "stars":0,
  "name":"name_1"
}
USER>
```
   from an already existing Stream it's like this    
```
USER>write ##class(rcc.jstog).stream(jsonstream,"^jsstr")
1
```
  and from file it is this method:
```
USER>set filename="/opt/irisbuild/src/data/big6.json"
USER>write ##class(rcc.jstog).file(filename)  ; using default global ^json
1
USER>
```
### Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

### Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/rcemper/JSONfile-to-Global.git
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it
log in to command line or use [iterm](http://localhost:42773/iterm/)   
```
docker-compose exec iris iris session iris
```
2 test files are available   
- /opt/irisbuild/src/data/demo.json  ~1kB     
![](https://community.intersystems.com/sites/default/files/inline/images/demo.jpg)  
- /opt/irisbuild/src/data/big6.json  ~6GB 
![](https://community.intersystems.com/sites/default/files/inline/images/big6.jpg)  
this file is composed from the anonymized results of AOC2022 contest  

```
USER>......< your choice  > ....."
USER>kill ^json ; using default global ^json  
USER>write ##class(rcc.jstog).file(filename)
1
USER ZWRITE ^json
```

[Article in DC](https://community.intersystems.com/post/jsonfile-global-1)   

[Video](https://youtu.be/rJ4hY7-5CRk)    

[Online Demo](https://jsonfile-to-global.demo.community.intersystems.com/csp/sys/UtilHome.csp)   
[Online Terminal](https://jsonfile-to-global.demo.community.intersystems.com/terminal/)   



