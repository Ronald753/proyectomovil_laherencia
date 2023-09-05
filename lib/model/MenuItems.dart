class MenuItems{
  final int? id;
  final String? nombre;
  final double? precio;
  final String? imagen;
  final String? descripcion;

  const MenuItems({this.id, this.nombre, this.precio, this.imagen, this.descripcion});
}

final platos =[
  new MenuItems(id: 1, nombre: "Carne1", precio: 70, imagen: "carne.jpg", descripcion: "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas"),
  new MenuItems(id: 2, nombre: "Carne2", precio: 9.99, imagen: "carne1.jpg", descripcion: "Carne2"),
  new MenuItems(id: 3, nombre: "Carne3", precio: 39.99, imagen: "carne2.jpg", descripcion: "Carne3"),
  new MenuItems(id: 4, nombre: "Carne4", precio: 89.99, imagen: "carne.jpg", descripcion: "Carne4"),
  new MenuItems(id: 1, nombre: "Carne5", precio: 59.99, imagen: "carne1.jpg", descripcion: "Carne5"),
  new MenuItems(id: 2, nombre: "Carne6", precio: 99.99, imagen: "carne2.jpg", descripcion: "Carne6"),
  new MenuItems(id: 3, nombre: "Carne7", precio: 69.99, imagen: "carne.jpg", descripcion: "Carne7"),
  new MenuItems(id: 4, nombre: "Carne8", precio: 79.99, imagen: "carne1.jpg", descripcion: "Carne8"),
];