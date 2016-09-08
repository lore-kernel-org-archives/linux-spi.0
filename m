From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] spi: meson: Add GXBB compatible
Date: Thu,  8 Sep 2016 09:53:26 +0200
Message-ID: <1473321206-32284-3-git-send-email-narmstrong@baylibre.com>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, carlo@caione.org, khilman@baylibre.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spifc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 2465259..616566e 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -442,6 +442,7 @@ static const struct dev_pm_ops meson_spifc_pm_ops = {
 
 static const struct of_device_id meson_spifc_dt_match[] = {
 	{ .compatible = "amlogic,meson6-spifc", },
+	{ .compatible = "amlogic,meson-gxbb-spifc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, meson_spifc_dt_match);
-- 
1.9.1
