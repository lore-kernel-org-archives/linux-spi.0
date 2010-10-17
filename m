From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 16/28] Blackfin SPI: save/restore state when
	suspending/resuming
Date: Sun, 17 Oct 2010 18:59:29 -0400
Message-ID: <1287356381-31495-17-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

We can't rely on the SPI_CTL/SPI_FLG registers retaining their state when
suspending, so save/restore their entire values.

Signed-off-by: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 278fe0a..c23ac3b 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -101,6 +101,9 @@ struct master_data {
 	size_t rx_map_len;
 	size_t tx_map_len;
 	u8 n_bytes;
+	u16 ctrl_reg;
+	u16 flag_reg;
+
 	int cs_change;
 	const struct transfer_ops *ops;
 };
@@ -1426,8 +1429,14 @@ static int bfin_spi_suspend(struct platform_device *pdev, pm_message_t state)
 	if (status != 0)
 		return status;
 
-	/* stop hardware */
-	bfin_spi_disable(drv_data);
+	drv_data->ctrl_reg = read_CTRL(drv_data);
+	drv_data->flag_reg = read_FLAG(drv_data);
+
+	/*
+	 * reset SPI_CTL and SPI_FLG registers
+	 */
+	write_CTRL(drv_data, BIT_CTL_CPHA | BIT_CTL_MASTER);
+	write_FLAG(drv_data, 0xFF00);
 
 	return 0;
 }
@@ -1437,8 +1446,8 @@ static int bfin_spi_resume(struct platform_device *pdev)
 	struct master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
-	/* Enable the SPI interface */
-	bfin_spi_enable(drv_data);
+	write_CTRL(drv_data, drv_data->ctrl_reg);
+	write_FLAG(drv_data, drv_data->flag_reg);
 
 	/* Start the queue running */
 	status = bfin_spi_start_queue(drv_data);
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
