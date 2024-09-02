plugins {
    id("org.jetbrains.kotlin.jvm") version "1.7.22"
}

repositories {
    mavenLocal()
    mavenCentral()
    gradlePluginPortal()
}

dependencies {
//    implementation("org.yaml:snakeyaml:2.3")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin:2.14.3") // Check for the latest version
    implementation("com.fasterxml.jackson.dataformat:jackson-dataformat-yaml:2.14.3") // Check for the latest version
}