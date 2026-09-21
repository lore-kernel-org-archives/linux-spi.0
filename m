Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9C44E67D;
	Mon, 21 Sep 2026 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986519; cv=none; b=Or52pFa3QXBzqCY7lwaAljHMx1tV+KECIScu1pFzvJXKXHUlWWvO5FSTIs2v58KlAjzCoDGShgq4I9vjEK/VNX6K16l4fUCimD3/1CN0NE0hlZkhaHU33e7oJAT7YilWbkt0NIdyAf53PglA/wJqaoFjfjlyVlcKspTMebgK1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986519; c=relaxed/simple;
	bh=eRpuG3W7qZFzhSkX/5BP7UEKPvkv71oaz0w6dmJR4I0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnsCkceUNxzZxVjTY3yr5kvsRR9Gu4MW7pSJqbMGUO12+CXQqco9KFr2+LZ4oeuFGGb8rIUvwdjKHzZY44HaW9pMSXNc9kRzRQ3Py0ess6i0H4BlLoF67xyls4Xim8nemk+V/dJ7rUt3Jzs9bmVfF5hp0pAZ0+CI4mkUAxuht2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=fail (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=JBwRuUxU reason="signature verification failed"; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="JBwRuUxU"
Received: from spam01.horizon.auto (localhost [127.0.0.2] (may be forged))
	by spam01.horizon.auto with ESMTP id 68L9ct8l069415;
	Mon, 21 Sep 2026 17:38:55 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from spam01.horizon.auto (exchange003.hobot.cc [10.69.1.10])
	by spam01.horizon.auto with ESMTPS id 68L9c2QT068824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
	Mon, 21 Sep 2026 17:38:02 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by exchange003.hobot.cc
 (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Mon, 21 Sep 2026
 17:38:01 +0800
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
Subject: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
Date: Mon, 21 Sep 2026 17:36:59 +0800
Message-ID: <20260921093701.1341766-3-fei.xie@horizon.auto>
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
X-MAIL:spam01.horizon.auto 68L9ct8l069415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1789983493;
	bh=Fe0svDoY4P+wByAso92+l+8cbApwumiXGixK8icWVUY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JBwRuUxUKJ30tWCNVe1uvJw8PVqFJPA9sjNasbW0Uva8p1Jf1sIIpjuPLbBfAnSHs
	 vNhAsUj6jd+Q2/LZfk9a0NAq4g7tI2ioau0S5D+J6YOuoUnYSzBfmT9nps+lmV5GZQ
	 61Gc3wBeibQIuYcUzVMn7ZR+fWSEihZTvoeHi8C+ckLk2zSSpooWR/IY5rJywxtU2q
	 RApgkfqDCbYwzLdZYKNO5RfEAu2PByqcyHY0MWzA4QS3sEuHmAkScgEvN/tDW0zgge
	 iE5Qt3z+eXkQNCQ2wGHbhbQAjhwgIXR1EN3gPOg3HedKaaD88KaHo+UMGzBrbbdKIH
	 K2rJAlfiRo5wQ==

From: "fei.xie" <fei.xie@horizon.auto>

Add PIO master-DMA support for the controller auto-command mode.
Configure the SPI NAND read, program, erase, status and reset
sequences, retaining STIG for operations not consumed by ACMD.

Signed-off-by: fei.xie <fei.xie@horizon.auto>
---
 drivers/spi/spi-cadence-xspi.c | 782 +++++++++++++++++++++++++++++++++
 1 file changed, 782 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 39c868a5b171c..0fedf6cd6a590 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -4,6 +4,7 @@
 
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
@@ -11,6 +12,8 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mtd/spinand.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -54,7 +57,33 @@
 #define CDNS_XSPI_CMD_REG_4			0x0010
 #define CDNS_XSPI_CMD_REG_5			0x0014
 
+/* Auto command fields in command register 0 */
+#define CDNS_XSPI_ACMD_MODE			GENMASK(31, 30)
+#define CDNS_XSPI_ACMD_TRD_NUM			GENMASK(26, 24)
+#define CDNS_XSPI_ACMD_BANK_NUM			GENMASK(22, 20)
+#define CDNS_XSPI_ACMD_DMA_SEL			BIT(19)
+#define CDNS_XSPI_ACMD_INT_EN			BIT(18)
+#define CDNS_XSPI_ACMD_CMD_TYPE			GENMASK(15, 0)
+
+#define CDNS_XSPI_ACMD_READ_OP			0x2200
+#define CDNS_XSPI_ACMD_PROG_OP			0x2100
+#define CDNS_XSPI_ACMD_ERASE_OP			0x1000
+#define CDNS_XSPI_ACMD_RESET_OP			0x1100
+#define CDNS_XSPI_ACMD_DATA_THREAD		7
+#define CDNS_XSPI_ACMD_ERASE_THREAD		5
+#define CDNS_XSPI_ACMD_TIMEOUT_MS		1000
+#define CDNS_XSPI_ACMD_MODE_PIO			1
+
+#define CDNS_XSPI_NAND_OP_GET_FEATURE		0x0f
+#define CDNS_XSPI_NAND_OP_WRITE_ENABLE		0x06
+#define CDNS_XSPI_NAND_OP_PROGRAM_EXECUTE	0x10
+#define CDNS_XSPI_NAND_OP_PAGE_READ		0x13
+#define CDNS_XSPI_NAND_OP_BLOCK_ERASE		0xd8
+#define CDNS_XSPI_NAND_OP_RESET			0xff
+#define CDNS_XSPI_NAND_STATUS_REG		0xc0
+
 /* Command status registers */
+#define CDNS_XSPI_CMD_STATUS_PTR_REG	0x0040
 #define CDNS_XSPI_CMD_STATUS_REG		0x0044
 
 /* Controller status register */
@@ -143,10 +172,126 @@
 #define CDNS_XSPI_CMD_STATUS_CRC_ERROR		BIT(2)
 #define CDNS_XSPI_CMD_STATUS_BUS_ERROR		BIT(1)
 #define CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR	BIT(0)
+/* Reset sequence config register */
+#define CDNS_XSPI_RST_SEQ_CFG_0			0x0400
+#define CDNS_XSPI_RST_SEQ_P1_CMD1_VAL		GENMASK(15, 8)
+
+/* Erase sequence config registers */
+#define CDNS_XSPI_ERSS_SEQ_CFG_0			0x0410
+#define CDNS_XSPI_ERSS_SEQ_P1_CMD_VAL		GENMASK(7, 0)
+#define CDNS_XSPI_ERSS_SEQ_P1_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_ERSS_SEQ_P1_CMD_EDGE		BIT(11)
+#define CDNS_XSPI_ERSS_SEQ_P1_ADDR_CNT		GENMASK(14, 12)
+#define CDNS_XSPI_ERSS_SEQ_P1_CMD_EXT_EN	BIT(15)
+#define CDNS_XSPI_ERSS_SEQ_P1_CMD_EXT_VAL	GENMASK(23, 16)
+#define CDNS_XSPI_ERSS_SEQ_P1_ADDR_IOS		GENMASK(25, 24)
+#define CDNS_XSPI_ERSS_SEQ_P1_ADDR_EDGE		BIT(28)
+
+#define CDNS_XSPI_ERSS_SEQ_CFG_1			0x0414
+#define CDNS_XSPI_ERSS_SEQ_P1_SECT_SIZE		GENMASK(4, 0)
+
+#define CDNS_XSPI_ERSS_SEQ_CFG_2			0x0418
+
+/* Program sequence config registers */
+#define CDNS_XSPI_PROG_SEQ_CFG_0			0x0420
+#define CDNS_XSPI_PROG_SEQ_P1_CMD_VAL		GENMASK(7, 0)
+#define CDNS_XSPI_PROG_SEQ_P1_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_PROG_SEQ_P1_CMD_EDGE		BIT(11)
+#define CDNS_XSPI_PROG_SEQ_P1_ADDR_CNT		GENMASK(14, 12)
+#define CDNS_XSPI_PROG_SEQ_P1_ADDR_IOS		GENMASK(17, 16)
+#define CDNS_XSPI_PROG_SEQ_P1_ADDR_EDGE		BIT(19)
+#define CDNS_XSPI_PROG_SEQ_P1_DATA_IOS		GENMASK(21, 20)
+#define CDNS_XSPI_PROG_SEQ_P1_DATA_EDGE		BIT(23)
+#define CDNS_XSPI_PROG_SEQ_P1_DUMMY_CNT		GENMASK(29, 24)
+
+#define CDNS_XSPI_PROG_SEQ_CFG_1			0x0424
+#define CDNS_XSPI_PROG_SEQ_P1_CMD_EXT_EN		BIT(0)
+#define CDNS_XSPI_PROG_SEQ_P1_CMD_EXT_VAL		GENMASK(15, 8)
+
+#define CDNS_XSPI_PROG_SEQ_CFG_2			0x0428
+
+/* Read sequence config registers */
+#define CDNS_XSPI_READ_SEQ_CFG_0			0x0430
+#define CDNS_XSPI_READ_SEQ_P1_CMD_VAL		GENMASK(7, 0)
+#define CDNS_XSPI_READ_SEQ_P1_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_READ_SEQ_P1_CMD_EDGE		BIT(11)
+#define CDNS_XSPI_READ_SEQ_P1_ADDR_CNT		GENMASK(14, 12)
+#define CDNS_XSPI_READ_SEQ_P1_ADDR_IOS		GENMASK(17, 16)
+#define CDNS_XSPI_READ_SEQ_P1_ADDR_EDGE		BIT(19)
+#define CDNS_XSPI_READ_SEQ_P1_DATA_IOS		GENMASK(21, 20)
+#define CDNS_XSPI_READ_SEQ_P1_DATA_EDGE		BIT(23)
+#define CDNS_XSPI_READ_SEQ_P1_DUMMY_CNT		GENMASK(29, 24)
+
+#define CDNS_XSPI_READ_SEQ_CFG_1			0x0434
+#define CDNS_XSPI_READ_SEQ_P1_CMD_EXT_EN		BIT(0)
+#define CDNS_XSPI_READ_SEQ_P1_CACHE_RANDOM_READ_EN	BIT(4)
+#define CDNS_XSPI_READ_SEQ_CFG_2			0x0438
+
+/* Write enable sequence config register */
+#define CDNS_XSPI_WE_SEQ_CFG_0			0x0440
+#define CDNS_XSPI_WE_SEQ_P1_CMD_VAL		GENMASK(7, 0)
+#define CDNS_XSPI_WE_SEQ_P1_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_WE_SEQ_P1_CMD_EDGE		BIT(11)
+#define CDNS_XSPI_WE_SEQ_P1_EN			BIT(24)
+
+/* Status sequence config registers */
+#define CDNS_XSPI_STAT_SEQ_CFG_0			0x0450
+#define CDNS_XSPI_STAT_SEQ_P1_ADDR_CNT			GENMASK(9, 8)
+#define CDNS_XSPI_STAT_SEQ_CFG_1			0x0454
+#define CDNS_XSPI_P1_DEV_RDY_ADDR_EN		BIT(6)
+#define CDNS_XSPI_P1_PROG_FAIL_ADDR_EN		BIT(22)
+#define CDNS_XSPI_P1_ERS_FAIL_ADDR_EN		BIT(30)
+
+#define CDNS_XSPI_STAT_SEQ_CFG_2			0x0458
+#define CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_CMD_VAL	GENMASK(7, 0)
+#define CDNS_XSPI_STAT_SEQ_P1_ERS_FAIL_CMD_VAL	GENMASK(15, 8)
+#define CDNS_XSPI_STAT_SEQ_P1_PROG_FAIL_CMD_VAL	GENMASK(31, 24)
+
+#define CDNS_XSPI_STAT_SEQ_CFG_3			0x045c
+#define CDNS_XSPI_STAT_SEQ_CFG_4			0x0460
+#define CDNS_XSPI_STAT_SEQ_CFG_5			0x0464
+#define CDNS_XSPI_STAT_SEQ_DEV_RDY_IDX		GENMASK(3, 0)
+#define CDNS_XSPI_STAT_SEQ_DEV_RDY_EN		BIT(6)
+#define CDNS_XSPI_STAT_SEQ_ERS_FAIL_IDX		GENMASK(11, 8)
+#define CDNS_XSPI_STAT_SEQ_ERS_FAIL_VAL		BIT(12)
+#define CDNS_XSPI_STAT_SEQ_ERS_FAIL_EN		BIT(14)
+#define CDNS_XSPI_STAT_SEQ_PROG_FAIL_IDX		GENMASK(27, 24)
+#define CDNS_XSPI_STAT_SEQ_PROG_FAIL_VAL		BIT(28)
+#define CDNS_XSPI_STAT_SEQ_PROG_FAIL_EN			BIT(30)
+
+#define CDNS_XSPI_STAT_SEQ_CFG_7			0x046c
+#define CDNS_XSPI_STAT_SEQ_CFG_8			0x0470
+#define CDNS_XSPI_STAT_SEQ_CFG_9			0x0474
+
+#define CDNS_XSPI_STAT_SEQ_CFG_10		0x0478
+#define CDNS_XSPI_STAT_SEQ_ECC_FAIL_EN		BIT(31)
+#define CDNS_XSPI_STAT_SEQ_CRDY_VAL		BIT(27)
+#define CDNS_XSPI_STAT_SEQ_CRDY_IDX		GENMASK(26, 24)
+#define CDNS_XSPI_STAT_SEQ_ECC_CORR_VAL		GENMASK(23, 16)
+#define CDNS_XSPI_STAT_SEQ_ECC_FAIL_VAL		GENMASK(15, 8)
+#define CDNS_XSPI_STAT_SEQ_ECC_FAIL_MASK		GENMASK(7, 0)
 
 #define CDNS_XSPI_STIG_DONE_FLAG		BIT(0)
 #define CDNS_XSPI_TRD_STATUS			0x0104
 
+#define CDNS_XSPI_FLASH_TYPE_NOR		0
+#define CDNS_XSPI_FLASH_TYPE_NAND		1
+
+#define CDNS_XSPI_GLOBAL_SEQ_CFG			0x0390
+#define CDNS_XSPI_SEQ_TYPE			GENMASK(24, 23)
+#define CDNS_XSPI_SEQ_PAGE_SIZE_PGM		GENMASK(7, 4)
+#define CDNS_XSPI_SEQ_PAGE_SIZE_RD		GENMASK(3, 0)
+#define CDNS_XSPI_SEQ_SPI_NAND			3
+
+#define CDNS_XSPI_GLOBAL_SEQ_CFG_1		0x0394
+#define CDNS_XSPI_SEQ_PLANE_CNT			GENMASK(29, 28)
+#define CDNS_XSPI_SEQ_PAGE_PER_BLOCK		GENMASK(26, 24)
+#define CDNS_XSPI_SEQ_PAGE_CA_SIZE		BIT(16)
+#define CDNS_XSPI_SEQ_PAGE_SIZE_EXT		GENMASK(8, 0)
+
+#define CDNS_XSPI_XIP_MODE_CFG			0x0388
+#define CDNS_XSPI_XIP_EN			BIT(0)
+
 #define MODE_NO_OF_BYTES			GENMASK(25, 24)
 #define MODEBYTES_COUNT			1
 
@@ -305,6 +450,7 @@ enum cdns_xspi_stig_cmd_dir {
 
 struct cdns_xspi_driver_data {
 	bool mrvl_hw_overlay;
+	bool use_acmd;
 	u32 dll_phy_ctrl;
 	u32 ctb_rfile_phy_ctrl;
 	u32 rfile_phy_tsel;
@@ -313,12 +459,26 @@ struct cdns_xspi_driver_data {
 	u32 rfile_phy_gate_lpbk_ctrl;
 	u32 rfile_phy_dll_master_ctrl;
 	u32 rfile_phy_dll_slave_ctrl;
+	u8 flash_type;
 };
 
 static struct cdns_xspi_driver_data cdns_driver_data = {
 	.mrvl_hw_overlay = false,
 };
 
+static struct cdns_xspi_driver_data cdns_nand_driver_data = {
+	.mrvl_hw_overlay = false,
+	.use_acmd = true,
+	.flash_type = CDNS_XSPI_FLASH_TYPE_NAND,
+};
+
+struct cdns_xspi_acmd_info {
+	u64 row_addr;
+	u64 column_addr;
+	size_t data_nbytes;
+	bool row_addr_valid;
+	bool initialized;
+};
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct spi_controller *host;
@@ -351,6 +511,13 @@ struct cdns_xspi_dev {
 
 	bool xfer_in_progress;
 	int current_xfer_qword;
+	u32 work_mode;
+	u8 flash_type;
+
+	struct cdns_xspi_acmd_info acmd_info;
+	void *dma_buf;
+	dma_addr_t dma_addr;
+	u32 dma_buf_len;
 };
 
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
@@ -425,6 +592,268 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 }
 
+static void cdns_xspi_nand_cfg_seq_init(struct cdns_xspi_dev *cdns_xspi,
+					struct spinand_device *spinand)
+{
+	u32 seq_cfg, seq_cfg1;
+
+	seq_cfg = readl(cdns_xspi->iobase + CDNS_XSPI_GLOBAL_SEQ_CFG);
+	seq_cfg1 = readl(cdns_xspi->iobase + CDNS_XSPI_GLOBAL_SEQ_CFG_1);
+	seq_cfg = u32_replace_bits(seq_cfg, CDNS_XSPI_SEQ_SPI_NAND,
+				   CDNS_XSPI_SEQ_TYPE);
+	seq_cfg = u32_replace_bits(seq_cfg,
+				   ilog2(spinand->base.memorg.pagesize),
+				   CDNS_XSPI_SEQ_PAGE_SIZE_PGM);
+	seq_cfg = u32_replace_bits(seq_cfg,
+				   ilog2(spinand->base.memorg.pagesize),
+				   CDNS_XSPI_SEQ_PAGE_SIZE_RD);
+	seq_cfg1 = u32_replace_bits(seq_cfg1,
+				    ilog2(spinand->base.memorg.planes_per_lun),
+				    CDNS_XSPI_SEQ_PLANE_CNT);
+	seq_cfg1 = u32_replace_bits(seq_cfg1,
+				    ilog2(spinand->base.memorg.pages_per_eraseblock),
+				    CDNS_XSPI_SEQ_PAGE_PER_BLOCK);
+	seq_cfg1 = u32_replace_bits(seq_cfg1,
+				    !!(spinand->base.memorg.pagesize & BIT(12)),
+				    CDNS_XSPI_SEQ_PAGE_CA_SIZE);
+	seq_cfg1 = u32_replace_bits(seq_cfg1, spinand->base.memorg.oobsize,
+				    CDNS_XSPI_SEQ_PAGE_SIZE_EXT);
+
+	writel(seq_cfg, cdns_xspi->iobase + CDNS_XSPI_GLOBAL_SEQ_CFG);
+	writel(seq_cfg1, cdns_xspi->iobase + CDNS_XSPI_GLOBAL_SEQ_CFG_1);
+}
+
+static void cdns_xspi_nand_read_seq_init(struct cdns_xspi_dev *cdns_xspi,
+					 struct spinand_device *spinand)
+{
+	const struct spi_mem_op *op = spinand->op_templates->read_cache;
+	u32 dummy_cycles = 0;
+	u32 read_seq_cfg0;
+	u32 read_seq_cfg1;
+
+	if (op->dummy.nbytes && op->dummy.buswidth)
+		dummy_cycles = op->dummy.nbytes * BITS_PER_BYTE /
+			       (op->dummy.buswidth * (op->dummy.dtr + 1));
+
+	read_seq_cfg0 =
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_VAL, op->cmd.opcode) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_IOS,
+			   ilog2(op->cmd.buswidth)) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_EDGE, op->cmd.dtr) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_ADDR_CNT,
+			   op->addr.nbytes) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_ADDR_IOS,
+			   ilog2(op->addr.buswidth)) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_ADDR_EDGE, op->addr.dtr) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_DATA_IOS,
+			   ilog2(op->data.buswidth)) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_DATA_EDGE, op->data.dtr) |
+		FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_DUMMY_CNT, dummy_cycles);
+	read_seq_cfg1 = FIELD_PREP(CDNS_XSPI_READ_SEQ_P1_CMD_EXT_EN,
+				   op->cmd.nbytes > 1) |
+		CDNS_XSPI_READ_SEQ_P1_CACHE_RANDOM_READ_EN;
+
+	writel(read_seq_cfg0, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG_0);
+	writel(read_seq_cfg1, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG_1);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_READ_SEQ_CFG_2);
+
+	dev_dbg(cdns_xspi->dev,
+		"ACMD read: op=%02x %u-%u-%u%s addr=%u dummy=%u cfg=%08x/%08x\n",
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->data.buswidth, op->data.dtr ? " DTR" : " SDR",
+		op->addr.nbytes, dummy_cycles, read_seq_cfg0, read_seq_cfg1);
+}
+
+static void cdns_xspi_nand_write_seq_init(struct cdns_xspi_dev *cdns_xspi,
+					  struct spinand_device *spinand)
+{
+	const struct spi_mem_op *op = spinand->op_templates->write_cache;
+	u32 dummy_cycles = 0;
+	u32 write_seq_cfg0;
+	u32 write_seq_cfg1;
+
+	if (op->dummy.nbytes && op->dummy.buswidth)
+		dummy_cycles = op->dummy.nbytes * BITS_PER_BYTE /
+			       (op->dummy.buswidth * (op->dummy.dtr + 1));
+
+	write_seq_cfg0 =
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_VAL, op->cmd.opcode) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_IOS,
+			   ilog2(op->cmd.buswidth)) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_EDGE, op->cmd.dtr) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_ADDR_CNT,
+			   op->addr.nbytes) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_ADDR_IOS,
+			   ilog2(op->addr.buswidth)) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_ADDR_EDGE, op->addr.dtr) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_DATA_IOS,
+			   ilog2(op->data.buswidth)) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_DATA_EDGE, op->data.dtr) |
+		FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_DUMMY_CNT, dummy_cycles);
+	write_seq_cfg1 = FIELD_PREP(CDNS_XSPI_PROG_SEQ_P1_CMD_EXT_EN,
+				    op->cmd.nbytes > 1);
+
+	writel(write_seq_cfg0, cdns_xspi->iobase + CDNS_XSPI_PROG_SEQ_CFG_0);
+	writel(write_seq_cfg1, cdns_xspi->iobase + CDNS_XSPI_PROG_SEQ_CFG_1);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_PROG_SEQ_CFG_2);
+
+	dev_dbg(cdns_xspi->dev,
+		"ACMD program: op=%02x %u-%u-%u%s addr=%u dummy=%u cfg=%08x/%08x\n",
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->data.buswidth, op->data.dtr ? " DTR" : " SDR",
+		op->addr.nbytes, dummy_cycles, write_seq_cfg0, write_seq_cfg1);
+}
+
+static void cdns_xspi_nand_erase_seq_init(struct cdns_xspi_dev *cdns_xspi,
+					  struct spinand_device *spinand)
+{
+	u32 erase_seq_cfg0;
+	u32 erase_seq_cfg1;
+
+	/* SPI-NAND block erase is always D8h with a 3-byte row address. */
+	erase_seq_cfg0 =
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_VAL, 0xd8) |
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_IOS, 0) |
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_EDGE, 0) |
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_ADDR_CNT, 3) |
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_EXT_EN, 0) |
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_CMD_EXT_VAL, 0) |
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_ADDR_IOS, 0) |
+		FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_ADDR_EDGE, 0);
+	erase_seq_cfg1 = FIELD_PREP(CDNS_XSPI_ERSS_SEQ_P1_SECT_SIZE,
+				    ilog2(nanddev_eraseblock_size(&spinand->base)));
+
+	writel(erase_seq_cfg0,
+	       cdns_xspi->iobase + CDNS_XSPI_ERSS_SEQ_CFG_0);
+	writel(erase_seq_cfg1,
+	       cdns_xspi->iobase + CDNS_XSPI_ERSS_SEQ_CFG_1);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_ERSS_SEQ_CFG_2);
+
+	dev_dbg(cdns_xspi->dev,
+		"ACMD erase sequence: cfg0=%08x cfg1=%08x\n",
+		erase_seq_cfg0, erase_seq_cfg1);
+}
+
+static void cdns_xspi_nand_status_seq_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 stat_seq_cfg1;
+	u32 stat_seq_cfg2;
+	u32 stat_seq_cfg5;
+
+	writel(FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_ADDR_CNT, 0),
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_0);
+
+	stat_seq_cfg1 = CDNS_XSPI_P1_DEV_RDY_ADDR_EN |
+			CDNS_XSPI_P1_PROG_FAIL_ADDR_EN |
+			CDNS_XSPI_P1_ERS_FAIL_ADDR_EN;
+	writel(stat_seq_cfg1, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_1);
+
+	stat_seq_cfg2 = FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_DEV_RDY_CMD_VAL,
+				   CDNS_XSPI_NAND_OP_GET_FEATURE) |
+		FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_PROG_FAIL_CMD_VAL,
+			   CDNS_XSPI_NAND_OP_GET_FEATURE) |
+		FIELD_PREP(CDNS_XSPI_STAT_SEQ_P1_ERS_FAIL_CMD_VAL,
+			   CDNS_XSPI_NAND_OP_GET_FEATURE);
+	writel(stat_seq_cfg2, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_2);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_3);
+	writel(0, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_4);
+
+	stat_seq_cfg5 =
+		FIELD_PREP(CDNS_XSPI_STAT_SEQ_DEV_RDY_IDX,
+			   __ffs(STATUS_BUSY)) |
+		CDNS_XSPI_STAT_SEQ_DEV_RDY_EN |
+		FIELD_PREP(CDNS_XSPI_STAT_SEQ_ERS_FAIL_IDX,
+			   __ffs(STATUS_ERASE_FAILED)) |
+		CDNS_XSPI_STAT_SEQ_ERS_FAIL_VAL |
+		CDNS_XSPI_STAT_SEQ_ERS_FAIL_EN |
+		FIELD_PREP(CDNS_XSPI_STAT_SEQ_PROG_FAIL_IDX,
+			   __ffs(STATUS_PROG_FAILED)) |
+		CDNS_XSPI_STAT_SEQ_PROG_FAIL_VAL |
+		CDNS_XSPI_STAT_SEQ_PROG_FAIL_EN;
+	writel(stat_seq_cfg5, cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_5);
+	writel(CDNS_XSPI_NAND_STATUS_REG,
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_7);
+	writel(CDNS_XSPI_NAND_STATUS_REG,
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_8);
+	writel(CDNS_XSPI_NAND_STATUS_REG,
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_9);
+
+	writel(CDNS_XSPI_STAT_SEQ_ECC_FAIL_EN |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_CRDY_IDX, __ffs(STATUS_BUSY)) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_CRDY_VAL, 0) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_ECC_CORR_VAL,
+			  STATUS_ECC_HAS_BITFLIPS) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_ECC_FAIL_VAL,
+			  STATUS_ECC_UNCOR_ERROR) |
+	       FIELD_PREP(CDNS_XSPI_STAT_SEQ_ECC_FAIL_MASK,
+			  STATUS_ECC_MASK),
+	       cdns_xspi->iobase + CDNS_XSPI_STAT_SEQ_CFG_10);
+}
+
+static void cdns_xspi_nand_write_enable_seq_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 cfg;
+
+	cfg = readl(cdns_xspi->iobase + CDNS_XSPI_WE_SEQ_CFG_0);
+	cfg = u32_replace_bits(cfg, 1, CDNS_XSPI_WE_SEQ_P1_EN);
+	cfg = u32_replace_bits(cfg, CDNS_XSPI_NAND_OP_WRITE_ENABLE,
+			       CDNS_XSPI_WE_SEQ_P1_CMD_VAL);
+	cfg = u32_replace_bits(cfg, 0, CDNS_XSPI_WE_SEQ_P1_CMD_IOS);
+	cfg = u32_replace_bits(cfg, 0, CDNS_XSPI_WE_SEQ_P1_CMD_EDGE);
+	writel(cfg, cdns_xspi->iobase + CDNS_XSPI_WE_SEQ_CFG_0);
+}
+
+static void cdns_xspi_set_mode_acmd(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 reg_val;
+
+	reg_val = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+	reg_val = u32_replace_bits(reg_val, CDNS_XSPI_WORK_MODE_ACMD,
+				   CDNS_XSPI_CTRL_WORK_MODE);
+	writel(reg_val, cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+}
+
+static void cdns_xspi_nand_reset_seq_init(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 cfg;
+
+	cfg = FIELD_PREP(CDNS_XSPI_RST_SEQ_P1_CMD1_VAL,
+			 CDNS_XSPI_NAND_OP_RESET);
+	writel(cfg, cdns_xspi->iobase + CDNS_XSPI_RST_SEQ_CFG_0);
+}
+
+static int cdns_xspi_nand_init(struct cdns_xspi_dev *cdns_xspi,
+			       struct spinand_device *spinand)
+{
+	u32 reg_val;
+
+	cdns_xspi_nand_cfg_seq_init(cdns_xspi, spinand);
+	cdns_xspi_nand_read_seq_init(cdns_xspi, spinand);
+	cdns_xspi_nand_reset_seq_init(cdns_xspi);
+	cdns_xspi_nand_write_seq_init(cdns_xspi, spinand);
+	cdns_xspi_nand_write_enable_seq_init(cdns_xspi);
+	cdns_xspi_nand_status_seq_init(cdns_xspi);
+	cdns_xspi_nand_erase_seq_init(cdns_xspi, spinand);
+
+	reg_val = readl(cdns_xspi->iobase + CDNS_XSPI_XIP_MODE_CFG);
+	if (reg_val & CDNS_XSPI_XIP_EN) {
+		reg_val &= ~CDNS_XSPI_XIP_EN;
+		writel(reg_val, cdns_xspi->iobase + CDNS_XSPI_XIP_MODE_CFG);
+	}
+	cdns_xspi->dma_buf_len = spinand->base.memorg.pagesize +
+				 spinand->base.memorg.oobsize;
+	cdns_xspi->dma_buf = dmam_alloc_coherent(cdns_xspi->dev,
+						 cdns_xspi->dma_buf_len,
+						 &cdns_xspi->dma_addr,
+						 GFP_KERNEL);
+	if (!cdns_xspi->dma_buf)
+		return -ENOMEM;
+
+	cdns_xspi->acmd_info.initialized = true;
+
+	return 0;
+}
+
 static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_ver;
@@ -580,6 +1009,349 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	return 0;
 }
 
