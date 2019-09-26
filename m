From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 19/19] spi: spi-axi: extend support for the `delay` field
Date: Thu, 26 Sep 2019 13:51:47 +0300
Message-ID: <20190926105147.7839-20-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The AXI SPI engine driver uses the `delay_usecs` field from `spi_transfer`
to configure delays, which the controller will execute.
This change extends the logic to also include the `delay` value, in case it
is used (instead if `delay_usecs`).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3b1833e6c7ad..111d3b83285f 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -163,10 +163,21 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-	struct spi_engine *spi_engine, unsigned int clk_div, unsigned int delay)
+	struct spi_engine *spi_engine, unsigned int clk_div,
+	struct spi_transfer *xfer)
 {
 	unsigned int spi_clk = clk_get_rate(spi_engine->ref_clk);
 	unsigned int t;
+	int delay;
+
+	if (xfer->delay_usecs) {
+		delay = xfer->delay_usecs;
+	} else {
+		delay = spi_delay_to_ns(&xfer->delay, xfer);
+		if (delay < 0)
+			return;
+		delay /= 1000;
+	}
 
 	if (delay == 0)
 		return;
@@ -218,8 +229,7 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 			spi_engine_gen_cs(p, dry, spi, true);
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, spi_engine, clk_div,
-			xfer->delay_usecs);
+		spi_engine_gen_sleep(p, dry, spi_engine, clk_div, xfer);
 
 		cs_change = xfer->cs_change;
 		if (list_is_last(&xfer->transfer_list, &msg->transfers))
-- 
2.20.1
