Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1A495AEE
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962606; cv=none; b=n0fTy+1MajrxkUGbixsN+aidLvhw9zehZuqMGAuA2fcqZ55evOuHdZsZJ4FtBmLdyJFnkKHHJ3wNTCgdXDBRziGCQXleQtGT2E65vqc9RK/uRqTZ9zno0FMIrupS1tO9pf2tJYLNyAVryz4cMjmXbOGu0ze5ezP5QObbuyUrk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962606; c=relaxed/simple;
	bh=2tefS0k9py8JryL9sWHerTjVHvSgEXhzrSvkKM5WuT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS/fiHO76JY1z98zmGv8g/RFSZMFCGcOjhTD2VhqeLvn0apygfj3lGq7WwETceXTDYv2ZF2xNzeNLJjgn+4dvaLK+SadhriI2LFvwvzihPjSbmpM7128dqwcJM2c2r8s/9qbRSPi5+hHMyttQcr9I9msiRvM4hmVBTGH0a/SEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smxxPA10; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smxxPA10"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48deeadb3fdso75716f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962595; x=1792567395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OX0VXOszlEhy3QmUuQYMcEiT+j/7+8CPCHw1G+kDYVg=;
        b=smxxPA1059gE9ehIGtwh1pqylsG2AZZOMi4QUMmCiIKJBFTN0IXFvQJ6UCQwJEO7oX
         J8Jlu8b/dK/nqeZpNkKhDKUygTgV5QMZfvHyAvUOGiJOFMwN7BdALDwFTNYvyUm/X4an
         JYSta3Quoi2/X0ChIT8zA/fKch+DoXnLYHSKcI9W8DYpXVaBuRUZ4/lMWmTPKANRRTRn
         N9N0en4TaSTD42geB1Q46Ama42XL497/P4p2vYmM+hhd9rIUR7XSQ184inLHmdZ1rD+X
         bFyKSe9a7TBOKsSMqkGKjHuxi+miOc3MhaBxmUyXw+oFCWKwdwg6Tr6jUtC9kZ0YGxNm
         qLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962595; x=1792567395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OX0VXOszlEhy3QmUuQYMcEiT+j/7+8CPCHw1G+kDYVg=;
        b=mumscTi3D7SV37nq4gBOYDvnVlHp5552Wd0ClhQ06k0fuHgXgdka5iQHNPvA625VTf
         IlVCeDlY8X4Q7ReUJnoE7QTURCxCbOH2YYpv6pUxf0DhUqWBHvje35ZMl+8ifXkd4WiN
         6K2mkCFYhAmF3eX3JqcL3QmLVMb4BvJ1qjc3oqMyKRmGGfbrFbECQWVswqmENhONXQMh
         Oluco6LK9QOPKHHvORPiTIlDVCSQ8/+9ohZcM2fXWXGaezCMYz4PTrLSanr90VRGoBIn
         gb8cYLV2Fch/IY1mSN8eypKPIryFfhZGUsrn5n8KakcMZQru9YfRMoPMOr981Z5GsYJb
         3ztA==
X-Forwarded-Encrypted: i=1; AKwUvByKP1mv02V/EmjJSHwyZ4C9q1VcOva8Uv/e9HuDhUy+vO8XKj/A0s9tYfNXEtS3v56pbaLMc9rUgyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUKPoefyegavdnZLtAJkkRzu6M03GeiYbhFefGMWfOEbzG3MZx
	AYXyF3/XpKsIekgtRrhrp0KnDpqAjyf+SXyjaEtPrN7mXgFqAYJ4bwmF
X-Gm-Gg: AYBFou3jjyvzrI+LCia6bG0x2qlvC7qXyVpqbIoUIzD0jpGidq3uLkrn994VFqtKEbz
	QOKJsuvHOqLENSFaNMJ+cD61ArVefHQsf9svDuWHjJSSCV2o+C2pwcE/HiO2Nb/auWCI2/Ek4F7
	uNXVHj3l1kWJllJKrPKY/+cKbw3FULz0TyM6roPDpWYvdecfeA/Mm4Xbj/iQLq0ISvhKMxlUIpV
	/5hxo7xODYOWMstj3EblAUwf/Cikr3kPzDF6qAAQhM3YR2NJJu4vQRhqNJJFC6aqw5gtgqdwFIe
	rrjmmo4StCNyhNxMmrb9ZOMFNtoM5tnuAxxtdladfm8IJZuT/gnWLvsU6dbH4jso8shmQI6YzQl
	tdel21UtC4qLoeVdeP5Nnkl+1H8tqjgcfrqgUZ1jY6mEpd3ifd/AgGH5eod1Y9NhGoXRdmjGloX
	q8QH3XcaP2LWkTNPImCJg97mFoWLI1WmIcO8C6cnU7VYPgNyaCj2fH0xKstpb1isU4LpFpNZzWZ
	bdvjXQB8rvgMTAFmnsJBavKZCSIoFl5HZZCaEDHiQgoRt0W84yyL7IvT0TsQVXslfHLli3EuBUu
	ycIF8RnW3yxCbZjuH5/2yvOsmujtb3iKjbq/gpi+R2KevkuExYgqF1peDGRziw==
