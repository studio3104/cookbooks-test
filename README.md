DESCRIPTION:
===========

this file is chef cookbook
for OS setting check.

ATTRIBUTES:
==========

This cookbook is very simple OS setting test.

* set `/root/chef/json/example.yaml` your os setting.
* CPU check
* Memory check *(Check the integrity of the 90%)*
* Disk partition check
* Disk Size Check *(Check the integrity of the 90%)*
* NIC setting check
* ping 

so very versy simple recipe!!!  

For more information, please read the  source file.  
*(/cookbooks-test/recipes/default.rb)*

USAGE:
=====


* /root/chef/json/example.yaml


```
"hoge-admin01":
  cpu: 8
  memory: 16
  disk:
   name: "/dev/vda3"
   size: 20
  disk_data:
   name: "/dev/vdb1"
   size: 80
  network:
   eth0: "192.168.0.11" 
   eth1: "172.16.0.11"
  ping: "192.168.0.12"
```

You can check more than one server in the form of YAML.

```
"hoge-web01"
  cpu: 8

…

"hoge-db01"
  cpu: 4

...
```



## run on the json file.



```
{
  "test": { "yaml" : "/root/chef/json/example.yaml" },
  "run_list": [
        "test"
  ]
}
```

## run run run!!!


```
$ chef-solo -c /root/chef/config/solo.rb -j /root/chef/json/test.json 
[2012-11-19T20:59:52+09:00] INFO: *** Chef 10.16.2 ***
[2012-11-19T20:59:52+09:00] INFO: Setting the run_list to ["test"] from JSON
[2012-11-19T20:59:52+09:00] INFO: Run List is [recipe[test]]
[2012-11-19T20:59:52+09:00] INFO: Run List expands to [test]
[2012-11-19T20:59:52+09:00] INFO: Starting Chef Run for uma-admin01
[2012-11-19T20:59:52+09:00] INFO: Running start handlers
[2012-11-19T20:59:52+09:00] INFO: Start handlers complete.
[2012-11-19T20:59:52+09:00] INFO:

=== Chef Server Settings Check Test Start ==========
[2012-11-19T20:59:52+09:00] INFO: CPU: 8  ... OK
[2012-11-19T20:59:52+09:00] INFO: Memory: 16777216kB  ... OK
[2012-11-19T20:59:52+09:00] INFO: mount "/": / ... OK
[2012-11-19T20:59:52+09:00] INFO: Disk size "/" : 22327164  ... OK
[2012-11-19T20:59:52+09:00] INFO: eth1: exists  ... OK
[2012-11-19T20:59:52+09:00] INFO: eth1: 192.168.0.11  ... OK
[2012-11-19T20:59:52+09:00] INFO: eth0: exists  ... OK
[2012-11-19T20:59:52+09:00] INFO: eth0: 172.16.0.11  ... OK
[2012-11-20T29:59:52+09:00] INFO: ping : 192.168.0.12 ... OK
[2012-11-19T20:59:52+09:00] INFO:
=== Chef Server Settings Check Test Done ==========

[2012-11-19T20:59:52+09:00] INFO: Chef Run complete in 0.061459 seconds
[2012-11-19T20:59:52+09:00] INFO: Running report handlers
[2012-11-19T20:59:52+09:00] INFO: Report handlers complete
```



LICENSE:
==================

The MIT License (MIT)  
Copyright (c) 2012, kenjiskywalker All rights reserved.
