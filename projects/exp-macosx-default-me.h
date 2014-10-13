/*
    me.h -- MakeMe Configuration Header for macosx-x64-default

    This header is created by Me during configuration. To change settings, re-run
    configure or define variables in your Makefile to override these default values.
 */

/* Settings */
#ifndef ME_AUTHOR
    #define ME_AUTHOR "Embedthis Software"
#endif
#ifndef ME_COMPANY
    #define ME_COMPANY "embedthis"
#endif
#ifndef ME_COMPATIBLE
    #define ME_COMPATIBLE "0.4"
#endif
#ifndef ME_COMPILER_HAS_ATOMIC
    #define ME_COMPILER_HAS_ATOMIC 1
#endif
#ifndef ME_COMPILER_HAS_ATOMIC64
    #define ME_COMPILER_HAS_ATOMIC64 1
#endif
#ifndef ME_COMPILER_HAS_DOUBLE_BRACES
    #define ME_COMPILER_HAS_DOUBLE_BRACES 1
#endif
#ifndef ME_COMPILER_HAS_DYN_LOAD
    #define ME_COMPILER_HAS_DYN_LOAD 1
#endif
#ifndef ME_COMPILER_HAS_LIB_EDIT
    #define ME_COMPILER_HAS_LIB_EDIT 1
#endif
#ifndef ME_COMPILER_HAS_LIB_RT
    #define ME_COMPILER_HAS_LIB_RT 0
#endif
#ifndef ME_COMPILER_HAS_MMU
    #define ME_COMPILER_HAS_MMU 1
#endif
#ifndef ME_COMPILER_HAS_MTUNE
    #define ME_COMPILER_HAS_MTUNE 1
#endif
#ifndef ME_COMPILER_HAS_PAM
    #define ME_COMPILER_HAS_PAM 1
#endif
#ifndef ME_COMPILER_HAS_STACK_PROTECTOR
    #define ME_COMPILER_HAS_STACK_PROTECTOR 1
#endif
#ifndef ME_COMPILER_HAS_SYNC
    #define ME_COMPILER_HAS_SYNC 1
#endif
#ifndef ME_COMPILER_HAS_SYNC64
    #define ME_COMPILER_HAS_SYNC64 1
#endif
#ifndef ME_COMPILER_HAS_SYNC_CAS
    #define ME_COMPILER_HAS_SYNC_CAS 1
#endif
#ifndef ME_COMPILER_HAS_UNNAMED_UNIONS
    #define ME_COMPILER_HAS_UNNAMED_UNIONS 1
#endif
#ifndef ME_COMPILER_WARN64TO32
    #define ME_COMPILER_WARN64TO32 1
#endif
#ifndef ME_COMPILER_WARN_UNUSED
    #define ME_COMPILER_WARN_UNUSED 1
#endif
#ifndef ME_DEBUG
    #define ME_DEBUG 1
#endif
#ifndef ME_DEPTH
    #define ME_DEPTH 1
#endif
#ifndef ME_DESCRIPTION
    #define ME_DESCRIPTION "Embedthis Expansive"
#endif
#ifndef ME_EJS_DB
    #define ME_EJS_DB 1
#endif
#ifndef ME_EJS_MAIL
    #define ME_EJS_MAIL 1
#endif
#ifndef ME_EJS_MAPPER
    #define ME_EJS_MAPPER 1
#endif
#ifndef ME_EJS_SHELL
    #define ME_EJS_SHELL 1
#endif
#ifndef ME_EJS_TAR
    #define ME_EJS_TAR 1
#endif
#ifndef ME_EJS_TEMPLATE
    #define ME_EJS_TEMPLATE 1
#endif
#ifndef ME_EJS_WEB
    #define ME_EJS_WEB 1
#endif
#ifndef ME_EJS_ZLIB
    #define ME_EJS_ZLIB 1
#endif
#ifndef ME_EJS_ONE_MODULE
    #define ME_EJS_ONE_MODULE 1
#endif
#ifndef ME_EST_CAMELLIA
    #define ME_EST_CAMELLIA 0
#endif
#ifndef ME_EST_DES
    #define ME_EST_DES 0
#endif
#ifndef ME_EST_GEN_PRIME
    #define ME_EST_GEN_PRIME 0
#endif
#ifndef ME_EST_PADLOCK
    #define ME_EST_PADLOCK 0
#endif
#ifndef ME_EST_ROM_TABLES
    #define ME_EST_ROM_TABLES 0
#endif
#ifndef ME_EST_SSL_CLIENT
    #define ME_EST_SSL_CLIENT 0
#endif
#ifndef ME_EST_TEST_CERTS
    #define ME_EST_TEST_CERTS 0
#endif
#ifndef ME_EST_XTEA
    #define ME_EST_XTEA 0
#endif
#ifndef ME_HTTP_PAM
    #define ME_HTTP_PAM 0
#endif
#ifndef ME_MANIFEST
    #define ME_MANIFEST "package/manifest.me"
#endif
#ifndef ME_MPR_LOGGING
    #define ME_MPR_LOGGING 1
#endif
#ifndef ME_NAME
    #define ME_NAME "exp"
#endif
#ifndef ME_PLATFORMS
    #define ME_PLATFORMS "local"
