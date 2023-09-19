class MenuItems{
  final int? id;
  final String? nombre;
  final double? precio;
  final String? imagen;
  final String? descripcion;

  const MenuItems({this.id, this.nombre, this.precio, this.imagen, this.descripcion});
}

final platos =[
  new MenuItems(id: 1, nombre: "Carne1", precio: 70, imagen: "carne.jpg", descripcion: "Lorem Ipsum is simply dummy Ipsum."),
  new MenuItems(id: 2, nombre: "Carne2", precio: 9.99, imagen: "carne1.jpg", descripcion: "It is a long established humour and the like)."),
  new MenuItems(id: 3, nombre: "Carne3", precio: 39.99, imagen: "carne2.jpg", descripcion: "Contrary to popular belief, The first line of Lorem Ipsum."),
  new MenuItems(id: 4, nombre: "Carne4", precio: 89.99, imagen: "carne.jpg", descripcion: "There are many variations of passages of Lorem Ipsum available etc."),
  new MenuItems(id: 1, nombre: "Carne5", precio: 59.99, imagen: "carne1.jpg", descripcion: "Lorem ipsum dolor sit amet, tincidunt iaculis nulla laoreet."),
  new MenuItems(id: 2, nombre: "Carne6", precio: 99.99, imagen: "carne2.jpg", descripcion: "Pellentesque elementum arcu interdum risus euismod, finibus pharetra."),
  new MenuItems(id: 3, nombre: "Carne7", precio: 69.99, imagen: "carne.jpg", descripcion: "Ut sit amet elit augue. Ut malesuada condimentum sapien."),
  new MenuItems(id: 4, nombre: "Carne8", precio: 79.99, imagen: "carne1.jpg", descripcion: "Vivamus efficitur gravida pharetra. Morbi eget diam mauris."),
];