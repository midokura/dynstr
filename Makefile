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
PROJECT = libdynstr.a
CFLAGS = -Iinclude
DEPS = \
	dynstr.o

all: $(PROJECT)

install: $(PROJECT) $(PC_DST)/dynstr.pc
	mkdir -p $(PREFIX)/include
	cp include/dynstr.h $(PREFIX)/include
	chmod 0644 $(PREFIX)/include/dynstr.h
	mkdir -p $(DST)
	cp $(PROJECT) $(DST)
	chmod 0755 $(DST)/$(PROJECT)

clean:
	rm -f $(DEPS)

$(PROJECT): $(DEPS)
	$(AR) $(ARFLAGS) $@ $(DEPS)

$(PC_DST)/dynstr.pc: dynstr.pc
	mkdir -p $(PC_DST)
	sed -e 's,/usr/local,$(PREFIX),' $< > $@
	chmod 0644 $@
