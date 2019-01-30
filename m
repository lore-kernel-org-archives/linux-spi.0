From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Wed, 30 Jan 2019 15:08:47 +0000
Message-ID: <20190130150818.24902-10-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory. It uses
dedicated register for Read Instruction Code Register (RICR) and
Write Instruction Code Register (WICR). ICR/RICR/WICR have identical
fields.

Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 331 ++++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 277 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 1d21db7851e9..bfdc8488f23b 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi-mem.h>
=20
@@ -35,7 +36,9 @@
=20
 #define QSPI_IAR     0x0030  /* Instruction Address Register */
 #define QSPI_ICR     0x0034  /* Instruction Code Register */
+#define QSPI_WICR    0x0034  /* Write Instruction Code Register */
 #define QSPI_IFR     0x0038  /* Instruction Frame Register */
+#define QSPI_RICR    0x003C  /* Read Instruction Code Register */
=20
 #define QSPI_SMR     0x0040  /* Scrambling Mode Register */
 #define QSPI_SKR     0x0044  /* Scrambling Key Register */
@@ -88,7 +91,7 @@
 #define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
 #define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK=
)
=20
-/* Bitfields in QSPI_ICR (Instruction Code Register) */
+/* Bitfields in QSPI_ICR (Read/Write Instruction Code Register) */
 #define QSPI_ICR_INST_MASK              GENMASK(7, 0)
 #define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MAS=
K)
 #define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
@@ -113,6 +116,8 @@
 #define QSPI_IFR_OPTL_4BIT              (2 << 8)
 #define QSPI_IFR_OPTL_8BIT              (3 << 8)
 #define QSPI_IFR_ADDRL                  BIT(10)
+#define QSPI_IFR_TFRTYP_TRSFR_MEM	BIT(12)
+#define QSPI_IFR_TFRTYP_TRSFR_REG	(0 << 12)
 #define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
 #define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
 #define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
@@ -121,6 +126,8 @@
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK=
)
+#define QSPI_IFR_APBTFRTYP_WRITE	(0 << 24)
+#define QSPI_IFR_APBTFRTYP_READ		BIT(24)
=20
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
@@ -137,15 +144,37 @@
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
=20
=20
+/* Describes register values. */
+struct atmel_qspi_cfg {
+	u32 icr;
+	u32 iar;
+	u32 ifr;
+};
+
+struct atmel_qspi_caps;
+
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
 	struct clk		*clk;
+	struct clk		*qspick;
 	struct platform_device	*pdev;
+	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	struct completion	cmd_completion;
 };
