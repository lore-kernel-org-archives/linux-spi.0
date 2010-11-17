From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 43/49] spi: davinci: enable and power-up SPI only when required
Date: Wed, 17 Nov 2010 16:14:15 +0530
Message-ID: <1289990661-30126-44-git-send-email-nsekhar@ti.com>
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
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
	<1289990661-30126-21-git-send-email-nsekhar@ti.com>
	<1289990661-30126-22-git-send-email-nsekhar@ti.com>
	<1289990661-30126-23-git-send-email-nsekhar@ti.com>
	<1289990661-30126-24-git-send-email-nsekhar@ti.com>
	<1289990661-30126-25-git-send-email-nsekhar@ti.com>
	<1289990661-30126-26-git-send-email-nsekhar@ti.com>
	<1289990661-30126-27-git-send-email-nsekhar@ti.com>
	<1289990661-30126-28-git-send-email-nsekhar@ti.com>
	<1289990661-30126-29-git-send-email-nsekhar@ti.com>
	<1289990661-30126-30-git-send-email-nsekhar@ti.com>
	<1289990661-30126-31-git-send-email-nsekhar@ti.com>
	<1289990661-30126-32-git-send-email-nsekhar@ti.com>
	<1289990661-30126-33-git-send-email-nsekhar@ti.com>
	<1289990661-30126-34-git-send-email-nsekhar@ti.com>
	<1289990661-30126-35-git-send-email-nsekhar@ti.com>
	<1289990661-30126-36-git-send-email-nsekhar@ti.com>
	<1289990661-30126-37-git-send-email-nsekhar@ti.com>
	<1289990661-30126-38-git-send-email-nsekhar@ti.com>
	<1289990661-30126-39-git-send-email-nsekhar@ti.com>
	<1289990661-30126-40-git-send-email-nsekhar@ti.com>
	<1289990661-30126-41-git-send-email-nsekhar@ti.com>
	<1289990661-30126-42-git-send-email-nsekhar@ti.com>
	<1289990661-30126-43-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-43-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Enable SPI only when active transfers are in progress. Keep
it in local low power when not in use.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 2e74fcd..1652bba 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -49,7 +49,6 @@
 #define SPIFMT_WDELAY_SHIFT	24
 #define SPIFMT_PRESCALE_SHIFT	8
 
-
 /* SPIPC0 */
 #define SPIPC0_DIFUN_MASK	BIT(11)		/* MISO */
 #define SPIPC0_DOFUN_MASK	BIT(10)		/* MOSI */
@@ -67,6 +66,7 @@
 /* SPIGCR1 */
 #define SPIGCR1_CLKMOD_MASK	BIT(1)
 #define SPIGCR1_MASTER_MASK     BIT(0)
+#define SPIGCR1_POWERDOWN_MASK	BIT(8)
 #define SPIGCR1_LOOPBACK_MASK	BIT(16)
 #define SPIGCR1_SPIENA_MASK	BIT(24)
 
@@ -556,7 +556,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
 
-	/* Enable SPI */
+	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
 	INIT_COMPLETION(davinci_spi->done);
@@ -693,6 +693,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
 	}
 
+	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
+	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	/*
 	 * Check for bit error, desync error,parity error,timeout error and
 	 * receive overflow errors
@@ -937,6 +940,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	/* master mode default */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_CLKMOD_MASK);
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
+	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
 
 	ret = spi_bitbang_start(&davinci_spi->bitbang);
 	if (ret)
-- 
1.7.3.2
