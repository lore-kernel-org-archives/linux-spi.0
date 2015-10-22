From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: disable other channels CHCONF_FORCE in prepare_message" to the spi tree
Date: Fri, 23 Oct 2015 08:10:58 +0900
Message-ID: <E1ZpP0c-0000Lp-2a@finisterre>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap2-mcspi: disable other channels CHCONF_FORCE in prepare_message

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 468a32082b04c7febccfcd55b06ecbc438fcddcc Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Date: Fri, 9 Oct 2015 15:47:41 +0200
Subject: [PATCH] spi: omap2-mcspi: disable other channels CHCONF_FORCE in
 prepare_message

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
Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Reviewed-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

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
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
