From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] spi: meson-axg: Fix error handling in meson_spicc_probe()
Date: Sat, 14 Apr 2018 00:39:46 +0300
Message-ID: <1523655586-4163-1-git-send-email-khoroshilov@ispras.ru>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
To: Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If devm_spi_register_master() fails in meson_spicc_probe(),
spicc->core is left undisabled. The patch fixes that.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/spi/spi-meson-spicc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 5c82910e3480..7fe4488ace57 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -574,10 +574,15 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		master->max_speed_hz = rate >> 2;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-	if (!ret)
-		return 0;
+	if (ret) {
+		dev_err(&pdev->dev, "spi master registration failed\n");
+		goto out_clk;
+	}
 
-	dev_err(&pdev->dev, "spi master registration failed\n");
+	return 0;
+
+out_clk:
+	clk_disable_unprepare(spicc->core);
 
 out_master:
 	spi_master_put(master);
-- 
2.7.4
