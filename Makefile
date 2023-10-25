# Copyright 2020-2023 Xavier Del Campo Romero
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.POSIX:

PREFIX = /usr/local
DST = $(PREFIX)/lib
PC_DST = $(DST)/pkgconfig
PROJECT = libdynstr
MAJOR_VERSION = 0
MINOR_VERSION = 1
PATCH_VERSION = 0
VERSION = $(MAJOR_VERSION).$(MINOR_VERSION).$(PATCH_VERSION)
PROJECT_A = $(PROJECT).a
PROJECT_SO = $(PROJECT).so.$(VERSION)
PROJECT_SO_FQ = $(PROJECT).so.$(MAJOR_VERSION)
PROJECT_SO_NV = $(PROJECT).so
CFLAGS = -Iinclude -fPIC
LDFLAGS = -shared
DEPS = \
	dynstr.o

all: $(PROJECT_A) $(PROJECT_SO)

install: all $(PC_DST)/dynstr.pc
	mkdir -p $(PREFIX)/include
	cp include/dynstr.h $(PREFIX)/include
	chmod 0644 $(PREFIX)/include/dynstr.h
	mkdir -p $(DST)
	cp $(PROJECT_A) $(PROJECT_SO) $(DST)
	chmod 0755 $(DST)/$(PROJECT_A) $(DST)/$(PROJECT_SO)
	ln -fs $(DST)/$(PROJECT_SO) $(DST)/$(PROJECT_SO_FQ)
	ln -fs $(DST)/$(PROJECT_SO) $(DST)/$(PROJECT_SO_NV)

clean:
	rm -f $(DEPS)

$(PROJECT_A): $(DEPS)
	$(AR) $(ARFLAGS) $@ $(DEPS)

$(PROJECT_SO): $(DEPS)
	$(CC) $(LDFLAGS) $(DEPS) -o $@

$(PC_DST)/dynstr.pc: dynstr.pc
	mkdir -p $(PC_DST)
	sed -e 's,/usr/local,$(PREFIX),' $< > $@
	chmod 0644 $@
