// MongoDB: basado en JavaScript
// Guarda documentos en formato BSON (Binary JSON)
// Lo mismo que JSON con soporte extra para tipos binarios no definidos en el estandar.

// Corre el cliente de consola
// Defaults: localhost, port 27017

// $ mongo

// Si no existen, las bases de datos se crean al ser usadas.

use mydatabase;

// Las "colecciones", equivalentes a las tablas, se crean al momento de ser referenciadas.

db.users.count();

// Inserta datos, si no se especifica, el _id es asignado automaticamente
db.users.insert({username: "sergio", firstname: "Sergio", lastname: "Kas", company: "UTN"});
db.users.insert({username: "roberto", firstname: "Roberto", lastname: "Gomez", company: "UTN"});
db.users.insert({username: "franco", firstname: "Franco", lastname: "Pessana", company: "UTN"});

// Los datos no tienen que tener el mismo modelo en absoluto.
db.users.insert({username: "cacarulo", ciudad: "Mar del Plata", profesion: "mago"});

// Multidimensional
db.users.insert({username: "multi", firstname: "Multi", lastname: "Dimension", 
  skills: ['python','mysql','sqlite','mongodb'],
  resume: [{company: "IBM", year: 2009}, {company: "Hewlett-Packard", year: 2011}]
});

// Busca por campo
db.users.find({username: "sergio"});

// Busca por valor en la lista
db.users.find({skills: "python"});

// Busca por multidimensional
db.users.find({"resume.company": "IBM"});

// Updates
db.users.update({username: "cacarulo"}, {$set: {company: "UTN"}});

// Los datos son indexables
db.users.ensureIndex({username: 1});

// Incluye soporte para "referencias"
ref = db.users.findOne({username: "roberto"})._id
db.publications.insert({users_id: ref, title: "A linear programming approach for adaptive synchronization of traffic signals"});

db.publications.findOne();
uid = db.publications.findOne().users_id;
db.users.find(uid);

// Remove user
db.users.remove({username: "cacarulo"});

// Destruye la coleccion
db.users.drop();