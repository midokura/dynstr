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

prefix = /usr/local
exec_prefix = $(prefix)
includedir = $(prefix)/include
libdir = $(exec_prefix)/lib
pkgcfgdir = $(libdir)/pkgconfig
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

install: all $(pkgcfgdir)/dynstr.pc
	mkdir -p $(DESTDIR)$(includedir)
	cp include/dynstr.h $(DESTDIR)$(includedir)
	chmod 0644 $(DESTDIR)$(includedir)/dynstr.h
	mkdir -p $(DESTDIR)$(libdir)
	cp $(PROJECT_A) $(PROJECT_SO) $(DESTDIR)$(libdir)
	chmod 0755 $(libdir)/$(PROJECT_A) $(DESTDIR)$(libdir)/$(PROJECT_SO)
	ln -fs $(DESTDIR)$(libdir)/$(PROJECT_SO) $(DESTDIR)$(libdir)/$(PROJECT_SO_FQ)
	ln -fs $(DESTDIR)$(libdir)/$(PROJECT_SO) $(DESTDIR)$(libdir)/$(PROJECT_SO_NV)

clean:
	rm -f $(DEPS)

$(PROJECT_A): $(DEPS)
	$(AR) $(ARFLAGS) $@ $(DEPS)

$(PROJECT_SO): $(DEPS)
	$(CC) $(LDFLAGS) $(DEPS) -o $@

$(pkgcfgdir)/dynstr.pc: dynstr.pc
	mkdir -p $(DESTDIR)$(pkgcfgdir)
	sed -e 's,/usr/local,$(DESTDIR)$(prefix),' $< > $@
	chmod 0644 $@
