
//como hacer esta consultas sin el where 
db.pokemons.find(
  { 
    $and: [ 
      { games: { $exists: true } }, 
      { $where: "this.games.lengyh >= 5" } 
    ] 
  },
  { nombre: true, games: true }
)

//seria de esta manera 
db.pokemons.find(
  {
    games: { $exists: true, $not: { $size: 0 } },
    $expr: { $gte: [{ $size: "$games" }, 5] }     
  },
  { nombre: 1, games: 1, _id: 0 }
)



/*  documentos anidados
son aquellos que contienen otros documentos como valores de sus campos. 
Esto permite representar relaciones complejas entre datos dentro de un 
mismo documento, en lugar de usar referencias a otros documentos como en las bases de datos relacionales. 
*/

//use bokuNoHero
db.createCollection("heroes")

db.heroes.insertMany([
  {
    nombre: "Midoriya Izuku",
    edad: 16,
    quirk: "One For All",
    academia: {
      nombre: "U.A.",
      clase: "1-A",
      mentor: "Aizawa Shouta"
    },
    misiones: [
      { nombre: "Rescate", exito: true },
      { nombre: "Combate contra villano", exito: true }
    ]
  },
  {
    nombre: "Bakugo Katsuki",
    edad: 16,
    quirk: "Explosion",
    academia: {
      nombre: "U.A.",
      clase: "1-A",
      mentor: "Aizawa Shouta"
    },
    misiones: [
      { nombre: "Entrenamiento especial", exito: true }
    ]
  },
  {
    nombre: "Todoroki Shoto",
    edad: 16,
    quirk: "mdio frio medio caliente",
    academia: {
      nombre: "U.A.",
      clase: "1-A",
      mentor: "Endeavor"
    },
    misiones: [
      { nombre: "Operacion secreta", exito: false }
    ]
  },
  {
    nombre: "Uraraka Ochako",
    edad: 16,
    quirk: "Zero Gravity",
    academia: {
      nombre: "U.A.",
      clase: "1-A",
      mentor: "Thirteen"
    },
    misiones: [
      { nombre: "Rescate en escombros", exito: true }
    ]
  },
  {
    nombre: "Iida Tenya",
    edad: 16,
    quirk: "Engine",
    academia: {
      nombre: "U.A.",
      clase: "1-A",
      mentor: "Aizawa Shouta"
    },
    misiones: [
      { nombre: "Patrullaje", exito: true }
    ]
  }
]);



//buscar todos los datos de la coleccion
db.heroes.find();

//buscar todos los datos en formato bonito
db.heroes.find().pretty();

//Como consultar por campos anidados?
db.heroes.find({ "academia.clase": "1-A" });

//Cómo consultar un elemento dentro de un array anidado?
db.heroes.find(
  { nombre: "Midoriya Izuku" },
  { misiones: { $elemMatch: { nombre: "Rescate" } }, _id: 0 }
);

//Como consultar un elemento dentro de un array anidado?
db.heroes.find(
  { nombre: "Midoriya Izuku" },
  { misiones: { $elemMatch: { nombre: "Rescate" } }, _id: 0 }
);

//Como proyectar campos anidados?
db.heroes.find({}, {
  nombre: true,
  misiones: true,
  _id: false
});

//Como actualizar datos de un documento anidado?
db.heroes.updateOne(
  { nombre: "Uraraka Ochako" },
  { $set: { "academia.mentor": "All Might" } }
);


//Como insertar un documento anidado dentro de otro después?
db.heroes.updateOne(
  { nombre: "Midoriya Izuku" },
  { $set: { direccion: { ciudad: "Musutafu", calle: "Calle 123", codigo_postal: "110111" } } }
);

//Eliminar una mision del array 
db.heroes.updateOne(
  { nombre: "Bakugo Katsuki" },
  { $pull: { misiones: { nombre: "Entrenamiento especial" } } }
);

