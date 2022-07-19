# [1.1.0](https://github.com/SmartMedSA/base-php/compare/v1.0.0...v1.1.0) (2022-07-19)


### Features

* **Dockerfile:** bump base image to version php:8.0.21-cli ([7a67630](https://github.com/SmartMedSA/base-php/commit/7a67630b6cb21ad10ecdcc07b6e908b9315afd2a))

# 1.0.0 (2022-07-19)


### Bug Fixes

* added +x previlege to files under docker/php ([91b301f](https://github.com/SmartMedSA/base-php/commit/91b301fb549fcc7750efec33ab2e24374f1f1dd9))
* added execute previlege to entrypoint.sh ([48c61f9](https://github.com/SmartMedSA/base-php/commit/48c61f9055b82972b8df3ee248c318c87b76b5e1))
* added project name+ description to composer.json + restored ([9cfec2b](https://github.com/SmartMedSA/base-php/commit/9cfec2b8f2cf33926d30c5f79efd34276bd4f385))
* clean project from extra files ([4cdac59](https://github.com/SmartMedSA/base-php/commit/4cdac59cdbc21ac88f478e354bc6a07464a7bf29))
* clean project from extra files ([fee9dbc](https://github.com/SmartMedSA/base-php/commit/fee9dbc6d845abaeb704ccd778f68f001e6de36a))
* composer.json + added gitlab-ci.yml ([193c8d7](https://github.com/SmartMedSA/base-php/commit/193c8d7a0a47fe37bc0c612ebb180da2974a09c6))
* **composer:** composer update --lock ([ca1675d](https://github.com/SmartMedSA/base-php/commit/ca1675d6c5b9d71cf831846197456fd902b95234))
* dockerignore + gitignore files ([97d4c2a](https://github.com/SmartMedSA/base-php/commit/97d4c2aeba16fc8ab2f43058b618035eeb054d44))
* fixed .env in dockeringore file ([74dcd3d](https://github.com/SmartMedSA/base-php/commit/74dcd3dca665eac01b7cf62f1a471848eba54b90))
* fixed added required files + fixed docker-compose + added --env-file to dcupd in Makefile ([976b5b5](https://github.com/SmartMedSA/base-php/commit/976b5b51bd0ef2013505e2e14c5245ba48ce63e1))
* fixed cache ([4cc0b1d](https://github.com/SmartMedSA/base-php/commit/4cc0b1dc074feba05408cec31c87882b6f720237))
* fixed cache options ([ce984fe](https://github.com/SmartMedSA/base-php/commit/ce984fe11ba9560282dc36439560c09c9b3c8b69))
* fixed cache options ([d4ab22b](https://github.com/SmartMedSA/base-php/commit/d4ab22b8c160363e10b6e0bd069c6659174d63b0))
* fixed cache-to to value ([a4f72b1](https://github.com/SmartMedSA/base-php/commit/a4f72b1200527517a0506f7bd37971fac51304d8))
* fixed mount path ([aad152c](https://github.com/SmartMedSA/base-php/commit/aad152c19a6b4d4e7b4d5f9e856e44c0558dcbcb))
* fixed mount path ([2bc7348](https://github.com/SmartMedSA/base-php/commit/2bc734880617ed6925549b5aaaf20ce71ce9562b))
* fixed names in tags entry ([61dcb1b](https://github.com/SmartMedSA/base-php/commit/61dcb1b8e298404fe4f0b325ad9e69700f3467e6))
* fixed psalm cache directory ([5fc31bb](https://github.com/SmartMedSA/base-php/commit/5fc31bb9957ff0a0e06f04d01fa8d89f95538009))
* modified git ignore ([2c90e27](https://github.com/SmartMedSA/base-php/commit/2c90e271dcc48bf67ef0f399f2018424f465d6c0))
* pointed docker-compose build on Dockerfile ([7cc9887](https://github.com/SmartMedSA/base-php/commit/7cc9887faaafc4f84e10d1f560f730b8343c70cd))
* psalm cache directory ([b317bee](https://github.com/SmartMedSA/base-php/commit/b317bee46e922555c04796ed929c3ca002a7ef3c))
* removed extra naming step + relying on meta step to get tags name ([d6471be](https://github.com/SmartMedSA/base-php/commit/d6471bee5ad24e92eb0616496791013c4bf7b61a))
* removed PMA references in Makefile ([eca76fe](https://github.com/SmartMedSA/base-php/commit/eca76fe7764d183db3fd54f18d7b2799b97ecdbf))
* removed S3_service + added app_port as a env var ([5e58683](https://github.com/SmartMedSA/base-php/commit/5e58683e73d7a62fd93fb146dbc8fc10f65126d6))
* renamed app-name to app in docker-compose + added .env files ([d4159ed](https://github.com/SmartMedSA/base-php/commit/d4159ed9dcf34093106dfd28490b7dc609e9b1d2))
* set push registry to github registry ([369cc12](https://github.com/SmartMedSA/base-php/commit/369cc1215a210b4a9bb802fcd09abba3546165cc))


### Features

* add missing .env.local dockerignore ([4118b1b](https://github.com/SmartMedSA/base-php/commit/4118b1ba45ff58b0196367e983d2a15118e3f401))
* added caching feature + removed auto container push unless event not a push ([fccab8b](https://github.com/SmartMedSA/base-php/commit/fccab8b8ac815ee42512dbf3610f9a99ea04c162))
* added caching from base-cache tag ([968dd8d](https://github.com/SmartMedSA/base-php/commit/968dd8d072559ecf4efd752e384be9518f7e2a0d))
* added caching from develop branch ([7f3340a](https://github.com/SmartMedSA/base-php/commit/7f3340adc1a6f95e1eabe06263952d942dfb772a))
* added required workflow files ([199e075](https://github.com/SmartMedSA/base-php/commit/199e0754b53da4f72a5b94cdf611afa9d1b21e82))
* added triggerworkflow on PR types + delete docker image after PR ends ([f947370](https://github.com/SmartMedSA/base-php/commit/f9473709c49fc66f88a6489efb28d34ff36ee6cd))
* caching from dev + inline caching type ([94c7a8f](https://github.com/SmartMedSA/base-php/commit/94c7a8f4d2806e188697f518bed823dcc5b375fe))
* **Dockerfile:** add wait-for-it package ([#14](https://github.com/SmartMedSA/base-php/issues/14)) ([9fe5fd1](https://github.com/SmartMedSA/base-php/commit/9fe5fd19111fa3cc62b774167cce9e41565d2c3a))
* **Dockerfile:** add zip to apt deps ([d59390f](https://github.com/SmartMedSA/base-php/commit/d59390fe6d24e1957103f37d1fea860231a67214))
* **Dockerfile:** bump base image to 8.0.19-cli ([c80512c](https://github.com/SmartMedSA/base-php/commit/c80512c3a9c49ad1ee2e065ae9588dec929d6aca))
* **init.d/30-composer.sh:** improve composer install command ([af5e579](https://github.com/SmartMedSA/base-php/commit/af5e5798eebf2cbc565b3d35833142b31e1a9bc0))
* mapping container's user with the host's user ([985dea9](https://github.com/SmartMedSA/base-php/commit/985dea911358bb1daa4ef1cea90388afd101bd68))
* restructured project ([51e7304](https://github.com/SmartMedSA/base-php/commit/51e730435927deaa67e012b85ed5adadc9419655))
* user creation in parent + substitution in child ([a2d6331](https://github.com/SmartMedSA/base-php/commit/a2d63314d8974e0f485e09cf9dae06170968894c))