X-Received: by 2002:a05:6000:220f:b0:48d:eee6:b1a0 with SMTP id ffacd0b85a97d-48deee6b2f0mr231922f8f.9.1791962595326;
        Wed, 14 Oct 2026 00:23:15 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:14 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 20/24] spi: zx: Add ZTE ZX family SPI flash controller driver
Date: Wed, 14 Oct 2026 08:21:00 +0100
Message-ID: <20261014072109.1759502-21-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the SPI flash controller found on ZTE ZX family SoCs
(ZX297520V3, ZX279128S). Implement tuned PIO to avoid redundant FIFO
depth reads, dynamic CCF clock scaling, 4KB operation chunking, and
optional DMA support.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 drivers/spi/Kconfig  |  15 +
 drivers/spi/Makefile |   1 +
 drivers/spi/spi-zx.c | 728 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 744 insertions(+)
 create mode 100644 drivers/spi/spi-zx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a0f37e2df7..5ab0cec218 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1320,6 +1320,21 @@ config SPI_XTENSA_XTFPGA
 	  16 bit words in SPI mode 0, automatically asserting CS on transfer
 	  start and deasserting on end.
 
+config SPI_ZX
+	tristate "ZTE ZX family SPI flash controller"
+	depends on ARCH_ZTE || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	depends on SPI_MEM
+	help
+	  This enables support for the SPI flash controller found on ZTE ZX
+	  family SoCs (ZX297520V3, ZX279128S, etc.), through which they reach
+	  boot flash (such as SPI NAND on the ZTE ZXHN H3600).
+	  This controller operates flash transactions through a hardware FIFO
+	  or optional DMA engine.
+	  This driver does not support generic SPI. It only implements the
+	  spi-mem interface.
+
+
 config SPI_ZYNQ_QSPI
 	tristate "Xilinx Zynq QSPI controller"
 	depends on ARCH_ZYNQ || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a18814fbde..3e9ea1e6fa 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -170,6 +170,7 @@ obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
+obj-$(CONFIG_SPI_ZX)			+= spi-zx.o
 obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 obj-$(CONFIG_SPI_AMD)			+= spi-amd.o spi-amd-pci.o
