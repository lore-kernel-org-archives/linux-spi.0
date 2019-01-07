From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 3/8] spi: lpspi: Improve the stability of lpspi data
 transmission
Date: Mon, 7 Jan 2019 07:47:38 +0000
Message-ID: <20190107074639.6336-4-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use SR_TDF to judge if need to send data, and SR_FCF is to judge if
transmission end and to replace the waiting after transmission end.
This waiting has no actual meaning, for module will set the FCF
flag at the real end.

The changes of interrupt flag and ISR function reduce the times of
calling ISR. The use of the FCF flag improves the stability of the
data transmission. These two points generally improve the data
transfer speed of lpspi, especially when it is set to slave mode
it can support higher transfer speed of the host.

After making these changes, there is no need to use
fsl_lpspi_txfifo_empty(), so remove it.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 61 ++++++++++++-------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 3e935db5ff02..f32a2e0d7ae1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -53,9 +53,11 @@
 #define CR_RST		BIT(1)
 #define CR_MEN		BIT(0)
 #define SR_TCF		BIT(10)
+#define SR_FCF		BIT(9)
 #define SR_RDF		BIT(1)
 #define SR_TDF		BIT(0)
 #define IER_TCIE	BIT(10)
+#define IER_FCIE	BIT(9)
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
@@ -174,28 +176,10 @@ static int lpspi_unprepare_xfer_hardware(struct spi_c=
ontroller *controller)
 	return 0;
 }
=20
-static int fsl_lpspi_txfifo_empty(struct fsl_lpspi_data *fsl_lpspi)
-{
-	u32 txcnt;
-	unsigned long orig_jiffies =3D jiffies;
-
-	do {
-		txcnt =3D readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
-
-		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
-			dev_dbg(fsl_lpspi->dev, "txfifo empty timeout\n");
-			return -ETIMEDOUT;
-		}
-		cond_resched();
-
-	} while (txcnt);
-
-	return 0;
-}
-
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
+	u32 temp;
=20
 	txfifo_cnt =3D readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
=20
@@ -206,9 +190,15 @@ static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_d=
ata *fsl_lpspi)
 		txfifo_cnt++;
 	}
=20
-	if (!fsl_lpspi->remain && (txfifo_cnt < fsl_lpspi->txfifosize))
-		writel(0, fsl_lpspi->base + IMX7ULP_TDR);
-	else
+	if (txfifo_cnt < fsl_lpspi->txfifosize) {
+		if (!fsl_lpspi->is_slave) {
+			temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
+			temp &=3D ~TCR_CONTC;
+			writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+		}
+
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+	} else
 		fsl_lpspi_intctrl(fsl_lpspi, IER_TDIE);
 }
=20
@@ -404,12 +394,6 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
r *controller,
 	if (ret)
 		return ret;
=20
-	ret =3D fsl_lpspi_txfifo_empty(fsl_lpspi);
-	if (ret)
-		return ret;
-
-	fsl_lpspi_read_rx_fifo(fsl_lpspi);
-
 	return 0;
 }
=20
@@ -421,7 +405,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contro=
ller *controller,
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
-	u32 temp;
 	int ret =3D 0;
=20
 	msg->status =3D 0;
@@ -441,13 +424,6 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
 	}
=20
 complete:
-	if (!fsl_lpspi->is_slave) {
-		/* de-assert SS, then finalize current message */
-		temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
-		temp &=3D ~TCR_CONTC;
-		writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
-	}
-
 	msg->status =3D ret;
 	spi_finalize_current_message(controller);
=20
@@ -456,20 +432,23 @@ static int fsl_lpspi_transfer_one_msg(struct spi_cont=
roller *controller,
=20
 static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 {
+	u32 temp_SR, temp_IER;
 	struct fsl_lpspi_data *fsl_lpspi =3D dev_id;
-	u32 temp;
=20
+	temp_IER =3D readl(fsl_lpspi->base + IMX7ULP_IER);
 	fsl_lpspi_intctrl(fsl_lpspi, 0);
-	temp =3D readl(fsl_lpspi->base + IMX7ULP_SR);
+	temp_SR =3D readl(fsl_lpspi->base + IMX7ULP_SR);
=20
 	fsl_lpspi_read_rx_fifo(fsl_lpspi);
=20
-	if (temp & SR_TDF) {
+	if ((temp_SR & SR_TDF) && (temp_IER & IER_TDIE)) {
 		fsl_lpspi_write_tx_fifo(fsl_lpspi);
+		return IRQ_HANDLED;
+	}
=20
-		if (!fsl_lpspi->remain)
+	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
+		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 			complete(&fsl_lpspi->xfer_done);
-
 		return IRQ_HANDLED;
 	}
=20
--=20
2.17.1
