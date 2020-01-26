From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] spi: fspi: enable fspi on imx8qxp and imx8mm
Date: Sun, 26 Jan 2020 08:09:08 -0600
Message-ID: <20200126140913.2139260-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: han.xu-3arQi8VN3Tc@public.gmane.org, Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>

Pull in this patch from NXP's upstream repo to
enable fspi on imx8qxp and imx8mm

Signed-off-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 8c5084a3a617..00c7899428a1 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -324,6 +324,22 @@ static const struct nxp_fspi_devtype_data lx2160a_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static const struct nxp_fspi_devtype_data imx8mm_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.little_endian = true,  /* little-endian    */
+};
+
+static const struct nxp_fspi_devtype_data imx8qxp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1076,6 +1092,8 @@ static int nxp_fspi_resume(struct device *dev)
 
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
+	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
+	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
-- 
2.24.0
