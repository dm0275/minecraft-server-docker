plugins {
    id("org.jetbrains.kotlin.jvm") version "1.7.22"
}

repositories {
    mavenLocal()
    mavenCentral()
    gradlePluginPortal()
}

dependencies {
    implementation("com.google.code.gson:gson:2.8.6")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin:2.14.3") // Check for the latest version
    implementation("com.fasterxml.jackson.dataformat:jackson-dataformat-yaml:2.14.3") // Check for the latest version
}