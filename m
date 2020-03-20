From: <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH] spi: atmel-quadspi: Add verbose debug facilities to monitor
 register accesses
Date: Fri, 20 Mar 2020 06:51:01 +0000
Message-ID: <20200320065058.891221-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <Nicolas.Ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, <Ludovic.Desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

This feature should not be enabled in release but can be useful for
developers who need to monitor register accesses at some specific places.

Helped me identify a bug in u-boot, by comparing the register accesses
from the linux driver with the ones from its u-boot variant.

Signed-off-by: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 drivers/spi/atmel-quadspi.c | 119 +++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 13def7f78b9e..cb44d1e169aa 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -173,6 +173,81 @@ static const struct atmel_qspi_mode atmel_qspi_modes[]=
 =3D {
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
=20
+#ifdef VERBOSE_DEBUG
+static const char *atmel_qspi_reg_name(u32 offset, char *tmp, size_t sz)
+{
+	switch (offset) {
+	case QSPI_CR:
+		return "CR";
+	case QSPI_MR:
+		return "MR";
+	case QSPI_RD:
+		return "MR";
+	case QSPI_TD:
+		return "TD";
+	case QSPI_SR:
+		return "SR";
+	case QSPI_IER:
+		return "IER";
+	case QSPI_IDR:
+		return "IDR";
+	case QSPI_IMR:
+		return "IMR";
+	case QSPI_SCR:
+		return "SCR";
+	case QSPI_IAR:
+		return "IAR";
+	case QSPI_ICR:
+		return "ICR/WICR";
+	case QSPI_IFR:
+		return "IFR";
+	case QSPI_RICR:
+		return "RICR";
+	case QSPI_SMR:
+		return "SMR";
+	case QSPI_SKR:
+		return "SKR";
+	case QSPI_WPMR:
+		return "WPMR";
+	case QSPI_WPSR:
+		return "WPSR";
+	case QSPI_VERSION:
+		return "VERSION";
+	default:
+		snprintf(tmp, sz, "0x%02x", offset);
+		break;
+	}
+
+	return tmp;
+}
+#endif /* VERBOSE_DEBUG */
+
+static u32 atmel_qspi_read(struct atmel_qspi *aq, u32 offset)
+{
+	u32 value =3D readl_relaxed(aq->regs + offset);
+
+#ifdef VERBOSE_DEBUG
+	char tmp[8];
+
+	dev_vdbg(&aq->pdev->dev, "read 0x%08x from %s\n", value,
+		 atmel_qspi_reg_name(offset, tmp, sizeof(tmp)));
+#endif /* VERBOSE_DEBUG */
+
+	return value;
+}
+
+static void atmel_qspi_write(u32 value, struct atmel_qspi *aq, u32 offset)
+{
+#ifdef VERBOSE_DEBUG
+	char tmp[8];
+
+	dev_vdbg(&aq->pdev->dev, "write 0x%08x into %s\n", value,
+		 atmel_qspi_reg_name(offset, tmp, sizeof(tmp)));
+#endif /* VERBOSE_DEBUG */
+
+	writel_relaxed(value, aq->regs + offset);
+}
+
 static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
 					    const struct atmel_qspi_mode *mode)
 {
@@ -293,32 +368,32 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	 * Serial Memory Mode (SMM).
 	 */
 	if (aq->mr !=3D QSPI_MR_SMM) {
-		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
 		aq->mr =3D QSPI_MR_SMM;
 	}
=20
 	/* Clear pending interrupts */
-	(void)readl_relaxed(aq->regs + QSPI_SR);
+	(void)atmel_qspi_read(aq, QSPI_SR);
=20
 	if (aq->caps->has_ricr) {
 		if (!op->addr.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_IN)
 			ifr |=3D QSPI_IFR_APBTFRTYP_READ;
=20
 		/* Set QSPI Instruction Frame registers */
-		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		atmel_qspi_write(iar, aq, QSPI_IAR);
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
-			writel_relaxed(icr, aq->regs + QSPI_RICR);
+			atmel_qspi_write(icr, aq, QSPI_RICR);
 		else
-			writel_relaxed(icr, aq->regs + QSPI_WICR);
-		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+			atmel_qspi_write(icr, aq, QSPI_WICR);
+		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	} else {
 		if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
 			ifr |=3D QSPI_IFR_SAMA5D2_WRITE_TRSFR;
=20
 		/* Set QSPI Instruction Frame registers */
-		writel_relaxed(iar, aq->regs + QSPI_IAR);
-		writel_relaxed(icr, aq->regs + QSPI_ICR);
-		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+		atmel_qspi_write(iar, aq, QSPI_IAR);
+		atmel_qspi_write(icr, aq, QSPI_ICR);
+		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	}
=20
 	return 0;
@@ -345,7 +420,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
 		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)readl_relaxed(aq->regs + QSPI_IFR);
