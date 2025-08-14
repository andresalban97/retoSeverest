function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    ApiUrl: 'https://serverest.dev/'
  }
  if (env == 'dev') {
    config.isAdministrator = "true";
    config.existingEmail = "fulano@qa.com"
  } else if (env == 'e2e') {
    config.isAdministrator = "true";
    config.existingEmail = "fulano@qa.com"
  }
  return config;
}