=20
+struct atmel_qspi_ops {
+	int (*clk_prepare_enable)(struct atmel_qspi *aq);
+	void (*clk_disable_unprepare)(struct atmel_qspi *aq);
+	int (*set_qspi_cfg)(struct atmel_qspi *aq, const struct spi_mem_op *op,
+			    struct atmel_qspi_cfg *cfg);
+};
+
+struct atmel_qspi_caps {
+	const struct atmel_qspi_ops *ops;
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -214,23 +243,36 @@ static bool atmel_qspi_supports_op(struct spi_mem *me=
m,
 	return true;
 }
=20
-static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+static int atmel_qspi_set_mode(struct atmel_qspi_cfg *cfg,
+			       const struct spi_mem_op *op)
 {
-	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
-	int mode;
-	u32 dummy_cycles =3D 0;
-	u32 iar, icr, ifr, sr;
-	int err =3D 0;
-
-	iar =3D 0;
-	icr =3D QSPI_ICR_INST(op->cmd.opcode);
-	ifr =3D QSPI_IFR_INSTEN;
+	int mode =3D atmel_qspi_find_mode(op);
=20
-	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
+	cfg->ifr =3D QSPI_IFR_INSTEN | sama5d2_qspi_modes[mode].config;
+	return 0;
+}
=20
-	ifr |=3D sama5d2_qspi_modes[mode].config;
+/*
+ * atmel_qspi_set_address_mode() - set address mode.
+ * @cfg:	contains register values
+ * @op:		describes a SPI memory operation
+ *
+ * The controller allows 24 and 32-bit addressing while NAND-flash require=
s
+ * 16-bit long. Handling 8-bit long addresses is done using the option fie=
ld.
+ * For the 16-bit addresses, the workaround depends of the number of reque=
sted
+ * dummy bits. If there are 8 or more dummy cycles, the address is shifted=
 and
+ * sent with the first dummy byte. Otherwise opcode is disabled and the fi=
rst
+ * byte of the address contains the command opcode (works only if the opco=
de and
+ * address use the same buswidth). The limitation is when the 16-bit addre=
ss is
+ * used without enough dummy cycles and the opcode is using a different bu=
swidth
+ * than the address.
+ */
+static int atmel_qspi_set_address_mode(struct atmel_qspi_cfg *cfg,
+				       const struct spi_mem_op *op)
+{
+	u32 dummy_cycles =3D 0;
=20
 	if (op->dummy.buswidth && op->dummy.nbytes)
 		dummy_cycles =3D op->dummy.nbytes * 8 / op->dummy.buswidth;
@@ -240,28 +282,28 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		case 0:
 			break;
 		case 1:
-			ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
-			icr |=3D QSPI_ICR_OPT(op->addr.val & 0xff);
+			cfg->ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			cfg->icr |=3D QSPI_ICR_OPT(op->addr.val & 0xff);
 			break;
 		case 2:
 			if (dummy_cycles < 8 / op->addr.buswidth) {
-				ifr &=3D ~QSPI_IFR_INSTEN;
-				ifr |=3D QSPI_IFR_ADDREN;
-				iar =3D (op->cmd.opcode << 16) |
-					(op->addr.val & 0xffff);
+				cfg->ifr &=3D ~QSPI_IFR_INSTEN;
+				cfg->ifr |=3D QSPI_IFR_ADDREN;
+				cfg->iar =3D (op->cmd.opcode << 16) |
+					   (op->addr.val & 0xffff);
 			} else {
-				ifr |=3D QSPI_IFR_ADDREN;
-				iar =3D (op->addr.val << 8) & 0xffffff;
+				cfg->ifr |=3D QSPI_IFR_ADDREN;
+				cfg->iar =3D (op->addr.val << 8) & 0xffffff;
 				dummy_cycles -=3D 8 / op->addr.buswidth;
 			}
 			break;
 		case 3:
-			ifr |=3D QSPI_IFR_ADDREN;
-			iar =3D op->addr.val & 0xffffff;
+			cfg->ifr |=3D QSPI_IFR_ADDREN;
+			cfg->iar =3D op->addr.val & 0xffffff;
 			break;
 		case 4:
-			ifr |=3D QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
-			iar =3D op->addr.val & 0x7ffffff;
+			cfg->ifr |=3D QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
+			cfg->iar =3D op->addr.val & 0x7ffffff;
 			break;
 		default:
 			return -ENOTSUPP;
@@ -270,24 +312,99 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
=20
 	/* Set number of dummy cycles */
 	if (dummy_cycles)
-		ifr |=3D QSPI_IFR_NBDUM(dummy_cycles);
+		cfg->ifr |=3D QSPI_IFR_NBDUM(dummy_cycles);
=20
-	/* Set data enable */
-	if (op->data.nbytes)
-		ifr |=3D QSPI_IFR_DATAEN;
+	return 0;
+}
+
+static int atmel_sama5d2_qspi_set_cfg(struct atmel_qspi *aq,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret =3D atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	cfg->icr =3D QSPI_ICR_INST(op->cmd.opcode);
=20
 	if (op->data.dir =3D=3D SPI_MEM_DATA_IN && op->data.nbytes)
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_READ;
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_READ;
 	else
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |=3D QSPI_IFR_DATAEN;
+
+	ret =3D atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
+
+	/* Clear pending interrupts */
+	(void)atmel_qspi_readl(aq, QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
+	atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
+	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
+
+	return 0;
+}
+
+static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret =3D atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	cfg->icr =3D QSPI_ICR_INST(op->cmd.opcode);
+
+	if (!op->addr.nbytes) {
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_REG;
+		if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+			cfg->ifr |=3D QSPI_IFR_APBTFRTYP_WRITE;
+		else
+			cfg->ifr |=3D QSPI_IFR_APBTFRTYP_READ;
+	} else {
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_MEM;
+	}
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |=3D QSPI_IFR_DATAEN;
+
+	ret =3D atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
=20
 	/* Clear pending interrupts */
 	(void)atmel_qspi_readl(aq, QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	atmel_qspi_writel(aq, QSPI_IAR, iar);
-	atmel_qspi_writel(aq, QSPI_ICR, icr);
-	atmel_qspi_writel(aq, QSPI_IFR, ifr);
+	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+		atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
+	else
+		atmel_qspi_writel(aq, QSPI_RICR, cfg->icr);
+	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+{
+	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
+	struct atmel_qspi_cfg cfg =3D {0};
+	u32 sr;
+	int err;
+
+	err =3D aq->caps->ops->set_qspi_cfg(aq, op, &cfg);
+	if (err)
+		return err;
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -296,11 +413,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
=20
 		/* Send/Receive data */
 		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
-			_memcpy_fromio(op->data.buf.in,
-				aq->mem + iar, op->data.nbytes);
+			_memcpy_fromio(op->data.buf.in, aq->mem + cfg.iar,
+				       op->data.nbytes);
 		else
-			_memcpy_toio(aq->mem + iar,
-				op->data.buf.out, op->data.nbytes);
+			_memcpy_toio(aq->mem + cfg.iar, op->data.buf.out,
+				     op->data.nbytes);
=20
 		/* Release the chip-select */
 		atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
@@ -395,10 +512,84 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void=
 *dev_id)
 	return IRQ_HANDLED;
 }
=20
+static int atmel_sama5d2_qspi_clk_prepare_enable(struct atmel_qspi *aq)
+{
+	int ret;
+
+	if (!aq->clk) {
+		/* Get the peripheral clock */
+		aq->clk =3D devm_clk_get(&aq->pdev->dev, NULL);
+		if (IS_ERR(aq->clk)) {
+			dev_err(&aq->pdev->dev, "missing peripheral clock\n");
+			return PTR_ERR(aq->clk);
+		}
+	}
+
+	/* Enable the peripheral clock */
+	ret =3D clk_prepare_enable(aq->clk);
+	if (ret)
+		dev_err(&aq->pdev->dev,
+			"failed to enable the peripheral clock\n");
+
+	return ret;
+}
+
+static void atmel_sama5d2_qspi_clk_disable_unprepare(struct atmel_qspi *aq=
)
+{
+	clk_disable_unprepare(aq->clk);
+}
+
+static int atmel_sam9x60_qspi_clk_prepare_enable(struct atmel_qspi *aq)
+{
+	struct device *dev =3D &aq->pdev->dev;
+	int ret;
+
+	if (!aq->clk) {
+		/* Get the peripheral clock */
+		aq->clk =3D devm_clk_get(dev, "pclk");
+		if (IS_ERR(aq->clk)) {
+			dev_err(dev, "missing peripheral clock\n");
+			return PTR_ERR(aq->clk);
+		}
+	}
+
+	if (!aq->qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick =3D devm_clk_get(dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(dev, "missing system clock\n");
+			return PTR_ERR(aq->qspick);
+		}
+	}
+
+	/* Enable the peripheral clock */
+	ret =3D clk_prepare_enable(aq->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable the peripheral clock\n");
+		return ret;
+	}
+
+	/* Enable the QSPI system clock */
+	ret =3D clk_prepare_enable(aq->qspick);
+	if (ret) {
+		dev_err(dev, "failed to enable the QSPI system clock\n");
+		clk_disable_unprepare(aq->clk);
+	}
+
+	return ret;
+}
+
+static void atmel_sam9x60_qspi_clk_disable_unprepare(struct atmel_qspi *aq=
)
+{
+	clk_disable_unprepare(aq->qspick);
+	clk_disable_unprepare(aq->clk);
+}
+
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
+	const struct atmel_qspi_caps *caps;
 	struct resource *res;
 	int irq, err =3D 0;
=20
@@ -437,20 +628,22 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 		goto exit;
 	}
=20
-	/* Get the peripheral clock */
-	aq->clk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(aq->clk)) {
-		dev_err(&pdev->dev, "missing peripheral clock\n");
-		err =3D PTR_ERR(aq->clk);
-		goto exit;
+	caps =3D of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		return -EINVAL;
 	}
