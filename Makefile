TARGETS=all check clean clobber distclean install uninstall
TARGET=all

PREFIX=${DESTDIR}/opt
BINDIR=${PREFIX}/bin
SUBDIRS=

CC	=gcc -std=gnu99
CFLAGS	=-Os -Wall -Wextra -pedantic -g
LDFLAGS	=-g

ifeq	(${MAKE},gmake)
	INSTALL=ginstall
else
	INSTALL=install
endif

.PHONY: ${TARGETS} ${SUBDIRS}

all::	setcpulatency

${TARGETS}::

clobber distclean:: clean
	${RM} setcpulatency

clean::
	${RM} *.o a.out

check::	setcpulatency
	./setcpulatency ${ARGS}

install:: setcpulatency
	${INSTALL} -D setcpulatency ${BINDIR}/setcpulatency

uninstall::
	${RM} ${BINDIR}/setcpulatency

ifneq	(,${SUBDIRS})
${TARGETS}::
	${MAKE} TARGET=$@ ${SUBDIRS}
${SUBDIRS}::
	${MAKE} -C $@ ${TARGET}
endif
