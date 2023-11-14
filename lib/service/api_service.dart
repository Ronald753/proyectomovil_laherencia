import 'package:proyectomovil/model/modelCategorias.dart';
import 'package:proyectomovil/model/modelLogin.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/model/modelPedido.dart';
import 'package:proyectomovil/model/modelPersona.dart';
import 'package:proyectomovil/model/PedidosCliente.dart';
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

  @FormUrlEncoded()
  @POST('/session/loginMovil')
  Future<LoginResponse> loginMovil(
    @Field('email') String email,
    @Field('password') String password,
  );

  //Enviar pedido
  @POST('/pedidos/')
  Future<void> enviarPedido(@Body() Pedido pedido);

  @POST("/personas/") // Ruta de la API para el registro
  Future<Persona> registrarPersona(@Body() Persona request);

  @GET('/session/forgotPass') // Asegúrate de que esta ruta coincida con la ruta real en tu backend
  Future<void> restaurarPassword(
    @Query('email') String email,
  );

  @GET('/personas/{id}')
  Future<Persona> obtenerPersona(@Path('id') String id);

  @GET("/pedidos/user/{id}")
  Future<List<PedidosCliente>> getPedidosByUserId(@Path("id") String userId);
}
