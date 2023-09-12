import 'package:proyectomovil/model/modelProductos.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://churrasqueriaherencia.onrender.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/activos')
  Future<List<Productos>> getProductos();
}
