Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D25474E;
	Sun,  6 Sep 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788706695; cv=none; b=FLnwGYNhSPjquVG/9aVMearW84w5GhrAwnpoNDzgMHTyximoDBwaoxGF2GxJgj/WkOJY46VwlRJdsFpsQ3YH+9RqCyuPEgDLtYegJkUAt6E9kw0Jn9uY+xI+PKq+R/1x5IWkHe3slmRT67WPK3J9ZoO2JOsTL5K/SJq95hx5mWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788706695; c=relaxed/simple;
	bh=vvdZe3uSiHkV5Qsw51uAUYdWtq6uyrVuspfKq4fLoAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qphWdZAdDiLv6ndRGrHMuoZ5w7/42imdw+R1knklVSIUzsvlbSMsUEbJ732lSexNG6a5OPrcKXyPgApjO/4EP4RdZljhairGigxsOofIyRYO+SF21P0Wmh5/RBvGti723KKGt+/8Kkg0d/HG73BVkPXFTFe+kzctY1ds5P5QOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=h4WHt/h5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="h4WHt/h5"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 686EvuJM32020811, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788706676; bh=mK3anRSMFsYf2qf8l4s43kZ5oZco+YyaCYelEOGWOFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=h4WHt/h5GQXg8Ko684Bcog1LbHkDxEx9gvZ/xn+viAIOQEo7q8OPFP2ypnOAbW3ab
	 rSUchyxJxLFnHwpff38GxiGM7a6WZGGVUam4eis9iWc5ZQmsvUw+rfDXeHj04w0Ro+
	 okV2iZrpTLdwEW1NTgZvCJUabqNIxwtqh+f7HNlMtudbGd6whqWTFDi7CGIV7OQNIA
	 hy2zR6e1F9ksyMmi5Fqzw+ij7vJDKXwr6zkVEuDL6U38bRu9XmE7og9FtH/86DhGup
	 YmV8Jeiw8thOaryXpDNz5tBdVgMNM9Chzn6ociDttluKB6U3NSLucMwBOQ5C0LkVRf
	 1Sc1TozewzKwA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 686EvuJM32020811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 6 Sep 2026 22:57:56 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 6 Sep 2026 22:57:56 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 6 Sep 2026 22:57:56 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Sun, 6 Sep 2026 22:57:56 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <jyanchou@realtek.com>, <p.zabel@pengutronix.de>
CC: <afaerber@suse.com>, <devicetree@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<james.tai@realtek.com>, <cy.huang@realtek.com>, <stanley_chang@realtek.com>,
	<eleanor.lin@realtek.com>
Subject: [PATCH v2 2/2] spi: spi-mem: Add Realtek SPI flash controller driver
Date: Sun, 6 Sep 2026 22:57:55 +0800
Message-ID: <20260906145755.1230079-3-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260906145755.1230079-1-eleanor.lin@realtek.com>
References: <20260906145755.1230079-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jyan Chou <jyanchou@realtek.com>

Add a spi-mem driver for the SPI Flash Controller (SFC) found on Realtek
DHC SoC. SFC supports Dual I/O.

Implement the exec_op API for regular control commands and the dirmap API
for hardware-accelerated read/write operations.

The controller is described by three register ranges. The first one (ctrl)
holds the control registers. The second one (dma) holds the DMA engine
registers, used to transfer the payload between the flash and main memory.
The third range is the memory aperture (dirmap) that maps the flash
contents.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>
Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v2:
- None.
---
 MAINTAINERS               |   6 +
 drivers/spi/Kconfig       |  10 +
 drivers/spi/Makefile      |   1 +
 drivers/spi/spi-rtk-nor.c | 637 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 654 insertions(+)
 create mode 100644 drivers/spi/spi-rtk-nor.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..705f7ddf792f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23011,6 +23011,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
 F:	drivers/spi/spi-realtek-rtl-snand.c
 
