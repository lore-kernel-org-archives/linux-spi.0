Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8047277C;
	Mon, 21 Sep 2026 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986509; cv=none; b=QYdN98OMBwiCs2fFG4K1QXHNHJfbrYxjin4y43n2/ZcdhFbpUGXZktuBEcJIfjaCq4TprJieEGefuIdxPrV99hNJSIiTHxnQW+9QT8rqWZm8nLBg26kifFeAnjKcT8G2DiwIIHxMJG+rSnOkylOfOAGoP4Rn1F0dmoZQGTeHBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986509; c=relaxed/simple;
	bh=C/cijtAZYyQdBEf0M/dJNxv6j+pvRLaav2ADrktA3Vg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sh1nxHQrvk/5wCCSy0nBxl+dX0l+TWFaQhBy06G4tuBDbh07V5gaHVuKjG4ctQCjiHHWT1b9nxFaXaqhx0QSwHqHo3l8v05apyPJyoBj9vLX7VDqLAGEOZOJTlddeJXAlDAh4qoAXZCvV0wxCCw+MTxMdqjMtUkntlgUue1oR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=fail (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=KsAgJfnv reason="signature verification failed"; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="KsAgJfnv"
Received: from spam01.horizon.auto (localhost [127.0.0.2] (may be forged))
	by spam01.horizon.auto with ESMTP id 68L9csUL069412;
	Mon, 21 Sep 2026 17:38:54 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from spam01.horizon.auto (exchange003.hobot.cc [10.69.1.10])
	by spam01.horizon.auto with ESMTPS id 68L9c4Sh068891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
	Mon, 21 Sep 2026 17:38:04 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by exchange003.hobot.cc
 (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Mon, 21 Sep 2026
 17:38:04 +0800
From: Fei Xie <fei.xie@horizon.auto>
To: Mark Brown <broonie@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parshuram Thombare <pthombar@cadence.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "fei.xie"
	<fei.xie@horizon.auto>
Subject: [RFC PATCH 4/4] spi: cadence-xspi: add ACMD support for SPI NOR
Date: Mon, 21 Sep 2026 17:37:01 +0800
Message-ID: <20260921093701.1341766-5-fei.xie@horizon.auto>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921093701.1341766-1-fei.xie@horizon.auto>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange004.hobot.cc (10.9.15.112) To exchange003.hobot.cc
 (10.69.1.10)
X-DKIM-Results: exchange003.hobot.cc; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam01.horizon.auto 68L9csUL069412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1789983503;
	bh=NIDiqsVmgrS3EXwLeiz3kru1Gjw4BQlfnJkDij+iwqc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KsAgJfnv2QHpF9krCruijVPJsVP4w8IqeFqrHdu2P6xt531EdAhAsLhC4xkShNkgR
	 jB9I1O8fnj7c48pfr4B8QvpnlQXAY6GRXG+iosKUEXhUSax0No5AkwYYMa11km4kUo
	 /bAXS2XwbxLh3MbUT5q1CdiIJpLE1cY4opkBs9hvHLnmBuFOPkDMK3+M3ytzjgMuXa
	 7EGLpMqfZ9oke1j2FWTYjV3dbNtQ+ZlV6tqQvlZDEObfFVNoj46lRkx4Y1s7T2Lj7w
	 vn26aYMsKt4seFidU+9P8QzOnlZy0HB0mD1sTjq9ZVbRcr3fuRv3WDv2CJdB4Qr+j3
	 i+whB+T3PycUA==

From: "fei.xie" <fei.xie@horizon.auto>

Program the automatic command sequences from the SPI NOR operation
templates.

Use the PIO command path with MDMA data transfers for reads, page
programs and erases. Unsupported command layouts continue to use STIG
mode.

Signed-off-by: fei.xie <fei.xie@horizon.auto>
---
 drivers/spi/spi-cadence-xspi.c | 440 ++++++++++++++++++++++++++++++++-
 1 file changed, 433 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 114c1e0fd79fb..5900d4cbffb5c 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -12,11 +12,13 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/mtd/spinand.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/sizes.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
@@ -73,6 +75,7 @@
 #define CDNS_XSPI_ACMD_ERASE_THREAD		5
 #define CDNS_XSPI_ACMD_TIMEOUT_MS		1000
 #define CDNS_XSPI_ACMD_MODE_PIO			1
+#define CDNS_XSPI_NOR_DMA_BUF_SIZE		SZ_32K
 
 #define CDNS_XSPI_NAND_OP_GET_FEATURE		0x0f
 #define CDNS_XSPI_NAND_OP_WRITE_ENABLE		0x06
@@ -225,6 +228,7 @@
 #define CDNS_XSPI_READ_SEQ_CFG_1			0x0434
 #define CDNS_XSPI_READ_SEQ_P1_CMD_EXT_EN		BIT(0)
 #define CDNS_XSPI_READ_SEQ_P1_CACHE_RANDOM_READ_EN	BIT(4)
+#define CDNS_XSPI_READ_SEQ_P1_CMD_EXT_VAL	GENMASK(15, 8)
 #define CDNS_XSPI_READ_SEQ_CFG_2			0x0438
 
 /* Write enable sequence config register */
@@ -232,12 +236,22 @@
 #define CDNS_XSPI_WE_SEQ_P1_CMD_VAL		GENMASK(7, 0)
 #define CDNS_XSPI_WE_SEQ_P1_CMD_IOS		GENMASK(9, 8)
 #define CDNS_XSPI_WE_SEQ_P1_CMD_EDGE		BIT(11)
+#define CDNS_XSPI_WE_SEQ_P1_CMD_EXT_EN		BIT(15)
+#define CDNS_XSPI_WE_SEQ_P1_CMD_EXT_VAL		GENMASK(23, 16)
 #define CDNS_XSPI_WE_SEQ_P1_EN			BIT(24)
 
 /* Status sequence config registers */
 #define CDNS_XSPI_STAT_SEQ_CFG_0			0x0450
+#define CDNS_XSPI_STAT_SEQ_P1_CMD_IOS		GENMASK(1, 0)
+#define CDNS_XSPI_STAT_SEQ_P1_CMD_EDGE		BIT(4)
+#define CDNS_XSPI_STAT_SEQ_P1_CMD_EXT_EN	BIT(5)
 #define CDNS_XSPI_STAT_SEQ_P1_ADDR_CNT			GENMASK(9, 8)
+#define CDNS_XSPI_STAT_SEQ_P1_ADDR_IOS		GENMASK(11, 10)
+#define CDNS_XSPI_STAT_SEQ_P1_ADDR_EDGE		BIT(12)
+#define CDNS_XSPI_STAT_SEQ_P1_DATA_IOS		GENMASK(21, 20)
+#define CDNS_XSPI_STAT_SEQ_P1_DATA_EDGE		BIT(22)
 #define CDNS_XSPI_STAT_SEQ_CFG_1			0x0454
+#define CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_DUMMY_CNT	GENMASK(5, 0)
 #define CDNS_XSPI_P1_DEV_RDY_ADDR_EN		BIT(6)
 #define CDNS_XSPI_P1_PROG_FAIL_ADDR_EN		BIT(22)
 #define CDNS_XSPI_P1_ERS_FAIL_ADDR_EN		BIT(30)
@@ -248,9 +262,11 @@
 #define CDNS_XSPI_STAT_SEQ_P1_PROG_FAIL_CMD_VAL	GENMASK(31, 24)
 
 #define CDNS_XSPI_STAT_SEQ_CFG_3			0x045c
+#define CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_CMD_EXT_VAL	GENMASK(7, 0)
 #define CDNS_XSPI_STAT_SEQ_CFG_4			0x0460
 #define CDNS_XSPI_STAT_SEQ_CFG_5			0x0464
 #define CDNS_XSPI_STAT_SEQ_DEV_RDY_IDX		GENMASK(3, 0)
+#define CDNS_XSPI_STAT_SEQ_DEV_RDY_SIZE		BIT(5)
 #define CDNS_XSPI_STAT_SEQ_DEV_RDY_EN		BIT(6)
 #define CDNS_XSPI_STAT_SEQ_ERS_FAIL_IDX		GENMASK(11, 8)
 #define CDNS_XSPI_STAT_SEQ_ERS_FAIL_VAL		BIT(12)
@@ -288,6 +304,7 @@
 #define CDNS_XSPI_SEQ_PAGE_PER_BLOCK		GENMASK(26, 24)
 #define CDNS_XSPI_SEQ_PAGE_CA_SIZE		BIT(16)
 #define CDNS_XSPI_SEQ_PAGE_SIZE_EXT		GENMASK(8, 0)
+#define CDNS_XSPI_SEQ_SPI_NOR			0
 
 #define CDNS_XSPI_XIP_MODE_CFG			0x0388
 #define CDNS_XSPI_XIP_EN			BIT(0)
@@ -476,7 +493,13 @@ struct cdns_xspi_acmd_info {
 	u64 row_addr;
 	u64 column_addr;
 	size_t data_nbytes;
+	u8 nor_status_buswidth;
+	u8 nor_write_enable_buswidth;
 	bool row_addr_valid;
+	bool nor_status_dtr;
+	bool nor_write_enable_dtr;
+	bool nor_status_initialized;
+	bool nor_write_enable_initialized;
 	bool initialized;
 };
 struct cdns_xspi_dev {
@@ -592,6 +615,31 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 }
 
+static u8 cdns_xspi_get_opcode(const struct spi_mem_op *op)
+{
+	if (op->cmd.nbytes == 2)
+		return op->cmd.opcode >> 8;
+
+	return op->cmd.opcode;
+}
+
+static u8 cdns_xspi_get_opcode_extension(const struct spi_mem_op *op)
+{
+	if (op->cmd.nbytes == 2)
+		return op->cmd.opcode;
+
+	return 0;
+}
+
+static u32 cdns_xspi_get_dummy_cycles(const struct spi_mem_op *op)
+{
+	if (!op->dummy.nbytes || !op->dummy.buswidth)
+		return 0;
+
+	return op->dummy.nbytes * BITS_PER_BYTE /
+	       (op->dummy.buswidth * (op->dummy.dtr + 1));
+}
+
 static void cdns_xspi_nand_cfg_seq_init(struct cdns_xspi_dev *cdns_xspi,
 					struct spinand_device *spinand)
 {
@@ -872,6 +920,268 @@ static int cdns_xspi_nand_init(struct cdns_xspi_dev *cdns_xspi,
 	return 0;
 }
 
+static int cdns_xspi_nor_cfg_seq_init(struct cdns_xspi_dev *cdns_xspi,
+				      struct spi_nor *nor)
+{
+	unsigned int page_size;
+	u32 seq_cfg;
+
+	if (!is_power_of_2(nor->mtd.writebufsize))
+		return -EOPNOTSUPP;
+
+	page_size = ilog2(nor->mtd.writebufsize);
+	if (!FIELD_FIT(CDNS_XSPI_SEQ_PAGE_SIZE_PGM, page_size))
+		return -EOPNOTSUPP;
+
+	seq_cfg = readl(cdns_xspi->iobase + CDNS_XSPI_GLOBAL_SEQ_CFG);
+	seq_cfg = u32_replace_bits(seq_cfg, CDNS_XSPI_SEQ_SPI_NOR,
+				   CDNS_XSPI_SEQ_TYPE);
+	seq_cfg = u32_replace_bits(seq_cfg, page_size,
+				   CDNS_XSPI_SEQ_PAGE_SIZE_PGM);
+	seq_cfg = u32_replace_bits(seq_cfg,
+				   ilog2(CDNS_XSPI_NOR_DMA_BUF_SIZE),
+				   CDNS_XSPI_SEQ_PAGE_SIZE_RD);
+	writel(seq_cfg, cdns_xspi->iobase + CDNS_XSPI_GLOBAL_SEQ_CFG);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_GLOBAL_SEQ_CFG_1);
+
+	return 0;
+}
+
+static int cdns_xspi_nor_read_seq_init(struct cdns_xspi_dev *cdns_xspi,
+				       const struct spi_mem_op *op)
+{
+	u32 dummy_cycles = cdns_xspi_get_dummy_cycles(op);
+	u32 cfg0;
+	u32 cfg1;
+
+	if (!FIELD_FIT(CDNS_XSPI_READ_SEQ_P1_ADDR_CNT, op->addr.nbytes) ||
+	    !FIELD_FIT(CDNS_XSPI_READ_SEQ_P1_DUMMY_CNT, dummy_cycles))
+		return -EOPNOTSUPP;
+
+	cfg0 = FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_VAL,
+			  cdns_xspi_get_opcode(op)) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_IOS,
+			  ilog2(op->cmd.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_EDGE, op->cmd.dtr) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_ADDR_CNT, op->addr.nbytes) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_ADDR_IOS,
+			  ilog2(op->addr.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_ADDR_EDGE, op->addr.dtr) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_DATA_IOS,
+			  ilog2(op->data.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_DATA_EDGE, op->data.dtr) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_DUMMY_CNT, dummy_cycles);
+	cfg1 = FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_EXT_EN,
+			  op->cmd.nbytes == 2) |
+	       FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_EXT_VAL,
+			  cdns_xspi_get_opcode_extension(op));
+
+	writel(cfg0, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG_0);
+	writel(cfg1, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG_1);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG_2);
+
+	return 0;
+}
+
+static int cdns_xspi_nor_program_seq_init(struct cdns_xspi_dev *cdns_xspi,
+					  const struct spi_mem_op *op)
+{
+	u32 dummy_cycles = cdns_xspi_get_dummy_cycles(op);
+	u32 cfg0;
+	u32 cfg1;
+
+	if (!FIELD_FIT(CDNS_XSPI_PROG_SEQ_P1_ADDR_CNT, op->addr.nbytes) ||
+	    !FIELD_FIT(CDNS_XSPI_PROG_SEQ_P1_DUMMY_CNT, dummy_cycles))
+		return -EOPNOTSUPP;
+
+	cfg0 = FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_VAL,
+			  cdns_xspi_get_opcode(op)) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_IOS,
+			  ilog2(op->cmd.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_EDGE, op->cmd.dtr) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_ADDR_CNT, op->addr.nbytes) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_ADDR_IOS,
+			  ilog2(op->addr.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_ADDR_EDGE, op->addr.dtr) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_DATA_IOS,
+			  ilog2(op->data.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_DATA_EDGE, op->data.dtr) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_DUMMY_CNT, dummy_cycles);
+	cfg1 = FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_EXT_EN,
+			  op->cmd.nbytes == 2) |
+	       FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_EXT_VAL,
+			  cdns_xspi_get_opcode_extension(op));
+
+	writel(cfg0, cdns_xspi->iobase + CDNS_XSPI_PROG_SEQ_CFG_0);
+	writel(cfg1, cdns_xspi->iobase + CDNS_XSPI_PROG_SEQ_CFG_1);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_PROG_SEQ_CFG_2);
+
+	return 0;
+}
+
+static int cdns_xspi_nor_erase_seq_init(struct cdns_xspi_dev *cdns_xspi,
+					struct spi_nor *nor,
+					const struct spi_mem_op *op)
+{
+	unsigned int erase_size;
+	u32 cfg0;
+
+	if (!is_power_of_2(nor->mtd.erasesize))
+		return -EOPNOTSUPP;
+
+	erase_size = ilog2(nor->mtd.erasesize);
+	if (!FIELD_FIT(CDNS_XSPI_ERSS_SEQ_P1_ADDR_CNT, op->addr.nbytes) ||
+	    !FIELD_FIT(CDNS_XSPI_ERSS_SEQ_P1_SECT_SIZE, erase_size))
+		return -EOPNOTSUPP;
+
+	cfg0 = FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_VAL,
+			  cdns_xspi_get_opcode(op)) |
+	       FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_IOS,
+			  ilog2(op->cmd.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_EDGE, op->cmd.dtr) |
+	       FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_ADDR_CNT, op->addr.nbytes) |
+	       FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_EXT_EN,
+			  op->cmd.nbytes == 2) |
+	       FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_EXT_VAL,
+			  cdns_xspi_get_opcode_extension(op)) |
+	       FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_ADDR_IOS,
+			  ilog2(op->addr.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_ADDR_EDGE, op->addr.dtr);
+
+	writel(cfg0, cdns_xspi->iobase + CDNS_XSPI_ERSS_SEQ_CFG_0);
+	writel(FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_SECT_SIZE, erase_size),
+	       cdns_xspi->iobase + CDNS_XSPI_ERSS_SEQ_CFG_1);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_ERSS_SEQ_CFG_2);
+
+	return 0;
+}
+
+static int cdns_xspi_nor_status_seq_init(struct cdns_xspi_dev *cdns_xspi,
+					 const struct spi_mem_op *op)
+{
+	u32 dummy_cycles = cdns_xspi_get_dummy_cycles(op);
+	u32 addr_count = op->addr.nbytes ? op->addr.nbytes - 1 : 0;
+	u32 cfg0;
+	u32 cfg1;
+	u32 cfg5;
+
+	if (op->data.dir != SPI_MEM_DATA_IN || !op->data.nbytes ||
+	    !FIELD_FIT(CDNS_XSPI_STAT_SEQ_P1_ADDR_CNT, addr_count) ||
+	    !FIELD_FIT(CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_DUMMY_CNT,
+		       dummy_cycles) || upper_32_bits(op->addr.val))
+		return -EOPNOTSUPP;
+
+	cfg0 = FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_CMD_IOS,
+			  ilog2(op->cmd.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_CMD_EDGE, op->cmd.dtr) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_CMD_EXT_EN,
+			  op->cmd.nbytes == 2) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_ADDR_CNT, addr_count) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_ADDR_IOS,
+			  op->addr.buswidth ? ilog2(op->addr.buswidth) : 0) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_ADDR_EDGE, op->addr.dtr) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_DATA_IOS,
+			  ilog2(op->data.buswidth)) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_DATA_EDGE, op->data.dtr);
+	cfg1 = FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_DUMMY_CNT,
+			  dummy_cycles) |
+	       (op->addr.nbytes ? CDNS_XSPI_P1_DEV_RDY_ADDR_EN : 0);
+	cfg5 = FIELD_PREP(CDNS_XSPI_STAT_SEQ_DEV_RDY_IDX, __ffs(SR_WIP)) |
+	       (op->data.dtr ? CDNS_XSPI_STAT_SEQ_DEV_RDY_SIZE : 0) |
+	       CDNS_XSPI_STAT_SEQ_DEV_RDY_EN;
+
+	writel(cfg0, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_0);
+	writel(cfg1, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_1);
+	writel(FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_CMD_VAL,
+			  cdns_xspi_get_opcode(op)),
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_2);
+	writel(FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_CMD_EXT_VAL,
+			  cdns_xspi_get_opcode_extension(op)),
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_3);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_4);
+	writel(cfg5, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_5);
+	writel(lower_32_bits(op->addr.val),
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_7);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_8);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_9);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_10);
+
+	cdns_xspi->acmd_info.nor_status_initialized = true;
+	cdns_xspi->acmd_info.nor_status_buswidth = op->cmd.buswidth;
+	cdns_xspi->acmd_info.nor_status_dtr = op->cmd.dtr;
+
+	return 0;
+}
+
+static void
+cdns_xspi_nor_write_enable_seq_init(struct cdns_xspi_dev *cdns_xspi,
+				    const struct spi_mem_op *op)
+{
+	u32 cfg;
+
+	cfg = FIELD_PREP(CDNS_XSPI_WE_SEQ_P1_CMD_VAL,
+			 cdns_xspi_get_opcode(op)) |
+	      FIELD_PREP(CDNS_XSPI_WE_SEQ_P1_CMD_IOS,
+			 ilog2(op->cmd.buswidth)) |
+	      FIELD_PREP(CDNS_XSPI_WE_SEQ_P1_CMD_EDGE, op->cmd.dtr) |
+	      FIELD_PREP(CDNS_XSPI_WE_SEQ_P1_CMD_EXT_EN,
+			 op->cmd.nbytes == 2) |
+	      FIELD_PREP(CDNS_XSPI_WE_SEQ_P1_CMD_EXT_VAL,
+			 cdns_xspi_get_opcode_extension(op)) |
+	      CDNS_XSPI_WE_SEQ_P1_EN;
+	writel(cfg, cdns_xspi->iobase + CDNS_XSPI_WE_SEQ_CFG_0);
+	cdns_xspi->acmd_info.nor_write_enable_initialized = true;
+	cdns_xspi->acmd_info.nor_write_enable_buswidth = op->cmd.buswidth;
+	cdns_xspi->acmd_info.nor_write_enable_dtr = op->cmd.dtr;
+}
+
+static int cdns_xspi_nor_init(struct cdns_xspi_dev *cdns_xspi,
+			      struct spi_nor *nor)
+{
+	struct spi_mem_op status_op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(1, NULL, 1));
+	int ret;
+
+	ret = cdns_xspi_nor_cfg_seq_init(cdns_xspi, nor);
+	if (ret)
+		return ret;
+
+	cdns_xspi_acmd_disable_xip(cdns_xspi);
+	ret = cdns_xspi_acmd_alloc_dma_buf(cdns_xspi,
+					   CDNS_XSPI_NOR_DMA_BUF_SIZE);
+	if (ret)
+		return ret;
+
+	if (!spi_nor_protocol_is_dtr(nor->reg_proto) &&
+	    !cdns_xspi->acmd_info.nor_status_initialized) {
+		ret = cdns_xspi_nor_status_seq_init(cdns_xspi, &status_op);
+		if (ret)
+			return ret;
+	}
+
+	cdns_xspi->acmd_info.initialized = true;
+
+	return 0;
+}
+
+static bool
+cdns_xspi_nor_helper_sequences_ready(const struct cdns_xspi_dev *cdns_xspi,
+				     const struct spi_nor *nor)
+{
+	u8 buswidth = spi_nor_get_protocol_inst_nbits(nor->reg_proto);
+	bool dtr = spi_nor_protocol_is_dtr(nor->reg_proto);
+
+	return cdns_xspi->acmd_info.nor_status_initialized &&
+	       cdns_xspi->acmd_info.nor_status_buswidth == buswidth &&
+	       cdns_xspi->acmd_info.nor_status_dtr == dtr &&
+	       cdns_xspi->acmd_info.nor_write_enable_initialized &&
+	       cdns_xspi->acmd_info.nor_write_enable_buswidth == buswidth &&
+	       cdns_xspi->acmd_info.nor_write_enable_dtr == dtr;
+}
+
 static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_ver;
