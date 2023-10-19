import 'package:proyectomovil/model/modelProductos.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://churrasqueriaherencia.onrender.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //Obtener categorias



  //Obtener productos
  @GET('/activos')
  Future<List<Productos>> getProductos();

  //Actualizar puntuacion
  @PUT('/activos/{id}') // Utiliza el método HTTP correcto y la ruta de actualización adecuada
  Future<Productos> updateProducto(
    @Path('id') String id, // Debes proporcionar el ID del producto que deseas actualizar
    @Body() Map<String, dynamic> body, // El cuerpo de la solicitud debe contener el nuevo valor de la puntuación
  );

  //

  
}
