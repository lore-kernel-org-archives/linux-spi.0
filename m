From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH V3] mxs/spi: Fix misuse of init_completion
Date: Fri, 24 Aug 2012 04:56:27 +0200
Message-ID: <1345776987-15350-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The init_completion() call does reinit not only the variable carrying
the flag that the completion finished, but also initialized the
waitqueue associated with the completion. On the contrary, the
INIT_COMPLETION() call only reinits the flag.

In case there was anything still stuck in the waitqueue, subsequent call
to init_completion() would be able to create possible race condition. This
patch uses the proper function and moves init_completion() into .probe() call
of the driver, to be issued only once.

Note that such scenario is impossible, since two threads can never enter the
mxs_spi_txrx_dma(), since whole this section is protected by mutex in SPI core.
This by no means allows this issue to exit though.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

V2: Update the patch description and snap a whip over myself for being lazy to
    write one in the first place!
V3: Replace INIT_WORKQUEUE() with INIT_COMPLETION(), typo in patch description.

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 331f600..c965cc6 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -230,7 +230,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 		return -EINVAL;
 	}
 
-	init_completion(&spi->c);
+	INIT_COMPLETION(spi->c);
 
 	if (*first)
 		pio |= BM_SSP_CTRL0_LOCK_CS;
@@ -560,6 +560,8 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	ssp->devid = devid;
 	ssp->dma_channel = dma_channel;
 
+	init_completion(&spi->c);
+
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
 			       DRIVER_NAME, ssp);
 	if (ret)
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
