From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] spi: export tracepoint symbols to modules
Date: Thu, 21 Mar 2019 13:42:25 +0100
Message-ID: <20190321124240.901884-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The newly added tracepoints in the spi-mxs driver cause a link
error when the driver is a loadable module:

ERROR: "__tracepoint_spi_transfer_stop" [drivers/spi/spi-mxs.ko] undefined!
ERROR: "__tracepoint_spi_transfer_start" [drivers/spi/spi-mxs.ko] undefined!

I'm not quite sure where to put the export statements, but
directly after the inclusion of the header seems as good as
any other place.

Fixes: f3fdea3af405 ("spi: mxs: add tracing to custom .transfer_one_message callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 93986f879b09..e5d38152888a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -36,6 +36,8 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_start);
+EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 
 #include "internals.h"
 
-- 
2.20.0
