set(SOURCE_FILES
    blockmap.c
    bsp.c
    endian.c
    funcs.c
    level.c
    makenode.c
    picknode.c)

add_executable(bsp ${SOURCE_FILES})
target_link_libraries(bsp m)