@@ -1315,9 +1625,9 @@ static int cdns_xspi_nand_pio_read(struct cdns_xspi_dev *cdns_xspi,
 	return ret;
 }
 
-static int cdns_xspi_send_pio_command(struct cdns_xspi_dev *cdns_xspi,
-				      struct spi_mem *mem,
-				      const struct spi_mem_op *op)
+static int cdns_xspi_send_nand_pio_command(struct cdns_xspi_dev *cdns_xspi,
+					   struct spi_mem *mem,
+					   const struct spi_mem_op *op)
 {
 	struct spinand_device *spinand;
 	const struct spi_mem_op *read_cache;
@@ -1325,9 +1635,6 @@ static int cdns_xspi_send_pio_command(struct cdns_xspi_dev *cdns_xspi,
 	const struct spi_mem_op *update_cache;
 	int ret;
 
-	if (cdns_xspi->flash_type != CDNS_XSPI_FLASH_TYPE_NAND)
-		goto use_stig;
-
 	spinand = spi_mem_get_drvdata(mem);
 	if (!spinand || !spinand->op_templates ||
 	    !spinand->op_templates->read_cache ||
@@ -1401,6 +1708,115 @@ static int cdns_xspi_send_pio_command(struct cdns_xspi_dev *cdns_xspi,
 					   op->data.dir != SPI_MEM_NO_DATA);
 }
 
+static int cdns_xspi_send_nor_pio_command(struct cdns_xspi_dev *cdns_xspi,
+					  struct spi_mem *mem,
+					  const struct spi_mem_op *op)
+{
+	struct spi_nor *nor = spi_mem_get_drvdata(mem);
+	u8 opcode = cdns_xspi_get_opcode(op);
+	int ret;
+
+	if (!nor)
+		goto use_stig;
+
+	if (opcode == SPINOR_OP_WREN) {
+		cdns_xspi_nor_write_enable_seq_init(cdns_xspi, op);
+		goto use_stig;
+	}
+
+	if (opcode == SPINOR_OP_RDSR && op->data.dir == SPI_MEM_DATA_IN) {
+		cdns_xspi->acmd_info.nor_status_initialized = false;
+		ret = cdns_xspi_nor_status_seq_init(cdns_xspi, op);
+		if (ret)
+			dev_dbg(cdns_xspi->dev,
+				"cannot use RDSR operation for ACMD status: %d\n",
+				ret);
+		goto use_stig;
+	}
+
+	if (!nor->mtd.size || !nor->mtd.writebufsize)
+		goto use_stig;
+
+	if (opcode != nor->read_opcode && opcode != nor->program_opcode &&
+	    opcode != nor->erase_opcode)
+		goto use_stig;
+	if (upper_32_bits(op->addr.val))
+		goto use_stig;
+
+	if (!cdns_xspi->acmd_info.initialized) {
+		ret = cdns_xspi_nor_init(cdns_xspi, nor);
+		if (ret == -EOPNOTSUPP)
+			goto use_stig;
+		if (ret) {
+			dev_err(cdns_xspi->dev,
+				"failed to initialize NOR ACMD: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (opcode == nor->read_opcode && op->data.dir == SPI_MEM_DATA_IN) {
+		ret = cdns_xspi_nor_read_seq_init(cdns_xspi, op);
+		if (ret == -EOPNOTSUPP)
+			goto use_stig;
+		if (ret)
+			return ret;
+
+		return cdns_xspi_pio_mdma_read(cdns_xspi, op->addr.val,
+					      op->data.buf.in,
+					      op->data.nbytes);
+	}
+
+	if (opcode == nor->program_opcode &&
+	    op->data.dir == SPI_MEM_DATA_OUT) {
+		if (!cdns_xspi_nor_helper_sequences_ready(cdns_xspi, nor))
+			goto use_stig;
+
+		ret = cdns_xspi_nor_program_seq_init(cdns_xspi, op);
+		if (ret == -EOPNOTSUPP)
+			goto use_stig;
+		if (ret)
+			return ret;
+
+		return cdns_xspi_pio_mdma_program(cdns_xspi, op->addr.val,
+						 op->data.buf.out,
+						 op->data.nbytes);
+	}
+
+	if (opcode == nor->erase_opcode && op->data.dir == SPI_MEM_NO_DATA) {
+		if (nor->mtd.numeraseregions ||
+		    !cdns_xspi_nor_helper_sequences_ready(cdns_xspi, nor))
+			goto use_stig;
+
+		ret = cdns_xspi_nor_erase_seq_init(cdns_xspi, nor, op);
+		if (ret == -EOPNOTSUPP)
+			goto use_stig;
+		if (ret)
+			return ret;
+
+		return cdns_xspi_pio_erase(cdns_xspi, op->addr.val);
+	}
+
+use_stig:
+	return cdns_xspi_send_stig_command(cdns_xspi, op,
+					   op->data.dir != SPI_MEM_NO_DATA);
+}
+
+static int cdns_xspi_send_pio_command(struct cdns_xspi_dev *cdns_xspi,
+				      struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	switch (cdns_xspi->flash_type) {
+	case CDNS_XSPI_FLASH_TYPE_NAND:
+		return cdns_xspi_send_nand_pio_command(cdns_xspi, mem, op);
+
+	case CDNS_XSPI_FLASH_TYPE_NOR:
+		return cdns_xspi_send_nor_pio_command(cdns_xspi, mem, op);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 			    struct spi_mem *mem,
 			    const struct spi_mem_op *op)
@@ -1484,8 +1900,18 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 {
 	struct cdns_xspi_dev *cdns_xspi =
 		spi_controller_get_devdata(mem->spi->controller);
+	size_t max_len = cdns_xspi->sdmasize;
+
+	if (cdns_xspi->work_mode == CDNS_XSPI_WORK_MODE_ACMD) {
+		if (cdns_xspi->acmd_info.initialized)
+			max_len = min_t(size_t, max_len,
+					cdns_xspi->dma_buf_len);
+		else if (cdns_xspi->flash_type == CDNS_XSPI_FLASH_TYPE_NOR)
+			max_len = min_t(size_t, max_len,
+					CDNS_XSPI_NOR_DMA_BUF_SIZE);
+	}
 
-	op->data.nbytes = clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasize);
+	op->data.nbytes = min_t(size_t, op->data.nbytes, max_len);
 
 	return 0;
 }
-- 
2.34.1

