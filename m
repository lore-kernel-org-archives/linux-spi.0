From: Takuo Koguchi <takuo.koguchi@gmail.com>
Subject: [PATCH] spi: sun4i: disable clocks in the remove function
Date: Thu,  7 Dec 2017 00:22:13 +0900
Message-ID: <1512573752-13091-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Cc: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: lkml@vger.kernel.org, khoroshilov@ispras.ru,
        takuo.koguchi.sw@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

mclk and hclk need to be disabled explicitly since pm_runtime_disable does
not disable the clocks.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
---
 drivers/spi/spi-sun4i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635..9011c09 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -525,6 +525,11 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master = dev_get_drvdata(&pdev->dev);
+	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(sspi->mclk);
+	clk_disable_unprepare(sspi->hclk);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.7.4
