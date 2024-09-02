package com.fussionlabs.data

data class TaskMatrix(
    val include: MutableList<Include> = mutableListOf()
)

data class Include(
    val task: String
)