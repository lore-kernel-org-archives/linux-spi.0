From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4 1/8] spi: rockchip: add compatible string for rv1108 spi
Date: Mon, 14 Aug 2017 16:34:22 +0800
Message-ID: <1502699662-8181-1-git-send-email-andy.yan@rock-chips.com>
References: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502699477-8063-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi on rv1108 is the same as other rockchip based
socs, add compatible string for it.

Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
 drivers/spi/spi-rockchip.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 83da493..6e3ffac 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -6,6 +6,7 @@ and display controllers using the SPI communication interface.
 Required Properties:
 
 - compatible: should be one of the following.
+    "rockchip,rv1108-spi" for rv1108 SoCs.
     "rockchip,rk3036-spi" for rk3036 SoCS.
     "rockchip,rk3066-spi" for rk3066 SoCs.
     "rockchip,rk3188-spi" for rk3188 SoCs.
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0b4a52b..27b4db2 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -919,6 +919,7 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
+	{ .compatible = "rockchip,rv1108-spi", },
 	{ .compatible = "rockchip,rk3036-spi", },
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
