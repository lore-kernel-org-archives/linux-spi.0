From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH] spi: Add support for specifing 3-wire mode via device tree
Date: Fri, 13 Jul 2012 14:43:47 +0200
Message-ID: <1342183427-23430-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
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

This patch allows to specify that a SPI device is connected in 3-wire mode via
the device tree.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |    2 ++
 drivers/spi/spi.c                                 |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index e782add..46f2f3b 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -33,6 +33,8 @@ contain the following properties.
     		shifted clock phase (CPHA) mode
 - spi-cs-high     - (optional) Empty property indicating device requires
     		chip select active high
+- spi-3wire       - (optional) Empty property indicating device requires
+    		    3-wire mode.
 
 SPI example for an MPC5200 SPI bus:
 	spi@f00 {
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fc0da39..09da7de 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -856,6 +856,8 @@ static void of_register_spi_devices(struct spi_master *master)
 			spi->mode |= SPI_CPOL;
 		if (of_find_property(nc, "spi-cs-high", NULL))
 			spi->mode |= SPI_CS_HIGH;
+		if (of_find_property(nc, "spi-3wire", NULL))
+			spi->mode |= SPI_3WIRE;
 
 		/* Device speed */
 		prop = of_get_property(nc, "spi-max-frequency", &len);
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