+static int cdns_xspi_acmd_get_thread_status(struct cdns_xspi_dev *cdns_xspi,
+					    u32 thread)
+{
+	writel(thread, cdns_xspi->iobase + CDNS_XSPI_CMD_STATUS_PTR_REG);
+
+	return cdns_xspi_check_command_status(cdns_xspi);
+}
+
+static int cdns_xspi_acmd_run(struct cdns_xspi_dev *cdns_xspi, u32 cmd_regs[6],
+			      u32 thread)
+{
+	unsigned long timeout;
+	int ret;
+
+	cdns_xspi_set_mode_acmd(cdns_xspi);
+	reinit_completion(&cdns_xspi->auto_cmd_complete);
+	cdns_xspi_set_interrupts(cdns_xspi, true);
+	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+	timeout = msecs_to_jiffies(CDNS_XSPI_ACMD_TIMEOUT_MS);
+	if (!wait_for_completion_timeout(&cdns_xspi->auto_cmd_complete,
+					 timeout)) {
+		dev_err(cdns_xspi->dev, "ACMD command timed out\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = cdns_xspi_acmd_get_thread_status(cdns_xspi, thread);
+	}
+
+	cdns_xspi_set_interrupts(cdns_xspi, false);
+
+	return ret;
+}
+
+static int cdns_xspi_nand_addr(struct spinand_device *spinand, u64 row,
+			       u64 column, u64 *xspi_addr)
+{
+	const struct nand_memory_organization *memorg = &spinand->base.memorg;
+	u64 column_limit, page_stride;
+
+	page_stride = roundup_pow_of_two(memorg->pagesize + memorg->oobsize);
+	if (check_mul_overflow(page_stride, memorg->planes_per_lun,
+			       &column_limit) ||
+	    column >= column_limit ||
+	    check_mul_overflow(row, page_stride, xspi_addr) ||
+	    check_add_overflow(*xspi_addr, column, xspi_addr))
+		return -ERANGE;
+
+	return 0;
+}
+
+static u32 cdns_xspi_acmd_cmd(struct cdns_xspi_dev *cdns_xspi, u32 type,
+			      u32 thread, bool use_dma)
+{
+	return FIELD_PREP(CDNS_XSPI_ACMD_MODE, CDNS_XSPI_ACMD_MODE_PIO) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_TRD_NUM, thread) |
+	       FIELD_PREP(CDNS_XSPI_ACMD_BANK_NUM, cdns_xspi->cur_cs) |
+	       (use_dma ? CDNS_XSPI_ACMD_DMA_SEL : 0) |
+	       CDNS_XSPI_ACMD_INT_EN |
+	       FIELD_PREP(CDNS_XSPI_ACMD_CMD_TYPE, type);
+}
+
+static int cdns_xspi_pio_mdma_erase(struct cdns_xspi_dev *cdns_xspi,
+				    struct spinand_device *spinand,
+				    const struct spi_mem_op *op)
+{
+	u32 cmd_regs[6] = { 0 };
+	u64 xspi_addr;
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret) {
+		dev_err(cdns_xspi->dev,
+			"controller did not become idle before erase\n");
+		return ret;
+	}
+
+	ret = cdns_xspi_nand_addr(spinand, op->addr.val, 0, &xspi_addr);
+	if (ret)
+		return ret;
+
+	if (upper_32_bits(xspi_addr)) {
+		dev_err(cdns_xspi->dev,
+			"erase address 0x%llx exceeds the ACMD PIO range\n",
+			xspi_addr);
+		return -ERANGE;
+	}
+
+	cmd_regs[1] = lower_32_bits(xspi_addr);
+	cmd_regs[0] = cdns_xspi_acmd_cmd(cdns_xspi,
+					 CDNS_XSPI_ACMD_ERASE_OP,
+					 CDNS_XSPI_ACMD_ERASE_THREAD, false);
+
+	ret = cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
+				 CDNS_XSPI_ACMD_ERASE_THREAD);
+	if (ret)
+		dev_err(cdns_xspi->dev, "ACMD erase failed: %d\n", ret);
+
+	return ret;
+}
+
+static int cdns_xspi_pio_reset(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 cmd_regs[6] = { 0 };
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret) {
+		dev_err(cdns_xspi->dev,
+			"controller did not become idle before reset\n");
+		return ret;
+	}
+	cmd_regs[0] = cdns_xspi_acmd_cmd(cdns_xspi,
+					 CDNS_XSPI_ACMD_RESET_OP,
+					 CDNS_XSPI_ACMD_DATA_THREAD, false);
+	ret = cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
+				 CDNS_XSPI_ACMD_DATA_THREAD);
+	if (ret)
+		return ret;
+
+	cdns_xspi->acmd_info.row_addr_valid = false;
+	cdns_xspi->acmd_info.column_addr = 0;
+	cdns_xspi->acmd_info.data_nbytes = 0;
+	cdns_xspi->out_buffer = NULL;
+
+	return 0;
+}
+
+static int cdns_xspi_pio_mdma_program(struct cdns_xspi_dev *cdns_xspi,
+				      struct spinand_device *spinand,
+				      const struct spi_mem_op *op)
+{
+	u32 cmd_regs[6] = { 0 };
+	u64 xspi_addr;
+	int ret;
+
+	if (!cdns_xspi->out_buffer || !cdns_xspi->acmd_info.data_nbytes) {
+		dev_err(cdns_xspi->dev, "missing program-load data\n");
+		ret = -EINVAL;
+		goto out_clear_program_state;
+	}
+
+	if (cdns_xspi->acmd_info.data_nbytes > cdns_xspi->dma_buf_len) {
+		ret = -EMSGSIZE;
+		goto out_clear_program_state;
+	}
+
+	memcpy(cdns_xspi->dma_buf, cdns_xspi->out_buffer,
+	       cdns_xspi->acmd_info.data_nbytes);
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret) {
+		dev_err(cdns_xspi->dev,
+			"controller did not become idle before program\n");
+		goto out_clear_program_state;
+	}
+
+	ret = cdns_xspi_nand_addr(spinand, op->addr.val,
+				  cdns_xspi->acmd_info.column_addr,
+				  &xspi_addr);
+	if (ret)
+		goto out_clear_program_state;
+
+	if (upper_32_bits(xspi_addr)) {
+		dev_err(cdns_xspi->dev,
+			"program address 0x%llx exceeds the ACMD PIO range\n",
+			xspi_addr);
+		ret = -ERANGE;
+		goto out_clear_program_state;
+	}
+
+	cmd_regs[1] = lower_32_bits(xspi_addr);
+	cmd_regs[2] = lower_32_bits(cdns_xspi->dma_addr);
+	cmd_regs[3] = upper_32_bits(cdns_xspi->dma_addr);
+	cmd_regs[4] = cdns_xspi->acmd_info.data_nbytes - 1;
+	cmd_regs[0] = cdns_xspi_acmd_cmd(cdns_xspi,
+					 CDNS_XSPI_ACMD_PROG_OP,
+					 CDNS_XSPI_ACMD_DATA_THREAD, true);
+
+	ret = cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
+				 CDNS_XSPI_ACMD_DATA_THREAD);
+
+out_clear_program_state:
+	cdns_xspi->acmd_info.column_addr = 0;
+	cdns_xspi->acmd_info.data_nbytes = 0;
+	cdns_xspi->out_buffer = NULL;
+	return ret;
+}
+
+static int cdns_xspi_pio_mdma_read(struct cdns_xspi_dev *cdns_xspi,
+				   struct spinand_device *spinand,
+				   const struct spi_mem_op *op)
+{
+	u32 cmd_regs[6] = { 0 };
+	u64 xspi_addr;
+	int ret;
+
+	if (!cdns_xspi->acmd_info.row_addr_valid) {
+		dev_err(cdns_xspi->dev,
+			"read cache command without a pending page read\n");
+		return -EINVAL;
+	}
+
+	if (op->data.dir != SPI_MEM_DATA_IN || !op->data.nbytes ||
+	    !op->data.buf.in) {
+		ret = -EINVAL;
+		goto out_clear_read_state;
+	}
+
+	if (op->data.nbytes > cdns_xspi->dma_buf_len) {
+		ret = -EMSGSIZE;
+		goto out_clear_read_state;
+	}
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret) {
+		dev_err(cdns_xspi->dev,
+			"controller did not become idle before read\n");
+		goto out_clear_read_state;
+	}
+
+	ret = cdns_xspi_nand_addr(spinand,
+				  cdns_xspi->acmd_info.row_addr,
+				  op->addr.val, &xspi_addr);
+	if (ret)
+		goto out_clear_read_state;
+
+	if (upper_32_bits(xspi_addr)) {
+		dev_err(cdns_xspi->dev,
+			"read address 0x%llx exceeds the ACMD PIO range\n",
+			xspi_addr);
+		ret = -ERANGE;
+		goto out_clear_read_state;
+	}
+
+	cmd_regs[1] = lower_32_bits(xspi_addr);
+	cmd_regs[2] = lower_32_bits(cdns_xspi->dma_addr);
+	cmd_regs[3] = upper_32_bits(cdns_xspi->dma_addr);
+	cmd_regs[4] = op->data.nbytes - 1;
+	cmd_regs[0] = cdns_xspi_acmd_cmd(cdns_xspi,
+					 CDNS_XSPI_ACMD_READ_OP,
+					 CDNS_XSPI_ACMD_DATA_THREAD, true);
+
+	ret = cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
+				 CDNS_XSPI_ACMD_DATA_THREAD);
+	if (ret) {
+		dev_err(cdns_xspi->dev, "ACMD read failed: %d\n", ret);
+		goto out_clear_read_state;
+	}
+
+	memcpy(op->data.buf.in, cdns_xspi->dma_buf, op->data.nbytes);
+
+out_clear_read_state:
+	cdns_xspi->acmd_info.row_addr_valid = false;
+	cdns_xspi->acmd_info.row_addr = 0;
+	return ret;
+}
+
+static int cdns_xspi_send_pio_command(struct cdns_xspi_dev *cdns_xspi,
+				      struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	struct spinand_device *spinand;
+	const struct spi_mem_op *read_cache;
+	const struct spi_mem_op *write_cache;
+	const struct spi_mem_op *update_cache;
+	int ret;
+
+	if (cdns_xspi->flash_type != CDNS_XSPI_FLASH_TYPE_NAND)
+		goto use_stig;
+
+	spinand = spi_mem_get_drvdata(mem);
+	if (!spinand || !spinand->op_templates ||
+	    !spinand->op_templates->read_cache ||
+	    !spinand->op_templates->write_cache ||
+	    !spinand->op_templates->update_cache)
+		goto use_stig;
+
+	if (!cdns_xspi->acmd_info.initialized) {
+		ret = cdns_xspi_nand_init(cdns_xspi, spinand);
+		if (ret) {
+			dev_err(cdns_xspi->dev,
+				"failed to initialize ACMD: %d\n", ret);
+			return ret;
+		}
+	}
+
+	read_cache = spinand->op_templates->read_cache;
+	write_cache = spinand->op_templates->write_cache;
+	update_cache = spinand->op_templates->update_cache;
+
+	if ((write_cache && op->cmd.opcode == write_cache->cmd.opcode) ||
+	    (update_cache && op->cmd.opcode == update_cache->cmd.opcode)) {
+		if (op->data.dir != SPI_MEM_DATA_OUT || !op->data.nbytes ||
+		    !op->data.buf.out)
+			return -EINVAL;
+
+		cdns_xspi_nand_write_enable_seq_init(cdns_xspi);
+		cdns_xspi->out_buffer = op->data.buf.out;
+		cdns_xspi->acmd_info.column_addr = op->addr.val;
+		cdns_xspi->acmd_info.data_nbytes = op->data.nbytes;
+		return 0;
+	}
+
+	switch (op->cmd.opcode) {
+	case CDNS_XSPI_NAND_OP_PAGE_READ:
+		cdns_xspi->acmd_info.row_addr = op->addr.val;
+		cdns_xspi->acmd_info.row_addr_valid = true;
+		return 0;
+
+	case CDNS_XSPI_NAND_OP_GET_FEATURE:
+		if (op->addr.val != CDNS_XSPI_NAND_STATUS_REG ||
+		    !cdns_xspi->acmd_info.row_addr_valid)
+			break;
+
+		if (op->data.dir != SPI_MEM_DATA_IN || !op->data.nbytes ||
+		    !op->data.buf.in)
+			return -EINVAL;
+
+		memset(op->data.buf.in, 0, op->data.nbytes);
+		return 0;
+
+	case CDNS_XSPI_NAND_OP_RESET:
+		return cdns_xspi_pio_reset(cdns_xspi);
+
+	case CDNS_XSPI_NAND_OP_BLOCK_ERASE:
+		return cdns_xspi_pio_mdma_erase(cdns_xspi, spinand, op);
+
+	case CDNS_XSPI_NAND_OP_PROGRAM_EXECUTE:
+		return cdns_xspi_pio_mdma_program(cdns_xspi, spinand, op);
+
+	default:
+		break;
+	}
+
+	if (read_cache && op->cmd.opcode == read_cache->cmd.opcode)
+		return cdns_xspi_pio_mdma_read(cdns_xspi, spinand, op);
+
+use_stig:
+	/* ACMD does not consume this operation; execute it through STIG. */
+	return cdns_xspi_send_stig_command(cdns_xspi, op,
+					   op->data.dir != SPI_MEM_NO_DATA);
+}
+
 static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 			    struct spi_mem *mem,
 			    const struct spi_mem_op *op)
