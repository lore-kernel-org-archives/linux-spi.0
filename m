From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [v2 PATCH 11/14] spi/atmel_spi: correct 16 bits transfer with DMA
Date: Tue,  4 Dec 2012 15:53:57 +0800
Message-ID: <1354607640-13229-12-git-send-email-wenyou.yang@atmel.com>
References: <1354607640-13229-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, JM.Lin-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1354607640-13229-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
---
 drivers/spi/spi-atmel.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 9616fab..61452a5 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -439,12 +439,18 @@ static inline int atmel_spi_xfer_can_be_chained(struct spi_transfer *xfer)
 }
 
 static int atmel_spi_dma_slave_config(struct atmel_spi *as,
-				struct dma_slave_config *slave_config)
+				struct dma_slave_config *slave_config,
+				u8 bits_per_word)
 {
 	int err = 0;
 
-	slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	if (bits_per_word > 8) {
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	} else {
+		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
 
 	slave_config->dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
 	slave_config->src_addr = (dma_addr_t)as->phybase + SPI_RDR;
@@ -506,7 +512,7 @@ static int __devinit atmel_spi_configure_dma(struct atmel_spi *as)
 		goto error;
 	}
 
-	err = atmel_spi_dma_slave_config(as, &slave_config);
+	err = atmel_spi_dma_slave_config(as, &slave_config, 8);
 	if (err)
 		goto error;
 
@@ -641,10 +647,9 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config))
+	if (atmel_spi_dma_slave_config(as, &slave_config, 8))
 		goto err_exit;
 
-
 	/* Send both scatterlists */
 	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
 					&as->dma.sgrx,
-- 
1.7.9.5


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
