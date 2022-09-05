import 'http_services/dio_interceptor.dart';

class ExceptionHandler {
  void handle(Object e) {
    if (e is BadRequestException ||
        e is UnauthorizedException ||
        e is InternalServerErrorException ||
        e is NoInternetConnectionException ||
        e is DeadlineExceededException) {

        {{#using_snakbar_manager}}
        SnackbarManager().showAlertSnackbar(e.toString());
        {{/using_snakbar_manager}}

        {{^using_snakbar_manager}}
        /* Put your SnackbarManager method here. e is the Exception, you can use it like (e.toString()) */
        {{/using_snakbar_manager}}
    }
  }
}
