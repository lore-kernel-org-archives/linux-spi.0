From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: enable dma modes for transfers meeting certain conditions
Date: Sun, 10 May 2015 20:47:28 +0000
Message-ID: <1431290849-11151-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=46rom: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Conditions per spi_transfer are:
* transfer.len >=3D 96 bytes (to avoid mapping overhead costs)
* transfer.len < 65536 bytes (limitaion by spi-hw block - could get ext=
ended)
* an individual scatter/gather transfer length must be a multiple of 4
  for anything but the last transfer - spi-hw block limit.
  (some shortcut has been taken in can_dma to avoid unnecessary mapping=
 of
   pages which, for which there is a chance that there is a split with =
a
   transfer length not a multiple of 4)

If it becomes a necessity these restrictions can get removed by additio=
nal
code.

Note that this patch requires a patch to dma-bcm2835.c by Noralf to
enable scatter-gather mode inside the dmaengine, which has not been
merged yet.

That is why no patch to arch/arm/boot/dts/bcm2835.dtsi is included - th=
e
code works as before without dma when tx/rx are not set, but it writes
a message warning about dma not used:
spi-bcm2835 20204000.spi: no tx-dma configuration found - not using dma=
 mode

To enable dma-mode add the following lines to the device-tree:
        dmas =3D <&dma 6>, <&dma 7>;
        dma-names =3D "tx", "rx";

Tested-by: Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
(private communication)

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |  303 +++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 301 insertions(+), 2 deletions(-)

Tested with:
* 2x mcp251x
* 1x enc28j60
* 1x fb_st7735r

Note that to make it work it requires the patch to dma-engine by=20
Noralf Tronnes for scatter/gather DMA.

Also it is recommended that the patch for the race-condition in
spi_finalize_current_message is applied to avoid a free before unmap
situations (this only happens only in some configurations)=20

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 830d99c..6ab43c8 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -23,15 +23,18 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_gpio.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/spi/spi.h>
=20
 /* SPI register offsets */
@@ -70,6 +73,7 @@
=20
 #define BCM2835_SPI_POLLING_LIMIT_US	30
 #define BCM2835_SPI_POLLING_JIFFIES	2
+#define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
=20
@@ -83,6 +87,7 @@ struct bcm2835_spi {
 	u8 *rx_buf;
 	int tx_len;
 	int rx_len;
+	bool dma_pending;
 };
=20
 static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
@@ -128,12 +133,15 @@ static void bcm2835_spi_reset_hw(struct spi_maste=
r *master)
 	/* Disable SPI interrupts and transfer */
 	cs &=3D ~(BCM2835_SPI_CS_INTR |
 		BCM2835_SPI_CS_INTD |
+		BCM2835_SPI_CS_DMAEN |
 		BCM2835_SPI_CS_TA);
 	/* and reset RX/TX FIFOS */
 	cs |=3D BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX;
=20
 	/* and reset the SPI_HW */
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+	/* as well as DLEN */
+	bcm2835_wr(bs, BCM2835_SPI_DLEN, 0);
 }
=20
 static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
@@ -193,6 +201,279 @@ static int bcm2835_spi_transfer_one_irq(struct sp=
i_master *master,
 	return 1;
 }
