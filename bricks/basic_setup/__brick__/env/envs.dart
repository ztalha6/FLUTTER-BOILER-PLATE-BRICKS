import 'env.dart';

class Envs {
  static const Env LocalEnv = Env(
    'Local',
    EnvUsers.DummyUser,
    {{#pascalCase}}'{{baseUrl}}'{{/pascalCase}},
    true,
  );
  static const Env DevEnv = Env(
    'Dev',
    EnvUsers.DummyUser,
    {{#pascalCase}}'{{baseUrl}}'{{/pascalCase}},
    true,
  );
  static const Env AutoDevEnv = Env(
    'Auto Dev',
    EnvUsers.DummyUser,
    {{#pascalCase}}'{{baseUrl}}'{{/pascalCase}},
    true,
  );
  static const Env StagingAutoSetupEnv = Env(
    'Auto Staging',
    EnvUsers.DummyUser,
    {{#pascalCase}}'{{baseUrl}}'{{/pascalCase}},
    true,
  );
  static const Env StagingEnv = Env(
    'Staging',
    EnvUsers.DummyUser,
    {{#pascalCase}}'{{baseUrl}}'{{/pascalCase}},
    false,
  );
  static const Env ProductionEnv = Env(
    'Production',
    null,
    {{#pascalCase}}'{{baseUrl}}'{{/pascalCase}},
    false,
  );

  static const List<Env> envs = [
    DevEnv,
    StagingEnv,
  ];
}

class EnvUsers {
  static const EnvUser DummyUser = EnvUser(
    'user@gmail.com',
    '123',
  );
  /* You can create new users as many as you want like above. */
}
