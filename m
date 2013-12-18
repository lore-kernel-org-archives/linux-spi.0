From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi: spi-imx: Fix out-of-order CS/SCLK operation at low speeds
Date: Wed, 18 Dec 2013 18:31:47 +0100
Message-ID: <1387387907-19756-1-git-send-email-marex@denx.de>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Problem:
--------
 The problem this patch addresses has the following assumptions about the
 SPI bus setup:
 - The hardware used to find this is Freescale i.MX537 @ 1200MHz
 - The SPI SCLK operate at very low speed, less than 200 kHz
 - There are two SPI devices attached to the bus
   - Each device uses different GPIO for chipselect
   - Each device requires different SCLK signal polarity

 The observation of the SCLK and GPIO chipselect lines with a logic analyzer
 shows, that the SCLK polarity change does sometimes happen after the GPIO
 chipselect is asserted. The SPI slave device reacts on that by counting the
 SCLK polarity change as a clock pulse, which disrupts the communication with
 the SPI slave device.

Explanation:
------------
 We found an interesting correlation, that the maximum delay between the write
 into the ECSPIx_CONFIGREG register and the change of SCLK polarity at each
 SCLK frequency of 10 kHz, 20 kHz, 50 kHz and 100 kHz is 100 uS, 50 uS, 20 uS
 and 10 uS respectively. This lead us to a theory, that at SCLK frequency of
 1 Hz, the delay would be 1 S. Therefore, the time it takes for the write to
 ECSPIx_CONFIGREG to take effect in the hardware is up to the duration of 1
 tick of the SCLK clock.

 During this delay period, if the SCLK frequency is too low, the execution of
 the spi-imx.c driver can advance so much, that the GPIO chipselect will be
 asserted. The GPIO chipselect is asserted almost immediatelly.

Solution:
---------
 The solution this patch presents is simple. We calculate the resulting SCLK
 clock first by dividing the ECSPI block clock by both dividers that are to be
 programmed into the configuration register. Based on the resulting SCLK clock,
 we derive the delay it will take for the changes to get really applied. We are
 extra careful here so we delay twice as long as we should. Note that the patch
 does not create additional overhead at high speeds as the delay will likely be
 close to zero there.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b80f2f7..a5474ef 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -206,7 +206,8 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
 #define MX51_ECSPI_STAT_RR		(1 <<  3)
 
 /* MX51 eCSPI */
-static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi)
+static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
+				      unsigned int *fres)
 {
 	/*
 	 * there are two 4-bit dividers, the pre-divider divides by
@@ -234,6 +235,10 @@ static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi)
 
 	pr_debug("%s: fin: %u, fspi: %u, post: %u, pre: %u\n",
 			__func__, fin, fspi, post, pre);
+
+	/* Resulting frequency for the SCLK line. */
+	*fres = (fin / (pre + 1)) >> post;
+
 	return (pre << MX51_ECSPI_CTRL_PREDIV_OFFSET) |
 		(post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
 }
@@ -264,6 +269,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
+	u32 clk = config->speed_hz, delay;
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -275,7 +281,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/* set clock speed */
-	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz);
+	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz, &clk);
 
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
@@ -297,6 +303,23 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
+	/*
+	 * Wait until the changes in the configuration register CONFIGREG
+	 * propagate into the hardware. It takes exactly one tick of the
+	 * SCLK clock, but we will wait two SCLK clock just to be sure. The
+	 * effect of the delay it takes for the hardware to apply changes
+	 * is noticable if the SCLK clock run very slow. In such a case, if
+	 * the polarity of SCLK should be inverted, the GPIO ChipSelect might
+	 * be asserted before the SCLK polarity changes, which would disrupt
+	 * the SPI communication as the device on the other end would consider
+	 * the change of SCLK polarity as a clock tick already.
+	 */
+	delay = (2 * 1000000) / clk;
+	if (likely(delay < 10))	/* SCLK is faster than 100 kHz */
+		udelay(delay);
+	else			/* SCLK is _very_ slow */
+		usleep_range(delay, delay + 10);
+
 	return 0;
 }
 
-- 
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