=20
+/*
+ * DMA support
+ *
+ * this implementation has currently a few issues in so far as it does
+ * not work arrount limitations of the HW.
+ *
+ * the main one being that DMA transfers are limited to 16 bit
+ * (so 0 to 65535 bytes) by the SPI HW due to BCM2835_SPI_DLEN
+ *
+ * also we currently assume that the scatter-gather fragments are
+ * all multiple of 4 (except the last) - otherwise we would need
+ * to reset the FIFO before subsequent transfers...
+ * this also means that tx/rx transfers sg's need to be of equal size!
+ *
+ * there may be a few more border-cases we may need to address as well
+ * but unfortunately this would mean splitting up the scatter-gather
+ * list making it slightly unpractical...
+ */
+static void bcm2835_spi_dma_done(void *data)
+{
+	struct spi_master *master =3D data;
+	struct bcm2835_spi *bs =3D spi_master_get_devdata(master);
+
+	/* reset fifo and HW */
+	bcm2835_spi_reset_hw(master);
+
+	/* and terminate tx-dma as we do not have an irq for it
+	 * because when the rx dma will terminate and this callback
+	 * is called the tx-dma must have finished - can't get to this
+	 * situation otherwise...
+	 */
+	dmaengine_terminate_all(master->dma_tx);
+
+	/* mark as no longer pending */
+	bs->dma_pending =3D 0;
+
+	/* and mark as completed */;
+	complete(&master->xfer_completion);
+}
+
+static int bcm2835_spi_prepare_sg(struct spi_master *master,
+				  struct spi_transfer *tfr,
+				  bool is_tx)
+{
+	struct dma_chan *chan;
+	struct scatterlist *sgl;
+	unsigned int nents;
+	enum dma_transfer_direction dir;
+	unsigned long flags;
+
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+
+	if (is_tx) {
+		dir   =3D DMA_MEM_TO_DEV;
+		chan  =3D master->dma_tx;
+		nents =3D tfr->tx_sg.nents;
+		sgl   =3D tfr->tx_sg.sgl;
+		flags =3D 0 /* no  tx interrupt */;
+
+	} else {
+		dir   =3D DMA_DEV_TO_MEM;
+		chan  =3D master->dma_rx;
+		nents =3D tfr->rx_sg.nents;
+		sgl   =3D tfr->rx_sg.sgl;
+		flags =3D DMA_PREP_INTERRUPT;
+	}
+	/* prepare the channel */
+	desc =3D dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
+	if (!desc)
+		return -EINVAL;
+
+	/* set callback for rx */
+	if (!is_tx) {
+		desc->callback =3D bcm2835_spi_dma_done;
+		desc->callback_param =3D master;
+	}
+
+	/* submit it to DMA-engine */
+	cookie =3D dmaengine_submit(desc);
+
+	return dma_submit_error(cookie);
+}
+
+static inline int bcm2835_check_sg_length(struct sg_table *sgt)
+{
+	int i;
+	struct scatterlist *sgl;
+
+	/* check that the sg entries are word-sized (except for last) */
+	for_each_sg(sgt->sgl, sgl, (int)sgt->nents - 1, i) {
+		if (sg_dma_len(sgl) % 4)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
+					struct spi_device *spi,
+					struct spi_transfer *tfr,
+					u32 cs)
+{
+	struct bcm2835_spi *bs =3D spi_master_get_devdata(master);
+	int ret;
+
+	/* check that the scatter gather segments are all a multiple of 4 */
+	if (bcm2835_check_sg_length(&tfr->tx_sg) ||
+	    bcm2835_check_sg_length(&tfr->rx_sg)) {
+		dev_warn_once(&spi->dev,
+			      "scatter gather segment length is not a multiple of 4 - falli=
ng back to interrupt mode\n");
+		return bcm2835_spi_transfer_one_irq(master, spi, tfr, cs);
+	}
+
+	/* setup tx-DMA */
+	ret =3D bcm2835_spi_prepare_sg(master, tfr, true);
+	if (ret)
+		return ret;
+
+	/* start TX early */
+	dma_async_issue_pending(master->dma_tx);
+
+	/* mark as dma pending */
+	bs->dma_pending =3D 1;
+
+	/* set the DMA length */
+	bcm2835_wr(bs, BCM2835_SPI_DLEN, tfr->len);
+
+	/* start the HW */
+	bcm2835_wr(bs, BCM2835_SPI_CS,
+		   cs | BCM2835_SPI_CS_TA | BCM2835_SPI_CS_DMAEN);
+
+	/* setup rx-DMA late - to run transfers while
+	 * mapping of the rx buffers still takes place
+	 * this saves 10us or more.
+	 */
+	ret =3D bcm2835_spi_prepare_sg(master, tfr, false);
+	if (ret) {
+		/* need to reset on errors */
+		dmaengine_terminate_all(master->dma_tx);
+		bcm2835_spi_reset_hw(master);
+		return ret;
+	}
+
+	/* start rx dma late */
+	dma_async_issue_pending(master->dma_rx);
+
+	/* wait for wakeup in framework */
+	return 1;
+}
+
+static bool bcm2835_spi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *tfr)
+{
+	/* only run for gpio_cs */
+	if (!gpio_is_valid(spi->cs_gpio))
+		return false;
+
+	/* we start DMA efforts only on bigger transfers */
+	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
+		return false;
+
+	/* BCM2835_SPI_DLEN has defined a max transfer size as
+	 * 16 bit, so max is 65535
+	 * we can revisit this by using an alternative transfer
+	 * method - ideally this would get done without any more
+	 * interaction...
+	 */
+	if (tfr->len > 65535) {
+		dev_warn_once(&spi->dev,
+			      "transfer size of %d too big for dma-transfer\n",
+			      tfr->len);
+		return false;
+	}
+
+	/* if we run rx/tx_buf with word aligned addresses then we are OK */
+	if (((u32)tfr->tx_buf % 4 =3D=3D 0) && ((u32)tfr->tx_buf % 4 =3D=3D 0=
))
+		return true;
+
+	/* otherwise we only allow transfers within the same page
+	 * to avoid wasting time on dma_mapping when it is not practical
+	 */
+	if (((u32)tfr->tx_buf % SZ_4K) + tfr->len > SZ_4K) {
+		dev_warn_once(&spi->dev,
+			      "Unaligned spi tx-transfer bridging page\n");
+		return false;
+	}
+	if (((u32)tfr->rx_buf % SZ_4K) + tfr->len > SZ_4K) {
+		dev_warn_once(&spi->dev,
+			      "Unaligned spi tx-transfer bridging page\n");
+		return false;
+	}
+
+	/* return OK */
+	return true;
+}
+
+void bcm2835_dma_release(struct spi_master *master)
+{
+	if (master->dma_tx) {
+		dmaengine_terminate_all(master->dma_tx);
+		dma_release_channel(master->dma_tx);
+		master->dma_tx =3D NULL;
+	}
+	if (master->dma_rx) {
+		dmaengine_terminate_all(master->dma_rx);
+		dma_release_channel(master->dma_rx);
+		master->dma_rx =3D NULL;
+	}
+}
+
+void bcm2835_dma_init(struct spi_master *master, struct device *dev)
+{
+	struct dma_slave_config slave_config;
+	const __be32 *addr;
+	dma_addr_t dma_reg_base;
+	int ret;
+
+	/* base address in dma-space */
+	addr =3D of_get_address(master->dev.of_node, 0, NULL, NULL);
+	if (!addr) {
+		dev_err(dev, "could not get DMA-register address - not using dma mod=
e\n");
+		goto err;
+	}
+	dma_reg_base =3D be32_to_cpup(addr);
+
+	/* get tx/rx dma */
+	master->dma_tx =3D dma_request_slave_channel(dev, "tx");
+	if (!master->dma_tx) {
+		dev_err(dev, "no tx-dma configuration found - not using dma mode\n")=
;
+		goto err;
+	}
+	master->dma_rx =3D dma_request_slave_channel(dev, "rx");
+	if (!master->dma_rx) {
+		dev_err(dev, "no rx-dma configuration found - not using dma mode\n")=
;
+		goto err_release;
+	}
+
+	/* configure DMAs */
+	slave_config.direction =3D DMA_MEM_TO_DEV;
+	slave_config.dst_addr =3D (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret =3D dmaengine_slave_config(master->dma_tx, &slave_config);
+	if (ret)
+		goto err_config;
+
+	slave_config.direction =3D DMA_DEV_TO_MEM;
+	slave_config.src_addr =3D (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	ret =3D dmaengine_slave_config(master->dma_rx, &slave_config);
+	if (ret)
+		goto err_config;
+
+	/* all went well, so set can_dma */
+	master->can_dma =3D bcm2835_spi_can_dma;
+	master->max_dma_len =3D 65535; /* limitation by BCM2835_SPI_DLEN */
+	/* need to do TX AND RX DMA, so we need dummy buffers */
+	master->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+
+	return;
+
+err_config:
+	dev_err(dev, "issue configuring dma: %d - not using DMA mode\n",
+		ret);
+err_release:
+	bcm2835_dma_release(master);
+err:
+	return;
+}
+
 static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 struct spi_device *spi,
 					 struct spi_transfer *tfr,
@@ -301,12 +582,26 @@ static int bcm2835_spi_transfer_one(struct spi_ma=
ster *master,
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr,
 						     cs, xfer_time_us);
=20
+	/* run in dma mode if conditions are right */
+	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
+		return bcm2835_spi_transfer_one_dma(master, spi, tfr, cs);
+
+	/* run in interrupt-mode */
 	return bcm2835_spi_transfer_one_irq(master, spi, tfr, cs);
 }
=20
 static void bcm2835_spi_handle_err(struct spi_master *master,
 				   struct spi_message *msg)
 {
+	struct bcm2835_spi *bs =3D spi_master_get_devdata(master);
+
+	/* if an error occurred and we have an active dma, then terminate */
+	if (bs->dma_pending) {
+		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(master->dma_rx);
+		bs->dma_pending =3D 0;
+	}
+	/* and reset */
 	bcm2835_spi_reset_hw(master);
 }
=20
@@ -476,6 +771,8 @@ static int bcm2835_spi_probe(struct platform_device=
 *pdev)
 		goto out_clk_disable;
 	}
=20
+	bcm2835_dma_init(master, &pdev->dev);
+
 	/* initialise the hardware with the default polarities */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
@@ -506,6 +803,8 @@ static int bcm2835_spi_remove(struct platform_devic=
e *pdev)
=20
 	clk_disable_unprepare(bs->clk);
=20
+	bcm2835_dma_release(master);
+
 	return 0;
 }
=20
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
