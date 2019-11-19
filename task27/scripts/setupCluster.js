var dbPass = "mysql"
var clusterName = "otusCluster"

try {
  shell.connect('root@mysql-server-1:3306', dbPass)
  var cluster = dba.createCluster(clusterName);
  cluster.addInstance({user: "root", host: "mysql-server-2", password: dbPass})
  cluster.addInstance({user: "root", host: "mysql-server-3", password: dbPass})
} catch(e) { 
}
