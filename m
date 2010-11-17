From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 08/49] spi: davinci: remove unnecessary data transmit on CS
	disable
Date: Wed, 17 Nov 2010 16:13:40 +0530
Message-ID: <1289990661-30126-9-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-8-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

On TI DaVinci's SPI controller, the SPIDAT1 register which
controls the chip slect status, also has data transmit register
in the lower 16 bits. Writing to the whole 32-bits triggers
an additional data transmit every time the chip select is disabled.

While most SPI slaves cope-up with this, some cannot. This
patch fixes this by doing a 16-bit write on the upper half
of the SPIDAT1 register

While at it, group the SPIGCR1 register related defines seperately
from SPIDAT1 register defines.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 105c686..82dddf8 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -65,9 +65,10 @@
 #define SPI_INTLVL_1		0x000001FFu
 #define SPI_INTLVL_0		0x00000000u
 
-/* SPIDAT1 */
-#define SPIDAT1_CSHOLD_MASK	BIT(28)
-#define SPIDAT1_CSNR_SHIFT	16
+/* SPIDAT1 (upper 16 bit defines) */
+#define SPIDAT1_CSHOLD_MASK	BIT(12)
+
+/* SPIGCR1 */
 #define SPIGCR1_CLKMOD_MASK	BIT(1)
 #define SPIGCR1_MASTER_MASK     BIT(0)
 #define SPIGCR1_LOOPBACK_MASK	BIT(16)
@@ -235,8 +236,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_platform_data *pdata;
-	u32 data1_reg_val;
 	u8 chip_sel = spi->chip_select;
+	u16 spidat1_cfg = CS_DEFAULT;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
@@ -245,17 +246,12 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	 * Board specific chip select logic decides the polarity and cs
 	 * line for the controller
 	 */
-	data1_reg_val = CS_DEFAULT << SPIDAT1_CSNR_SHIFT;
 	if (value == BITBANG_CS_ACTIVE) {
-		data1_reg_val |= SPIDAT1_CSHOLD_MASK;
-		data1_reg_val &= ~((0x1 << chip_sel) << SPIDAT1_CSNR_SHIFT);
+		spidat1_cfg |= SPIDAT1_CSHOLD_MASK;
+		spidat1_cfg &= ~(0x1 << chip_sel);
 	}
 
-	iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
-	while ((ioread32(davinci_spi->base + SPIBUF)
-				& SPIBUF_RXEMPTY_MASK) == 0)
-		cpu_relax();
-
+	iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
 }
 
 /**
-- 
1.7.3.2
