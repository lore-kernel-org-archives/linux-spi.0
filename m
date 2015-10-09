From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] spi: omap2-mcspi: disable other channels CHCONF_FORCE in
 prepare_message
Date: Fri, 9 Oct 2015 15:47:41 +0200
Message-ID: <5617C57D.9080902@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael Welling <mwelling@ieee.org>,
	Fionn Cleary <clearyf@tcd.ie>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since the "Switch driver to use transfer_one" change, the cs_change
behavior has changed and a channel chip select can still be
asserted when changing channel from a previous last transfer in a
message having the cs_change attribute.

Since there is no sense having multiple chip select being asserted at the
same time, disable all the remaining forced chip selects in a the
prepare_message called right before a spi_transfer_one_message call.
It ignores the current channel configuration in order to keep the
possibility to leave the chip select asserted between messages.

It fixes this bug on a DM8168 SoC ES2.1 Soc and an OMAP4 ES2.1 SoC.
It was hanging all the other channels transfers when a CHCONF_FORCE
is present on the wrong channel.

Fixes: b28cb9414db9 ("spi: omap2-mcspi: Switch driver to use transfer_one")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-omap2-mcspi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Test code can be found on :
http://pastebin.com/0SrqbGP7

Before patch :
# ./test_spi
cs_change_command() start
spidev1.3 ioctl success
no_dma_command() start
[   59.790069] spidev spi1.1: TXS timed out
spidev1.1 ioctl success
cs_change_command() start
[   60.798736] spidev spi1.3: RXS timed out
spidev1.3 ioctl success
no_dma_command() start
[   61.802032] spidev spi1.1: TXS timed out
spidev1.1 ioctl success
cs_change_command() start
[   62.807525] spidev spi1.3: RXS timed out
spidev1.3 ioctl success
no_dma_command() start
[   63.812042] spidev spi1.1: TXS timed out
spidev1.1 ioctl success
...

After Patch :
# ./test_spi
cs_change_command() start
spidev1.3 ioctl success
no_dma_command() start
spidev1.1 ioctl success
cs_change_command() start
spidev1.3 ioctl success
no_dma_command() start
spidev1.1 ioctl success
cs_change_command() start
spidev1.3 ioctl success
...

v2: uses msg to leave asserted chip select for the current channel

This is a patch RFC following the bug report :
'McSPI hangs with cs_change after "Switch driver to use transfer_one" change'
http://permalink.gmane.org/gmane.linux.kernel/2056841

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3d09e0b..1f8903d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1217,6 +1217,33 @@ out:
 	return status;
 }

+static int omap2_mcspi_prepare_message(struct spi_master *master,
+				       struct spi_message *msg)
+{
+	struct omap2_mcspi	*mcspi = spi_master_get_devdata(master);
+	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
+	struct omap2_mcspi_cs	*cs;
+
+	/* Only a single channel can have the FORCE bit enabled
+	 * in its chconf0 register.
+	 * Scan all channels and disable them except the current one.
+	 * A FORCE can remain from a last transfer having cs_change enabled
+	 */
+	list_for_each_entry(cs, &ctx->cs, node) {
+		if (msg->spi->controller_state == cs)
+			continue;
+
+		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE)) {
+			cs->chconf0 &= ~OMAP2_MCSPI_CHCONF_FORCE;
+			writel_relaxed(cs->chconf0,
+					cs->base + OMAP2_MCSPI_CHCONF0);
+			readl_relaxed(cs->base + OMAP2_MCSPI_CHCONF0);
+		}
+	}
+
+	return 0;
+}
+
 static int omap2_mcspi_transfer_one(struct spi_master *master,
 		struct spi_device *spi, struct spi_transfer *t)
 {
@@ -1344,6 +1371,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = omap2_mcspi_setup;
 	master->auto_runtime_pm = true;
+	master->prepare_message = omap2_mcspi_prepare_message;
 	master->transfer_one = omap2_mcspi_transfer_one;
 	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
-- 
1.9.1
