From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/49] spi: davinci: removed unused #defines
Date: Wed, 17 Nov 2010 16:13:36 +0530
Message-ID: <1289990661-30126-5-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-4-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Remove unused defines from code which should help
in easy reading of code.

Also, use the opportuinity to keep the SPIGCR1
register defines together.

Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Tested-By: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   33 ++-------------------------------
 1 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index a92f507..7bd0a55 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -54,16 +54,12 @@
 #define SPIFMT_WDELAY_SHIFT	24
 #define SPIFMT_CHARLEN_MASK	0x0000001Fu
 
-/* SPIGCR1 */
-#define SPIGCR1_SPIENA_MASK	0x01000000u
 
 /* SPIPC0 */
 #define SPIPC0_DIFUN_MASK	BIT(11)		/* MISO */
 #define SPIPC0_DOFUN_MASK	BIT(10)		/* MOSI */
 #define SPIPC0_CLKFUN_MASK	BIT(9)		/* CLK */
 #define SPIPC0_SPIENA_MASK	BIT(8)		/* nREADY */
-#define SPIPC0_EN1FUN_MASK	BIT(1)
-#define SPIPC0_EN0FUN_MASK	BIT(0)
 
 #define SPIINT_MASKALL		0x0101035F
 #define SPI_INTLVL_1		0x000001FFu
@@ -75,6 +71,7 @@
 #define SPIGCR1_CLKMOD_MASK	BIT(1)
 #define SPIGCR1_MASTER_MASK     BIT(0)
 #define SPIGCR1_LOOPBACK_MASK	BIT(16)
+#define SPIGCR1_SPIENA_MASK	BIT(24)
 
 /* SPIBUF */
 #define SPIBUF_TXFULL_MASK	BIT(29)
@@ -90,23 +87,12 @@
 #define SPIFLG_RX_INTR_MASK		BIT(8)
 #define SPIFLG_TX_INTR_MASK		BIT(9)
 #define SPIFLG_BUF_INIT_ACTIVE_MASK	BIT(24)
-#define SPIFLG_MASK			(SPIFLG_DLEN_ERR_MASK \
-				| SPIFLG_TIMEOUT_MASK | SPIFLG_PARERR_MASK \
-				| SPIFLG_DESYNC_MASK | SPIFLG_BITERR_MASK \
-				| SPIFLG_OVRRUN_MASK | SPIFLG_RX_INTR_MASK \
-				| SPIFLG_TX_INTR_MASK \
-				| SPIFLG_BUF_INIT_ACTIVE_MASK)
-
-#define SPIINT_DLEN_ERR_INTR	BIT(0)
-#define SPIINT_TIMEOUT_INTR	BIT(1)
-#define SPIINT_PARERR_INTR	BIT(2)
-#define SPIINT_DESYNC_INTR	BIT(3)
+
 #define SPIINT_BITERR_INTR	BIT(4)
 #define SPIINT_OVRRUN_INTR	BIT(6)
 #define SPIINT_RX_INTR		BIT(8)
 #define SPIINT_TX_INTR		BIT(9)
 #define SPIINT_DMA_REQ_EN	BIT(16)
-#define SPIINT_ENABLE_HIGHZ	BIT(24)
 
 #define SPI_T2CDELAY_SHIFT	16
 #define SPI_C2TDELAY_SHIFT	24
@@ -118,26 +104,11 @@
 #define SPILVL		0x0c
 #define SPIFLG		0x10
 #define SPIPC0		0x14
-#define SPIPC1		0x18
-#define SPIPC2		0x1c
-#define SPIPC3		0x20
-#define SPIPC4		0x24
-#define SPIPC5		0x28
-#define SPIPC6		0x2c
-#define SPIPC7		0x30
-#define SPIPC8		0x34
-#define SPIDAT0		0x38
 #define SPIDAT1		0x3c
 #define SPIBUF		0x40
-#define SPIEMU		0x44
 #define SPIDELAY	0x48
 #define SPIDEF		0x4c
 #define SPIFMT0		0x50
-#define SPIFMT1		0x54
-#define SPIFMT2		0x58
-#define SPIFMT3		0x5c
-#define TGINTVEC0	0x60
-#define TGINTVEC1	0x64
 
 struct davinci_spi_slave {
 	u32	cmd_to_write;
-- 
1.7.3.2
