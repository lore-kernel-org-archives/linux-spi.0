From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-axi: extend support for the `delay` field" to the
 spi tree
Date: Tue, 15 Oct 2019 12:12:21 +0100 (BST)
Message-ID: <20191015111221.CAFB92741CD7@ypsilon.sirena.org.uk>
References: <20190926105147.7839-20-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: f.fainelli@gmail.com, baolin.wang@linaro.org, linux-iio@vger.kernel.org,
 zhang.lyra@gmail.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, orsonzhai@gmail.com, jic23@kernel.org
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190926105147.7839-20-alexandru.ardelean@analog.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-axi: extend support for the `delay` field

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From acc7720de3cb9721ac07f68309dd6d7aae8e9a7a Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:47 +0300
Subject: [PATCH] spi: spi-axi: extend support for the `delay` field

The AXI SPI engine driver uses the `delay_usecs` field from `spi_transfer`
to configure delays, which the controller will execute.
This change extends the logic to also include the `delay` value, in case it
is used (instead if `delay_usecs`).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-20-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-axi-spi-engine.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 74842f6019ed..eb9b78a90dcf 100644
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
