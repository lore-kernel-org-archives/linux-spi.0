From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem accesses
Date: Sat, 2 Feb 2019 04:07:19 +0000
Message-ID: <20190202040653.1217-4-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The wrappers hid that the accesses are relaxed. Drop them.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: no change
v2: new patch

 drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++----------------------=
----
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index feeddcb25e1f..131374db0db4 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] =3D=
 {
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
=20
-/* Register access functions */
-static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
-{
-	return readl_relaxed(aq->regs + reg);
-}
-
-static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
-{
-	writel_relaxed(value, aq->regs + reg);
-}
-
 static inline bool is_compatible(const struct spi_mem_op *op,
 				 const struct qspi_mode *mode)
 {
@@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
 {
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
+	void __iomem *base =3D aq->regs;
 	int mode;
 	u32 dummy_cycles =3D 0;
 	u32 iar, icr, ifr, sr;
@@ -240,7 +230,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
=20
 	/* Set the QSPI controller in Serial Memory Mode */
 	if (aq->smm !=3D QSPI_MR_SMM) {
-		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
 		aq->smm =3D QSPI_MR_SMM;
 	}
=20
@@ -300,17 +290,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
=20
 	/* Clear pending interrupts */
-	(void)qspi_readl(aq, QSPI_SR);
+	(void)readl_relaxed(base + QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	qspi_writel(aq, QSPI_IAR, iar);
-	qspi_writel(aq, QSPI_ICR, icr);
-	qspi_writel(aq, QSPI_IFR, ifr);
+	writel_relaxed(iar, base + QSPI_IAR);
+	writel_relaxed(icr, base + QSPI_ICR);
+	writel_relaxed(ifr, base + QSPI_IFR);
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
 		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)qspi_readl(aq, QSPI_IFR);
+		(void)readl_relaxed(base + QSPI_IFR);
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
@@ -321,22 +311,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 				op->data.buf.out, op->data.nbytes);
=20
 		/* Release the chip-select */
-		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
+		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
 	}
=20
 	/* Poll INSTRuction End status */
-	sr =3D qspi_readl(aq, QSPI_SR);
+	sr =3D readl_relaxed(base + QSPI_SR);
 	if ((sr & QSPI_SR_CMD_COMPLETED) =3D=3D QSPI_SR_CMD_COMPLETED)
 		return err;
=20
 	/* Wait for INSTRuction End interrupt */
 	reinit_completion(&aq->cmd_completion);
 	aq->pending =3D sr & QSPI_SR_CMD_COMPLETED;
-	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
+	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IER);
 	if (!wait_for_completion_timeout(&aq->cmd_completion,
 					 msecs_to_jiffies(1000)))
 		err =3D -ETIMEDOUT;
-	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
+	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IDR);
=20
 	return err;
 }
@@ -375,18 +365,20 @@ static int atmel_qspi_setup(struct spi_device *spi)
 		scbr--;
=20
 	scr =3D QSPI_SCR_SCBR(scbr);
-	qspi_writel(aq, QSPI_SCR, scr);
+	writel_relaxed(scr, aq->regs + QSPI_SCR);
=20
 	return 0;
 }
=20
 static int atmel_qspi_init(struct atmel_qspi *aq)
 {
+	void __iomem *base =3D aq->regs;
+
 	/* Reset the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
+	writel_relaxed(QSPI_CR_SWRST, base + QSPI_CR);
=20
 	/* Enable the QSPI controller */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
+	writel_relaxed(QSPI_CR_QSPIEN, base + QSPI_CR);
=20
 	return 0;
 }
@@ -394,10 +386,11 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
 	struct atmel_qspi *aq =3D (struct atmel_qspi *)dev_id;
+	void __iomem *base =3D aq->regs;
 	u32 status, mask, pending;
=20
-	status =3D qspi_readl(aq, QSPI_SR);
-	mask =3D qspi_readl(aq, QSPI_IMR);
+	status =3D readl_relaxed(base + QSPI_SR);
+	mask =3D readl_relaxed(base + QSPI_IMR);
 	pending =3D status & mask;
=20
 	if (!pending)
@@ -503,7 +496,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(ctrl);
=20
 	spi_unregister_controller(ctrl);
-	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
+	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
 	clk_disable_unprepare(aq->clk);
 	return 0;
 }
--=20
2.9.5
