From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Use reinit_completion at appropriate places
Date: Sun, 09 Feb 2014 11:06:04 +0800
Message-ID: <1391915164.17493.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>,
	Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Calling init_completion() once is enough.
=46or the rest of the iterations, call reinit_completion() instead.

Cc: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Cc: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Cc: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>
Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 3 ++-
 drivers/spi/spi-bcm63xx.c       | 3 ++-
 drivers/spi/spi-efm32.c         | 3 ++-
 drivers/spi/spi-imx.c           | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-=
hsspi.c
index b528f9f..3ad3e0c 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -180,7 +180,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device =
*spi, struct spi_transfer *t)
 	while (pending > 0) {
 		int curr_step =3D min_t(int, step_size, pending);
=20
-		init_completion(&bs->done);
+		reinit_completion(&bs->done);
 		if (tx) {
 			memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN, tx, curr_step);
 			tx +=3D curr_step;
@@ -369,6 +369,7 @@ static int bcm63xx_hsspi_probe(struct platform_devi=
ce *pdev)
 	bs->fifo =3D (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
=20
 	mutex_init(&bs->bus_mutex);
+	init_completion(&bs->done);
=20
 	master->bus_num =3D HSSPI_BUS_NUM;
 	master->num_chipselect =3D 8;
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 6922935..9f57758 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -169,7 +169,7 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi=
, struct spi_transfer *first,
 			       transfer_list);
 	}
=20
-	init_completion(&bs->done);
+	reinit_completion(&bs->done);
=20
 	/* Fill in the Message control register */
 	msg_ctl =3D (len << SPI_BYTE_CNT_SHIFT);
@@ -353,6 +353,7 @@ static int bcm63xx_spi_probe(struct platform_device=
 *pdev)
 	}
=20
 	bs =3D spi_master_get_devdata(master);
+	init_completion(&bs->done);
=20
 	platform_set_drvdata(pdev, master);
 	bs->pdev =3D pdev;
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index d4d3cc5..03cbb5e 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -198,7 +198,7 @@ static int efm32_spi_txrx_bufs(struct spi_device *s=
pi, struct spi_transfer *t)
=20
 	efm32_spi_filltx(ddata);
=20
-	init_completion(&ddata->done);
+	reinit_completion(&ddata->done);
=20
 	efm32_spi_write32(ddata, REG_IF_TXBL | REG_IF_RXDATAV, REG_IEN);
=20
@@ -349,6 +349,7 @@ static int efm32_spi_probe(struct platform_device *=
pdev)
 	ddata->bitbang.txrx_bufs =3D efm32_spi_txrx_bufs;
=20
 	spin_lock_init(&ddata->lock);
+	init_completion(&ddata->done);
=20
 	ddata->clk =3D devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ddata->clk)) {
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 8a77b7b..2ccfde6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -740,7 +740,7 @@ static int spi_imx_transfer(struct spi_device *spi,
 	spi_imx->count =3D transfer->len;
 	spi_imx->txfifo =3D 0;
=20
-	init_completion(&spi_imx->xfer_done);
+	reinit_completion(&spi_imx->xfer_done);
=20
 	spi_imx_push(spi_imx);
=20
--=20
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
