From: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2 3/6] mtd: m25p80: add support to
	parse the SPI flash's partitions
Date: Mon, 2 Aug 2010 15:52:01 +0800
Message-ID: <1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1280735524-17547-3-git-send-email-Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---

v2:
 - Move the flash partition function from of_spi.c to MTD driver

 drivers/mtd/devices/m25p80.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 81e49a9..5f00075 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -752,6 +752,31 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
 	return NULL;
 }
 
+/*
+ * parse_flash_partition - Parse the flash partition on the SPI bus
+ * @spi: Pointer to spi_device device
+ */
+void parse_flash_partition(struct spi_device *spi)
+{
+	struct mtd_partition *parts;
+	struct flash_platform_data *pdata;
+	int nr_parts = 0;
+	struct device_node *np = spi->dev.of_node;
+
+	nr_parts = of_mtd_parse_partitions(&spi->dev, np, &parts);
+	if (!nr_parts)
+		return;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return;
+
+	pdata->parts = parts;
+	pdata->nr_parts = nr_parts;
+	spi->dev.platform_data = pdata;
+
+	return;
+}
 
 /*
  * board specific setup should have ensured the SPI clock used here
@@ -771,6 +796,10 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	 * a chip ID, try the JEDEC id commands; they'll work for most
 	 * newer chips, even if we don't recognize the particular chip.
 	 */
+
+	/* Parse the flash partition */
+	parse_flash_partition(spi);
+
 	data = spi->dev.platform_data;
 	if (data && data->type) {
 		const struct spi_device_id *plat_id;
-- 
1.6.4



------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
