package com.fussionlabs

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory
import com.fasterxml.jackson.module.kotlin.registerKotlinModule
import com.fussionlabs.data.Config
import com.fussionlabs.data.ServerConfig
import java.io.File

object Utils {
    val mapper = ObjectMapper(YAMLFactory()).registerKotlinModule()

    fun readConfig(file: File): List<ServerConfig> {
        val config: Config = mapper.readValue(file, Config::class.java)
        return config.serverList
    }
}