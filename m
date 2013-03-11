From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 11/12] spi/bcm63xx: inline hz usage in
	bcm63xx_spi_setup_transfer
Date: Tue, 12 Mar 2013 00:13:46 +0100
Message-ID: <1363043627-23524-12-git-send-email-jogo@openwrt.org>
References: <1363043627-23524-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363043627-23524-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

bcm63xx_spi_setup_transfer is called from only one place, and that has
t always set, to hz will always be t->speed_hz - just use it directly in
the two places instead of moving it in a local variable.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index d777f63..2d64db4 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -97,15 +97,12 @@ static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
 				      struct spi_transfer *t)
 {
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
-	u32 hz;
 	u8 clk_cfg, reg;
 	int i;
 
-	hz = (t) ? t->speed_hz : spi->max_speed_hz;
-
 	/* Find the closest clock configuration */
 	for (i = 0; i < SPI_CLK_MASK; i++) {
-		if (hz >= bcm63xx_spi_freq_table[i][0]) {
+		if (t->speed_hz >= bcm63xx_spi_freq_table[i][0]) {
 			clk_cfg = bcm63xx_spi_freq_table[i][1];
 			break;
 		}
@@ -122,7 +119,7 @@ static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
 
 	bcm_spi_writeb(bs, reg, SPI_CLK_CFG);
 	dev_dbg(&spi->dev, "Setting clock register to %02x (hz %d)\n",
-		clk_cfg, hz);
+		clk_cfg, t->speed_hz);
 }
 
 /* the spi->mode bits understood by this driver: */
-- 
1.7.10.4


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
