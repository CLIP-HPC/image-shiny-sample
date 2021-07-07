# Shiny sample image

This repository contains everything to build a sample shiny app that can be hosted
on CBE/CLIP.

## Application code

The application goes into the `app` folder. This repository contains the source code for the sample shiny app. Please remove them and replace it with your custom application code

## Additional dependencies

The `Dockerfile` in this repository will only install `shiny` and `markdown`.
If your app requires additional repositories, pease uncomment following line in the Dockerfile and
explicitly add the dependencies:

```Dockerfile
RUN R -e "install.packages(c('dep1','dep2'), repos='https://cran.rstudio.com/')"
```

## CI/CD

The repository contains a `Jenkinsfile` for automatically building and deploying the image.
Following information needs to be adapted for every custom image that should be deployed:

- jobName: The name of the tower job that will deploy the new image (this will be typically provided to you by the CLIP TEam)
- pushRegistryNamespace: The namespace of the artifactory image registry where to push the images (typically every facility/lab has their own namespace)
- pushBranches: For which git branches a new image should be pushed. Note: for every change in git a new image will be built, however by default only git commit that's are tagged will be also pushed into the registry. If you want to also push every commit on a specific branch (i.e main), you need to add them to the list

## Local testing/development

To test if your app proplery works and the image can be built, you need to install docker on your workstation/laptop and then run following command inside the repository to build the image:

```sh
docker build -t image-shiny-sample .
```

Note: The first build will take some time becasue shiny and all its depenencies have to be installed inside the image. Subsequent builds where you only change the application code should go much faster as docker will use the cached image layers.

Once the image is successuflly built, you can test it with:

```sh
docker run -it -p 3838:3838 image-shiny-sample:latest
```

and then open http://localhost:3838/app in the browser