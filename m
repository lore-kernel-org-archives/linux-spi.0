From: Shailendra Verma <shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 10:25:13 +0530
Message-ID: <1485752113-29581-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130045527epcas2p18ca90e9cd6b0a6153bf941eec4f40ddf@epcas2p1.samsung.com>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, p.shailesh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
        ashish.kalra-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
        Shailendra Verma <shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-mxs.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 5b0e9a3..c3aea7e 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -470,6 +470,11 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	 */
 	const int clk_freq_default = 160000000;
 
+	if (!of_id) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
+
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_err = platform_get_irq(pdev, 0);
 	if (irq_err < 0)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
