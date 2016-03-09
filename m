From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 2/3] spi/spi-xilinx:  Add clock support
Date: Wed, 9 Mar 2016 14:17:21 +0530
Message-ID: <1457513242-11202-2-git-send-email-shubhraj@xilinx.com>
References: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457513242-11202-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add basic clock support. The clocks are requested at probe
and released at remove.

Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v2 changes
Add ack

 drivers/spi/spi-xilinx.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121..7e12338 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi_bitbang.h>
 #include <linux/spi/xilinx_spi.h>
 #include <linux/io.h>
+#include <linux/clk.h>
=20
 #define XILINX_SPI_MAX_CS	32
=20
@@ -83,6 +84,7 @@ struct xilinx_spi {
 	struct spi_bitbang bitbang;
 	struct completion done;
 	void __iomem	*regs;	/* virt. address of the control registers */
+	struct clk *clk;
=20
 	int		irq;
=20
@@ -428,6 +430,15 @@ static int xilinx_spi_probe(struct platform_device=
 *pdev)
 		goto put_master;
 	}
=20
+	xspi->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(xspi->clk)) {
+		dev_err(&pdev->dev, "input clock not found.\n");
+		return PTR_ERR(xspi->clk);
+	}
+	ret =3D clk_prepare_enable(xspi->clk);
+	if (ret)
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+
 	master->bus_num =3D pdev->id;
 	master->num_chipselect =3D num_cs;
 	master->dev.of_node =3D pdev->dev.of_node;
@@ -485,6 +496,7 @@ static int xilinx_spi_probe(struct platform_device =
*pdev)
=20
 put_master:
 	spi_master_put(master);
+	clk_disable_unprepare(xspi->clk);
=20
 	return ret;
 }
@@ -503,6 +515,7 @@ static int xilinx_spi_remove(struct platform_device=
 *pdev)
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
=20
 	spi_master_put(xspi->bitbang.master);
+	clk_disable_unprepare(xspi->clk);
=20
 	return 0;
 }
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
