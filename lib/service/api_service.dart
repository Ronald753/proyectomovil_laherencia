import 'package:proyectomovil/model/modelCategorias.dart';
import 'package:proyectomovil/model/modelLogin.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://herencia-api.onrender.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;


  //Obtener productos
  @GET('/productos')
  Future<List<Productos>> getProductos();

  //Obtener categroias
  @GET('/categorias')
  Future<List<Categorias>> getCategorias();

  // Inicio de sesión
  /*@GET('/session/loginMovil')
  Future<bool> login(
    @Query('email') String email,
    @Query('password') String password,
  );*/

  @POST('/session/loginMovil')
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);
  

  //Actualizar puntuacion
  /*
  @PUT('/activos/{id}') // Utiliza el método HTTP correcto y la ruta de actualización adecuada
  Future<Productos> updateProducto(
    @Path('id_producto') String id_producto, // Debes proporcionar el ID del producto que deseas actualizar
    @Body() Map<String, dynamic> body, // El cuerpo de la solicitud debe contener el nuevo valor de la puntuación
  );*/
  //

  
}
