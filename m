From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rockchip: limit transfers to (64K - 1) bytes" to the spi tree
Date: Wed, 20 Jul 2016 17:44:04 +0100
Message-ID: <E1bPubM-0002u3-AQ@debutante>
References: <1468546259-136659-1-git-send-email-briannorris@chromium.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Eddie Cai <eddie.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468546259-136659-1-git-send-email-briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rockchip: limit transfers to (64K - 1) bytes

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

>From 5185a81c02d4118b11e6cb7b5fbf6f15ff7aff90 Mon Sep 17 00:00:00 2001
From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Thu, 14 Jul 2016 18:30:59 -0700
Subject: [PATCH] spi: rockchip: limit transfers to (64K - 1) bytes

The Rockchip SPI controller's length register only supports 16-bits,
yielding a maximum length of 64KiB (the CTRLR1 register holds "length -
1"). Trying to transfer more than that (e.g., with a large SPI flash
read) will cause the driver to hang.

Now, it seems that while theoretically we should be able to program
CTRLR1 with 0xffff, and get a 64KiB transfer, but that also seems to
cause the core to choke, so stick with a maximum of 64K - 1 bytes --
i.e., 0xffff.

Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index cd89682065b9..cf69f4dfb8c7 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -142,6 +142,12 @@
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
 #define MAX_SCLK_OUT		50000000
 
+/*
+ * SPI_CTRLR1 is 16-bits, so we should support lengths of 0xffff + 1. However,
+ * the controller seems to hang when given 0x10000, so stick with this for now.
+ */
+#define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
+
 enum rockchip_ssi_type {
 	SSI_MOTO_SPI = 0,
 	SSI_TI_SSP,
@@ -573,6 +579,11 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	dev_dbg(rs->dev, "cr0 0x%x, div %d\n", cr0, div);
 }
 
+static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
+{
+	return ROCKCHIP_SPI_MAX_TRANLEN;
+}
+
 static int rockchip_spi_transfer_one(
 		struct spi_master *master,
 		struct spi_device *spi,
@@ -589,6 +600,11 @@ static int rockchip_spi_transfer_one(
 		return -EINVAL;
 	}
 
+	if (xfer->len > ROCKCHIP_SPI_MAX_TRANLEN) {
+		dev_err(rs->dev, "Transfer is too long (%d)\n", xfer->len);
+		return -EINVAL;
+	}
+
 	rs->speed = xfer->speed_hz;
 	rs->bpw = xfer->bits_per_word;
 	rs->n_bytes = rs->bpw >> 3;
@@ -728,6 +744,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->prepare_message = rockchip_spi_prepare_message;
 	master->unprepare_message = rockchip_spi_unprepare_message;
 	master->transfer_one = rockchip_spi_transfer_one;
+	master->max_transfer_size = rockchip_spi_max_transfer_size;
 	master->handle_err = rockchip_spi_handle_err;
 
 	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
