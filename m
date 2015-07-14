From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: mpc512x-psc: add support for Freescale MPC5125
Date: Tue, 14 Jul 2015 11:19:56 +0200
Message-ID: <1436865596-9592-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The register layout of the PSC devices differ between MPC5121 and
MPC5125, but the registers are named nearly identical and their purpose
is similar enough ("freescale identical") such that substituting
mpc52xx_psc by mpc5125_psc is nearly enough to make the driver work on
MPC5125. To keep supporting MPC5121 this patch introduces a cpp
macro to select the right struct that defines the register layout.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 arch/powerpc/include/asm/mpc52xx_psc.h |  5 ++-
 drivers/spi/spi-mpc512x-psc.c          | 70 +++++++++++++++++++++++---=
--------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/incl=
ude/asm/mpc52xx_psc.h
index d0ece257d310..04c7e8fc24c2 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -150,7 +150,10 @@
=20
 /* Structure of the hardware registers */
 struct mpc52xx_psc {
-	u8		mode;		/* PSC + 0x00 */
+	union {
+		u8	mode;		/* PSC + 0x00 */
+		u8	mr2;
+	};
 	u8		reserved0[3];
 	union {				/* PSC + 0x04 */
 		u16	status;
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-ps=
c.c
index 965d2bdcfdcc..280794dd248a 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -30,11 +30,37 @@
 #include <linux/gpio.h>
 #include <asm/mpc52xx_psc.h>
=20
+enum {
+	TYPE_MPC5121,
+	TYPE_MPC5125,
+};
+
+/*
+ * This macro abstracts the differences in the PSC register layout bet=
ween
+ * MPC5121 (which uses a struct mpc52xx_psc) and MPC5125 (using mpc512=
5_psc).
+ */
+#define psc_addr(mps, regname) ({					\
+	void *__ret;							\
+	switch(mps->type) {						\
+	case TYPE_MPC5121: {						\
+			struct mpc52xx_psc __iomem *psc =3D mps->psc;	\
+			__ret =3D &psc->regname;				\
+		};							\
+		break;							\
+	case TYPE_MPC5125: {						\
+			struct mpc5125_psc __iomem *psc =3D mps->psc;	\
+			__ret =3D &psc->regname;				\
+		};							\
+		break;							\
+	}								\
+	__ret; })
+
 struct mpc512x_psc_spi {
 	void (*cs_control)(struct spi_device *spi, bool on);
=20
 	/* driver internal data */
-	struct mpc52xx_psc __iomem *psc;
+	int type;
+	void __iomem *psc;
 	struct mpc512x_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
@@ -71,13 +97,12 @@ static void mpc512x_psc_spi_activate_cs(struct spi_=
device *spi)
 {
 	struct mpc512x_psc_spi_cs *cs =3D spi->controller_state;
 	struct mpc512x_psc_spi *mps =3D spi_master_get_devdata(spi->master);
-	struct mpc52xx_psc __iomem *psc =3D mps->psc;
 	u32 sicr;
 	u32 ccr;
 	int speed;
 	u16 bclkdiv;
=20
-	sicr =3D in_be32(&psc->sicr);
+	sicr =3D in_be32(psc_addr(mps, sicr));
=20
 	/* Set clock phase and polarity */
 	if (spi->mode & SPI_CPHA)
@@ -94,9 +119,9 @@ static void mpc512x_psc_spi_activate_cs(struct spi_d=
evice *spi)
 		sicr |=3D 0x10000000;
 	else
 		sicr &=3D ~0x10000000;
-	out_be32(&psc->sicr, sicr);
+	out_be32(psc_addr(mps, sicr), sicr);
=20
-	ccr =3D in_be32(&psc->ccr);
+	ccr =3D in_be32(psc_addr(mps, ccr));
 	ccr &=3D 0xFF000000;
 	speed =3D cs->speed_hz;
 	if (!speed)
@@ -104,7 +129,7 @@ static void mpc512x_psc_spi_activate_cs(struct spi_=
device *spi)
 	bclkdiv =3D (mps->mclk_rate / speed) - 1;
=20
 	ccr |=3D (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
-	out_be32(&psc->ccr, ccr);
+	out_be32(psc_addr(mps, ccr), ccr);
 	mps->bits_per_word =3D cs->bits_per_word;
=20
 	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
@@ -315,16 +340,15 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_ma=
ster *master,
 static int mpc512x_psc_spi_prep_xfer_hw(struct spi_master *master)
 {
 	struct mpc512x_psc_spi *mps =3D spi_master_get_devdata(master);
-	struct mpc52xx_psc __iomem *psc =3D mps->psc;
=20
 	dev_dbg(&master->dev, "%s()\n", __func__);
=20
 	/* Zero MR2 */
-	in_8(&psc->mode);
-	out_8(&psc->mode, 0x0);
+	in_8(psc_addr(mps, mr2));
+	out_8(psc_addr(mps, mr2), 0x0);
=20
 	/* enable transmitter/receiver */
-	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_=
ENABLE);
=20
 	return 0;
 }
@@ -332,13 +356,12 @@ static int mpc512x_psc_spi_prep_xfer_hw(struct sp=
i_master *master)
 static int mpc512x_psc_spi_unprep_xfer_hw(struct spi_master *master)
 {
 	struct mpc512x_psc_spi *mps =3D spi_master_get_devdata(master);
-	struct mpc52xx_psc __iomem *psc =3D mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo =3D mps->fifo;
=20
 	dev_dbg(&master->dev, "%s()\n", __func__);
=20
 	/* disable transmitter/receiver and fifo interrupt */
-	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE)=
;
+	out_8(psc_addr(mps, command), MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX=
_DISABLE);
 	out_be32(&fifo->tximr, 0);
=20
 	return 0;
@@ -388,7 +411,6 @@ static void mpc512x_psc_spi_cleanup(struct spi_devi=
ce *spi)
 static int mpc512x_psc_spi_port_config(struct spi_master *master,
 				       struct mpc512x_psc_spi *mps)
 {
-	struct mpc52xx_psc __iomem *psc =3D mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo =3D mps->fifo;
 	u32 sicr;
 	u32 ccr;
@@ -396,12 +418,12 @@ static int mpc512x_psc_spi_port_config(struct spi=
_master *master,
 	u16 bclkdiv;
=20
 	/* Reset the PSC into a known state */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
-	out_8(&psc->command, MPC52xx_PSC_RST_TX);
-	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE)=
;
+	out_8(psc_addr(mps, command), MPC52xx_PSC_RST_RX);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_RST_TX);
+	out_8(psc_addr(mps, command), MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX=
_DISABLE);
=20
 	/* Disable psc interrupts all useful interrupts are in fifo */
-	out_be16(&psc->isr_imr.imr, 0);
+	out_be16(psc_addr(mps, isr_imr.imr), 0);
=20
 	/* Disable fifo interrupts, will be enabled later */
 	out_be32(&fifo->tximr, 0);
@@ -417,18 +439,18 @@ static int mpc512x_psc_spi_port_config(struct spi=
_master *master,
 		0x00004000 |	/* MSTR =3D 1   -- SPI master */
 		0x00000800;	/* UseEOF =3D 1 -- SS low until EOF */
=20
-	out_be32(&psc->sicr, sicr);
+	out_be32(psc_addr(mps, sicr), sicr);
=20
-	ccr =3D in_be32(&psc->ccr);
+	ccr =3D in_be32(psc_addr(mps, ccr));
 	ccr &=3D 0xFF000000;
 	speed =3D 1000000;	/* default 1MHz */
 	bclkdiv =3D (mps->mclk_rate / speed) - 1;
 	ccr |=3D (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
-	out_be32(&psc->ccr, ccr);
+	out_be32(psc_addr(mps, ccr), ccr);
=20
 	/* Set 2ms DTL delay */
-	out_8(&psc->ctur, 0x00);
-	out_8(&psc->ctlr, 0x82);
+	out_8(psc_addr(mps, ctur), 0x00);
+	out_8(psc_addr(mps, ctlr), 0x82);
=20
 	/* we don't use the alarms */
 	out_be32(&fifo->rxalarm, 0xfff);
@@ -482,6 +504,7 @@ static int mpc512x_psc_spi_do_probe(struct device *=
dev, u32 regaddr,
=20
 	dev_set_drvdata(dev, master);
 	mps =3D spi_master_get_devdata(master);
+	mps->type =3D (int)of_device_get_match_data(dev);
 	mps->irq =3D irq;
=20
 	if (pdata =3D=3D NULL) {
@@ -589,7 +612,8 @@ static int mpc512x_psc_spi_of_remove(struct platfor=
m_device *op)
 }
=20
 static const struct of_device_id mpc512x_psc_spi_of_match[] =3D {
-	{ .compatible =3D "fsl,mpc5121-psc-spi", },
+	{ .compatible =3D "fsl,mpc5121-psc-spi", .data =3D (void *)TYPE_MPC51=
21 },
+	{ .compatible =3D "fsl,mpc5125-psc-spi", .data =3D (void *)TYPE_MPC51=
25 },
 	{},
 };
=20
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
