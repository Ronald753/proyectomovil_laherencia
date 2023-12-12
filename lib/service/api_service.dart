import 'package:proyectomovil/model/modelCategorias.dart';
import 'package:proyectomovil/model/modelLogin.dart';
import 'package:proyectomovil/model/modelProductos.dart';
import 'package:proyectomovil/model/modelPedido.dart';
import 'package:proyectomovil/model/modelPersona.dart';
import 'package:proyectomovil/model/modelResetPass.dart';
import 'package:proyectomovil/model/PedidosCliente.dart';
import 'package:proyectomovil/model/modelCupon.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://seahorse-app-4vvf3.ondigitalocean.app')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //Obtener productos
  @GET('/productos')
  Future<List<Productos>> getProductos();

  //Obtener categroias
  @GET('/categorias')
  Future<List<Categorias>> getCategorias();

  //Login
  @FormUrlEncoded()
  @POST('/session/loginMovil')
  Future<LoginResponse> loginMovil(
    @Field('email') String email,
    @Field('password') String password,
  );

  //Enviar pedido
  @POST('/pedidos/')
  Future<void> enviarPedido(@Body() Pedido pedido);

  //Registro
  @POST("/personas/") 
  Future<Persona> registrarPersona(@Body() Persona request);

  //Restaurar contraseña
  @GET("/session/forgotPass")
    Future<ResetPasswordResponse> genResetPassLink(@Field("email") String email);

  //Obtener usuario
  @GET('/personas/{id}')
  Future<Persona> obtenerPersona(@Path('id') String id);

  //Pedidos por id de usuario
  @GET("/pedidos/user/{id}")
  Future<List<PedidosCliente>> getPedidosByUserId(@Path("id") String userId);

  @GET('/cupones/codigo/{codigo}')
  Future<CuponModel?> getCuponPorCodigo(@Path('codigo') String codigo);
}
