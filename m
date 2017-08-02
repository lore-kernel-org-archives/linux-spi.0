From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 14/23] spi: rockchip: add compatible string for rv1108 spi
Date: Wed,  2 Aug 2017 16:46:03 +0800
Message-ID: <1501663563-12482-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        Andy Yan <andy.yan@rock-chips.com>
To: heiko@sntech.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi on rv1108 is the same as other rockchip based
socs, add compatible string for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

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
