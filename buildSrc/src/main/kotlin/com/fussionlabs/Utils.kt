package com.fussionlabs

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory
import com.fasterxml.jackson.module.kotlin.registerKotlinModule
import com.fussionlabs.data.Config
import com.fussionlabs.data.ServerConfig
import com.fussionlabs.data.TaskMatrix
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import java.io.File

object Utils {
    var gson: Gson = GsonBuilder().create()
    val mapper = ObjectMapper(YAMLFactory()).registerKotlinModule()

    fun readConfig(file: File): List<ServerConfig> {
        val config: Config = mapper.readValue(file, Config::class.java)
        return config.serverList
    }

    fun convertToJson(value: Any): String {
        return gson.toJson(value, TaskMatrix::class.java)
    }
}