diff --git a/drivers/spi/spi-zx.c b/drivers/spi/spi-zx.c
new file mode 100644
index 0000000000..edcad6008d
--- /dev/null
+++ b/drivers/spi/spi-zx.c
@@ -0,0 +1,728 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) ZTE (for HW register defines and initial PIO implementation)
+ * Copyright (C) Stefan Dösinger 2026
+ * Author: Stefan Dösinger <stefandoesinger@gmail.com>
+ *
+ * This device has certain similarities to stm32-qspi, but it isn't as simple as remapping register
+ * offsets.
+ */
+
+//#define DEBUG
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/sizes.h>
+#include <linux/spi/spi-mem.h>
+
+#define MODULE_NAME "zx-qspi"
+
+struct zx_qspi {
+	struct spi_controller *ctrl;
+	struct reset_control *rstc;
+	phys_addr_t phys_base;
+	void __iomem *io_base;
+	struct clk *pclk, *wclk;
+
+	struct completion dma_completion;
+	struct sg_table sgt;
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_chan *cur_dma_ch;
+	unsigned int speed_hz;
+
+	/* TODO: Do I need locks? */
+};
+
+#define ZX_QSPI_FIFO_SIZE			16
+
+/* Register and flag defines are copypasted from ZTE's kernel */
+
+/*
+ * spifc register
+ *
+ * ZX_QSPI_VER_REG: This is a bit of a misnomer. The mmio areas of a lot of hardware on the ZX
+ * platform starts with an identifier. 0x01040000 is the identifier of the SPI and QSPI devices,
+ * so VER_REG will always contain 0x01040000.
+ */
+#define ZX_QSPI_VER_REG				0x0
+#define ZX_QSPI_START_REG			0x4
+#define ZX_QSPI_EN_REG				0x8
+#define ZX_QSPI_CTRL0_REG			0xc
+#define ZX_QSPI_CTRL1_REG			0x10
+#define ZX_QSPI_CTRL2_REG			0x14
+#define ZX_QSPI_BYTE_NUM_REG			0x18
+#define ZX_QSPI_ADDR_REG			0x1c
+#define ZX_QSPI_INS_REG				0x20
+#define ZX_QSPI_TIMING_REG			0x24
+#define ZX_QSPI_INT_EN_REG			0x28
+#define ZX_QSPI_INT_RAW_REG			0x2c
+#define ZX_QSPI_INT_SW_CLR_REG			0x30
+#define ZX_QSPI_SW_REG				0x34
+#define ZX_QSPI_DATA_REG			0x38
+
+/*
+ * spifc start register
+ */
+#define ZX_QSPI_START				BIT(0)
+#define ZX_QSPI_BUSY				BIT(0)
+
+/*
+ * spifc en register
+ */
+#define ZX_QSPI_EN				BIT(0)
+#define ZX_QSPI_EN_BACK				BIT(1)
+
+/*
+ * spifc ctrl0 register
+ *
+ * Guesswork: ZX_QSPI_*XFIFO_THRES are probably 4 bit counts that set at which point an int is
+ * raised. E.g. if ZX_QSPI_TXFIFO_THRES=5, it will raise an int when the RX fifo has 5 32 bit
+ * values ready to read. They also have an effect on DMA. If the THRES flags are set, the burst
+ * size needs to be big enough or the DMA transfer times out.
+ *
+ * I don't know what ZX_QSPI_WDOG_EN does. Likely there is some correlation with INT_WDOG_OVERRUN,
+ * but all I could observe is that setting ZX_QSPI_WDOG_EN breaks write operations with DMA.
+ */
+#define ZX_QSPI_SCLK_PAUSE_CLR_ALLOW		BIT(17)
+#define ZX_QSPI_SCLK_PAUSE_EN			BIT(16)
+#define ZX_QSPI_TXFIFO_CLR			BIT(15)
+#define ZX_QSPI_RXFIFO_CLR			BIT(14)
+#define ZX_QSPI_TXFIFO_THRES			BIT(10)
+#define ZX_QSPI_RXFIFO_THRES			BIT(6)
+#define ZX_QSPI_TX_DMA_EN			BIT(5)
+#define ZX_QSPI_RX_DMA_EN			BIT(4)
+#define ZX_QSPI_WDOG_EN				BIT(3)
+#define ZX_QSPI_SPI_MODE			BIT(1)
+#define ZX_QSPI_WR_PROTECT			BIT(0)
+
+/*
+ * spifc ctrl1 register
+ */
+#define ZX_QSPI_ADDR_TX_EN			BIT(4)
+#define ZX_QSPI_DUMMY_TX_EN			BIT(2)
+#define ZX_QSPI_READ_DATA_EN			BIT(1)
+#define ZX_QSPI_WRITE_DATA_EN			BIT(0)
+
+/*
+ * spifc ctrl2 register
+ */
+#define ZX_QSPI_DUMMY_BYTE_NUM			(12)		/* [12:15} */
+#define ZX_QSPI_DUMMY_BIT_NUM			(8)		/* [8:10] */
+#define ZX_QSPI_ADDR_BYTE_NUM			(5)		/* [5:6] */
+#define ZX_QSPI_ADDR_MULTI_LINE_EN		BIT(4)
+#define ZX_QSPI_DATA_MULTI_LINE_EN		BIT(2)
+#define ZX_QSPI_TRANS_MOD			BIT(0)
+
+#define ADDR_BYTE_WIDTH_8			(0)
+#define ADDR_BYTE_WIDTH_16			(1)
+#define ADDR_BYTE_WIDTH_24			(2)
+#define ADDR_BYTE_WIDTH_32			(3)
+
+/*
+ * spifc timing register
+ */
+#define ZX_QSPI_T_CS_SETUP			11	/* [11:13] */
+#define ZX_QSPI_T_CS_HOLD			6	/* [8:6] */
+#define ZX_QSPI_T_CS_DESEL			0	/* [0:3] */
+
+/*
+ * spifc int_en, int_raw, int_sw_clr register
+ */
+#define ZX_QSPI_INT_TX_BYD_THRES		BIT(7)
+#define ZX_QSPI_INT_RX_BYD_THRES		BIT(6)
+#define ZX_QSPI_INT_TX_UNDERRUN			BIT(5)
+#define ZX_QSPI_INT_RX_OVERRUN			BIT(4)
+#define ZX_QSPI_INT_WDOG_OVERRUN		BIT(2)
+#define ZX_QSPI_INT_FMT_ERR			BIT(1)
+#define ZX_QSPI_INT_CMD_END			BIT(0)
+#define ZX_QSPI_INT_ALL_MASK			GENMASK(7, 0)
+#define ZX_QSPI_INT_EN_MASK			GENMASK(5, 0)
+
+/*
+ * spifc sw register
+ */
+#define ZX_QSPI_TX_FIFO_CNT_MASK		GENMASK(20, 16)	/* [16:20] */
+#define ZX_QSPI_RX_FIFO_CNT_MASK		GENMASK(12, 8)	/* [8:12] */
+#define ZX_QSPI_TX_BYD_THRES			BIT(5)
+#define ZX_QSPI_RX_BYD_THRES			BIT(4)
+#define ZX_QSPI_SCLK_PAUSE_FLAG			BIT(3)
+#define ZX_QSPI_WAIT_FLAG			BIT(2)
+#define ZX_QSPI_FORMAT_ERR			BIT(1)
+
+static irqreturn_t zx_qspi_irq(int irq, void *dev_id)
+{
+	struct zx_qspi *qspi = dev_id;
+	struct device *dev = &qspi->ctrl->dev;
+	u32 sw, raw = 0;
+	/* The RAW_REG register reports the unmodified hardware status while the SW/CLR reg reports
+	 * RAW_REG & INT_EN_REG.
+	 *
+	 * Beware that clearing a FIFO flag here doesn't do much - the RX fifo will still have data
+	 * and the TX fifo will still have room, so it will re-raise the same int again. The
+	 * solution is to mask the RX/TX ints and re-enable them after reading or filling the fifo.
+	 *
+	 * By and large IRQs from this controller are not very helpful. If we're in PIO mode we are
+	 * forced to do a lot of busy waiting anyway because we have to drain/fill FIFOs every 64
+	 * bytes. In ad-hoc benchmarking, doing PIO with IRQ notifications resulted in both slower
+	 * reads as well as slower parallel CPU computation.
+	 *
+	 * In DMA mode we just piggypack on the DMA IRQ.
+	 */
+	sw = readl_relaxed(qspi->io_base + ZX_QSPI_INT_SW_CLR_REG);
+	raw = readl_relaxed(qspi->io_base + ZX_QSPI_INT_RAW_REG);
+
+	dev_dbg(dev, "Got an IRQ, sw %x raw %x\n", sw, raw);
+
+	writel_relaxed(0, qspi->io_base + ZX_QSPI_INT_EN_REG);
+
+	return IRQ_HANDLED;
+}
+
+/* IRQs for PIO aren't worth the bother. The hardware is sloppy with IRQs in larger (>2000 byte)
+ * transfers and in my testing it does not free up measurable amounts of CPU resources. DMA is the
+ * answer to better performance, not tuning PIO.
+ *
+ * To get IRQs for PIO operations set ZX_QSPI_{R/T}XFIFO_THRES to a non-zero value and enable
+ * ZX_QSPI_INT_{R/T}X_BYD_THES in ZX_QSPI_INT_EN_REG. Beware that the TX fifo will report empty
+ * until it is fed with data, so only unmask this interrupt after the pipe is full. Then either
+ * signal completion from zx_qspi_irq when it sees ZX_QSPI_INT_{R/T}X_BYD_THES and command
+ * completion or fill new data from the IRQ handler.
+ */
+static int zx_qspi_read_fifo(struct zx_qspi *qspi, u32 len, u8 *val)
+{
+	struct device *dev = &qspi->ctrl->dev;
+	u32 *p = (uint32_t *)val;
+	u32 fifo, readval;
+	u32 cnt = 0;
+	int ret;
+
+	len = ALIGN(len, 4) >> 2;
+	while (cnt < len) {
+		ret = readl_relaxed_poll_timeout_atomic(qspi->io_base + ZX_QSPI_SW_REG,
+							 fifo, fifo & ZX_QSPI_RX_FIFO_CNT_MASK, 1,
+							 30000);
+		if (ret) {
+			dev_err(dev, "fifo timeout (len:%d stat:%#x)\n",
+				len << 2, fifo);
+			return ret;
+		}
+		fifo = min((fifo & ZX_QSPI_RX_FIFO_CNT_MASK) >> 8, len - cnt);
+		while (fifo) {
+			readval = readl_relaxed(qspi->io_base + ZX_QSPI_DATA_REG);
+			p[cnt++] = readval;
+			fifo--;
+		}
+	}
+
+	return 0;
+}
+
+static int zx_qspi_write_fifo(struct zx_qspi *qspi, u32 len, u8 *val)
+{
+	struct device *dev = &qspi->ctrl->dev;
+	u32 *p = (uint32_t *)val;
+	u32 cnt = 0;
+	u32 fifo;
+	int ret;
+
+	len = ALIGN(len, 4) >> 2;
+	while (cnt < len) {
+		ret = readl_relaxed_poll_timeout_atomic(qspi->io_base + ZX_QSPI_SW_REG,
+							 fifo, fifo & ZX_QSPI_TX_FIFO_CNT_MASK, 1,
+							 30000);
+		if (ret) {
+			dev_err(dev, "fifo timeout (len:%d stat:%#x)\n",
+				len << 2, fifo);
+			return ret;
+		}
+		fifo = min((fifo & ZX_QSPI_TX_FIFO_CNT_MASK) >> 16, len - cnt);
+		while (fifo) {
+			writel_relaxed(p[cnt++], qspi->io_base + ZX_QSPI_DATA_REG);
+			fifo--;
+		}
+	}
+
+	return 0;
+}
+
+static int zx_qspi_tx(struct zx_qspi *qspi,
+		      const struct spi_mem_op *op)
+{
+	int (*tx_fifo)(struct zx_qspi *qspi, u32 len, u8 *val);
+	u32 len = op->data.nbytes;
+	u8 *buf;
+
+	if (!op->data.nbytes)
+		return 0;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		tx_fifo = zx_qspi_read_fifo;
+		buf = op->data.buf.in;
+	} else {
+		tx_fifo = zx_qspi_write_fifo;
+		buf = (u8 *)op->data.buf.out;
+	}
+
+	return tx_fifo(qspi, len, buf);
+}
+
+static void zx_qspi_callback_result(void *arg,
+				    const struct dmaengine_result *result)
+{
+	struct zx_qspi *qspi = arg;
+	struct device *dev = &qspi->ctrl->dev;
+	struct completion *dma_completion = &qspi->dma_completion;
+
+	if (result->residue)
+		dev_err(dev, "Residue %u not handled\n", result->residue);
+
+	if (result->result)
+		dev_err(dev, "Unexpected result %d\n", result->result);
+
+	complete(dma_completion);
+}
+
+static u32 zx_qspi_setup_dma(struct zx_qspi *qspi, const struct spi_mem_op *op)
+{
+	struct device *dev = &qspi->ctrl->dev;
+	enum dma_transfer_direction dma_dir;
+	u32 ctrl0 = 0;
+	int ret;
+
+	qspi->cur_dma_ch = NULL;
+	qspi->dma_desc = NULL;
+	if (op->data.nbytes < ZX_QSPI_FIFO_SIZE * 4)
+		return 0;
+
+	if (op->data.dir == SPI_MEM_DATA_IN && qspi->ctrl->dma_rx) {
+		dma_dir = DMA_DEV_TO_MEM;
+		ctrl0 |= ZX_QSPI_RX_DMA_EN;
+		qspi->cur_dma_ch = qspi->ctrl->dma_rx;
+	} else if (qspi->ctrl->dma_tx) {
+		dma_dir = DMA_MEM_TO_DEV;
+		ctrl0 |= ZX_QSPI_TX_DMA_EN;
+		qspi->cur_dma_ch = qspi->ctrl->dma_tx;
+	} else {
+		return 0;
+	}
+
+	reinit_completion(&qspi->dma_completion);
+	ret = spi_controller_dma_map_mem_op_data(qspi->ctrl, op, &qspi->sgt);
+	if (ret) {
+		dev_err(dev, "spi_controller_dma_map_mem_op_data = %d\n", ret);
+		return 0;
+	}
+
+	qspi->dma_desc = dmaengine_prep_slave_sg(qspi->cur_dma_ch, qspi->sgt.sgl, qspi->sgt.nents,
+				       dma_dir, DMA_PREP_INTERRUPT);
+	if (!qspi->dma_desc) {
+		dev_err(dev, "dmaengine_prep_slave_sg fail\n");
+		goto out;
+	}
+
+	return ctrl0;
+
+out:
+	spi_controller_dma_unmap_mem_op_data(qspi->ctrl, op, &qspi->sgt);
+	return 0;
+}
+
+static int zx_qspi_set_speed(struct zx_qspi *qspi, unsigned int max_hz)
+{
+	unsigned long rate;
+	long rounded;
+	int ret;
+
+	if (!max_hz)
+		return -EINVAL;
+	if (qspi->speed_hz == max_hz)
+		return 0;
+
+	rounded = clk_round_rate(qspi->wclk, max_hz);
+	if (rounded < 0)
+		return rounded;
+	if (!rounded || rounded > max_hz)
+		return -EINVAL;
+
+	ret = clk_set_rate(qspi->wclk, rounded);
+	if (ret)
+		return ret;
+	rate = clk_get_rate(qspi->wclk);
+	if (!rate || rate > max_hz)
+		return -EINVAL;
+	qspi->speed_hz = rate;
+
+	return 0;
+}
+
+static int zx_qspi_setup(struct spi_device *spi)
+{
+	struct zx_qspi *qspi = spi_controller_get_devdata(spi->controller);
+
+	return zx_qspi_set_speed(qspi, spi->max_speed_hz);
+}
+
+static int zx_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct zx_qspi *qspi = spi_controller_get_devdata(mem->spi->controller);
+	u32 ctrl0, ctrl1 = 0, ctrl2 = 0, txstatus;
+	struct device *dev = &qspi->ctrl->dev;
+	dma_cookie_t cookie;
+	int ret;
+
+	ret = zx_qspi_set_speed(qspi, op->max_freq ?: mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "%s cmd:%#x buswidth:%d.%d.%d.%d addr:%#llx nbytes:%#x\n",
+		__func__, op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->dummy.buswidth, op->data.buswidth,
+		op->addr.val, op->data.nbytes);
+
+	ctrl0 = readl_relaxed(qspi->io_base + ZX_QSPI_CTRL0_REG);
+	dev_dbg(dev, "ZX_QSPI_CTRL0_REG = 0x%08x\n", ctrl0);
+	ctrl0 &= ~(ZX_QSPI_TX_DMA_EN | ZX_QSPI_RX_DMA_EN);
+	ctrl0 |= (ZX_QSPI_RXFIFO_CLR | ZX_QSPI_TXFIFO_CLR);
+	/* What are these for? I don't know, the ZTE driver sets them. Removing them here makes it
+	 * possible to operate with a smaller burst size but presumably comes at a performance cost.
+	 * In simple benchmarking I have not found an impact though.
+	 */
+	ctrl0 |= ZX_QSPI_TXFIFO_THRES | ZX_QSPI_RXFIFO_THRES;
+
+	if (op->addr.nbytes && op->addr.buswidth) {
+		ctrl1 |= ZX_QSPI_ADDR_TX_EN;
+		switch (op->addr.buswidth * op->addr.nbytes) {
+		case 1:
+			ctrl2 |= (ADDR_BYTE_WIDTH_8 << ZX_QSPI_ADDR_BYTE_NUM);
+			break;
+		case 2:
+			ctrl2 |= (ADDR_BYTE_WIDTH_16 << ZX_QSPI_ADDR_BYTE_NUM);
+			break;
+		case 3:
+			ctrl2 |= (ADDR_BYTE_WIDTH_24 << ZX_QSPI_ADDR_BYTE_NUM);
+			break;
+		case 4:
+			ctrl2 |= (ADDR_BYTE_WIDTH_32 << ZX_QSPI_ADDR_BYTE_NUM);
+			break;
+		default:
+			dev_err(dev, "Unexpected addr.buswidth %u\n",
+				op->addr.buswidth * op->addr.nbytes);
+			return -EIO;
+		}
+	}
+
+	ctrl0 |= zx_qspi_setup_dma(qspi, op);
+
+	/* dummy config */
+	if (op->dummy.nbytes && op->dummy.buswidth) {
+		ctrl1 |= ZX_QSPI_DUMMY_TX_EN;
+		ctrl2 |= (0x1 << ZX_QSPI_DUMMY_BYTE_NUM);
+	}
+
+	/* data config */
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			ctrl1 |= ZX_QSPI_READ_DATA_EN;
+		else
+			ctrl1 |= ZX_QSPI_WRITE_DATA_EN;
+
+		if (op->data.buswidth == 0x4)
+			ctrl2 |= ZX_QSPI_DATA_MULTI_LINE_EN | ZX_QSPI_TRANS_MOD;
+		else if (op->data.buswidth == 0x2)
+			ctrl2 |= ZX_QSPI_DATA_MULTI_LINE_EN;
+	}
+
+	writel_relaxed(ctrl0, qspi->io_base + ZX_QSPI_CTRL0_REG);
+	writel_relaxed(ctrl1, qspi->io_base + ZX_QSPI_CTRL1_REG);
+	writel_relaxed(ctrl2, qspi->io_base + ZX_QSPI_CTRL2_REG);
+
+	/* clear int */
+	writel_relaxed(ZX_QSPI_INT_ALL_MASK, qspi->io_base + ZX_QSPI_INT_SW_CLR_REG);
+
+	/* data len */
+	if (op->data.nbytes)
+		writel_relaxed(op->data.nbytes - 1, qspi->io_base + ZX_QSPI_BYTE_NUM_REG);
+
+	/* addr */
+	if (op->addr.nbytes && op->addr.buswidth)
+		writel_relaxed(op->addr.val, qspi->io_base + ZX_QSPI_ADDR_REG);
+
+	/* cmd */
+	writel_relaxed(op->cmd.opcode, qspi->io_base + ZX_QSPI_INS_REG);
+
+	/* spifc start */
+	writel_relaxed(ZX_QSPI_START, qspi->io_base + ZX_QSPI_START_REG);
+
+	if (op->data.nbytes && ctrl0 & (ZX_QSPI_TX_DMA_EN | ZX_QSPI_RX_DMA_EN)) {
+		dev_dbg(dev, "Attempting DMA %x %s qspi 0x%08x...\n",
+			ctrl0, ctrl0 & ZX_QSPI_TX_DMA_EN ? "tx" : "rx",
+			(unsigned int)qspi);
+		// qspi->dma_desc->callback = zx_qspi_dma_callback;
+		qspi->dma_desc->callback_result = zx_qspi_callback_result;
+		qspi->dma_desc->callback_param = qspi;
+		cookie = dmaengine_submit(qspi->dma_desc);
+		ret = dma_submit_error(cookie);
+		if (ret) {
+			/* FIXME: Does this kind of fallback to PIO work? How do I provoke it to
+			 * test it?
+			 */
+			dev_err(dev, "dmaengine_submit = %d, falling back to PIO\n", ret);
+			ctrl0 &= ~(ZX_QSPI_TX_DMA_EN | ZX_QSPI_RX_DMA_EN);
+			writel_relaxed(ctrl0, qspi->io_base + ZX_QSPI_CTRL0_REG);
+		} else {
+			dma_async_issue_pending(qspi->cur_dma_ch);
+
+			if (!wait_for_completion_io_timeout(&qspi->dma_completion,
+					 msecs_to_jiffies(2000))) {
+				dev_err(dev, "DMA timed out\n");
+				spi_controller_dma_unmap_mem_op_data(qspi->ctrl, op, &qspi->sgt);
+				return -EIO;
+			}
+		}
+		qspi->dma_desc = NULL;
+
+		spi_controller_dma_unmap_mem_op_data(qspi->ctrl, op, &qspi->sgt);
+		writel_relaxed(ctrl0 & ~(ZX_QSPI_TX_DMA_EN | ZX_QSPI_RX_DMA_EN),
+			       qspi->io_base + ZX_QSPI_CTRL0_REG);
+	}
+
+	if (op->data.nbytes && !(ctrl0 & (ZX_QSPI_TX_DMA_EN | ZX_QSPI_RX_DMA_EN))) {
+		ret = zx_qspi_tx(qspi, op);
+		if (ret) {
+			dev_err(dev, "zx_qspi_tx error %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* With DMA the result is ready by the time we receive the DMA complete callback. With PIO,
+	 * the highest wait time I have seen was 1 us.
+	 */
+	ret = readl_relaxed_poll_timeout_atomic(qspi->io_base + ZX_QSPI_INT_RAW_REG,
+						txstatus, txstatus & ZX_QSPI_INT_CMD_END, 1,
+						1000);
+	if (ret) {
+		dev_err(dev, "Wait for transfer end failed: %u.\n", ret);
+		return ret;
+	}
+
+	if (txstatus & ZX_QSPI_INT_FMT_ERR) {
+		dev_err(dev, "SPI controller reported an error, status 0x%08x\n", txstatus);
+		return -EIO;
+	}
+	if (txstatus & ZX_QSPI_INT_CMD_END)
+		return 0;
+
+	dev_err(dev, "Unexpected status 0x%08x\n", txstatus);
+	return -EIO;
+}
+
+#define ZX_QSPI_MAX_DATA			4096
+
+static bool zx_qspi_supports_op(struct spi_mem *mem,
+				const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	/* Command and address are always on one line */
+	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+		return false;
+	if (op->addr.nbytes > 4 || (op->addr.nbytes && op->addr.buswidth != 1))
+		return false;
+	if (op->dummy.nbytes > 15 || (op->dummy.nbytes && op->dummy.buswidth != 1))
+		return false;
+
+	/* The controller cannot transmit data on two lines */
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT &&
+	    op->data.buswidth == 2)
+		return false;
+
+	return true;
+}
+
+static int zx_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	op->data.nbytes = min_t(unsigned int, op->data.nbytes, ZX_QSPI_MAX_DATA);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_caps zx_qspi_mem_caps = {
+	.per_op_freq = true,
+};
+
+static const struct spi_controller_mem_ops zx_qspi_mem_ops = {
+	.adjust_op_size = zx_qspi_adjust_op_size,
+	.supports_op = zx_qspi_supports_op,
+	.exec_op = zx_qspi_exec_op,
+};
+
+static int zx_qspi_probe(struct platform_device *pdev)
+{
+	struct dma_slave_config dma_cfg = {0};
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctrl;
+	struct zx_qspi *qspi;
+	struct resource *res;
+	int irq, ret;
+	u32 reg;
+
+	dev_info(dev, "ZX QSPI Controller driver initializing\n");
+
+	ctrl = devm_spi_alloc_host(dev, sizeof(*qspi));
+	if (!ctrl)
+		return -ENOMEM;
+
+	qspi = spi_controller_get_devdata(ctrl);
+	qspi->ctrl = ctrl;
+	platform_set_drvdata(pdev, qspi);
+
+	init_completion(&qspi->dma_completion);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	qspi->phys_base = res->start;
+	qspi->io_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qspi->io_base))
+		return PTR_ERR(qspi->io_base);
+
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq > 0) {
+		ret = devm_request_irq(dev, irq, zx_qspi_irq, 0, MODULE_NAME, qspi);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request irq\n");
+	}
+
+	qspi->pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(qspi->pclk))
+		return PTR_ERR(qspi->pclk);
+
+	qspi->wclk = devm_clk_get_enabled(dev, "wclk");
+	if (IS_ERR(qspi->wclk))
+		return PTR_ERR(qspi->wclk);
+
+	qspi->rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(qspi->rstc))
+		return PTR_ERR(qspi->rstc);
+	if (qspi->rstc) {
+		reset_control_assert(qspi->rstc);
+		udelay(10);
+		reset_control_deassert(qspi->rstc);
+	}
+
+	dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	dma_cfg.src_addr = qspi->phys_base + ZX_QSPI_DATA_REG;
+	dma_cfg.dst_addr = qspi->phys_base + ZX_QSPI_DATA_REG;
+	/* FIFO_THRES has an impact on the burst size. Don't make them too small. */
+	dma_cfg.src_maxburst = ZX_QSPI_FIFO_SIZE / 2;
+	dma_cfg.dst_maxburst = ZX_QSPI_FIFO_SIZE / 2;
+
+	dma_cfg.direction = DMA_DEV_TO_MEM;
+	qspi->ctrl->dma_rx = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(qspi->ctrl->dma_rx)) {
+		dev_info(dev, "Cannot get RX DMA, using PIO\n");
+		qspi->ctrl->dma_rx = NULL;
+	} else {
+		if (dmaengine_slave_config(qspi->ctrl->dma_rx, &dma_cfg)) {
+			dev_info(dev, "Cannot configure RX DMA, using PIO\n");
+			dma_release_channel(qspi->ctrl->dma_rx);
+			qspi->ctrl->dma_rx = NULL;
+		}
+	}
+
+	dma_cfg.direction = DMA_MEM_TO_DEV;
+	qspi->ctrl->dma_tx = devm_dma_request_chan(dev, "tx");
+	if (IS_ERR(qspi->ctrl->dma_tx)) {
+		dev_info(dev, "Cannot get TX DMA, using PIO\n");
+		qspi->ctrl->dma_tx = NULL;
+	} else {
+		if (dmaengine_slave_config(qspi->ctrl->dma_tx, &dma_cfg)) {
+			dev_info(dev, "Cannot configure TX DMA, using PIO\n");
+			dma_release_channel(qspi->ctrl->dma_tx);
+			qspi->ctrl->dma_tx = NULL;
+		}
+	}
+
+	ctrl->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL | SPI_TX_QUAD;
+	ctrl->bus_num = -1;
+	ctrl->mem_ops = &zx_qspi_mem_ops;
+	ctrl->mem_caps = &zx_qspi_mem_caps;
+	ctrl->setup = zx_qspi_setup;
+	ctrl->min_speed_hz = clk_round_rate(qspi->wclk, 1);
+	ctrl->max_speed_hz = 50000000;
+	ctrl->use_gpio_descriptors = true;
+	ctrl->num_chipselect = 1;
+	ctrl->dev.of_node = dev->of_node;
+	ctrl->dma_alignment = 4;
+
+	writel_relaxed(ZX_QSPI_EN, qspi->io_base + ZX_QSPI_EN_REG);
+	ret = readl_relaxed_poll_timeout_atomic(qspi->io_base + ZX_QSPI_EN_REG,
+						reg, reg & ZX_QSPI_EN_BACK, 1,
+						1000);
+	if (ret) {
+		dev_err(dev, "SPI controller failed to start: en_reg=%x\n", reg);
+		return ret;
+	}
+
+	writel_relaxed(ZX_QSPI_SCLK_PAUSE_EN, qspi->io_base + ZX_QSPI_CTRL0_REG);
+	writel_relaxed(0, qspi->io_base + ZX_QSPI_INT_EN_REG);
+
+	/* Ensure proper data sampling point */
+	reg = readl_relaxed(qspi->io_base + ZX_QSPI_TIMING_REG);
+	if (!FIELD_GET(GENMASK(17, 16), reg)) {
+		reg |= FIELD_PREP(GENMASK(17, 16), 1);
+		writel_relaxed(reg, qspi->io_base + ZX_QSPI_TIMING_REG);
+	}
+
+	reg = readl_relaxed(qspi->io_base + ZX_QSPI_SW_REG) >> 16;
+	if (reg != ZX_QSPI_FIFO_SIZE)
+		dev_info(dev, "Got unexpected fifo size %u\n", reg);
+
+	ret = devm_spi_register_controller(dev, ctrl);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void zx_qspi_remove(struct platform_device *pdev)
+{
+	struct zx_qspi *qspi = platform_get_drvdata(pdev);
+
+	writel_relaxed(~ZX_QSPI_EN, qspi->io_base + ZX_QSPI_EN_REG);
+}
+
+static const struct of_device_id zx_qspi_match[] = {
+	{ .compatible = "zte,zx29-qspi" },
+	{ .compatible = "zte,zx279128s-spifc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, zx_qspi_match);
+
+static struct platform_driver zx_qspi_driver = {
+	.probe	= zx_qspi_probe,
+	.remove = zx_qspi_remove,
+	.driver	= {
+		.name = MODULE_NAME,
+		.of_match_table = zx_qspi_match,
+	},
+};
+module_platform_driver(zx_qspi_driver);
+
+MODULE_AUTHOR("Stefan Dösinger <stefandoesinger@gmail.com>");
+MODULE_DESCRIPTION("ZTE zx29 quad spi driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

