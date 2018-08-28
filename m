From: Kirill kapranov <kirill.kapranov@compulab.co.il>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Tue, 28 Aug 2018 22:47:05 +0300 (IDT)
Message-ID: <2024176715.614.1535485625914.JavaMail.root@compulab.co.il>
References: <20180821095303.27664-1-geert+renesas@glider.be> <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il> <20180823102121.GC5207@sirena.org.uk> <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il> <20180826132415.GB2414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        linux@roeck-us.net
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180826132415.GB2414@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> Right, that clearly wasn't an intended effect, though - should be using
> the max of the big constant and the maximum static ID.

Due to difficulties of enumeration of all device in a system, I propose
to assign safe sub-range for dynamic IDs in the upper-half of ID range the following way.

NOTE-0: This patch has to be applied after Geert's patch,
which fixes double call of idr_alloc. (above in the thread). Many thanks, Geert!

NOTE-1: The best solution, IMHO, would be migration to property_get_*
functions, declared in linux/property.h 

[PATCH] Eliminate possibility of conflict between static and dynamic IDs

For systems without DT support allocate dynamical bus ID in a safe sub-range
(if given), otherwise in upper half of the range so as to avoid possible
conflict between statically and dynamically allocated IDs.

Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
---
 drivers/spi/Kconfig |  8 ++++++++
 drivers/spi/spi.c   | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 671d078349cc..7498fae0113b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -47,6 +47,14 @@ config SPI_MASTER
 
 if SPI_MASTER
 
+config SPI_MASTER_DYN_BUS_NUM_FIRST
+	int "First dynamically assigned SPI bus ID" if EXPERT
+	default 0
+	help
+	  This value can be used as the beginning of sub-range for dynamic
+	  allocation of SPI bus ID in case of absence of DT. If -1 chosen, the
+	  sub-range will be allocated in upper half of the SPI bus ID range.
+
 config SPI_MEM
 	bool "SPI memory extension"
 	help
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9da0bc5a036c..3ac0cf0ab49c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -49,6 +49,18 @@
 
 #include "internals.h"
 
+#ifndef CHAR_BIT
+#define CHAR_BIT 8	/* Normally in <limits.h> */
+#endif
+#if !defined(CONFIG_SPI_MASTER_DYN_BUS_NUM_FIRST) || \
+	CONFIG_SPI_MASTER_DYN_BUS_NUM_FIRST < 0
+//Half of the biggest signed int of this size
+#define SPI_DYN_FIRST_NUM (((1 << \
+	(sizeof(((struct spi_controller*)0)->bus_num) * CHAR_BIT - 1)) - 1) / 2)
+#else
+#define SPI_DYN_FIRST_NUM CONFIG_SPI_MASTER_DYN_BUS_NUM_FIRST
+#endif
+
 static DEFINE_IDR(spi_master_idr);
 
 static void spidev_release(struct device *dev)
@@ -2167,7 +2179,15 @@ int spi_register_controller(struct spi_controller *ctlr)
 	}
 	if (ctlr->bus_num < 0) {
 		first_dynamic = of_alias_get_highest_id("spi");
-		if (first_dynamic < 0)
+
+		if (first_dynamic == -ENOSYS)
+			/*
+			 * In case of system without DT support, allocate
+			 * dynamic bus ID in safe range, higher than the bound,
+			 * to avoid conflict between static and dynamic ID
+			 */
+			first_dynamic = SPI_DYN_FIRST_NUM;
+		else if (first_dynamic < 0)
 			first_dynamic = 0;
 		else
 			first_dynamic++;
-- 
2.11.0