#endif
#ifndef ME_PREFIXES
    #define ME_PREFIXES "package-prefixes"
#endif
#ifndef ME_STATIC
    #define ME_STATIC 0
#endif
#ifndef ME_TITLE
    #define ME_TITLE "Embedthis Expansive"
#endif
#ifndef ME_TUNE
    #define ME_TUNE "speed"
#endif
#ifndef ME_VERSION
    #define ME_VERSION "0.4.1"
#endif

/* Prefixes */
#ifndef ME_ROOT_PREFIX
    #define ME_ROOT_PREFIX "/"
#endif
#ifndef ME_BASE_PREFIX
    #define ME_BASE_PREFIX "${prefixes.root}/usr/local"
#endif
#ifndef ME_DATA_PREFIX
    #define ME_DATA_PREFIX "${prefixes.root}"
#endif
#ifndef ME_STATE_PREFIX
    #define ME_STATE_PREFIX "${prefixes.root}/var"
#endif
#ifndef ME_APP_PREFIX
    #define ME_APP_PREFIX "${prefixes.base}/lib/exp"
#endif
#ifndef ME_VAPP_PREFIX
    #define ME_VAPP_PREFIX "${prefixes.app}/0.4.1"
#endif
#ifndef ME_BIN_PREFIX
    #define ME_BIN_PREFIX "${prefixes.base}/bin"
#endif
#ifndef ME_INC_PREFIX
    #define ME_INC_PREFIX "${prefixes.base}/include"
#endif
#ifndef ME_LIB_PREFIX
    #define ME_LIB_PREFIX "${prefixes.base}/lib"
#endif
#ifndef ME_MAN_PREFIX
    #define ME_MAN_PREFIX "${prefixes.base}/share/man"
#endif
#ifndef ME_SBIN_PREFIX
    #define ME_SBIN_PREFIX "${prefixes.base}/sbin"
#endif
#ifndef ME_ETC_PREFIX
    #define ME_ETC_PREFIX "${prefixes.data}/etc/exp"
#endif
#ifndef ME_WEB_PREFIX
    #define ME_WEB_PREFIX "${prefixes.state}/www/exp-default"
#endif
#ifndef ME_LOG_PREFIX
    #define ME_LOG_PREFIX "${prefixes.state}/log/exp"
#endif
#ifndef ME_SPOOL_PREFIX
    #define ME_SPOOL_PREFIX "${prefixes.state}/spool/exp"
#endif
#ifndef ME_CACHE_PREFIX
    #define ME_CACHE_PREFIX "${prefixes.state}/spool/exp/cache"
#endif
#ifndef ME_SRC_PREFIX
    #define ME_SRC_PREFIX "exp-0.4.1"
#endif

/* Suffixes */
#ifndef ME_EXE
    #define ME_EXE ""
#endif
#ifndef ME_SHLIB
    #define ME_SHLIB ".dylib"
#endif
#ifndef ME_SHOBJ
    #define ME_SHOBJ ".dylib"
#endif
#ifndef ME_LIB
    #define ME_LIB ".a"
#endif
#ifndef ME_OBJ
    #define ME_OBJ ".o"
#endif

/* Profile */
#ifndef ME_CONFIG_CMD
    #define ME_CONFIG_CMD "me -d -q -platform macosx-x64-default -configure . --with est -gen xcode"
#endif
#ifndef ME_EXP_PRODUCT
    #define ME_EXP_PRODUCT 1
#endif
#ifndef ME_PROFILE
    #define ME_PROFILE "default"
#endif
#ifndef ME_TUNE_SPEED
    #define ME_TUNE_SPEED 1
#endif

/* Miscellaneous */
#ifndef ME_MAJOR_VERSION
    #define ME_MAJOR_VERSION 0
#endif
#ifndef ME_MINOR_VERSION
    #define ME_MINOR_VERSION 4
#endif
#ifndef ME_PATCH_VERSION
    #define ME_PATCH_VERSION 1
#endif
#ifndef ME_VNUM
    #define ME_VNUM 40001
#endif

/* Components */
#ifndef ME_COM_CC
    #define ME_COM_CC 1
#endif
#ifndef ME_COM_EJS
    #define ME_COM_EJS 1
#endif
#ifndef ME_COM_EST
    #define ME_COM_EST 1
#endif
#ifndef ME_COM_HTTP
    #define ME_COM_HTTP 1
#endif
#ifndef ME_COM_LIB
    #define ME_COM_LIB 1
#endif
#ifndef ME_COM_MPR
    #define ME_COM_MPR 1
#endif
#ifndef ME_COM_OPENSSL
    #define ME_COM_OPENSSL 0
#endif
#ifndef ME_COM_OSDEP
    #define ME_COM_OSDEP 1
#endif
#ifndef ME_COM_PCRE
    #define ME_COM_PCRE 1
#endif
#ifndef ME_COM_SQLITE
    #define ME_COM_SQLITE 0
#endif
#ifndef ME_COM_SSL
    #define ME_COM_SSL 1
#endif
#ifndef ME_COM_VXWORKS
    #define ME_COM_VXWORKS 0
#endif
#ifndef ME_COM_WINSDK
    #define ME_COM_WINSDK 1
#endif
#ifndef ME_COM_ZLIB
    #define ME_COM_ZLIB 1
#endif
