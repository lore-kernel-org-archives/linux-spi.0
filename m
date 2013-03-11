From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 10/12] spi/bcm63xx: inline bcm63xx_spi_check_transfer
Date: Tue, 12 Mar 2013 00:13:45 +0100
Message-ID: <1363043627-23524-11-git-send-email-jogo@openwrt.org>
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

It only does one check, so just do the check directly in the caller.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 9574e47..d777f63 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -93,18 +93,6 @@ static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
 	{   391000, SPI_CLK_0_391MHZ }
 };
 
-static int bcm63xx_spi_check_transfer(struct spi_device *spi,
-					struct spi_transfer *t)
-{
-	if (t->bits_per_word != 8) {
-		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
-			__func__, t->bits_per_word);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
 				      struct spi_transfer *t)
 {
@@ -293,9 +281,12 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 	 * full-duplex transfers.
 	 */
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		status = bcm63xx_spi_check_transfer(spi, t);
-		if (status < 0)
+		if (t->bits_per_word != 8) {
+			dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
+				__func__, t->bits_per_word);
+			status = -EINVAL;
 			goto exit;
+		}
 
 		if (!first)
 			first = t;
-- 
1.7.10.4


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
