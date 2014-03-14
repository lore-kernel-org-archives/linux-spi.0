From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number from DTS
Date: Fri, 14 Mar 2014 17:35:57 +0800
Message-ID: <1394789757-40732-2-git-send-email-B48286@freescale.com>
References: <1394789757-40732-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394789757-40732-1-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Get the spi_master's bus_num from DTS to make the spi_master's name
static. So "mtdparts=spi.bus_num.chip_select:..." in cmdline can be
used to asign mtd partions of spi flash.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-lib.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 0b75f26..f5f0307b 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -198,7 +198,7 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 	struct mpc8xxx_spi_probe_info *pinfo;
 	struct fsl_spi_platform_data *pdata;
 	const void *prop;
-	int ret = -ENOMEM;
+	int ret = -ENOMEM, bus_num;
 
 	pinfo = kzalloc(sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
@@ -207,8 +207,12 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 	pdata = &pinfo->pdata;
 	dev->platform_data = pdata;
 
-	/* Allocate bus num dynamically. */
-	pdata->bus_num = -1;
+	ret = of_property_read_u32(np, "bus-num", &bus_num);
+	if (ret < 0) {
+		/* Allocate bus num dynamically. */
+		bus_num = -1;
+	}
+	pdata->bus_num = bus_num;
 
 #ifdef CONFIG_FSL_SOC
 	/* SPI controller is either clocked from QE or SoC clock. */
-- 
1.8.5


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
