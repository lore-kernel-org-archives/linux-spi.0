From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Thu, 31 Jan 2019 16:15:51 +0000
Message-ID: <20190131161515.21605-11-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
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
v2:
- rework clock handling
- reorder setting of register values in set_cfg() calls -> move functions
  that can fail in the upper part of the function body.

 drivers/spi/atmel-quadspi.c | 296 +++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 239 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d3e76acf8517..80c934f3e479 100644
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
@@ -137,16 +144,37 @@
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
 	u32			mr;
 	struct completion	cmd_completion;
 };
=20
+struct atmel_qspi_ops {
+	int (*set_qspi_cfg)(void __iomem *regs, const struct spi_mem_op *op,
+			    struct atmel_qspi_cfg *cfg);
+};
+
+struct atmel_qspi_caps {
+	const struct atmel_qspi_ops *ops;
+	bool has_qspick;
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -204,28 +232,36 @@ static bool atmel_qspi_supports_op(struct spi_mem *me=
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
-	void __iomem *base =3D aq->regs;
-	int mode;
-	u32 dummy_cycles =3D 0;
-	u32 iar, icr, ifr, sr;
-	int err =3D 0;
+	int mode =3D atmel_qspi_find_mode(op);
=20
-	iar =3D 0;
-	icr =3D QSPI_ICR_INST(op->cmd.opcode);
-	ifr =3D QSPI_IFR_INSTEN;
-
-	/* Set the QSPI controller in Serial Memory Mode */
-	if (!(aq->mr & QSPI_MR_SMM))
-		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
-
-	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
+	cfg->ifr =3D sama5d2_qspi_modes[mode].config;
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
@@ -235,28 +271,28 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
nst struct spi_mem_op *op)
 		case 0:
 			break;
 		case 1:
-			ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
-			icr |=3D QSPI_ICR_OPT(op->addr.val & 0xff);
+			cfg->ifr |=3D QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			cfg->icr =3D QSPI_ICR_OPT(op->addr.val & 0xff);
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
@@ -265,24 +301,106 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, c=
onst struct spi_mem_op *op)
=20
 	/* Set number of dummy cycles */
 	if (dummy_cycles)
