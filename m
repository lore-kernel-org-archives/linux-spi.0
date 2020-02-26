From: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 05/11] spi: cadence-quadspi: Add support for octal DTR flashes
Date: Wed, 26 Feb 2020 15:06:57 +0530
Message-ID: <20200226093703.19765-6-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
To: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200226093703.19765-1-p.yadav-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set up opcode extension and enable/disable DTR mode based on whether the
command is DTR or not.

xSPI flashes can have a 4-byte dummy address associated with some
commands like the Read Status Register command in octal DTR mode. Since
the flash does not support sending the dummy address, we can not use
automatic write completion polling in DTR mode. Further, no write
completion polling makes it impossible to use DAC mode for DTR writes.
In that mode, the controller does not know beforehand how long a write
will be and so it can de-assert Chip Select (CS#) at any time. Once CS#
is de-assert, the flash will go into burning phase. But since the
controller does not do write completion polling, it does not know when
the flash is busy and might send in writes while the flash is not ready.

So, disable write completion polling and make writes go through indirect
mode for DTR writes and let spi-mem take care of polling the SR.

Signed-off-by: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-cadence-quadspi.c | 247 ++++++++++++++++++++++++++----
 1 file changed, 214 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 000f01c18c87..d43bf30e1cde 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -52,6 +52,7 @@ struct cqspi_flash_pdata {
 	u8		inst_width;
 	u8		addr_width;
 	u8		data_width;
+	bool		is_dtr;
 	u8		cs;
 	bool		registered;
 };
@@ -111,6 +112,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
 #define CQSPI_REG_CONFIG_BAUD_LSB		19
+#define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
 #define CQSPI_REG_CONFIG_BAUD_MASK		0xF
@@ -217,6 +220,14 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_CMDWRITEDATALOWER		0xA8
 #define CQSPI_REG_CMDWRITEDATAUPPER		0xAC
 
+#define CQSPI_REG_POLLING_STATUS		0xB0
+#define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
+
+#define CQSPI_REG_OP_EXT_LOWER			0xE0
+#define CQSPI_REG_OP_EXT_READ_LSB		24
+#define CQSPI_REG_OP_EXT_WRITE_LSB		16
+#define CQSPI_REG_OP_EXT_STIG_LSB		0
+
 /* Interrupt status bits */
 #define CQSPI_REG_IRQ_MODE_ERR			BIT(0)
 #define CQSPI_REG_IRQ_UNDERFLOW			BIT(1)
@@ -291,6 +302,69 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
 	return rdreg;
 }
 