=20
-	/* Enable the peripheral clock */
-	err =3D clk_prepare_enable(aq->clk);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
-		goto exit;
+	if (!caps->ops->clk_prepare_enable ||
+	    !caps->ops->clk_disable_unprepare || !caps->ops->set_qspi_cfg) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI ops\n");
+		return -EINVAL;
 	}
+	aq->caps =3D caps;
+
+	err =3D caps->ops->clk_prepare_enable(aq);
+	if (err)
+		return err;
=20
 	/* Request the IRQ */
 	irq =3D platform_get_irq(pdev, 0);
@@ -475,7 +668,7 @@ static int atmel_qspi_probe(struct platform_device *pde=
v)
 	return 0;
=20
 disable_clk:
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
 exit:
 	spi_controller_put(ctrl);
=20
@@ -486,18 +679,20 @@ static int atmel_qspi_remove(struct platform_device *=
pdev)
 {
 	struct spi_controller *ctrl =3D platform_get_drvdata(pdev);
 	struct atmel_qspi *aq =3D spi_controller_get_devdata(ctrl);
+	const struct atmel_qspi_caps *caps =3D aq->caps;
=20
 	spi_unregister_controller(ctrl);
 	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
 	return 0;
 }
=20
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
+	const struct atmel_qspi_caps *caps =3D aq->caps;
=20
-	clk_disable_unprepare(aq->clk);
+	caps->ops->clk_disable_unprepare(aq);
=20
 	return 0;
 }
