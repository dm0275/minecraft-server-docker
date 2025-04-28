import com.fussionlabs.Utils
import com.fussionlabs.data.*
import java.io.ByteArrayOutputStream

val dockerBuilder = "docker-builder"
val qname = "dm0275/minecraft-server"
val latestTag = "${qname}:latest"
val worldName = System.getenv("WORLD") ?: "world"
val loadImages = System.getenv("LOAD_IMAGES") ?: "false"

// Vanilla Config
val vanillaVersions = Utils.readConfig(File("$projectDir/config/vanilla-versions.yaml"))
val vanillaDirectories = listOf("data/$worldName/world", "data/$worldName/mods")

// Forge Config
val forgeDirectories = listOf("data_forge/$worldName/world", "data_forge/$worldName/mods")
val forgeVersions = Utils.readConfig(File("$projectDir/config/forge-versions.yaml"))

// Fabric Config
val fabricDirectories = listOf("data_fabric/$worldName/world", "data_fabric/$worldName/mods")
val fabricVersions = Utils.readConfig(File("$projectDir/config/fabric-versions.yaml"))

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

    tasks.register("pushVanilla${serverConfig.version}", Exec::class.java) {
        group = "Minecraft"
        description = "Push Minecraft server v${serverConfig.version} image"
        dependsOn("dockerLogin")
        dependsOn("setupDockerBuilder")

        if (serverConfig.latest) {
            buildCmd += " -t $latestTag"
        }
        commandLine = "$buildCmd --push .".split(" ")
    }
}

forgeVersions.forEachIndexed { index, serverConfig ->
    var buildCmd = "docker buildx build --builder $dockerBuilder " +
            "--platform=linux/amd64,linux/arm64 " +
            "--file forge/Dockerfile " +
            "--build-arg mc_version=${serverConfig.version} " +
            "--build-arg forge_version=${serverConfig.forgeVersion} " +
            "--build-arg java_version=${serverConfig.javaVersion} " +
            "--load -t ${qname}:forge-${serverConfig.version}"

    tasks.register("buildForge${serverConfig.version}", Exec::class.java) {
        group = "Minecraft"
        description = "Build Minecraft Forge server v${serverConfig.version} image (forge v${serverConfig.forgeVersion})"
        dependsOn("setupDockerBuilder")

        if (serverConfig.latest) {
            buildCmd += " -t $latestTag"
        }

        if (loadImages == "true") {
            buildCmd += " --load"
        }

        commandLine = "$buildCmd .".split(" ")
    }

    tasks.register("pushForge${serverConfig.version}", Exec::class.java) {
        group = "Minecraft"
        description = "Push Minecraft Forge server v${serverConfig.version} image"
        dependsOn("dockerLogin")
        dependsOn("setupDockerBuilder")

        if (serverConfig.latest) {
            buildCmd += " -t $latestTag"
        }
        commandLine = "$buildCmd --push .".split(" ")
    }
}

fabricVersions.forEachIndexed { index, serverConfig ->
    var buildCmd = "docker buildx build --builder $dockerBuilder " +
            "--platform=linux/amd64,linux/arm64 " +
            "--file fabric/Dockerfile " +
            "--build-arg mc_version=${serverConfig.version} " +
            "--build-arg fabric_version=${serverConfig.fabricVersion} " +
            "--build-arg fabric_installer_version=${serverConfig.fabricInstallerVersion} " +
            "--build-arg java_version=${serverConfig.javaVersion} " +
            "-t ${qname}:fabric-${serverConfig.version}"

    tasks.register("buildFabric${serverConfig.version}", Exec::class.java) {
        group = "Minecraft"
        description = "Build Minecraft Fabric server v${serverConfig.version} image (fabric v${serverConfig.fabricVersion})"
        dependsOn("setupDockerBuilder")

        if (serverConfig.latest) {
            buildCmd += " -t $latestTag"
        }
        commandLine = "$buildCmd .".split(" ")
    }

    tasks.register("pushFabric${serverConfig.version}", Exec::class.java) {
        group = "Minecraft"
        description = "Push Minecraft Fabric server v${serverConfig.version} image"
        dependsOn("dockerLogin")
        dependsOn("setupDockerBuilder")

        if (serverConfig.latest) {
            buildCmd += " -t $latestTag"
        }
        commandLine = "$buildCmd --push .".split(" ")
    }
}

tasks.register("setupBuild") {
    val config = TaskMatrix()
    val taskList = tasks.matching { task -> task.name.startsWith("build") && !task.name.contains("buildEnvironment") }
    taskList.forEach { task ->
        config.include.add(Include(task.name))
    }
    val data = Utils.convertToJson(config)
    val buildJson = File("$projectDir/output.json")
    buildJson.writeText(data)
}

tasks.register("setupPush") {
    val config = TaskMatrix()
    val taskList = tasks.matching { task -> task.name.startsWith("push") }
    taskList.forEach { task ->
        config.include.add(Include(task.name))
    }
    val data = Utils.convertToJson(config)
    val buildJson = File("$projectDir/output.json")
    buildJson.writeText(data)
}