+static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
+			      const struct spi_mem_op *op)
+{
+	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
+	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
+	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
+	f_pdata->is_dtr = op->data.is_dtr && op->cmd.is_dtr && op->addr.is_dtr;
+
+	switch (op->data.buswidth) {
+	case 0:
+		break;
+	case 1:
+		f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
+		break;
+	case 2:
+		f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
+		break;
+	case 4:
+		f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
+		break;
+	case 8:
+		f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Right now we only support 8-8-8 DTR mode. */
+	if (f_pdata->is_dtr) {
+		switch (op->cmd.buswidth) {
+		case 0:
+			break;
+		case 8:
+			f_pdata->inst_width = CQSPI_INST_TYPE_OCTAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (op->addr.buswidth) {
+		case 0:
+			break;
+		case 8:
+			f_pdata->addr_width = CQSPI_INST_TYPE_OCTAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		switch (op->data.buswidth) {
+		case 0:
+			break;
+		case 8:
+			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int cqspi_wait_idle(struct cqspi_st *cqspi)
 {
 	const unsigned int poll_idle_retry = 3;
@@ -348,6 +422,60 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 	return cqspi_wait_idle(cqspi);
 }
 
+static int cqspi_setup_opcode_ext(struct cqspi_flash_pdata *f_pdata,
+				  const struct spi_mem_op *op,
+				  unsigned int shift)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	int ret;
+	unsigned int reg;
+	u8 ext;
+
+	ret = spi_mem_get_cmd_ext(op, &ext);
+	if (ret)
+		return ret;
+	reg = readl(reg_base + CQSPI_REG_OP_EXT_LOWER);
+	reg &= ~(0xff << shift);
+	reg |= ext << shift;
+	writel(reg, reg_base + CQSPI_REG_OP_EXT_LOWER);
+
+	return 0;
+}
+
+static int cqspi_enable_dtr(struct cqspi_flash_pdata *f_pdata,
+			    const struct spi_mem_op *op, unsigned int shift,
+			    bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+
+	/*
+	 * We enable dual byte opcode here. The callers have to set up the
+	 * extension opcode based on which type of operation it is.
+	 */
+	if (enable) {
+		reg |= CQSPI_REG_CONFIG_DTR_PROTO;
+		reg |= CQSPI_REG_CONFIG_DUAL_OPCODE;
+
+		/* Set up command opcode extension. */
+		ret = cqspi_setup_opcode_ext(f_pdata, op, shift);
+		if (ret)
+			return ret;
+	} else {
+		reg &= ~CQSPI_REG_CONFIG_DTR_PROTO;
+		reg &= ~CQSPI_REG_CONFIG_DUAL_OPCODE;
+	}
+
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 			      const struct spi_mem_op *op)
 {
@@ -361,6 +489,15 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	size_t read_len;
 	int status;
 
+	status = cqspi_set_protocol(f_pdata, op);
+	if (status)
+		return status;
+
+	status = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
+				  f_pdata->is_dtr);
+	if (status)
+		return status;
+
 	if (!n_rx || n_rx > CQSPI_STIG_DATA_LEN_MAX || !rxbuf) {
 		dev_err(&cqspi->pdev->dev,
 			"Invalid input argument, len %zu rxbuf 0x%p\n",
@@ -410,6 +547,16 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 	unsigned int reg;
 	unsigned int data;
 	size_t write_len;
+	int ret;
+
+	ret = cqspi_set_protocol(f_pdata, op);
+	if (ret)
+		return ret;
+
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
+			       f_pdata->is_dtr);
+	if (ret)
+		return ret;
 
 	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
 		dev_err(&cqspi->pdev->dev,
@@ -418,6 +565,9 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
 		return -EINVAL;
 	}
 
+	reg = cqspi_calc_rdreg(f_pdata);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
 	reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 
 	if (op->addr.nbytes) {
@@ -456,16 +606,25 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int dummy_clk = 0;
 	unsigned int reg;
+	int ret;
+
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_READ_LSB,
+			       f_pdata->is_dtr);
+	if (ret)
+		return ret;
 
 	reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
 	reg |= cqspi_calc_rdreg(f_pdata);
 
 	/* Setup dummy clock cycles */
-	dummy_clk = op->dummy.nbytes * 8;
+	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
+	if (f_pdata->is_dtr)
+		dummy_clk /= 2;
+
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		dummy_clk = CQSPI_DUMMY_CLKS_MAX;
 
-	if (dummy_clk / 8)
+	if (dummy_clk)
 		reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
 		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
 
@@ -575,15 +734,38 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 			     const struct spi_mem_op *op)
 {
 	unsigned int reg;
+	int ret;
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
 
+	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_WRITE_LSB,
+			       f_pdata->is_dtr);
+	if (ret)
+		return ret;
+
 	/* Set opcode. */
 	reg = op->cmd.opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
+	reg |= f_pdata->data_width << CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
+	reg |= f_pdata->addr_width << CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
 	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
 	reg = cqspi_calc_rdreg(f_pdata);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
+	/* Set up the command opcode extension. */
+	if (f_pdata->is_dtr) {
+		/*
+		 * Some flashes like the cypress Semper flash expect a 4-byte
+		 * dummy address with the Read SR command in DTR mode, but this
+		 * controller does not support sending address with the Read SR
+		 * command. So, disable write completion polling on the
+		 * controller's side. spi-nor will take care of polling the
+		 * status register.
+		 */
+		reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
+		writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	}
+
 	reg = readl(reg_base + CQSPI_REG_SIZE);
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
@@ -833,35 +1015,6 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_controller_enable(cqspi, 1);
 }
 
-static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
-			      const struct spi_mem_op *op)
-{
-	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		switch (op->data.buswidth) {
-		case 1:
-			f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-			break;
-		case 2:
-			f_pdata->data_width = CQSPI_INST_TYPE_DUAL;
-			break;
-		case 4:
-			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
-			break;
-		case 8:
-			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 			   const struct spi_mem_op *op)
 {
@@ -879,7 +1032,16 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	if (ret)
 		return ret;
 
-	if (cqspi->use_dac_mode && ((to + len) <= cqspi->ahb_size)) {
+	/*
+	 * Some flashes like the Cypress Semper flash expect a dummy 4-byte
+	 * address (all 0s) with the read status register command in DTR mode.
+	 * But this controller does not support sending dummy address bytes to
+	 * the flash when it is polling the write completion register in DTR
+	 * mode. So, we can not use direct mode when in DTR mode for writing
+	 * data.
+	 */
+	if (!f_pdata->is_dtr && cqspi->use_dac_mode
+	    && ((to + len) <= cqspi->ahb_size)) {
 		memcpy_toio(cqspi->ahb_base + to, buf, len);
 		return cqspi_wait_idle(cqspi);
 	}
@@ -1006,6 +1168,23 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return ret;
 }
 
+static bool cqspi_supports_mem_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	bool all_true, all_false;
+
+	all_true = op->cmd.is_dtr && op->addr.is_dtr && op->dummy.is_dtr &&
+		   op->data.is_dtr;
+	all_false = !op->cmd.is_dtr && !op->addr.is_dtr && !op->dummy.is_dtr &&
+		    !op->data.is_dtr;
+
+	/* Mixed DTR modes not supported. */
+	if (!(all_true || all_false))
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 				    struct cqspi_flash_pdata *f_pdata,
 				    struct device_node *np)
@@ -1136,6 +1315,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 
 static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
+	.supports_op = cqspi_supports_mem_op,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
@@ -1187,7 +1367,8 @@ static int cqspi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "spi_alloc_master failed\n");
 		return -ENOMEM;
 	}
-	master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL;
+	master->mode_bits = SPI_RX_OCTAL | SPI_TX_OCTAL | SPI_RX_QUAD |
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_RX_DTR | SPI_TX_DTR;
 	master->mem_ops = &cqspi_mem_ops;
 	master->dev.of_node = pdev->dev.of_node;
 
-- 
2.25.0
