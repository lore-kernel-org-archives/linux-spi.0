From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/5] spi: uniphier: Add SPI_LOOP to the capabilities
Date: Tue, 24 Dec 2019 09:58:26 +0900
Message-ID: <1577149107-30670-5-git-send-email-hayashi.kunihiko@socionext.com>
References: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add SPI_LOOP to the capabilities to support loopback mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-uniphier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c4e3b96..caf0446 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -543,7 +543,8 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	master->max_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MIN_CLK_DIVIDER);
 	master->min_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MAX_CLK_DIVIDER);
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    SPI_LOOP;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = pdev->id;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-- 
2.7.4