+REALTEK SPI-NOR
+M:	Jyan Chou <jyanchou@realtek.com>
+M:	Yu-Chun <eleanor.lin@realtek.com>
+S:	Supported
+F:	drivers/spi/spi-rtk-nor.c
+
 REALTEK SYSTIMER DRIVER
 M:	Hao-Wen Ting <haowen.ting@realtek.com>
 S:	Maintained
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 357cebef9917..4b758ca31490 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -976,6 +976,16 @@ config SPI_RSPI
 	help
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
+config SPI_RTK_NOR
+	tristate "Realtek SPI-NOR flash controller"
+	depends on ARCH_REALTEK || COMPILE_TEST
+	depends on SPI_MEM
+	help
+	  This enables support for the SPI Flash Controller found on Realtek
+	  DHC SoCs. The controller supports single and dual I/O transfers and
+	  offloads the payload to an integrated DMA engine.
+	  Say Y or M here if you are building a kernel for a Realtek DHC SoC
+
 config SPI_RZV2H_RSPI
 	tristate "Renesas RZ/V2H RSPI controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a18814fbde93..37c6eec9b541 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_MACH_REALTEK_RTL)		+= spi-realtek-rtl.o
 obj-$(CONFIG_SPI_REALTEK_SNAND)		+= spi-realtek-rtl-snand.o
 obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
+obj-$(CONFIG_SPI_RTK_NOR)		+= spi-rtk-nor.o
 obj-$(CONFIG_SPI_RZV2H_RSPI)		+= spi-rzv2h-rspi.o
 obj-$(CONFIG_SPI_RZV2M_CSI)		+= spi-rzv2m-csi.o
 obj-$(CONFIG_SPI_S3C64XX)		+= spi-s3c64xx.o
