include(CheckIPOSupported)

add_library(
    common_opt
    INTERFACE
)

if (CMAKE_C_COMPILER_ID STREQUAL "GNU")
# not consider clang, for now
    target_compile_options(
        common_opt
        INTERFACE
        # warning
        -Wall
        -Wextra
        -Wconversion
        -Wpedantic
        -Wformat
        -Werror=format-security
        # message
        -fmessage-length=0
        -fdiagnostics-color=always
        # safety
        $<$<CONFIG:Release>:-Wp,-D_FORTIFY_SOURCE=2>
        -fstack-protector-strong
        -fstack-clash-protection
        -fexceptions
        -fasynchronous-unwind-tables
        # output
        -fno-common
        -fno-plt
        # misc
        -pipe
        # sanitizer
        $<$<CONFIG:Debug>:-fsanitize=address,undefined>
        $<$<CONFIG:Debug>:-fno-omit-frame-pointer>
        $<$<CONFIG:Debug>:-O1>
    )
    target_link_options(
        common_opt
        INTERFACE
        $<$<CONFIG:Debug>:-fsanitize=address,undefined>
        -Wl,-O1,--as-needed,-z,relro,-z,now,-z,noexecstack
    )
endif()

# compiler must support LTO
check_ipo_supported()
