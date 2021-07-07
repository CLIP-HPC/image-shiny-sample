def tag_name = "latest"
if (env.TAG_NAME) {
    tag_name = "${env.TAG_NAME}"
}

def jobsMapping = [
    tags: [jobName:"Shiny Sample App", extraVars: "app_generic_image_tag: " + tag_name],
]

buildDockerImage([
    imageName: "sample-shiny-app",
    pushRegistryNamespace: "it",
    pushBranches: ['main'],
    testCmd: null,
    tower: jobsMapping,])