@@ -589,6 +1361,9 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 	if (cdns_xspi->cur_cs != spi_get_chipselect(mem->spi, 0))
 		cdns_xspi->cur_cs = spi_get_chipselect(mem->spi, 0);
 
+	if (cdns_xspi->work_mode == CDNS_XSPI_WORK_MODE_ACMD)
+		return cdns_xspi_send_pio_command(cdns_xspi, mem, op);
+
 	return cdns_xspi_send_stig_command(cdns_xspi, op,
 					   (dir != SPI_MEM_NO_DATA));
 }
@@ -1217,6 +1992,9 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	cdns_xspi->host = host;
 	cdns_xspi->dev = &pdev->dev;
 	cdns_xspi->cur_cs = 0;
+	cdns_xspi->flash_type = cdns_xspi->driver_data->flash_type;
+	cdns_xspi->work_mode = cdns_xspi->driver_data->use_acmd ?
+		CDNS_XSPI_WORK_MODE_ACMD : CDNS_XSPI_WORK_MODE_STIG;
 
 	init_completion(&cdns_xspi->cmd_complete);
 	init_completion(&cdns_xspi->auto_cmd_complete);
@@ -1344,6 +2122,10 @@ static const struct of_device_id cdns_xspi_of_match[] = {
 		.data = &marvell_driver_data,
 	},
 #endif
+	{
+		.compatible = "cdns,xspi-nand",
+		.data = &cdns_nand_driver_data,
+	},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);
-- 
2.34.1

