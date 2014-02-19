From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [RFT][PATCH 1/2] spi: octeon: Remove struct octeon_spi_setup usage
Date: Wed, 19 Feb 2014 17:30:52 +0800
Message-ID: <1392802252.7991.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Current code uses struct octeon_spi_setup to store max_speed_hz, chip_select and
mode settings of current spi device.
We can always get the same settings in octeon_spi_do_transfer() by msg->spi.
So this patch removes struct octeon_spi_setup and octeon_spi_setup,
octeon_spi_cleanup functions.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-octeon.c | 69 +++++-------------------------------------------
 1 file changed, 7 insertions(+), 62 deletions(-)

diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index c54c083..b47245c 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -32,12 +32,6 @@ struct octeon_spi {
 	u64 cs_enax;
 };
 
-struct octeon_spi_setup {
-	u32 max_speed_hz;
-	u8 chip_select;
-	u8 mode;
-};
-
 static void octeon_spi_wait_ready(struct octeon_spi *p)
 {
 	union cvmx_mpi_sts mpi_sts;
@@ -55,6 +49,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 				  struct spi_transfer *xfer,
 				  bool last_xfer)
 {
+	struct spi_device *spi = msg->spi;
 	union cvmx_mpi_cfg mpi_cfg;
 	union cvmx_mpi_tx mpi_tx;
 	unsigned int clkdiv;
@@ -66,16 +61,11 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	int len;
 	int i;
 
-	struct octeon_spi_setup *msg_setup = spi_get_ctldata(msg->spi);
-
-	speed_hz = msg_setup->max_speed_hz;
-	mode = msg_setup->mode;
+	mode = spi->mode;
 	cpha = mode & SPI_CPHA;
 	cpol = mode & SPI_CPOL;
 
-	if (xfer->speed_hz)
-		speed_hz = xfer->speed_hz;
-
+	speed_hz = xfer->speed_hz ? : spi->max_speed_hz;
 	if (speed_hz > OCTEON_SPI_MAX_CLOCK_HZ)
 		speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
@@ -91,8 +81,8 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	mpi_cfg.s.cslate = cpha ? 1 : 0;
 	mpi_cfg.s.enable = 1;
 
-	if (msg_setup->chip_select < 4)
-		p->cs_enax |= 1ull << (12 + msg_setup->chip_select);
+	if (spi->chip_select < 4)
+		p->cs_enax |= 1ull << (12 + spi->chip_select);
 	mpi_cfg.u64 |= p->cs_enax;
 
 	if (mpi_cfg.u64 != p->last_cfg) {
@@ -112,7 +102,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 			cvmx_write_csr(p->register_base + OCTEON_SPI_DAT0 + (8 * i), d);
 		}
 		mpi_tx.u64 = 0;
-		mpi_tx.s.csid = msg_setup->chip_select;
+		mpi_tx.s.csid = spi->chip_select;
 		mpi_tx.s.leavecs = 1;
 		mpi_tx.s.txnum = tx_buf ? OCTEON_SPI_MAX_BYTES : 0;
 		mpi_tx.s.totnum = OCTEON_SPI_MAX_BYTES;
@@ -137,7 +127,7 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	}
 
 	mpi_tx.u64 = 0;
-	mpi_tx.s.csid = msg_setup->chip_select;
+	mpi_tx.s.csid = spi->chip_select;
 	if (last_xfer)
 		mpi_tx.s.leavecs = xfer->cs_change;
 	else
@@ -167,15 +157,6 @@ static int octeon_spi_transfer_one_message(struct spi_master *master,
 	int status = 0;
 	struct spi_transfer *xfer;
 
-	/*
-	 * We better have set the configuration via a call to .setup
-	 * before we get here.
-	 */
-	if (spi_get_ctldata(msg->spi) == NULL) {
-		status = -EINVAL;
-		goto err;
-	}
-
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		bool last_xfer = list_is_last(&xfer->transfer_list,
 					      &msg->transfers);
@@ -193,40 +174,6 @@ err:
 	return status;
 }
 
-static struct octeon_spi_setup *octeon_spi_new_setup(struct spi_device *spi)
-{
-	struct octeon_spi_setup *setup = kzalloc(sizeof(*setup), GFP_KERNEL);
-	if (!setup)
-		return NULL;
-
-	setup->max_speed_hz = spi->max_speed_hz;
-	setup->chip_select = spi->chip_select;
-	setup->mode = spi->mode;
-	return setup;
-}
-
-static int octeon_spi_setup(struct spi_device *spi)
-{
-	struct octeon_spi_setup *new_setup;
-	struct octeon_spi_setup *old_setup = spi_get_ctldata(spi);
-
-	new_setup = octeon_spi_new_setup(spi);
-	if (!new_setup)
-		return -ENOMEM;
-
-	spi_set_ctldata(spi, new_setup);
-	kfree(old_setup);
-
-	return 0;
-}
-
-static void octeon_spi_cleanup(struct spi_device *spi)
-{
-	struct octeon_spi_setup *old_setup = spi_get_ctldata(spi);
-	spi_set_ctldata(spi, NULL);
-	kfree(old_setup);
-}
-
 static int octeon_spi_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem;
@@ -262,8 +209,6 @@ static int octeon_spi_probe(struct platform_device *pdev)
 			    SPI_LSB_FIRST |
 			    SPI_3WIRE;
 
-	master->setup = octeon_spi_setup;
-	master->cleanup = octeon_spi_cleanup;
 	master->transfer_one_message = octeon_spi_transfer_one_message;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
