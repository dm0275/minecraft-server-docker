package com.fussionlabs.data

data class Config(
    val serverList: List<ServerConfig>
){}

data class ServerConfig(
    val javaVersion: String,
    val version: String,
    val latest: Boolean = false,
    val url: String = "",
    val forgeVersion: String = ""
){}

