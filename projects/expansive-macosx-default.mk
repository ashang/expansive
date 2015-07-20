#
#   expansive-macosx-default.mk -- Makefile to build Embedthis Expansive for macosx
#

NAME                  := expansive
VERSION               := 0.5.5
PROFILE               ?= default
ARCH                  ?= $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
CC_ARCH               ?= $(shell echo $(ARCH) | sed 's/x86/i686/;s/x64/x86_64/')
OS                    ?= macosx
CC                    ?= clang
CONFIG                ?= $(OS)-$(ARCH)-$(PROFILE)
BUILD                 ?= build/$(CONFIG)
LBIN                  ?= $(BUILD)/bin
PATH                  := $(LBIN):$(PATH)

ME_COM_COMPILER       ?= 1
ME_COM_EJSCRIPT       ?= 1
ME_COM_HTTP           ?= 1
ME_COM_LIB            ?= 1
ME_COM_MATRIXSSL      ?= 0
ME_COM_MBEDTLS        ?= 1
ME_COM_MPR            ?= 1
ME_COM_NANOSSL        ?= 0
ME_COM_OPENSSL        ?= 0
ME_COM_OSDEP          ?= 1
ME_COM_PCRE           ?= 1
ME_COM_SQLITE         ?= 0
ME_COM_SSL            ?= 1
ME_COM_VXWORKS        ?= 0
ME_COM_WINSDK         ?= 1
ME_COM_ZLIB           ?= 1

ME_COM_OPENSSL_PATH   ?= "/usr/lib"

ifeq ($(ME_COM_LIB),1)
    ME_COM_COMPILER := 1
endif
ifeq ($(ME_COM_MBEDTLS),1)
    ME_COM_SSL := 1
endif
ifeq ($(ME_COM_OPENSSL),1)
    ME_COM_SSL := 1
endif
ifeq ($(ME_COM_EJSCRIPT),1)
    ME_COM_ZLIB := 1
endif

CFLAGS                += -g -w
DFLAGS                +=  $(patsubst %,-D%,$(filter ME_%,$(MAKEFLAGS))) -DME_COM_COMPILER=$(ME_COM_COMPILER) -DME_COM_EJSCRIPT=$(ME_COM_EJSCRIPT) -DME_COM_HTTP=$(ME_COM_HTTP) -DME_COM_LIB=$(ME_COM_LIB) -DME_COM_MATRIXSSL=$(ME_COM_MATRIXSSL) -DME_COM_MBEDTLS=$(ME_COM_MBEDTLS) -DME_COM_MPR=$(ME_COM_MPR) -DME_COM_NANOSSL=$(ME_COM_NANOSSL) -DME_COM_OPENSSL=$(ME_COM_OPENSSL) -DME_COM_OSDEP=$(ME_COM_OSDEP) -DME_COM_PCRE=$(ME_COM_PCRE) -DME_COM_SQLITE=$(ME_COM_SQLITE) -DME_COM_SSL=$(ME_COM_SSL) -DME_COM_VXWORKS=$(ME_COM_VXWORKS) -DME_COM_WINSDK=$(ME_COM_WINSDK) -DME_COM_ZLIB=$(ME_COM_ZLIB) 
IFLAGS                += "-I$(BUILD)/inc"
LDFLAGS               += '-Wl,-rpath,@executable_path/' '-Wl,-rpath,@loader_path/'
LIBPATHS              += -L$(BUILD)/bin
LIBS                  += -ldl -lpthread -lm

DEBUG                 ?= debug
CFLAGS-debug          ?= -g
DFLAGS-debug          ?= -DME_DEBUG
LDFLAGS-debug         ?= -g
DFLAGS-release        ?= 
CFLAGS-release        ?= -O2
LDFLAGS-release       ?= 
CFLAGS                += $(CFLAGS-$(DEBUG))
DFLAGS                += $(DFLAGS-$(DEBUG))
LDFLAGS               += $(LDFLAGS-$(DEBUG))

ME_ROOT_PREFIX        ?= 
ME_BASE_PREFIX        ?= $(ME_ROOT_PREFIX)/usr/local
ME_DATA_PREFIX        ?= $(ME_ROOT_PREFIX)/
ME_STATE_PREFIX       ?= $(ME_ROOT_PREFIX)/var
ME_APP_PREFIX         ?= $(ME_BASE_PREFIX)/lib/$(NAME)
ME_VAPP_PREFIX        ?= $(ME_APP_PREFIX)/$(VERSION)
ME_BIN_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/bin
ME_INC_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/include
ME_LIB_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/lib
ME_MAN_PREFIX         ?= $(ME_ROOT_PREFIX)/usr/local/share/man
ME_SBIN_PREFIX        ?= $(ME_ROOT_PREFIX)/usr/local/sbin
ME_ETC_PREFIX         ?= $(ME_ROOT_PREFIX)/etc/$(NAME)
ME_WEB_PREFIX         ?= $(ME_ROOT_PREFIX)/var/www/$(NAME)
ME_LOG_PREFIX         ?= $(ME_ROOT_PREFIX)/var/log/$(NAME)
ME_SPOOL_PREFIX       ?= $(ME_ROOT_PREFIX)/var/spool/$(NAME)
ME_CACHE_PREFIX       ?= $(ME_ROOT_PREFIX)/var/spool/$(NAME)/cache
ME_SRC_PREFIX         ?= $(ME_ROOT_PREFIX)$(NAME)-$(VERSION)


