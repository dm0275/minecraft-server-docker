import com.fussionlabs.Utils
import java.io.ByteArrayOutputStream

val dockerBuilder = "docker-builder"
val qname = "dm0275/minecraft-server"
val latestTag = "${qname}:latest"
val worldName = System.getenv("WORLD") ?: "world"

// Vanilla Config
val vanillaVersions = Utils.readConfig(File("$projectDir/config/vanilla-versions.yaml"))
val vanillaDirectories = listOf("data/$worldName/world", "data/$worldName/mods")

// Forge Config
val forgeDirectories = listOf("data_forge/$worldName/world", "data_forge/$worldName/mods")
val forgeVersions = Utils.readConfig(File("$projectDir/config/forge-versions.yaml"))

tasks.register("test") {
    doLast {
        println(vanillaVersions)
    }
}

tasks.register("dockerLogin", Exec::class.java) {
    commandLine("bash", "-c", "printenv DOCKER_TOKEN | docker login -u ${'$'}DOCKER_USERNAME --password-stdin")
}

tasks.register("setupDockerBuilder") {
    doLast {
        val stdout = ByteArrayOutputStream()
        exec {
            commandLine = listOf("docker", "buildx", "ls")
            standardOutput = stdout
            errorOutput = stdout
            isIgnoreExitValue = true
        }

        if (!stdout.toString().contains(dockerBuilder)) {
            exec {
                commandLine = listOf("docker", "buildx", "create", "--name", dockerBuilder, "--driver", "docker-container")
            }
        }
    }
}

vanillaVersions.forEachIndexed { index, serverConfig ->
    var buildCmd = "docker buildx build --builder $dockerBuilder " +
                        "--platform=linux/amd64,linux/arm64 " +
                        "--file vanilla/Dockerfile " +
                        "--build-arg mc_version=${serverConfig.version} " +
                        "--build-arg mc_url_link=${serverConfig.url} " +
                        "--build-arg java_version=${serverConfig.javaVersion} " +
                        "-t ${qname}:${serverConfig.version}"

    tasks.register("buildVanilla${serverConfig.version}", Exec::class.java) {
        group = "Minecraft"
        description = "Build Minecraft server v${serverConfig.version} image"
        dependsOn("setupDockerBuilder")

        if (serverConfig.latest) {
            buildCmd += " -t $latestTag"
        }
        commandLine = "$buildCmd .".split(" ")
    }
}