+		(void)atmel_qspi_read(aq, QSPI_IFR);
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
@@ -356,22 +431,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 				     op->data.nbytes);
=20
 		/* Release the chip-select */
-		writel_relaxed(QSPI_CR_LASTXFER, aq->regs + QSPI_CR);
+		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
 	}
=20
 	/* Poll INSTRuction End status */
-	sr =3D readl_relaxed(aq->regs + QSPI_SR);
+	sr =3D atmel_qspi_read(aq, QSPI_SR);
 	if ((sr & QSPI_SR_CMD_COMPLETED) =3D=3D QSPI_SR_CMD_COMPLETED)
 		return err;
=20
 	/* Wait for INSTRuction End interrupt */
 	reinit_completion(&aq->cmd_completion);
 	aq->pending =3D sr & QSPI_SR_CMD_COMPLETED;
-	writel_relaxed(QSPI_SR_CMD_COMPLETED, aq->regs + QSPI_IER);
+	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IER);
 	if (!wait_for_completion_timeout(&aq->cmd_completion,
 					 msecs_to_jiffies(1000)))
 		err =3D -ETIMEDOUT;
-	writel_relaxed(QSPI_SR_CMD_COMPLETED, aq->regs + QSPI_IDR);
+	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IDR);
=20
 	return err;
 }
@@ -410,7 +485,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 		scbr--;
=20
 	aq->scr =3D QSPI_SCR_SCBR(scbr);
-	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
+	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
=20
 	return 0;
 }
@@ -418,14 +493,14 @@ static int atmel_qspi_setup(struct spi_device *spi)
 static void atmel_qspi_init(struct atmel_qspi *aq)
 {
 	/* Reset the QSPI controller */
-	writel_relaxed(QSPI_CR_SWRST, aq->regs + QSPI_CR);
+	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
=20
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
 	aq->mr =3D QSPI_MR_SMM;
=20
 	/* Enable the QSPI controller */
-	writel_relaxed(QSPI_CR_QSPIEN, aq->regs + QSPI_CR);
+	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
 }
=20
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
@@ -433,8 +508,8 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *=
dev_id)
 	struct atmel_qspi *aq =3D dev_id;
 	u32 status, mask, pending;
=20
-	status =3D readl_relaxed(aq->regs + QSPI_SR);
-	mask =3D readl_relaxed(aq->regs + QSPI_IMR);
+	status =3D atmel_qspi_read(aq, QSPI_SR);
+	mask =3D atmel_qspi_read(aq, QSPI_IMR);
 	pending =3D status & mask;
=20
 	if (!pending)
@@ -569,7 +644,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(ctrl);
=20
 	spi_unregister_controller(ctrl);
-	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
@@ -596,7 +671,7 @@ static int __maybe_unused atmel_qspi_resume(struct devi=
ce *dev)
=20
 	atmel_qspi_init(aq);
=20
-	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
+	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
=20
 	return 0;
 }
--=20
2.23.0
