From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 4/4] mxs/spi: Rework the mxs_ssp_timeout to be more readable
Date: Tue,  4 Sep 2012 04:40:18 +0200
Message-ID: <1346726418-2856-5-git-send-email-marex@denx.de>
References: <1346726418-2856-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1346726418-2856-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Rework the mxs_ssp_timeout() function to make it a bit more readable
and hopefully less error prone. Also, have only one successful exit
from the function and one failing exit instead of two.

Finally, discard the udelay() from this function altogether, as this
tightloop is quick enough it's pointless.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 6650ded..2c3665a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -177,25 +177,23 @@ static inline void mxs_spi_disable(struct mxs_spi *spi)
 
 static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
+	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
 	struct mxs_ssp *ssp = &spi->ssp;
 	uint32_t reg;
 
-	while (1) {
+	do {
 		reg = readl_relaxed(ssp->base + offset);
 
-		if (set && ((reg & mask) == mask))
-			break;
+		if (!set)
+			reg = ~reg;
 
-		if (!set && ((~reg & mask) == mask))
-			break;
+		reg &= mask;
 
-		udelay(1);
+		if (reg == mask)
+			return 0;
+	} while (time_before(jiffies, timeout));
 
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-	}
-	return 0;
+	return -ETIMEDOUT;
 }
 
 static void mxs_ssp_dma_irq_callback(void *param)
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