-		ifr |=3D QSPI_IFR_NBDUM(dummy_cycles);
+		cfg->ifr |=3D QSPI_IFR_NBDUM(dummy_cycles);
+
+	return 0;
+}
+
+static int atmel_sama5d2_qspi_set_cfg(void __iomem *base,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret =3D atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	ret =3D atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
+
+	cfg->ifr |=3D QSPI_IFR_INSTEN;
+	cfg->icr |=3D QSPI_ICR_INST(op->cmd.opcode);
=20
 	/* Set data enable */
 	if (op->data.nbytes)
-		ifr |=3D QSPI_IFR_DATAEN;
+		cfg->ifr |=3D QSPI_IFR_DATAEN;
=20
 	if (op->data.dir =3D=3D SPI_MEM_DATA_IN && op->data.nbytes)
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_READ;
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_READ;
 	else
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
+		cfg->ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
+
+	/* Clear pending interrupts */
+	(void)readl_relaxed(base + QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	writel_relaxed(cfg->iar, base + QSPI_IAR);
+	writel_relaxed(cfg->icr, base + QSPI_ICR);
+	writel_relaxed(cfg->ifr, base + QSPI_IFR);
+
+	return 0;
+}
+
+static int atmel_sam9x60_qspi_set_cfg(void __iomem *base,
+				      const struct spi_mem_op *op,
+				      struct atmel_qspi_cfg *cfg)
+{
+	int ret =3D atmel_qspi_set_mode(cfg, op);
+
+	if (ret)
+		return ret;
+
+	ret =3D atmel_qspi_set_address_mode(cfg, op);
+	if (ret)
+		return ret;
+
+	cfg->ifr |=3D QSPI_IFR_INSTEN;
+	cfg->icr |=3D QSPI_ICR_INST(op->cmd.opcode);
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		cfg->ifr |=3D QSPI_IFR_DATAEN;
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
=20
 	/* Clear pending interrupts */
 	(void)readl_relaxed(base + QSPI_SR);
=20
 	/* Set QSPI Instruction Frame registers */
-	writel_relaxed(iar, base + QSPI_IAR);
-	writel_relaxed(icr, base + QSPI_ICR);
-	writel_relaxed(ifr, base + QSPI_IFR);
+	writel_relaxed(cfg->iar, base + QSPI_IAR);
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+		writel_relaxed(cfg->icr, base + QSPI_ICR);
+	else
+		writel_relaxed(cfg->icr, base + QSPI_RICR);
+	writel_relaxed(cfg->ifr, base + QSPI_IFR);
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op=
 *op)
+{
+	struct atmel_qspi *aq =3D spi_controller_get_devdata(mem->spi->master);
+	void __iomem *base =3D aq->regs;
+	struct atmel_qspi_cfg cfg =3D {0};
+	u32 sr;
+	int err;
+
+	/* Set the QSPI controller in Serial Memory Mode */
+	if (!(aq->mr & QSPI_MR_SMM))
+		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
+
+	err =3D aq->caps->ops->set_qspi_cfg(base, op, &cfg);
+	if (err)
+		return err;
=20
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -291,11 +409,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, co=
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
 		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
@@ -395,9 +513,22 @@ static int atmel_qspi_probe(struct platform_device *pd=
ev)
 	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
 	struct resource *res;
+	const struct atmel_qspi_caps *caps;
+	struct device *dev =3D &pdev->dev;
 	int irq, err =3D 0;
=20
-	ctrl =3D spi_alloc_master(&pdev->dev, sizeof(*aq));
+	caps =3D of_device_get_match_data(dev);
+	if (!caps) {
+		dev_err(dev, "Could not retrieve QSPI caps\n");
+		return -EINVAL;
+	}
+
+	if (!caps->ops->set_qspi_cfg) {
+		dev_err(dev, "Could not retrieve QSPI ops\n");
+		return -EINVAL;
+	}
+
+	ctrl =3D spi_alloc_master(dev, sizeof(*aq));
 	if (!ctrl)
 		return -ENOMEM;
=20
@@ -413,29 +544,33 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
=20
 	init_completion(&aq->cmd_completion);
 	aq->pdev =3D pdev;
+	aq->caps =3D caps;
=20
 	/* Map the registers */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
-	aq->regs =3D devm_ioremap_resource(&pdev->dev, res);
+	aq->regs =3D devm_ioremap_resource(dev, res);
 	if (IS_ERR(aq->regs)) {
-		dev_err(&pdev->dev, "missing registers\n");
+		dev_err(dev, "missing registers\n");
 		err =3D PTR_ERR(aq->regs);
 		goto exit;
 	}
=20
 	/* Map the AHB memory */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
-	aq->mem =3D devm_ioremap_resource(&pdev->dev, res);
+	aq->mem =3D devm_ioremap_resource(dev, res);
 	if (IS_ERR(aq->mem)) {
-		dev_err(&pdev->dev, "missing AHB memory\n");
+		dev_err(dev, "missing AHB memory\n");
 		err =3D PTR_ERR(aq->mem);
 		goto exit;
 	}
=20
 	/* Get the peripheral clock */
-	aq->clk =3D devm_clk_get(&pdev->dev, NULL);
+	aq->clk =3D devm_clk_get(dev, "pclk");
+	if (IS_ERR(aq->clk))
+		aq->clk =3D devm_clk_get(dev, NULL);
+
 	if (IS_ERR(aq->clk)) {
-		dev_err(&pdev->dev, "missing peripheral clock\n");
+		dev_err(dev, "missing peripheral clock\n");
 		err =3D PTR_ERR(aq->clk);
 		goto exit;
 	}
@@ -443,32 +578,52 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 	/* Enable the peripheral clock */
 	err =3D clk_prepare_enable(aq->clk);
 	if (err) {
-		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
+		dev_err(dev, "failed to enable the peripheral clock\n");
 		goto exit;
 	}
=20
+	if (caps->has_qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick =3D devm_clk_get(dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(dev, "missing system clock\n");
+			err =3D PTR_ERR(aq->qspick);
+			goto disable_clk;
+		}
+
+		/* Enable the QSPI system clock */
+		err =3D clk_prepare_enable(aq->qspick);
+		if (err) {
+			dev_err(dev,
+				"failed to enable the QSPI system clock\n");
+			goto disable_clk;
+		}
+	}
+
 	/* Request the IRQ */
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing IRQ\n");
+		dev_err(dev, "missing IRQ\n");
 		err =3D irq;
-		goto disable_clk;
+		goto disable_qspick;
 	}
-	err =3D devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
-			       0, dev_name(&pdev->dev), aq);
+	err =3D devm_request_irq(dev, irq, atmel_qspi_interrupt, 0,
+			       dev_name(dev), aq);
 	if (err)
-		goto disable_clk;
+		goto disable_qspick;
=20
 	err =3D atmel_qspi_init(aq);
 	if (err)
-		goto disable_clk;
+		goto disable_qspick;
=20
 	err =3D spi_register_controller(ctrl);
 	if (err)
-		goto disable_clk;
+		goto disable_qspick;
=20
 	return 0;
=20
+disable_qspick:
+	clk_disable_unprepare(aq->qspick);
 disable_clk:
 	clk_disable_unprepare(aq->clk);
 exit:
@@ -484,6 +639,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
=20
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->clk);
 	return 0;
 }
@@ -492,6 +648,7 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->clk);
=20
 	return 0;
@@ -502,6 +659,7 @@ static int __maybe_unused atmel_qspi_resume(struct devi=
ce *dev)
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
 	clk_prepare_enable(aq->clk);
+	clk_prepare_enable(aq->qspick);
=20
 	return atmel_qspi_init(aq);
 }
@@ -509,8 +667,32 @@ static int __maybe_unused atmel_qspi_resume(struct dev=
ice *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
=20
+static const struct atmel_qspi_ops atmel_sama5d2_qspi_ops =3D {
+	.set_qspi_cfg =3D atmel_sama5d2_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps =3D {
+	.ops =3D &atmel_sama5d2_qspi_ops,
+};
+
+static const struct atmel_qspi_ops atmel_sam9x60_qspi_ops =3D {
+	.set_qspi_cfg =3D atmel_sam9x60_qspi_set_cfg,
+};
+
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps =3D {
+	.ops =3D &atmel_sam9x60_qspi_ops,
+	.has_qspick =3D true,
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
