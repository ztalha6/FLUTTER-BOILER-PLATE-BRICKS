class AuthRepository {
  Future<RepositoryResponse> signIn(String email, String password) async {
    try {
      ResponseModel<SignInResponse> responseModel =
          await ResponseModel.fromApiResponse<SignInResponse>(
        () async => await AuthService().signInUser(
          SignInRequest(email: email, password: password),
        ),
        (body) => SignInResponse.fromJson(body),
      );
      if (responseModel.status == ResponseStatus.SUCCESS) {
        /* TODO: handle the success case here, you can save the token by using TokenManager that was generated */
        // await TokenManager()
        //     .setToken(responseModel.response!.body!.data!.token!);
        return RepositoryResponse(isSuccess: true);
      } else if (responseModel.status == ResponseStatus.RESPONSE_ERROR ||
          responseModel.status == ResponseStatus.NULL_RESPONSE) {
        SnackbarManager().showAlertSnackbar(responseModel.error!);
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
    return RepositoryResponse(isSuccess: false);
  }
}