ifeq ($(ME_COM_EJSCRIPT),1)
    TARGETS           += $(BUILD)/bin/ejs.mod
endif
TARGETS               += $(BUILD)/bin/expansive
TARGETS               += $(BUILD)/.install-certs-modified
TARGETS               += $(BUILD)/bin/sample.json

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(ME_APP_PREFIX)" = "" ] ; then echo WARNING: ME_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(BUILD)/bin ] && mkdir -p $(BUILD)/bin; true
	@[ ! -x $(BUILD)/inc ] && mkdir -p $(BUILD)/inc; true
	@[ ! -x $(BUILD)/obj ] && mkdir -p $(BUILD)/obj; true
	@[ ! -f $(BUILD)/inc/me.h ] && cp projects/expansive-macosx-default-me.h $(BUILD)/inc/me.h ; true
	@if ! diff $(BUILD)/inc/me.h projects/expansive-macosx-default-me.h >/dev/null ; then\
		cp projects/expansive-macosx-default-me.h $(BUILD)/inc/me.h  ; \
	fi; true
	@if [ -f "$(BUILD)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != "`cat $(BUILD)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build" ; \
			echo "   [Warning] Previous build command: "`cat $(BUILD)/.makeflags`"" ; \
		fi ; \
	fi
	@echo "$(MAKEFLAGS)" >$(BUILD)/.makeflags

clean:
	rm -f "$(BUILD)/obj/ejs.o"
	rm -f "$(BUILD)/obj/ejsLib.o"
	rm -f "$(BUILD)/obj/ejsc.o"
	rm -f "$(BUILD)/obj/expParser.o"
	rm -f "$(BUILD)/obj/expansive.o"
	rm -f "$(BUILD)/obj/http.o"
	rm -f "$(BUILD)/obj/httpLib.o"
	rm -f "$(BUILD)/obj/mbedtls.o"
	rm -f "$(BUILD)/obj/mbedtlsLib.o"
	rm -f "$(BUILD)/obj/mprLib.o"
	rm -f "$(BUILD)/obj/openssl.o"
	rm -f "$(BUILD)/obj/pcre.o"
	rm -f "$(BUILD)/obj/zlib.o"
	rm -f "$(BUILD)/bin/expansive-ejsc"
	rm -f "$(BUILD)/bin/expansive"
	rm -f "$(BUILD)/.install-certs-modified"
	rm -f "$(BUILD)/bin/libejs.dylib"
	rm -f "$(BUILD)/bin/libhttp.dylib"
	rm -f "$(BUILD)/bin/libmbedtls.a"
	rm -f "$(BUILD)/bin/libmpr.dylib"
	rm -f "$(BUILD)/bin/libpcre.dylib"
	rm -f "$(BUILD)/bin/libzlib.dylib"
	rm -f "$(BUILD)/bin/libmpr-mbedtls.a"
	rm -f "$(BUILD)/bin/sample.json"

clobber: clean
	rm -fr ./$(BUILD)

#
#   me.h
#

$(BUILD)/inc/me.h: $(DEPS_1)

#
#   osdep.h
#
DEPS_2 += src/osdep/osdep.h
DEPS_2 += $(BUILD)/inc/me.h

$(BUILD)/inc/osdep.h: $(DEPS_2)
	@echo '      [Copy] $(BUILD)/inc/osdep.h'
	mkdir -p "$(BUILD)/inc"
	cp src/osdep/osdep.h $(BUILD)/inc/osdep.h

#
#   mpr.h
#
DEPS_3 += src/mpr/mpr.h
DEPS_3 += $(BUILD)/inc/me.h
DEPS_3 += $(BUILD)/inc/osdep.h

$(BUILD)/inc/mpr.h: $(DEPS_3)
	@echo '      [Copy] $(BUILD)/inc/mpr.h'
	mkdir -p "$(BUILD)/inc"
	cp src/mpr/mpr.h $(BUILD)/inc/mpr.h

#
#   http.h
#
DEPS_4 += src/http/http.h
DEPS_4 += $(BUILD)/inc/mpr.h

$(BUILD)/inc/http.h: $(DEPS_4)
	@echo '      [Copy] $(BUILD)/inc/http.h'
	mkdir -p "$(BUILD)/inc"
	cp src/http/http.h $(BUILD)/inc/http.h

#
#   ejs.slots.h
#

src/ejscript/ejs.slots.h: $(DEPS_5)

#
#   pcre.h
#
DEPS_6 += src/pcre/pcre.h

$(BUILD)/inc/pcre.h: $(DEPS_6)
	@echo '      [Copy] $(BUILD)/inc/pcre.h'
	mkdir -p "$(BUILD)/inc"
	cp src/pcre/pcre.h $(BUILD)/inc/pcre.h

#
#   zlib.h
#
DEPS_7 += src/zlib/zlib.h
DEPS_7 += $(BUILD)/inc/me.h

$(BUILD)/inc/zlib.h: $(DEPS_7)
	@echo '      [Copy] $(BUILD)/inc/zlib.h'
	mkdir -p "$(BUILD)/inc"
	cp src/zlib/zlib.h $(BUILD)/inc/zlib.h

#
#   ejs.h
#
DEPS_8 += src/ejscript/ejs.h
DEPS_8 += $(BUILD)/inc/me.h
DEPS_8 += $(BUILD)/inc/osdep.h
DEPS_8 += $(BUILD)/inc/mpr.h
DEPS_8 += $(BUILD)/inc/http.h
DEPS_8 += src/ejscript/ejs.slots.h
DEPS_8 += $(BUILD)/inc/pcre.h
DEPS_8 += $(BUILD)/inc/zlib.h

$(BUILD)/inc/ejs.h: $(DEPS_8)
	@echo '      [Copy] $(BUILD)/inc/ejs.h'
	mkdir -p "$(BUILD)/inc"
	cp src/ejscript/ejs.h $(BUILD)/inc/ejs.h

#
#   ejs.slots.h
#
DEPS_9 += src/ejscript/ejs.slots.h

$(BUILD)/inc/ejs.slots.h: $(DEPS_9)
	@echo '      [Copy] $(BUILD)/inc/ejs.slots.h'
	mkdir -p "$(BUILD)/inc"
	cp src/ejscript/ejs.slots.h $(BUILD)/inc/ejs.slots.h

#
#   ejsByteGoto.h
#
DEPS_10 += src/ejscript/ejsByteGoto.h

$(BUILD)/inc/ejsByteGoto.h: $(DEPS_10)
	@echo '      [Copy] $(BUILD)/inc/ejsByteGoto.h'
	mkdir -p "$(BUILD)/inc"
	cp src/ejscript/ejsByteGoto.h $(BUILD)/inc/ejsByteGoto.h

#
#   expansive.h
#

$(BUILD)/inc/expansive.h: $(DEPS_11)

#
#   mbedtls.h
#
DEPS_12 += src/mbedtls/mbedtls.h

$(BUILD)/inc/mbedtls.h: $(DEPS_12)
	@echo '      [Copy] $(BUILD)/inc/mbedtls.h'
	mkdir -p "$(BUILD)/inc"
	cp src/mbedtls/mbedtls.h $(BUILD)/inc/mbedtls.h

#
#   ejs.h
#

src/ejscript/ejs.h: $(DEPS_13)

#
#   ejs.o
#
DEPS_14 += src/ejscript/ejs.h

$(BUILD)/obj/ejs.o: \
    src/ejscript/ejs.c $(DEPS_14)
	@echo '   [Compile] $(BUILD)/obj/ejs.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/ejs.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/ejscript/ejs.c

#
#   ejsLib.o
#
DEPS_15 += src/ejscript/ejs.h
DEPS_15 += $(BUILD)/inc/mpr.h
DEPS_15 += $(BUILD)/inc/pcre.h
DEPS_15 += $(BUILD)/inc/me.h

$(BUILD)/obj/ejsLib.o: \
    src/ejscript/ejsLib.c $(DEPS_15)
	@echo '   [Compile] $(BUILD)/obj/ejsLib.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/ejsLib.o -arch $(CC_ARCH) $(CFLAGS) -D_FILE_OFFSET_BITS=64 $(IFLAGS) src/ejscript/ejsLib.c

#
#   ejsc.o
#
DEPS_16 += src/ejscript/ejs.h

$(BUILD)/obj/ejsc.o: \
    src/ejscript/ejsc.c $(DEPS_16)
	@echo '   [Compile] $(BUILD)/obj/ejsc.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/ejsc.o -arch $(CC_ARCH) $(CFLAGS) -D_FILE_OFFSET_BITS=64 $(IFLAGS) src/ejscript/ejsc.c

#
#   expParser.o
#
DEPS_17 += $(BUILD)/inc/ejs.h
DEPS_17 += $(BUILD)/inc/expansive.h

$(BUILD)/obj/expParser.o: \
    src/expParser.c $(DEPS_17)
	@echo '   [Compile] $(BUILD)/obj/expParser.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/expParser.o -arch $(CC_ARCH) $(CFLAGS) -D_FILE_OFFSET_BITS=64 $(IFLAGS) src/expParser.c

#
#   expansive.o
#
DEPS_18 += $(BUILD)/inc/ejs.h
DEPS_18 += $(BUILD)/inc/expansive.h

$(BUILD)/obj/expansive.o: \
    src/expansive.c $(DEPS_18)
	@echo '   [Compile] $(BUILD)/obj/expansive.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/expansive.o -arch $(CC_ARCH) $(CFLAGS) -D_FILE_OFFSET_BITS=64 $(IFLAGS) src/expansive.c

#
#   http.h
#

src/http/http.h: $(DEPS_19)

#
#   http.o
#
DEPS_20 += src/http/http.h

$(BUILD)/obj/http.o: \
    src/http/http.c $(DEPS_20)
	@echo '   [Compile] $(BUILD)/obj/http.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/http.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/http/http.c

#
#   httpLib.o
#
DEPS_21 += src/http/http.h
DEPS_21 += $(BUILD)/inc/pcre.h

$(BUILD)/obj/httpLib.o: \
    src/http/httpLib.c $(DEPS_21)
	@echo '   [Compile] $(BUILD)/obj/httpLib.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/httpLib.o -arch $(CC_ARCH) $(CFLAGS) -D_FILE_OFFSET_BITS=64 $(IFLAGS) src/http/httpLib.c

#
#   mbedtls.o
#
DEPS_22 += $(BUILD)/inc/mpr.h

$(BUILD)/obj/mbedtls.o: \
    src/mpr-mbedtls/mbedtls.c $(DEPS_22)
	@echo '   [Compile] $(BUILD)/obj/mbedtls.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/mbedtls.o -arch $(CC_ARCH) $(CFLAGS) -D_FILE_OFFSET_BITS=64 $(IFLAGS) src/mpr-mbedtls/mbedtls.c

#
#   mbedtls.h
#

src/mbedtls/mbedtls.h: $(DEPS_23)

#
#   mbedtlsLib.o
#
DEPS_24 += src/mbedtls/mbedtls.h

$(BUILD)/obj/mbedtlsLib.o: \
    src/mbedtls/mbedtlsLib.c $(DEPS_24)
	@echo '   [Compile] $(BUILD)/obj/mbedtlsLib.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/mbedtlsLib.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/mbedtls/mbedtlsLib.c

#
#   mpr.h
#

src/mpr/mpr.h: $(DEPS_25)

#
#   mprLib.o
#
DEPS_26 += src/mpr/mpr.h

$(BUILD)/obj/mprLib.o: \
    src/mpr/mprLib.c $(DEPS_26)
	@echo '   [Compile] $(BUILD)/obj/mprLib.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/mprLib.o -arch $(CC_ARCH) $(CFLAGS) -D_FILE_OFFSET_BITS=64 $(IFLAGS) src/mpr/mprLib.c

#
#   openssl.o
#
DEPS_27 += $(BUILD)/inc/mpr.h

$(BUILD)/obj/openssl.o: \
    src/mpr-openssl/openssl.c $(DEPS_27)
	@echo '   [Compile] $(BUILD)/obj/openssl.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/openssl.o -arch $(CC_ARCH) $(CFLAGS) -DME_COM_OPENSSL_PATH=$(ME_COM_OPENSSL_PATH) $(IFLAGS) "-I$(ME_COM_OPENSSL_PATH)/include" src/mpr-openssl/openssl.c

#
#   pcre.h
#

src/pcre/pcre.h: $(DEPS_28)

#
#   pcre.o
#
DEPS_29 += $(BUILD)/inc/me.h
DEPS_29 += src/pcre/pcre.h

$(BUILD)/obj/pcre.o: \
    src/pcre/pcre.c $(DEPS_29)
	@echo '   [Compile] $(BUILD)/obj/pcre.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/pcre.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/pcre/pcre.c

#
#   zlib.h
#

src/zlib/zlib.h: $(DEPS_30)

#
#   zlib.o
#
DEPS_31 += $(BUILD)/inc/me.h
DEPS_31 += src/zlib/zlib.h

$(BUILD)/obj/zlib.o: \
    src/zlib/zlib.c $(DEPS_31)
	@echo '   [Compile] $(BUILD)/obj/zlib.o'
	$(CC) -c $(DFLAGS) -o $(BUILD)/obj/zlib.o -arch $(CC_ARCH) $(CFLAGS) $(IFLAGS) src/zlib/zlib.c

ifeq ($(ME_COM_MBEDTLS),1)
#
#   libmbedtls
#
DEPS_32 += $(BUILD)/inc/osdep.h
DEPS_32 += $(BUILD)/inc/mbedtls.h
DEPS_32 += $(BUILD)/obj/mbedtlsLib.o

$(BUILD)/bin/libmbedtls.a: $(DEPS_32)
	@echo '      [Link] $(BUILD)/bin/libmbedtls.a'
	ar -cr $(BUILD)/bin/libmbedtls.a "$(BUILD)/obj/mbedtlsLib.o"
endif

ifeq ($(ME_COM_SSL),1)
ifeq ($(ME_COM_MBEDTLS),1)
#
#   mbedtls
#
ifeq ($(ME_COM_MBEDTLS),1)
    DEPS_33 += $(BUILD)/bin/libmbedtls.a
endif
DEPS_33 += $(BUILD)/obj/mbedtls.o

$(BUILD)/bin/libmpr-mbedtls.a: $(DEPS_33)
	@echo '      [Link] $(BUILD)/bin/libmpr-mbedtls.a'
	ar -cr $(BUILD)/bin/libmpr-mbedtls.a "$(BUILD)/obj/mbedtls.o"
endif
endif

ifeq ($(ME_COM_SSL),1)
ifeq ($(ME_COM_OPENSSL),1)
#
#   openssl
#
DEPS_34 += $(BUILD)/obj/openssl.o

$(BUILD)/bin/libmpr-openssl.a: $(DEPS_34)
	@echo '      [Link] $(BUILD)/bin/libmpr-openssl.a'
	ar -cr $(BUILD)/bin/libmpr-openssl.a "$(BUILD)/obj/openssl.o"
endif
endif

#
#   libmpr
#
DEPS_35 += $(BUILD)/inc/osdep.h
ifeq ($(ME_COM_SSL),1)
ifeq ($(ME_COM_MBEDTLS),1)
    DEPS_35 += $(BUILD)/bin/libmpr-mbedtls.a
endif
endif
ifeq ($(ME_COM_SSL),1)
ifeq ($(ME_COM_OPENSSL),1)
    DEPS_35 += $(BUILD)/bin/libmpr-openssl.a
endif
endif
DEPS_35 += $(BUILD)/inc/mpr.h
DEPS_35 += $(BUILD)/obj/mprLib.o

ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_35 += -lmbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_35 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_35 += -lmbedtls
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_35 += -lmpr-openssl
    LIBPATHS_35 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_OPENSSL),1)
ifeq ($(ME_COM_SSL),1)
    LIBS_35 += -lssl
    LIBPATHS_35 += -L"$(ME_COM_OPENSSL_PATH)"
endif
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_35 += -lcrypto
    LIBPATHS_35 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_35 += -lmpr-mbedtls
endif

$(BUILD)/bin/libmpr.dylib: $(DEPS_35)
	@echo '      [Link] $(BUILD)/bin/libmpr.dylib'
	$(CC) -dynamiclib -o $(BUILD)/bin/libmpr.dylib -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) -install_name @rpath/libmpr.dylib -compatibility_version 0.5 -current_version 0.5 "$(BUILD)/obj/mprLib.o" $(LIBPATHS_35) $(LIBS_35) $(LIBS_35) $(LIBS) 

ifeq ($(ME_COM_PCRE),1)
#
#   libpcre
#
DEPS_36 += $(BUILD)/inc/pcre.h
DEPS_36 += $(BUILD)/obj/pcre.o

$(BUILD)/bin/libpcre.dylib: $(DEPS_36)
	@echo '      [Link] $(BUILD)/bin/libpcre.dylib'
	$(CC) -dynamiclib -o $(BUILD)/bin/libpcre.dylib -arch $(CC_ARCH) $(LDFLAGS) -compatibility_version 0.5 -current_version 0.5 $(LIBPATHS) -install_name @rpath/libpcre.dylib -compatibility_version 0.5 -current_version 0.5 "$(BUILD)/obj/pcre.o" $(LIBS) 
endif

ifeq ($(ME_COM_HTTP),1)
#
#   libhttp
#
DEPS_37 += $(BUILD)/bin/libmpr.dylib
ifeq ($(ME_COM_PCRE),1)
    DEPS_37 += $(BUILD)/bin/libpcre.dylib
endif
DEPS_37 += $(BUILD)/inc/http.h
DEPS_37 += $(BUILD)/obj/httpLib.o

ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_37 += -lmbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_37 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_37 += -lmbedtls
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_37 += -lmpr-openssl
    LIBPATHS_37 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_OPENSSL),1)
ifeq ($(ME_COM_SSL),1)
    LIBS_37 += -lssl
    LIBPATHS_37 += -L"$(ME_COM_OPENSSL_PATH)"
endif
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_37 += -lcrypto
    LIBPATHS_37 += -L"$(ME_COM_OPENSSL_PATH)"
endif
LIBS_37 += -lmpr
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_37 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_37 += -lpcre
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_37 += -lpcre
endif
LIBS_37 += -lmpr

$(BUILD)/bin/libhttp.dylib: $(DEPS_37)
	@echo '      [Link] $(BUILD)/bin/libhttp.dylib'
	$(CC) -dynamiclib -o $(BUILD)/bin/libhttp.dylib -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) -install_name @rpath/libhttp.dylib -compatibility_version 0.5 -current_version 0.5 "$(BUILD)/obj/httpLib.o" $(LIBPATHS_37) $(LIBS_37) $(LIBS_37) $(LIBS) 
endif

ifeq ($(ME_COM_ZLIB),1)
#
#   libzlib
#
DEPS_38 += $(BUILD)/inc/zlib.h
DEPS_38 += $(BUILD)/obj/zlib.o

$(BUILD)/bin/libzlib.dylib: $(DEPS_38)
	@echo '      [Link] $(BUILD)/bin/libzlib.dylib'
	$(CC) -dynamiclib -o $(BUILD)/bin/libzlib.dylib -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) -install_name @rpath/libzlib.dylib -compatibility_version 0.5 -current_version 0.5 "$(BUILD)/obj/zlib.o" $(LIBS) 
endif

ifeq ($(ME_COM_EJSCRIPT),1)
#
#   libejs
#
ifeq ($(ME_COM_HTTP),1)
    DEPS_39 += $(BUILD)/bin/libhttp.dylib
endif
ifeq ($(ME_COM_PCRE),1)
    DEPS_39 += $(BUILD)/bin/libpcre.dylib
endif
DEPS_39 += $(BUILD)/bin/libmpr.dylib
ifeq ($(ME_COM_ZLIB),1)
    DEPS_39 += $(BUILD)/bin/libzlib.dylib
endif
DEPS_39 += $(BUILD)/inc/ejs.h
DEPS_39 += $(BUILD)/inc/ejs.slots.h
DEPS_39 += $(BUILD)/inc/ejsByteGoto.h
DEPS_39 += $(BUILD)/obj/ejsLib.o

ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_39 += -lmbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_39 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_39 += -lmbedtls
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_39 += -lmpr-openssl
    LIBPATHS_39 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_OPENSSL),1)
ifeq ($(ME_COM_SSL),1)
    LIBS_39 += -lssl
    LIBPATHS_39 += -L"$(ME_COM_OPENSSL_PATH)"
endif
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_39 += -lcrypto
    LIBPATHS_39 += -L"$(ME_COM_OPENSSL_PATH)"
endif
LIBS_39 += -lmpr
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_39 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_39 += -lpcre
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_39 += -lhttp
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_39 += -lpcre
endif
LIBS_39 += -lmpr
ifeq ($(ME_COM_ZLIB),1)
    LIBS_39 += -lzlib
endif
ifeq ($(ME_COM_ZLIB),1)
    LIBS_39 += -lzlib
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_39 += -lhttp
endif

$(BUILD)/bin/libejs.dylib: $(DEPS_39)
	@echo '      [Link] $(BUILD)/bin/libejs.dylib'
	$(CC) -dynamiclib -o $(BUILD)/bin/libejs.dylib -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) -install_name @rpath/libejs.dylib -compatibility_version 0.5 -current_version 0.5 "$(BUILD)/obj/ejsLib.o" $(LIBPATHS_39) $(LIBS_39) $(LIBS_39) $(LIBS) 
endif

ifeq ($(ME_COM_EJSCRIPT),1)
#
#   ejsc
#
DEPS_40 += $(BUILD)/bin/libejs.dylib
DEPS_40 += $(BUILD)/obj/ejsc.o

ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_40 += -lmbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_40 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_40 += -lmbedtls
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_40 += -lmpr-openssl
    LIBPATHS_40 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_OPENSSL),1)
ifeq ($(ME_COM_SSL),1)
    LIBS_40 += -lssl
    LIBPATHS_40 += -L"$(ME_COM_OPENSSL_PATH)"
endif
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_40 += -lcrypto
    LIBPATHS_40 += -L"$(ME_COM_OPENSSL_PATH)"
endif
LIBS_40 += -lmpr
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_40 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_40 += -lpcre
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_40 += -lhttp
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_40 += -lpcre
endif
LIBS_40 += -lmpr
ifeq ($(ME_COM_ZLIB),1)
    LIBS_40 += -lzlib
endif
LIBS_40 += -lejs
ifeq ($(ME_COM_ZLIB),1)
    LIBS_40 += -lzlib
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_40 += -lhttp
endif

$(BUILD)/bin/expansive-ejsc: $(DEPS_40)
	@echo '      [Link] $(BUILD)/bin/expansive-ejsc'
	$(CC) -o $(BUILD)/bin/expansive-ejsc -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) "$(BUILD)/obj/ejsc.o" $(LIBPATHS_40) $(LIBS_40) $(LIBS_40) $(LIBS) 
endif

ifeq ($(ME_COM_EJSCRIPT),1)
#
#   ejs.mod
#
DEPS_41 += src/ejscript/ejs.es
DEPS_41 += $(BUILD)/bin/expansive-ejsc

$(BUILD)/bin/ejs.mod: $(DEPS_41)
	( \
	cd src/ejscript; \
	echo '   [Compile] ejs.mod' ; \
	"../../$(BUILD)/bin/expansive-ejsc" --out "../../$(BUILD)/bin/ejs.mod" --debug --optimize 9 --bind --require null ejs.es ; \
	)
endif

ifeq ($(ME_COM_EJSCRIPT),1)
#
#   ejscmd
#
DEPS_42 += $(BUILD)/bin/libejs.dylib
DEPS_42 += $(BUILD)/obj/ejs.o

ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_42 += -lmbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_42 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_42 += -lmbedtls
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_42 += -lmpr-openssl
    LIBPATHS_42 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_OPENSSL),1)
ifeq ($(ME_COM_SSL),1)
    LIBS_42 += -lssl
    LIBPATHS_42 += -L"$(ME_COM_OPENSSL_PATH)"
endif
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_42 += -lcrypto
    LIBPATHS_42 += -L"$(ME_COM_OPENSSL_PATH)"
endif
LIBS_42 += -lmpr
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_42 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_42 += -lpcre
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_42 += -lhttp
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_42 += -lpcre
endif
LIBS_42 += -lmpr
ifeq ($(ME_COM_ZLIB),1)
    LIBS_42 += -lzlib
endif
LIBS_42 += -lejs
ifeq ($(ME_COM_ZLIB),1)
    LIBS_42 += -lzlib
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_42 += -lhttp
endif

$(BUILD)/bin/expansive-ejs: $(DEPS_42)
	@echo '      [Link] $(BUILD)/bin/expansive-ejs'
	$(CC) -o $(BUILD)/bin/expansive-ejs -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) "$(BUILD)/obj/ejs.o" $(LIBPATHS_42) $(LIBS_42) $(LIBS_42) $(LIBS) -ledit 
endif

#
#   expansive.mod
#
DEPS_43 += src/expansive.es
DEPS_43 += src/ExpParser.es
DEPS_43 += paks/ejs-version/Version.es
ifeq ($(ME_COM_EJSCRIPT),1)
    DEPS_43 += $(BUILD)/bin/ejs.mod
endif

$(BUILD)/bin/expansive.mod: $(DEPS_43)
	echo '   [Compile] expansive.mod' ; \
	"./$(BUILD)/bin/expansive-ejsc" --debug --optimize 9 --out "./$(BUILD)/bin/expansive.mod" --optimize 9 src/expansive.es src/ExpParser.es paks/ejs-version/Version.es

#
#   expansive
#
DEPS_44 += $(BUILD)/bin/libmpr.dylib
ifeq ($(ME_COM_HTTP),1)
    DEPS_44 += $(BUILD)/bin/libhttp.dylib
endif
ifeq ($(ME_COM_EJSCRIPT),1)
    DEPS_44 += $(BUILD)/bin/libejs.dylib
endif
DEPS_44 += $(BUILD)/bin/expansive.mod
DEPS_44 += $(BUILD)/obj/expansive.o
DEPS_44 += $(BUILD)/obj/expParser.o

ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_44 += -lmbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_44 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_44 += -lmbedtls
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_44 += -lmpr-openssl
    LIBPATHS_44 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_OPENSSL),1)
ifeq ($(ME_COM_SSL),1)
    LIBS_44 += -lssl
    LIBPATHS_44 += -L"$(ME_COM_OPENSSL_PATH)"
endif
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_44 += -lcrypto
    LIBPATHS_44 += -L"$(ME_COM_OPENSSL_PATH)"
endif
LIBS_44 += -lmpr
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_44 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_44 += -lpcre
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_44 += -lhttp
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_44 += -lpcre
endif
LIBS_44 += -lmpr
ifeq ($(ME_COM_ZLIB),1)
    LIBS_44 += -lzlib
endif
ifeq ($(ME_COM_EJSCRIPT),1)
    LIBS_44 += -lejs
endif
ifeq ($(ME_COM_ZLIB),1)
    LIBS_44 += -lzlib
endif
ifeq ($(ME_COM_HTTP),1)
    LIBS_44 += -lhttp
endif

$(BUILD)/bin/expansive: $(DEPS_44)
	@echo '      [Link] $(BUILD)/bin/expansive'
	$(CC) -o $(BUILD)/bin/expansive -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) "$(BUILD)/obj/expansive.o" "$(BUILD)/obj/expParser.o" $(LIBPATHS_44) $(LIBS_44) $(LIBS_44) $(LIBS) 

ifeq ($(ME_COM_HTTP),1)
#
#   httpcmd
#
DEPS_45 += $(BUILD)/bin/libhttp.dylib
DEPS_45 += $(BUILD)/obj/http.o

ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_45 += -lmbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_45 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_45 += -lmbedtls
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_45 += -lmpr-openssl
    LIBPATHS_45 += -L"$(ME_COM_OPENSSL_PATH)"
endif
ifeq ($(ME_COM_OPENSSL),1)
ifeq ($(ME_COM_SSL),1)
    LIBS_45 += -lssl
    LIBPATHS_45 += -L"$(ME_COM_OPENSSL_PATH)"
endif
endif
ifeq ($(ME_COM_OPENSSL),1)
    LIBS_45 += -lcrypto
    LIBPATHS_45 += -L"$(ME_COM_OPENSSL_PATH)"
endif
LIBS_45 += -lmpr
ifeq ($(ME_COM_MBEDTLS),1)
    LIBS_45 += -lmpr-mbedtls
endif
ifeq ($(ME_COM_PCRE),1)
    LIBS_45 += -lpcre
endif
LIBS_45 += -lhttp
ifeq ($(ME_COM_PCRE),1)
    LIBS_45 += -lpcre
endif
LIBS_45 += -lmpr

$(BUILD)/bin/http: $(DEPS_45)
	@echo '      [Link] $(BUILD)/bin/http'
	$(CC) -o $(BUILD)/bin/http -arch $(CC_ARCH) $(LDFLAGS) $(LIBPATHS) "$(BUILD)/obj/http.o" $(LIBPATHS_45) $(LIBS_45) $(LIBS_45) $(LIBS) 
endif

#
#   install-certs
#
DEPS_46 += src/certs/samples/ca.crt
DEPS_46 += src/certs/samples/ca.key
DEPS_46 += src/certs/samples/ec.crt
DEPS_46 += src/certs/samples/ec.key
DEPS_46 += src/certs/samples/roots.crt
DEPS_46 += src/certs/samples/self.crt
DEPS_46 += src/certs/samples/self.key
DEPS_46 += src/certs/samples/test.crt
DEPS_46 += src/certs/samples/test.key

$(BUILD)/.install-certs-modified: $(DEPS_46)
	@echo '      [Copy] $(BUILD)/bin'
	mkdir -p "$(BUILD)/bin"
	cp src/certs/samples/ca.crt $(BUILD)/bin/ca.crt
	cp src/certs/samples/ca.key $(BUILD)/bin/ca.key
	cp src/certs/samples/ec.crt $(BUILD)/bin/ec.crt
	cp src/certs/samples/ec.key $(BUILD)/bin/ec.key
	cp src/certs/samples/roots.crt $(BUILD)/bin/roots.crt
	cp src/certs/samples/self.crt $(BUILD)/bin/self.crt
	cp src/certs/samples/self.key $(BUILD)/bin/self.key
	cp src/certs/samples/test.crt $(BUILD)/bin/test.crt
	cp src/certs/samples/test.key $(BUILD)/bin/test.key
	touch "$(BUILD)/.install-certs-modified"

#
#   sample
#
DEPS_47 += src/sample.json

$(BUILD)/bin/sample.json: $(DEPS_47)
	@echo '      [Copy] $(BUILD)/bin/sample.json'
	mkdir -p "$(BUILD)/bin"
	cp src/sample.json $(BUILD)/bin/sample.json

#
#   installPrep
#

installPrep: $(DEPS_48)
	if [ "`id -u`" != 0 ] ; \
	then echo "Must run as root. Rerun with "sudo"" ; \
	exit 255 ; \
	fi

#
#   stop
#

stop: $(DEPS_49)

#
#   installBinary
#

installBinary: $(DEPS_50)
	mkdir -p "$(ME_APP_PREFIX)" ; \
	rm -f "$(ME_APP_PREFIX)/latest" ; \
	ln -s "$(VERSION)" "$(ME_APP_PREFIX)/latest" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/bin" ; \
	cp $(BUILD)/bin/expansive $(ME_VAPP_PREFIX)/bin/expansive ; \
	chmod 755 "$(ME_VAPP_PREFIX)/bin/expansive" ; \
	mkdir -p "$(ME_BIN_PREFIX)" ; \
	chmod 755 "$(ME_BIN_PREFIX)" ; \
	rm -f "$(ME_BIN_PREFIX)/expansive" ; \
	ln -s "$(ME_VAPP_PREFIX)/bin/expansive" "$(ME_BIN_PREFIX)/expansive" ; \
	mkdir -p "$(ME_VAPP_PREFIX)/bin" ; \
	cp $(BUILD)/bin/libejs.dylib $(ME_VAPP_PREFIX)/bin/libejs.dylib ; \
	cp $(BUILD)/bin/libhttp.dylib $(ME_VAPP_PREFIX)/bin/libhttp.dylib ; \
	cp $(BUILD)/bin/libmpr.dylib $(ME_VAPP_PREFIX)/bin/libmpr.dylib ; \
	cp $(BUILD)/bin/libpcre.dylib $(ME_VAPP_PREFIX)/bin/libpcre.dylib ; \
	cp $(BUILD)/bin/libzlib.dylib $(ME_VAPP_PREFIX)/bin/libzlib.dylib ; \
	mkdir -p "$(ME_VAPP_PREFIX)/bin" ; \
	cp $(BUILD)/bin/roots.crt $(ME_VAPP_PREFIX)/bin/roots.crt ; \
	cp $(BUILD)/bin/ejs.mod $(ME_VAPP_PREFIX)/bin/ejs.mod ; \
	cp $(BUILD)/bin/expansive.mod $(ME_VAPP_PREFIX)/bin/expansive.mod ; \
	cp $(BUILD)/bin/sample.json $(ME_VAPP_PREFIX)/bin/sample.json ; \
	mkdir -p "$(ME_VAPP_PREFIX)/doc/man/man1" ; \
	cp doc/contents/man/expansive.1 $(ME_VAPP_PREFIX)/doc/man/man1/expansive.1 ; \
	mkdir -p "$(ME_MAN_PREFIX)/man1" ; \
	rm -f "$(ME_MAN_PREFIX)/man1/expansive.1" ; \
	ln -s "$(ME_VAPP_PREFIX)/doc/man/man1/expansive.1" "$(ME_MAN_PREFIX)/man1/expansive.1"

#
#   start
#

start: $(DEPS_51)

#
#   install
#
DEPS_52 += installPrep
DEPS_52 += stop
DEPS_52 += installBinary
DEPS_52 += start

install: $(DEPS_52)

#
#   uninstall
#
DEPS_53 += stop

uninstall: $(DEPS_53)
	rm -fr "$(ME_VAPP_PREFIX)" ; \
	rm -f "$(ME_APP_PREFIX)/latest" ; \
	rmdir -p "$(ME_APP_PREFIX)" 2>/dev/null ; true

#
#   version
#

version: $(DEPS_54)
	echo $(VERSION)

