
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'apiService.g.dart';

@RestApi(baseUrl: 'https://la-herencia-api.up.railway.app/productos')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('')
  Future<List<Productos>> getProductos();
}



