From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi-imx: hung task caused by vfs_read
Date: Wed, 2 Mar 2016 19:40:20 +0900
Message-ID: <20160302104020.GI18327@sirena.org.uk>
References: <CAH9NwWf_aDqnd3bbuYs+Fn8E50kh9bR3g8BYvVnFNKSAJe34dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mCWPyKcwNv47Ozt6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAH9NwWf_aDqnd3bbuYs+Fn8E50kh9bR3g8BYvVnFNKSAJe34dg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mCWPyKcwNv47Ozt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 09:34:07AM +0100, Christian Gmeiner wrote:

> I am currently investigating on an issue with spi-imx on a imx6d based
> platform. It looks like that between 4.1.7 and 4.1.17 a regression was
> introduced.
> A user space application tries to read from an eeprom via /dev/mtd0ro
> and from time to time the task hungs during reading that eeprom. I
> will start
> to run a bisect but as the problem does not occur every read it can
> take some time to tell if the problem still does exist or not. The
> thing that makes it
> harder is that only during boot the application reads that eeprom -
> lets see if I can speed up the process.

Please copy driver authors when mailing about problems, in this case
that includes both the EEPROM and the SPI controller driver authors...
I just took a look at the set of changes between v4.1.7 and v4.1.17 and
can't see any non-documentation changes in either the core or the i.MX
driver so it looks like something outside SPI.

Guenter Roeck (1):
      spi: Fix documentation of spi_alloc_master()

Koji Matsuoka (1):
      spi: sh-msiof: Fix FIFO size to 64 word from 256 word

Lars Persson (1):
      spi: Fix regression in spi-bitbang-txrx.h

Martin Sperl (1):
      spi: bcm2835: set up spi-mode before asserting cs-gpio

Max Filippov (1):
      spi: xtensa-xtfpga: fix register endianness

Michael van der Westhuizen (1):
      spi: dw: Allow interface drivers to limit data I/O to word sizes

Ricardo Ribalda Delgado (2):
      spi/spi-xilinx: Fix spurious IRQ ACK on irq mode
      spi/spi-xilinx: Fix mixed poll/irq mode

Sifan Naeem (3):
      spi: img-spfi: check for timeout error before proceeding
      spi: img-spfi: fix multiple calls to request gpio
      spi: img-spfi: fix kbuild test robot warning

Sudip Mukherjee (1):
      spi: spidev: fix possible NULL dereference

Tan, Jui Nee (1):
      spi: spi-pxa2xx: Check status register to determine if SSSR_TINT is d=
isabled

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 37875cf942f7..a5067739ee93 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -257,13 +257,11 @@ static int bcm2835_spi_transfer_one(struct spi_master=
 *master,
 	spi_used_hz =3D cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
=20
-	/* handle all the modes */
+	/* handle all the 3-wire mode */
 	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
 		cs |=3D BCM2835_SPI_CS_REN;
-	if (spi->mode & SPI_CPOL)
-		cs |=3D BCM2835_SPI_CS_CPOL;
-	if (spi->mode & SPI_CPHA)
-		cs |=3D BCM2835_SPI_CS_CPHA;
+	else
+		cs &=3D ~BCM2835_SPI_CS_REN;
=20
 	/* for gpio_cs set dummy CS so that no HW-CS get changed
 	 * we can not run this in bcm2835_spi_set_cs, as it does
@@ -291,6 +289,25 @@ static int bcm2835_spi_transfer_one(struct spi_master =
*master,
 	return bcm2835_spi_transfer_one_irq(master, spi, tfr, cs);
 }
=20
+static int bcm2835_spi_prepare_message(struct spi_master *master,
+				       struct spi_message *msg)
+{
+	struct spi_device *spi =3D msg->spi;
+	struct bcm2835_spi *bs =3D spi_master_get_devdata(master);
+	u32 cs =3D bcm2835_rd(bs, BCM2835_SPI_CS);
+
+	cs &=3D ~(BCM2835_SPI_CS_CPOL | BCM2835_SPI_CS_CPHA);
+
+	if (spi->mode & SPI_CPOL)
+		cs |=3D BCM2835_SPI_CS_CPOL;
+	if (spi->mode & SPI_CPHA)
+		cs |=3D BCM2835_SPI_CS_CPHA;
+
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+
+	return 0;
+}
+
 static void bcm2835_spi_handle_err(struct spi_master *master,
 				   struct spi_message *msg)
 {
@@ -429,6 +446,7 @@ static int bcm2835_spi_probe(struct platform_device *pd=
ev)
 	master->set_cs =3D bcm2835_spi_set_cs;
 	master->transfer_one =3D bcm2835_spi_transfer_one;
 	master->handle_err =3D bcm2835_spi_handle_err;
+	master->prepare_message =3D bcm2835_spi_prepare_message;
 	master->dev.of_node =3D pdev->dev.of_node;
=20
 	bs =3D spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index 06b34e5bcfa3..47bb9b898dfd 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -49,7 +49,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 {
 	/* if (cpol =3D=3D 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
=20
-	bool oldbit =3D !(word & 1);
+	u32 oldbit =3D (!(word & (1<<(bits-1)))) << 31;
 	/* clock starts at inactive polarity */
 	for (word <<=3D (32 - bits); likely(bits); bits--) {
=20
@@ -81,7 +81,7 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 {
 	/* if (cpol =3D=3D 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
=20
-	bool oldbit =3D !(word & (1 << 31));
+	u32 oldbit =3D (!(word & (1<<(bits-1)))) << 31;
 	/* clock starts at inactive polarity */
 	for (word <<=3D (32 - bits); likely(bits); bits--) {
=20
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index eb03e1215195..7edede6e024b 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -74,6 +74,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
=20
 	dws->max_freq =3D clk_get_rate(dwsmmio->clk);
=20
+	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
+			     &dws->reg_io_width);
+
 	num_cs =3D 4;
=20
 	if (pdev->dev.of_node)
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 8d67d03c71eb..4fbfcdc5cb24 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -194,7 +194,7 @@ static void dw_writer(struct dw_spi *dws)
 			else
 				txw =3D *(u16 *)(dws->tx);
 		}
-		dw_writel(dws, DW_SPI_DR, txw);
+		dw_write_io_reg(dws, DW_SPI_DR, txw);
 		dws->tx +=3D dws->n_bytes;
 	}
 }
