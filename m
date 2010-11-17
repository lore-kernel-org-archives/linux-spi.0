From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 15/49] spi: davinci: add support for wait enable timeouts
Date: Wed, 17 Nov 2010 16:13:47 +0530
Message-ID: <1289990661-30126-16-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-15-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Just enabling WAITENA in SPIFMTn register waits for the
enable signal from the slave indefinitely. Allow support
for finite waiting by adding support for c2e delay
(maximum time for addressed slave to respond) and t2e
delay (maximum time for slave to respond after transmit
data finished).

While at it, modify the T2C and C2T defines by prepending
the register name as is the convention followed for other
register field elsewhere in the driver.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |    2 +
 drivers/spi/davinci_spi.c                |   36 ++++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 29c19c4..483b055 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -43,6 +43,8 @@ struct davinci_spi_config {
 	u8	timer_disable;
 	u8	c2tdelay;
 	u8	t2cdelay;
+	u8	t2edelay;
+	u8	c2edelay;
 };
 
 #endif	/* __ARCH_ARM_DAVINCI_SPI_H */
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index d09b63c..e94c638 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -78,6 +78,16 @@
 #define SPIBUF_TXFULL_MASK	BIT(29)
 #define SPIBUF_RXEMPTY_MASK	BIT(31)
 
+/* SPIDELAY */
+#define SPIDELAY_C2TDELAY_SHIFT 24
+#define SPIDELAY_C2TDELAY_MASK  (0xFF << SPIDELAY_C2TDELAY_SHIFT)
+#define SPIDELAY_T2CDELAY_SHIFT 16
+#define SPIDELAY_T2CDELAY_MASK  (0xFF << SPIDELAY_T2CDELAY_SHIFT)
+#define SPIDELAY_T2EDELAY_SHIFT 8
+#define SPIDELAY_T2EDELAY_MASK  (0xFF << SPIDELAY_T2EDELAY_SHIFT)
+#define SPIDELAY_C2EDELAY_SHIFT 0
+#define SPIDELAY_C2EDELAY_MASK  0xFF
+
 /* Error Masks */
 #define SPIFLG_DLEN_ERR_MASK		BIT(0)
 #define SPIFLG_TIMEOUT_MASK		BIT(1)
@@ -95,9 +105,6 @@
 #define SPIINT_TX_INTR		BIT(9)
 #define SPIINT_DMA_REQ_EN	BIT(16)
 
-#define SPI_T2CDELAY_SHIFT	16
-#define SPI_C2TDELAY_SHIFT	24
-
 /* SPI Controller registers */
 #define SPIGCR0		0x00
 #define SPIGCR1		0x04
@@ -363,6 +370,8 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 
 	if (davinci_spi->version == SPI_VERSION_2) {
 
+		u32 delay = 0;
+
 		spifmt |= ((spicfg->wdelay << SPIFMT_WDELAY_SHIFT)
 							& SPIFMT_WDELAY_MASK);
 
@@ -372,15 +381,24 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 		if (spicfg->parity_enable)
 			spifmt |= SPIFMT_PARITYENA_MASK;
 
-		if (spicfg->timer_disable)
+		if (spicfg->timer_disable) {
 			spifmt |= SPIFMT_DISTIMER_MASK;
-		else
-			iowrite32((spicfg->c2tdelay << SPI_C2TDELAY_SHIFT) |
-				  (spicfg->t2cdelay << SPI_T2CDELAY_SHIFT),
-				  davinci_spi->base + SPIDELAY);
+		} else {
+			delay |= (spicfg->c2tdelay << SPIDELAY_C2TDELAY_SHIFT)
+						& SPIDELAY_C2TDELAY_MASK;
+			delay |= (spicfg->t2cdelay << SPIDELAY_T2CDELAY_SHIFT)
+						& SPIDELAY_T2CDELAY_MASK;
+		}
 
-		if (spi->mode & SPI_READY)
+		if (spi->mode & SPI_READY) {
 			spifmt |= SPIFMT_WAITENA_MASK;
+			delay |= (spicfg->t2edelay << SPIDELAY_T2EDELAY_SHIFT)
+						& SPIDELAY_T2EDELAY_MASK;
+			delay |= (spicfg->c2edelay << SPIDELAY_C2EDELAY_SHIFT)
+						& SPIDELAY_C2EDELAY_MASK;
+		}
+
+		iowrite32(delay, davinci_spi->base + SPIDELAY);
 	}
 
 	iowrite32(spifmt, davinci_spi->base + SPIFMT0);
-- 
1.7.3.2
