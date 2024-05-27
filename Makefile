PORTNAME=	bsdnews
PORTVERSION=	1.0
CATEGORIES=	news
MASTER_SITES=	# Not applicable as the script is local
DISTFILES=	# No distfiles as the script is local

MAINTAINER=	laurent.chardon@gmail.com
COMMENT=	BSD News Reader

LICENSE=	BSD2CLAUSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}requests>0:www/py-requests \
		${PYTHON_PKGNAMEPREFIX}feedparser>0:textproc/py-feedparser \
		${PYTHON_PKGNAMEPREFIX}beautifulsoup4>0:textproc/py-beautifulsoup4 \
		${PYTHON_PKGNAMEPREFIX}blessed>0:devel/py-blessed \
		less:sysutils/less

USES=		python:3.6+
USE_PYTHON=	distutils

NO_ARCH=	yes

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/bsdnews ${STAGEDIR}${PREFIX}/bin/bsdnews

.include <bsd.port.mk>