@@ -205,7 +205,7 @@ static void dw_reader(struct dw_spi *dws)
 	u16 rxw;
=20
 	while (max--) {
-		rxw =3D dw_readl(dws, DW_SPI_DR);
+		rxw =3D dw_read_io_reg(dws, DW_SPI_DR);
 		/* Care rx only if the transfer's original "rx" is not null */
 		if (dws->rx_end - dws->len) {
 			if (dws->n_bytes =3D=3D 1)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 6c91391c1a4f..b75ed327d5a2 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -109,6 +109,7 @@ struct dw_spi {
 	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
=20
+	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
=20
@@ -145,11 +146,45 @@ static inline u32 dw_readl(struct dw_spi *dws, u32 of=
fset)
 	return __raw_readl(dws->regs + offset);
 }
=20
+static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
+{
+	return __raw_readw(dws->regs + offset);
+}
+
 static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
 {
 	__raw_writel(val, dws->regs + offset);
 }
=20
+static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
+{
+	__raw_writew(val, dws->regs + offset);
+}
+
+static inline u32 dw_read_io_reg(struct dw_spi *dws, u32 offset)
+{
+	switch (dws->reg_io_width) {
+	case 2:
+		return dw_readw(dws, offset);
+	case 4:
+	default:
+		return dw_readl(dws, offset);
+	}
+}
+
+static inline void dw_write_io_reg(struct dw_spi *dws, u32 offset, u32 val)
+{
+	switch (dws->reg_io_width) {
+	case 2:
+		dw_writew(dws, offset, val);
+		break;
+	case 4:
+	default:
+		dw_writel(dws, offset, val);
+		break;
+	}
+}
+
 static inline void spi_enable_chip(struct dw_spi *dws, int enable)
 {
 	dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index acce90ac7371..bb916c8d40db 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -105,6 +105,10 @@ struct img_spfi {
 	bool rx_dma_busy;
 };
=20
+struct img_spfi_device_data {
+	bool gpio_requested;
+};
+
 static inline u32 spfi_readl(struct img_spfi *spfi, u32 reg)
 {
 	return readl(spfi->regs + reg);
@@ -267,15 +271,15 @@ static int img_spfi_start_pio(struct spi_master *mast=
er,
 		cpu_relax();
 	}
=20
-	ret =3D spfi_wait_all_done(spfi);
-	if (ret < 0)
-		return ret;
-
 	if (rx_bytes > 0 || tx_bytes > 0) {
 		dev_err(spfi->dev, "PIO transfer timed out\n");
 		return -ETIMEDOUT;
 	}
=20
+	ret =3D spfi_wait_all_done(spfi);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
=20
@@ -440,21 +444,50 @@ static int img_spfi_unprepare(struct spi_master *mast=
er,
=20
 static int img_spfi_setup(struct spi_device *spi)
 {
-	int ret;
-
-	ret =3D gpio_request_one(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ?
-			       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
-			       dev_name(&spi->dev));
-	if (ret)
-		dev_err(&spi->dev, "can't request chipselect gpio %d\n",
+	int ret =3D -EINVAL;
+	struct img_spfi_device_data *spfi_data =3D spi_get_ctldata(spi);
+
+	if (!spfi_data) {
+		spfi_data =3D kzalloc(sizeof(*spfi_data), GFP_KERNEL);
+		if (!spfi_data)
+			return -ENOMEM;
+		spfi_data->gpio_requested =3D false;
+		spi_set_ctldata(spi, spfi_data);
+	}
+	if (!spfi_data->gpio_requested) {
+		ret =3D gpio_request_one(spi->cs_gpio,
+				       (spi->mode & SPI_CS_HIGH) ?
+				       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+				       dev_name(&spi->dev));
+		if (ret)
+			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
 				spi->cs_gpio);
-
+		else
+			spfi_data->gpio_requested =3D true;
+	} else {
+		if (gpio_is_valid(spi->cs_gpio)) {
+			int mode =3D ((spi->mode & SPI_CS_HIGH) ?
+				    GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
+
+			ret =3D gpio_direction_output(spi->cs_gpio, mode);
+			if (ret)
+				dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
+					spi->cs_gpio, ret);
+		}
+	}
 	return ret;
 }
=20
 static void img_spfi_cleanup(struct spi_device *spi)
 {
-	gpio_free(spi->cs_gpio);
+	struct img_spfi_device_data *spfi_data =3D spi_get_ctldata(spi);
+
+	if (spfi_data) {
+		if (spfi_data->gpio_requested)
+			gpio_free(spi->cs_gpio);
+		kfree(spfi_data);
+		spi_set_ctldata(spi, NULL);
+	}
 }
=20
 static void img_spfi_config(struct spi_master *master, struct spi_device *=
spi,
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e3223ac75a7c..f089082c00e1 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -624,6 +624,10 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(sccr1_reg & SSCR1_TIE))
 		mask &=3D ~SSSR_TFS;
=20
+	/* Ignore RX timeout interrupt if it is disabled */
+	if (!(sccr1_reg & SSCR1_TINTE))
+		mask &=3D ~SSSR_TINT;
+
 	if (!(status & mask))
 		return IRQ_NONE;
=20
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index bcc7c635d8e7..7872f3c78b51 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -48,8 +48,8 @@ struct sh_msiof_spi_priv {
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
 	struct completion done;
-	int tx_fifo_size;
-	int rx_fifo_size;
+	unsigned int tx_fifo_size;
+	unsigned int rx_fifo_size;
 	void *tx_dma_page;
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
@@ -95,8 +95,6 @@ struct sh_msiof_spi_priv {
 #define MDR2_WDLEN1(i)	(((i) - 1) << 16) /* Word Count (1-64/256 (SH, A1))=
) */
 #define MDR2_GRPMASK1	0x00000001 /* Group Output Mask 1 (SH, A1) */
=20
-#define MAX_WDLEN	256U
-
 /* TSCR and RSCR */
 #define SCR_BRPS_MASK	    0x1f00 /* Prescaler Setting (1-32) */
 #define SCR_BRPS(i)	(((i) - 1) << 8)
@@ -850,7 +848,12 @@ static int sh_msiof_transfer_one(struct spi_master *ma=
ster,
 		 *  DMA supports 32-bit words only, hence pack 8-bit and 16-bit
 		 *  words, with byte resp. word swapping.
 		 */
-		unsigned int l =3D min(len, MAX_WDLEN * 4);
+		unsigned int l =3D 0;
+
+		if (tx_buf)
+			l =3D min(len, p->tx_fifo_size * 4);
+		if (rx_buf)
+			l =3D min(len, p->rx_fifo_size * 4);
=20
 		if (bits <=3D 8) {
 			if (l & 3)
@@ -963,7 +966,7 @@ static const struct sh_msiof_chipdata sh_data =3D {
=20
 static const struct sh_msiof_chipdata r8a779x_data =3D {
 	.tx_fifo_size =3D 64,
-	.rx_fifo_size =3D 256,
+	.rx_fifo_size =3D 64,
 	.master_flags =3D SPI_MASTER_MUST_TX,
 };
=20
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 133f53a9c1d4..a339c1e9997a 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -249,19 +249,23 @@ static int xilinx_spi_txrx_bufs(struct spi_device *sp=
i, struct spi_transfer *t)
 	xspi->tx_ptr =3D t->tx_buf;
 	xspi->rx_ptr =3D t->rx_buf;
 	remaining_words =3D t->len / xspi->bytes_per_word;
-	reinit_completion(&xspi->done);
=20
 	if (xspi->irq >=3D 0 &&  remaining_words > xspi->buffer_size) {
+		u32 isr;
 		use_irq =3D true;
-		xspi->write_fn(XSPI_INTR_TX_EMPTY,
-				xspi->regs + XIPIF_V123B_IISR_OFFSET);
-		/* Enable the global IPIF interrupt */
-		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
-				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
 		/* Inhibit irq to avoid spurious irqs on tx_empty*/
 		cr =3D xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
 		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
 			       xspi->regs + XSPI_CR_OFFSET);
+		/* ACK old irqs (if any) */
+		isr =3D xspi->read_fn(xspi->regs + XIPIF_V123B_IISR_OFFSET);
+		if (isr)
+			xspi->write_fn(isr,
+				       xspi->regs + XIPIF_V123B_IISR_OFFSET);
+		/* Enable the global IPIF interrupt */
+		xspi->write_fn(XIPIF_V123B_GINTR_ENABLE,
+				xspi->regs + XIPIF_V123B_DGIER_OFFSET);
+		reinit_completion(&xspi->done);
 	}
=20
 	while (remaining_words) {
@@ -302,8 +306,10 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi=
, struct spi_transfer *t)
 		remaining_words -=3D n_words;
 	}
=20
-	if (use_irq)
+	if (use_irq) {
 		xspi->write_fn(0, xspi->regs + XIPIF_V123B_DGIER_OFFSET);
+		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
+	}
=20
 	return t->len;
 }
diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpg=
a.c
index 2e32ea2f194f..be6155cba9de 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -34,13 +34,13 @@ struct xtfpga_spi {
 static inline void xtfpga_spi_write32(const struct xtfpga_spi *spi,
 				      unsigned addr, u32 val)
 {
-	iowrite32(val, spi->regs + addr);
+	__raw_writel(val, spi->regs + addr);
 }
=20
 static inline unsigned int xtfpga_spi_read32(const struct xtfpga_spi *spi,
 					     unsigned addr)
 {
-	return ioread32(spi->regs + addr);
+	return __raw_readl(spi->regs + addr);
 }
=20
 static inline void xtfpga_spi_wait_busy(struct xtfpga_spi *xspi)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d35c1a13217c..029dbd33b4b2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1427,8 +1427,7 @@ static struct class spi_master_class =3D {
  *
  * The caller is responsible for assigning the bus number and initializing
  * the master's methods before calling spi_register_master(); and (after e=
rrors
- * adding the device) calling spi_master_put() and kfree() to prevent a me=
mory
- * leak.
+ * adding the device) calling spi_master_put() to prevent a memory leak.
  */
 struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 {
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 92c909eed6b5..8fab566e0f0b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -664,7 +664,8 @@ static int spidev_release(struct inode *inode, struct f=
ile *filp)
 		kfree(spidev->rx_buffer);
 		spidev->rx_buffer =3D NULL;
=20
-		spidev->speed_hz =3D spidev->spi->max_speed_hz;
+		if (spidev->spi)
+			spidev->speed_hz =3D spidev->spi->max_speed_hz;
=20
 		/* ... after we unbound from the underlying device? */
 		spin_lock_irq(&spidev->spi_lock);

--mCWPyKcwNv47Ozt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1sMTAAoJECTWi3JdVIfQX3QH/j1c/OnTX/zVs1OK38LTrYUw
3kNKkwIPpFEwXsXDKwFbAbRS2UaoSPuBZT2CSWiwPKEOLY0RT8pRC8LxuDmiEa2O
aVjabJPNi17vgWQOOEHzidpLtUVXzZQCRBRNcsRVPAIDavF9xlbAj1FGKo+1ycai
TUecI3ZHq79TX0c06uXCJxn9wiCvnvy243tTdGDDpdJa59O6T9LGUgAMF4yzmJNd
2noN/NGSNbPNEmpbzTp5LafJvb/AgN1Fx9EFK+/oCMCR0H1LJsppDb9lFqZIYZbG
ibALyn2VX62fGgMI6TqsiRF1GPRAoR37O/lDfddEiXyZcECXjkB8OZ8K3XaNqP4=
=iZs6
-----END PGP SIGNATURE-----

--mCWPyKcwNv47Ozt6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