@@ -505,8 +700,9 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 static int __maybe_unused atmel_qspi_resume(struct device *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
+	const struct atmel_qspi_caps *caps =3D aq->caps;
=20
-	clk_prepare_enable(aq->clk);
+	caps->ops->clk_prepare_enable(aq);
=20
 	return atmel_qspi_init(aq);
 }
@@ -514,8 +710,35 @@ static int __maybe_unused atmel_qspi_resume(struct dev=
ice *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
=20
+static const struct atmel_qspi_ops atmel_sama5d2_qspi_ops =3D {
+	.clk_prepare_enable =3D atmel_sama5d2_qspi_clk_prepare_enable,
+	.clk_disable_unprepare =3D atmel_sama5d2_qspi_clk_disable_unprepare,
+	.set_qspi_cfg =3D atmel_sama5d2_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps =3D {
+	.ops =3D &atmel_sama5d2_qspi_ops,
+};
+
+static const struct atmel_qspi_ops atmel_sam9x60_qspi_ops =3D {
+	.clk_prepare_enable =3D atmel_sam9x60_qspi_clk_prepare_enable,
+	.clk_disable_unprepare =3D atmel_sam9x60_qspi_clk_disable_unprepare,
+	.set_qspi_cfg =3D atmel_sam9x60_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps =3D {
+	.ops =3D &atmel_sam9x60_qspi_ops,
+};
+
 static const struct of_device_id atmel_qspi_dt_ids[] =3D {
-	{ .compatible =3D "atmel,sama5d2-qspi" },
+	{
+		.compatible =3D "atmel,sama5d2-qspi",
+		.data =3D &atmel_sama5d2_qspi_caps,
+	},
+	{
+		.compatible =3D "microchip,sam9x60-qspi",
+		.data =3D &atmel_sam9x60_qspi_caps,
+	},
 	{ /* sentinel */ }
 };
=20
--=20
2.9.5
