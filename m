From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] SPI: MXS: Allow to pass the SPI master bus number from the
	device tree
Date: Fri,  3 Aug 2012 16:30:39 +0200
Message-ID: <1344004239-22868-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: marex-ynQEQJNshbs@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1343076052-27312-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

If you don't do it, the bus number will be a bogus value, possibly used
for device file names in drivers like spidev.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index d6a80a1..d6a73ef 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -527,6 +527,15 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	if (pdev->id != -1)
+		master->bus_num = pdev->id;
+	if (np) {
+		unsigned long prop;
+
+		of_property_read_u32(np, "cell-index", &prop);
+		master->bus_num = prop;
+	}
+
 	master->transfer_one_message = mxs_spi_transfer_one;
 	master->setup = mxs_spi_setup;
 	master->cleanup = mxs_spi_cleanup;
-- 
1.7.9.5


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
