From: <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 1/2] spi: stm32-qspi: defer probe for reset controller
Date: Mon, 3 Feb 2020 14:50:47 +0100
Message-ID: <20200203135048.1299-2-patrice.chotard@st.com>
References: <20200203135048.1299-1-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <patrice.chotard-qxv4g6HH51o@public.gmane.org>, <christophe.kerello-qxv4g6HH51o@public.gmane.org>,
        Etienne Carriere <etienne.carriere-qxv4g6HH51o@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200203135048.1299-1-patrice.chotard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Etienne Carriere <etienne.carriere-qxv4g6HH51o@public.gmane.org>

Changes stm32 QSPI driver to defer its probe operation when a reset
controller device have not yet probed but is registered in the
system.

Signed-off-by: Etienne Carriere <etienne.carriere-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-stm32-qspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 4ef569b47aa6..13bb64bf4c8f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -615,7 +615,11 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
-	if (!IS_ERR(rstc)) {
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		if (ret == -EPROBE_DEFER)
+			goto err;
+	} else {
 		reset_control_assert(rstc);
 		udelay(2);
 		reset_control_deassert(rstc);
-- 
2.17.1
