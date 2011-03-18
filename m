From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] SPI: dw_spi, fix PPC build
Date: Fri, 18 Mar 2011 10:41:17 +0100
Message-ID: <1300441277-23961-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	jirislaby@gmail.com, Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
To: dbrownell@users.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently, build on PPC dies with:
In file included from drivers/spi/dw_spi_mmio.c:16:
include/linux/spi/dw_spi.h:147: error: field =E2=80=98tx_sgl=E2=80=99 h=
as incomplete type
include/linux/spi/dw_spi.h:149: error: field =E2=80=98rx_sgl=E2=80=99 h=
as incomplete type

Add linux/scatterlist.h include to dw_spi.h, because we need to know
the contents of the structure.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 include/linux/spi/dw_spi.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index 6cd10f6..fb0bce5 100644
--- a/include/linux/spi/dw_spi.h
+++ b/include/linux/spi/dw_spi.h
@@ -2,6 +2,7 @@
 #define DW_SPI_HEADER_H
=20
 #include <linux/io.h>
+#include <linux/scatterlist.h>
=20
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
--=20
1.7.4.1