diff --git a/drivers/spi/spi-rtk-nor.c b/drivers/spi/spi-rtk-nor.c
new file mode 100644
index 000000000000..0206ea99f3c9
--- /dev/null
+++ b/drivers/spi/spi-rtk-nor.c
@@ -0,0 +1,637 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Realtek SPI Nor Flash Controller Driver (SFC)
+ *
+ * Copyright (c) 2024-2026 Realtek Technologies Co., Ltd.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/types.h>
+
+#define SFC_OPCODE		0x00
+#define DUAL_MODE_EN		BIT(9)
+
+#define SFC_CTL			0x04
+#define RW_DATAEN		BIT(4)
+#define ADDR_EN			BIT(3)
+
+#define SFC_SCK			0x08
+#define FDIV_MASK		GENMASK(7, 0)
+
+#define SFC_CE			0x0c
+#define DESLT_TIME		0x1a
+#define DESLT_TIME_SHIFT	16
+#define PH_CNT			0x13
+#define PH_CNT_SHIFT		8
+#define PL_CNT			0x7
+
+#define WT_PROM_DONE		BIT(8)
+
+#define SFC_POS_LATCH		0x14
+#define FALLING_EDGE_EN		0x0
+
+#define SFC_WAIT_WR		0x18
+#define SFC_EN_WR		0x1c
+#define WT_PROM_EN		BIT(8)
+
+#define SFC_ADR_FOUR_BYTE_EN	0x28
+
+#define MD_FDMA_DDR_SADDR	0x0c
+#define MD_FDMA_FL_SADDR	0x10
+
+#define MD_FDMA_CTRL2		0x14
+#define MAX_XFER_DMA_LEN	(BIT(26) | BIT(27))
+#define	MAX_XFER_256		BIT(26)
+#define DMA_TO_FLASH		BIT(25)
+
+#define MD_FDMA_CTRL1		0x18
+#define DMA_W_EN_START		BIT(3)
+#define	DMA_W_EN		BIT(1)
+#define DMA_START		BIT(0)
+
+#define MD_FDMA_DDR_SADDR1	0x20
+
+#define SFC_DMA_TIMEOUT		20000
+#define SFC_DMA_MAX_LEN		0x100
+
+#define SFC_CTL_DMYCNT_MASK	GENMASK(31, 24)
+#define SFC_CTL_DMYCNT_SHIFT	24
+#define SFC_SR_WIP		BIT(0)
+
+#define DMA_HIGH_BITS_MASK	0x7
+
+#define RTK_SPI_OP_RDSR		0x05
+#define RTK_SPI_OP_WREN		0x06
+#define RTK_SPI_OP_EN4B		0xb7
+#define RTK_SPI_OP_EX4B		0xe9
+
+#define SFC_AUTOSUSPEND_TIMEOUT	2000
+
+struct rtk_spi_host {
+	struct device		*dev;
+	struct clk		*clk;
+	struct reset_control	*rstc;
+	void __iomem		*regbase;
+	void __iomem		*iobase;
+	void __iomem		*mdbase;
+	void			*buffer;
+	dma_addr_t		dma_buffer;
+	resource_size_t		flash_phys_base;
+};
+
+static int rtk_spi_read_status(struct rtk_spi_host *host)
+{
+	int timeout = SFC_DMA_TIMEOUT;
+	u8 status;
+
+	while (timeout--) {
+		writel(RTK_SPI_OP_RDSR, host->regbase + SFC_OPCODE);
+		writel(RW_DATAEN, host->regbase + SFC_CTL);
+
+		status = readb(host->iobase);
+		if (!(status & SFC_SR_WIP))
+			return 0;
+
+		usleep_range(100, 200);
+	}
+
+	dev_err(host->dev, "Timeout waiting for Flash ready\n");
+
+	return -ETIMEDOUT;
+}
+
+static u32 rtk_spi_calc_dummy_cycles(const struct spi_mem_op *op)
+{
+	if (!op->dummy.nbytes)
+		return 0;
+
+	return (op->dummy.nbytes * 8) / op->dummy.buswidth;
+}
+
+static void rtk_spi_read_mode(struct rtk_spi_host *host, const struct spi_mem_op *op)
+{
+	u32 opcode = op->cmd.opcode;
+	u32 dummy_cycles, val;
+
+	if (op->data.buswidth == 2)
+		opcode |= DUAL_MODE_EN;
+
+	writel(opcode, host->regbase + SFC_OPCODE);
+
+	val = readl(host->regbase + SFC_CTL);
+	val |= RW_DATAEN | ADDR_EN;
+
+	dummy_cycles = rtk_spi_calc_dummy_cycles(op);
+
+	val &= ~SFC_CTL_DMYCNT_MASK;
+	val |= (dummy_cycles << SFC_CTL_DMYCNT_SHIFT) & SFC_CTL_DMYCNT_MASK;
+	writel(val, host->regbase + SFC_CTL);
+
+	readl(host->iobase);
+}
+
+static void rtk_spi_write_mode(struct rtk_spi_host *host,
+			       const struct spi_mem_op *op)
+{
+	u32 opcode = op->cmd.opcode;
+	u32 val;
+
+	writel(opcode, host->regbase + SFC_OPCODE);
+
+	val = readl(host->regbase + SFC_CTL);
+	val |= RW_DATAEN | ADDR_EN;
+	writel(val, host->regbase + SFC_CTL);
+}
+
+static void rtk_spi_enable_auto_write(struct rtk_spi_host *host)
+{
+	u32 val;
+
+	val = WT_PROM_DONE | RTK_SPI_OP_RDSR;
+	writel(val, host->regbase + SFC_WAIT_WR);
+
+	val = WT_PROM_EN | RTK_SPI_OP_WREN;
+	writel(val, host->regbase + SFC_EN_WR);
+}
+
+static void rtk_spi_disable_auto_write(struct rtk_spi_host *host)
+{
+	writel(RTK_SPI_OP_RDSR, host->regbase + SFC_WAIT_WR);
+	writel(RTK_SPI_OP_WREN, host->regbase + SFC_EN_WR);
+}
+
+static void rtk_spi_init(struct rtk_spi_host *host)
+{
+	u32 val;
+
+	val = readl(host->regbase + SFC_SCK);
+	val &= ~FDIV_MASK;
+	val |= (3 << 0) & FDIV_MASK;
+	writel(val, host->regbase + SFC_SCK);
+
+	val = (DESLT_TIME << DESLT_TIME_SHIFT) | (PH_CNT << PH_CNT_SHIFT) | PL_CNT;
+	writel(val, host->regbase + SFC_CE);
+
+	writel(FALLING_EDGE_EN, host->regbase + SFC_POS_LATCH);
+	writel(RTK_SPI_OP_RDSR, host->regbase + SFC_WAIT_WR);
+	writel(RTK_SPI_OP_WREN, host->regbase + SFC_EN_WR);
+}
+
+static int rtk_spi_command_read(struct rtk_spi_host *host, const struct spi_mem_op *op)
+{
+	size_t len = op->data.nbytes;
+	loff_t offset = op->addr.val;
+	u8 opcode = op->cmd.opcode;
+	u32 dummy_cycles, val;
+
+	writel(opcode, host->regbase + SFC_OPCODE);
+
+	val = readl(host->regbase + SFC_CTL);
+	val &= ~(SFC_CTL_DMYCNT_MASK | ADDR_EN);
+	val |= RW_DATAEN;
+
+	if (op->addr.nbytes > 0)
+		val |= ADDR_EN;
+
+	dummy_cycles = rtk_spi_calc_dummy_cycles(op);
+	val |= (dummy_cycles << SFC_CTL_DMYCNT_SHIFT) & SFC_CTL_DMYCNT_MASK;
+	writel(val, host->regbase + SFC_CTL);
+
+	memcpy_fromio(op->data.buf.in, host->iobase + offset, len);
+
+	return 0;
+}
+
+static int rtk_spi_do_write_and_cmds(struct rtk_spi_host *host, const struct spi_mem_op *op)
+{
+	u8 opcode = op->cmd.opcode;
+	u32 ctl_val = 0;
+	int ret = 0;
+
+	writel(opcode, host->regbase + SFC_OPCODE);
+
+	if (op->data.nbytes > 0)
+		ctl_val |= RW_DATAEN;
+	if (op->addr.nbytes > 0)
+		ctl_val |= ADDR_EN;
+
+	writel(ctl_val, host->regbase + SFC_CTL);
+
+	if (op->data.nbytes > 0) {
+		const u8 *buf = op->data.buf.out;
+		size_t i;
+
+		for (i = 0; i < op->data.nbytes; i++)
+			writeb(buf[i], host->iobase + op->addr.val + i);
+	} else if (op->addr.nbytes > 0) {
+		readb(host->iobase + op->addr.val);
+
+		/* Wait for internal flash erase/programming to complete */
+		ret = rtk_spi_read_status(host);
+	} else {
+		readb(host->iobase);
+
+		/*
+		 * For pure commands that require internal state synchronization
+		 * (such as Chip Erase), poll the flash status.
+		 */
+		ret = rtk_spi_read_status(host);
+	}
+
+	if (ret) {
+		dev_err(host->dev, "opcode 0x%02x failed: %d\n", opcode, ret);
+		return ret;
+	}
+
+	/*
+	 * Hardware Workaround:
+	 * The controller's auto-mode engine requires SFC_ADR_FOUR_BYTE_EN to be
+	 * explicitly updated when the flash enters or exits 4-byte mode via control
+	 * commands.
+	 */
+	if (opcode == RTK_SPI_OP_EN4B)
+		writel(0x1, host->regbase + SFC_ADR_FOUR_BYTE_EN);
+	else if (opcode == RTK_SPI_OP_EX4B)
+		writel(0x0, host->regbase + SFC_ADR_FOUR_BYTE_EN);
+
+	return ret;
+}
+
+static void rtk_spi_byte_transfer(struct rtk_spi_host *host, loff_t offset,
+				  size_t len, unsigned char *buf, bool is_read)
+{
+	if (is_read)
+		memcpy_fromio(buf, host->iobase + offset, len);
+	else
+		memcpy_toio(host->iobase + offset, buf, len);
+}
+
+static int rtk_spi_dma_transfer(struct rtk_spi_host *host, loff_t offset,
+				size_t len, bool is_read)
+{
+	u64 dma_buffer, timeout_us = SFC_DMA_TIMEOUT * 100;
+	u32 flash_phys_addr, val;
+	int ret;
+
+	writel(DMA_W_EN_START | DMA_W_EN, host->mdbase + MD_FDMA_CTRL1);
+
+	dma_buffer = host->dma_buffer;
+
+	/* Setup MD DDR address and flash address */
+	writel(lower_32_bits(dma_buffer), host->mdbase + MD_FDMA_DDR_SADDR);
+	writel(upper_32_bits(dma_buffer) & DMA_HIGH_BITS_MASK,
+	       host->mdbase + MD_FDMA_DDR_SADDR1);
+
+	/* MD_FDMA_FL_SADDR is a 32-bit hardware register */
+	flash_phys_addr = lower_32_bits(host->flash_phys_base + offset);
+	writel(flash_phys_addr, host->mdbase + MD_FDMA_FL_SADDR);
+
+	if (is_read)
+		val = MAX_XFER_DMA_LEN | len;
+	else
+		val = DMA_TO_FLASH | MAX_XFER_256 | len;
+
+	writel(val, host->mdbase + MD_FDMA_CTRL2);
+
+	writel(DMA_W_EN | DMA_START, host->mdbase + MD_FDMA_CTRL1);
+	udelay(1);
+
+	ret = readl_poll_timeout(host->mdbase + MD_FDMA_CTRL1, val,
+				 !(val & DMA_START), 100, timeout_us);
+	if (ret) {
+		dev_err(host->dev, "DMA transfer timed out\n");
+		return ret;
+	}
+
+	return rtk_spi_read_status(host);
+}
+
+static int rtk_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct rtk_spi_host *host = spi_controller_get_devdata(mem->spi->controller);
+
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		return rtk_spi_command_read(host, op);
+
+	return rtk_spi_do_write_and_cmds(host, op);
+}
+
+static bool rtk_spi_supports_op(struct spi_mem *mem,
+				const struct spi_mem_op *op)
+{
+	if (op->cmd.buswidth != 1)
+		return false;
+
+	if (op->cmd.dtr || op->addr.dtr || op->data.dtr)
+		return false;
+
+	if (op->addr.nbytes != 0) {
+		if (op->addr.buswidth > 1)
+			return false;
+		if (op->addr.nbytes < 3 || op->addr.nbytes > 4)
+			return false;
+	}
+
+	if (op->dummy.nbytes != 0) {
+		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
+			return false;
+	}
+
+	if (op->data.nbytes != 0 && op->data.buswidth > 2)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+static int rtk_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	const struct spi_mem_op *op = desc->info.op_tmpl;
+
+	if (op->data.dir == SPI_MEM_DATA_IN && op->addr.nbytes != 3 && op->addr.nbytes != 4)
+		return -EOPNOTSUPP;
+
+	if (op->data.dir != SPI_MEM_DATA_IN && op->data.dir != SPI_MEM_DATA_OUT)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static ssize_t rtk_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				   u64 offs, size_t len, void *buf)
+{
+	struct rtk_spi_host *host = spi_controller_get_devdata(desc->mem->spi->controller);
+	const struct spi_mem_op *op = desc->info.op_tmpl;
+	loff_t addr = desc->info.offset + offs;
+	size_t chunk_len;
+	int ret;
+
+	/*
+	 * Handle unaligned address bytes at the beginning of the read operation.
+	 * The hardware requires 4-byte alignment for DMA transfers.
+	 */
+	if (addr & 0x3) {
+		rtk_spi_read_mode(host, op);
+		chunk_len = min_t(size_t, 4 - (addr & 0x3), len);
+		rtk_spi_byte_transfer(host, addr, chunk_len, buf, true);
+
+		return chunk_len;
+	}
+
+	rtk_spi_read_mode(host, op);
+	chunk_len = min_t(size_t, len, SFC_DMA_MAX_LEN);
+	ret = rtk_spi_dma_transfer(host, addr, chunk_len, true);
+	if (ret) {
+		dev_err(host->dev, "DMA read transfer failed: %d\n", ret);
+		return ret;
+	}
+
+	memcpy(buf, host->buffer, chunk_len);
+
+	return chunk_len;
+}
+
+static ssize_t rtk_spi_dirmap_write(struct spi_mem_dirmap_desc *desc,
+				    u64 offs, size_t len, const void *buf)
+{
+	struct rtk_spi_host *host = spi_controller_get_devdata(desc->mem->spi->controller);
+	const struct spi_mem_op *op = desc->info.op_tmpl;
+	loff_t addr = desc->info.offset + offs;
+	size_t chunk_len;
+	int ret = 0;
+
+	rtk_spi_enable_auto_write(host);
+	rtk_spi_write_mode(host, op);
+
+	/*
+	 * Handle unaligned address bytes at the beginning of the write operation.
+	 * The hardware requires 4-byte alignment for DMA transfers.
+	 */
+	if (addr & 0x3) {
+		chunk_len = min_t(size_t, 4 - (addr & 0x3), len);
+		rtk_spi_byte_transfer(host, addr, chunk_len, (u8 *)buf, false);
+
+		goto out;
+	}
+
+	chunk_len = min_t(size_t, len, SFC_DMA_MAX_LEN);
+
+	memcpy(host->buffer, buf, chunk_len);
+
+	ret = rtk_spi_dma_transfer(host, addr, chunk_len, false);
+	if (ret)
+		dev_err(host->dev, "DMA write transfer failed: %d\n", ret);
+
+out:
+	rtk_spi_disable_auto_write(host);
+
+	return ret < 0 ? ret : chunk_len;
+}
+
+static const struct spi_controller_mem_ops rtk_spi_mem_ops = {
+	.supports_op = rtk_spi_supports_op,
+	.exec_op = rtk_spi_exec_op,
+	.dirmap_create = rtk_spi_dirmap_create,
+	.dirmap_read = rtk_spi_dirmap_read,
+	.dirmap_write = rtk_spi_dirmap_write,
+};
+
+static int rtk_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctrl;
+	struct rtk_spi_host *host;
+	struct resource *res;
+	int ret;
+
+	ctrl = devm_spi_alloc_host(dev, sizeof(*host));
+	if (!ctrl)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctrl);
+	host = spi_controller_get_devdata(ctrl);
+	host->dev = dev;
+
+	host->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(host->clk))
+		return PTR_ERR(host->clk);
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret)
+		return ret;
+
+	host->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(host->rstc)) {
+		ret = PTR_ERR(host->rstc);
+		goto err_disable_clk;
+	}
+
+	reset_control_assert(host->rstc);
+	usleep_range(10, 20);
+	reset_control_deassert(host->rstc);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(35));
+	if (ret) {
+		dev_err(dev, "Failed to set dma mask\n");
+		goto err_disable_clk;
+	}
+
+	host->buffer = dmam_alloc_coherent(dev, SFC_DMA_MAX_LEN,
+					   &host->dma_buffer, GFP_KERNEL);
+	if (!host->buffer) {
+		ret = -ENOMEM;
+		goto err_disable_clk;
+	}
+
+	host->regbase = devm_platform_ioremap_resource_byname(pdev, "ctrl");
+	if (IS_ERR(host->regbase)) {
+		ret = PTR_ERR(host->regbase);
+		goto err_disable_clk;
+	}
+
+	host->mdbase = devm_platform_ioremap_resource_byname(pdev, "dma");
+	if (IS_ERR(host->mdbase)) {
+		ret = PTR_ERR(host->mdbase);
+		goto err_disable_clk;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
+	host->iobase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(host->iobase)) {
+		ret = PTR_ERR(host->iobase);
+		goto err_disable_clk;
+	}
+
+	host->flash_phys_base = res->start;
+
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL;
+	ctrl->bus_num = -1;
+	ctrl->mem_ops = &rtk_spi_mem_ops;
+	ctrl->num_chipselect = 1;
+	ctrl->auto_runtime_pm = true;
+
+	rtk_spi_init(host);
+
+	pm_runtime_set_autosuspend_delay(dev, SFC_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_noresume(dev);
+
+	ret = spi_register_controller(ctrl);
+	if (ret < 0) {
+		dev_err(dev, "failed to register controller\n");
+		goto err_pm_disable;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+err_disable_clk:
+	clk_disable_unprepare(host->clk);
+
+	return ret;
+}
+
+static void rtk_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl = platform_get_drvdata(pdev);
+	struct rtk_spi_host *host = spi_controller_get_devdata(ctrl);
+	struct device *dev = &pdev->dev;
+
+	spi_unregister_controller(ctrl);
+
+	pm_runtime_get_sync(dev);
+	pm_runtime_disable(dev);
+	clk_disable_unprepare(host->clk);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+}
+
+static const struct of_device_id rtk_spi_dt_ids[] = {
+	{ .compatible = "realtek,rtd1625-nor" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, rtk_spi_dt_ids);
+
+static int rtk_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct rtk_spi_host *host = spi_controller_get_devdata(ctlr);
+
+	reset_control_assert(host->rstc);
+
+	clk_disable_unprepare(host->clk);
+
+	return 0;
+}
+
+static int rtk_spi_runtime_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct rtk_spi_host *host = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret < 0) {
+		dev_err(dev, "clk_prepare_enable failed: %d\n", ret);
+		return ret;
+	}
+
+	reset_control_assert(host->rstc);
+	usleep_range(10, 20);
+	reset_control_deassert(host->rstc);
+
+	rtk_spi_init(host);
+
+	return 0;
+}
+
+static int rtk_spi_suspend(struct device *dev)
+{
+	return pm_runtime_force_suspend(dev);
+}
+
+static int rtk_spi_resume(struct device *dev)
+{
+	return pm_runtime_force_resume(dev);
+}
+
+static const struct dev_pm_ops rtk_spi_pm_ops = {
+	RUNTIME_PM_OPS(rtk_spi_runtime_suspend, rtk_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(rtk_spi_suspend, rtk_spi_resume)
+};
+
+static struct platform_driver rtk_spi_driver = {
+	.driver = {
+		.name = "rtk-spi-nor",
+		.of_match_table = rtk_spi_dt_ids,
+		.pm = pm_ptr(&rtk_spi_pm_ops),
+	},
+	.probe	= rtk_spi_probe,
+	.remove	= rtk_spi_remove,
+};
+module_platform_driver(rtk_spi_driver);
+
+MODULE_DESCRIPTION("Realtek SPI Nor Controller Driver");
+MODULE_AUTHOR("Jyan Chou <jyanchou@realtek.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0

