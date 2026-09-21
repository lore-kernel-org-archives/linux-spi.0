Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52E46E01D;
	Mon, 21 Sep 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986498; cv=none; b=IiEQCwPxT+UTHSuLLERgHlkJLop1VXaNhUYv7aGTUg3toIXQp3VVcIR0kFSNmIJbxI+1q7D9Wd7MLexLx+jgLToPfg060EENFYnrw0kvxM9aCwsDoPUcta9nSosZGJMXbZ6C7+vn84nb2gCwcxSVk2uz4ZVcFd7bR4/xhGeamI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986498; c=relaxed/simple;
	bh=GcSjeCEg4EifetYnW8w4MqDaNAd6lARMlHDXjbziGbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLYm1CNlGktBg7Y1HbV72tnEiZOeWB0CPPJDWok0tpm59w93PQq4eUq7GTc9o9tUcuR7DiN+0REOOwWRvlV+XrbRQvmWpyGQFsPr1zvYc+GLcT8idr5thIWXA96gR/E4ZZUxhviapgtzBXSJzQKEW5wjh9VUxJhfjPOBM//096o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=fail (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=QWnT/mDe reason="signature verification failed"; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="QWnT/mDe"
Received: from spam01.horizon.auto (localhost [127.0.0.2] (may be forged))
	by spam01.horizon.auto with ESMTP id 68L9csFU069410;
	Mon, 21 Sep 2026 17:38:54 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from spam01.horizon.auto (exchange003.hobot.cc [10.69.1.10])
	by spam01.horizon.auto with ESMTPS id 68L9c36m068860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
	Mon, 21 Sep 2026 17:38:03 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by exchange003.hobot.cc
 (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Mon, 21 Sep 2026
 17:38:02 +0800
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
Subject: [RFC PATCH 3/4] spi: cadence-xspi: factor out reusable ACMD helpers
Date: Mon, 21 Sep 2026 17:37:00 +0800
Message-ID: <20260921093701.1341766-4-fei.xie@horizon.auto>
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
X-MAIL:spam01.horizon.auto 68L9csFU069410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1789983498;
	bh=1b1haRp//ZE7fcCGYJ0hGUgE8n+xITtgL9GI45T07h8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QWnT/mDeQvfT6OKpP2lYYoygkJByifjObIVo58BFETHmo1l4xdWt0U1fibOlWQc8P
	 jkgi2JQMO90mP/H5wrA5hdErLtoQavAQSWNJLOZ2ilP0RtkpSGxQGHSEFCq13iBZmD
	 ntrieEA9g4Q7y2Krtj9fofbniga0dEFCEBL8tAYsG06wHsERv9g6LOwdv8kvw7Hr1k
	 SKLKoMIOHaoxrKFhXcOf0b9klaKRRfOqJZ7Qjqx/5lYsS32mAf5Q/pou17jgsUIwxn
	 5qssNBpXhxZfDNJaq2pK7vsn1BaeEkXR+9Mi1yaxqFOG9kMnXpWwlAI26GArYbEpnR
	 d/aAnPXa6zQuQ==

From: "fei.xie" <fei.xie@horizon.auto>

Move DMA buffer allocation, XIP setup and PIO command execution into
common helpers.

Keep SPI NAND address conversion and operation state handling in
NAND-specific wrappers. This is a behavior-neutral preparation for
sharing the ACMD PIO and MDMA path with other flash types.

Signed-off-by: fei.xie <fei.xie@horizon.auto>
---
 drivers/spi/spi-cadence-xspi.c | 223 ++++++++++++++++++++-------------
 1 file changed, 136 insertions(+), 87 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 0fedf6cd6a590..114c1e0fd79fb 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -822,10 +822,35 @@ static void cdns_xspi_nand_reset_seq_init(struct cdns_xspi_dev *cdns_xspi)
 	writel(cfg, cdns_xspi->iobase + CDNS_XSPI_RST_SEQ_CFG_0);
 }
 
+static int cdns_xspi_acmd_alloc_dma_buf(struct cdns_xspi_dev *cdns_xspi,
+					size_t len)
+{
+	cdns_xspi->dma_buf = dmam_alloc_coherent(cdns_xspi->dev, len,
+						 &cdns_xspi->dma_addr,
+						 GFP_KERNEL);
+	if (!cdns_xspi->dma_buf)
+		return -ENOMEM;
+
+	cdns_xspi->dma_buf_len = len;
+
+	return 0;
+}
+
+static void cdns_xspi_acmd_disable_xip(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 reg_val;
+
+	reg_val = readl(cdns_xspi->iobase + CDNS_XSPI_XIP_MODE_CFG);
+	if (reg_val & CDNS_XSPI_XIP_EN) {
+		reg_val &= ~CDNS_XSPI_XIP_EN;
+		writel(reg_val, cdns_xspi->iobase + CDNS_XSPI_XIP_MODE_CFG);
+	}
+}
+
 static int cdns_xspi_nand_init(struct cdns_xspi_dev *cdns_xspi,
 			       struct spinand_device *spinand)
 {
-	u32 reg_val;
+	int ret;
 
 	cdns_xspi_nand_cfg_seq_init(cdns_xspi, spinand);
 	cdns_xspi_nand_read_seq_init(cdns_xspi, spinand);
@@ -835,19 +860,12 @@ static int cdns_xspi_nand_init(struct cdns_xspi_dev *cdns_xspi,
 	cdns_xspi_nand_status_seq_init(cdns_xspi);
 	cdns_xspi_nand_erase_seq_init(cdns_xspi, spinand);
 
-	reg_val = readl(cdns_xspi->iobase + CDNS_XSPI_XIP_MODE_CFG);
-	if (reg_val & CDNS_XSPI_XIP_EN) {
-		reg_val &= ~CDNS_XSPI_XIP_EN;
-		writel(reg_val, cdns_xspi->iobase + CDNS_XSPI_XIP_MODE_CFG);
-	}
-	cdns_xspi->dma_buf_len = spinand->base.memorg.pagesize +
-				 spinand->base.memorg.oobsize;
-	cdns_xspi->dma_buf = dmam_alloc_coherent(cdns_xspi->dev,
-						 cdns_xspi->dma_buf_len,
-						 &cdns_xspi->dma_addr,
-						 GFP_KERNEL);
-	if (!cdns_xspi->dma_buf)
-		return -ENOMEM;
+	cdns_xspi_acmd_disable_xip(cdns_xspi);
+	ret = cdns_xspi_acmd_alloc_dma_buf(cdns_xspi,
+					   spinand->base.memorg.pagesize +
+					   spinand->base.memorg.oobsize);
+	if (ret)
+		return ret;
 
 	cdns_xspi->acmd_info.initialized = true;
 
@@ -1070,12 +1088,10 @@ static u32 cdns_xspi_acmd_cmd(struct cdns_xspi_dev *cdns_xspi, u32 type,
 	       FIELD_PREP(CDNS_XSPI_ACMD_CMD_TYPE, type);
 }
 
-static int cdns_xspi_pio_mdma_erase(struct cdns_xspi_dev *cdns_xspi,
-				    struct spinand_device *spinand,
-				    const struct spi_mem_op *op)
+static int cdns_xspi_pio_erase(struct cdns_xspi_dev *cdns_xspi,
+			       u64 xspi_addr)
 {
 	u32 cmd_regs[6] = { 0 };
-	u64 xspi_addr;
 	int ret;
 
 	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
@@ -1085,10 +1101,6 @@ static int cdns_xspi_pio_mdma_erase(struct cdns_xspi_dev *cdns_xspi,
 		return ret;
 	}
 
-	ret = cdns_xspi_nand_addr(spinand, op->addr.val, 0, &xspi_addr);
-	if (ret)
-		return ret;
-
 	if (upper_32_bits(xspi_addr)) {
 		dev_err(cdns_xspi->dev,
 			"erase address 0x%llx exceeds the ACMD PIO range\n",
@@ -1137,71 +1149,141 @@ static int cdns_xspi_pio_reset(struct cdns_xspi_dev *cdns_xspi)
 }
 
 static int cdns_xspi_pio_mdma_program(struct cdns_xspi_dev *cdns_xspi,
-				      struct spinand_device *spinand,
-				      const struct spi_mem_op *op)
+				      u64 xspi_addr, const void *buf,
+				      size_t nbytes)
 {
 	u32 cmd_regs[6] = { 0 };
-	u64 xspi_addr;
 	int ret;
 
-	if (!cdns_xspi->out_buffer || !cdns_xspi->acmd_info.data_nbytes) {
-		dev_err(cdns_xspi->dev, "missing program-load data\n");
-		ret = -EINVAL;
-		goto out_clear_program_state;
-	}
+	if (!buf || !nbytes)
+		return -EINVAL;
 
-	if (cdns_xspi->acmd_info.data_nbytes > cdns_xspi->dma_buf_len) {
-		ret = -EMSGSIZE;
-		goto out_clear_program_state;
+	if (nbytes > cdns_xspi->dma_buf_len)
+		return -EMSGSIZE;
+
+	if (upper_32_bits(xspi_addr)) {
+		dev_err(cdns_xspi->dev,
+			"program address 0x%llx exceeds the ACMD PIO range\n",
+			xspi_addr);
+		return -ERANGE;
 	}
 
-	memcpy(cdns_xspi->dma_buf, cdns_xspi->out_buffer,
-	       cdns_xspi->acmd_info.data_nbytes);
+	memcpy(cdns_xspi->dma_buf, buf, nbytes);
 
 	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
 	if (ret) {
 		dev_err(cdns_xspi->dev,
 			"controller did not become idle before program\n");
-		goto out_clear_program_state;
+		return ret;
 	}
 
-	ret = cdns_xspi_nand_addr(spinand, op->addr.val,
-				  cdns_xspi->acmd_info.column_addr,
-				  &xspi_addr);
-	if (ret)
-		goto out_clear_program_state;
+	cmd_regs[1] = lower_32_bits(xspi_addr);
+	cmd_regs[2] = lower_32_bits(cdns_xspi->dma_addr);
+	cmd_regs[3] = upper_32_bits(cdns_xspi->dma_addr);
+	cmd_regs[4] = nbytes - 1;
+	cmd_regs[0] = cdns_xspi_acmd_cmd(cdns_xspi,
+					 CDNS_XSPI_ACMD_PROG_OP,
+					 CDNS_XSPI_ACMD_DATA_THREAD, true);
+
+	return cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
+				  CDNS_XSPI_ACMD_DATA_THREAD);
+}
+
+static int cdns_xspi_pio_mdma_read(struct cdns_xspi_dev *cdns_xspi,
+				   u64 xspi_addr, void *buf, size_t nbytes)
+{
+	u32 cmd_regs[6] = { 0 };
+	int ret;
+
+	if (!buf || !nbytes)
+		return -EINVAL;
+
+	if (nbytes > cdns_xspi->dma_buf_len)
+		return -EMSGSIZE;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret) {
+		dev_err(cdns_xspi->dev,
+			"controller did not become idle before read\n");
+		return ret;
+	}
 
 	if (upper_32_bits(xspi_addr)) {
 		dev_err(cdns_xspi->dev,
-			"program address 0x%llx exceeds the ACMD PIO range\n",
+			"read address 0x%llx exceeds the ACMD PIO range\n",
 			xspi_addr);
-		ret = -ERANGE;
-		goto out_clear_program_state;
+		return -ERANGE;
 	}
 
 	cmd_regs[1] = lower_32_bits(xspi_addr);
 	cmd_regs[2] = lower_32_bits(cdns_xspi->dma_addr);
 	cmd_regs[3] = upper_32_bits(cdns_xspi->dma_addr);
-	cmd_regs[4] = cdns_xspi->acmd_info.data_nbytes - 1;
+	cmd_regs[4] = nbytes - 1;
 	cmd_regs[0] = cdns_xspi_acmd_cmd(cdns_xspi,
-					 CDNS_XSPI_ACMD_PROG_OP,
+					 CDNS_XSPI_ACMD_READ_OP,
 					 CDNS_XSPI_ACMD_DATA_THREAD, true);
 
 	ret = cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
 				 CDNS_XSPI_ACMD_DATA_THREAD);
+	if (ret) {
+		dev_err(cdns_xspi->dev, "ACMD read failed: %d\n", ret);
+		return ret;
+	}
+
+	memcpy(buf, cdns_xspi->dma_buf, nbytes);
+
+	return 0;
+}
+
+static int cdns_xspi_nand_pio_erase(struct cdns_xspi_dev *cdns_xspi,
+				    struct spinand_device *spinand,
+				    const struct spi_mem_op *op)
+{
+	u64 xspi_addr;
+	int ret;
+
+	ret = cdns_xspi_nand_addr(spinand, op->addr.val, 0, &xspi_addr);
+	if (ret)
+		return ret;
+
+	return cdns_xspi_pio_erase(cdns_xspi, xspi_addr);
+}
+
+static int cdns_xspi_nand_pio_program(struct cdns_xspi_dev *cdns_xspi,
+				      struct spinand_device *spinand,
+				      const struct spi_mem_op *op)
+{
+	u64 xspi_addr;
+	int ret;
+
+	if (!cdns_xspi->out_buffer || !cdns_xspi->acmd_info.data_nbytes) {
+		dev_err(cdns_xspi->dev, "missing program-load data\n");
+		ret = -EINVAL;
+		goto out_clear_program_state;
+	}
+
+	ret = cdns_xspi_nand_addr(spinand, op->addr.val,
+				  cdns_xspi->acmd_info.column_addr,
+				  &xspi_addr);
+	if (ret)
+		goto out_clear_program_state;
+
+	ret = cdns_xspi_pio_mdma_program(cdns_xspi, xspi_addr,
+					 cdns_xspi->out_buffer,
+					 cdns_xspi->acmd_info.data_nbytes);
 
 out_clear_program_state:
 	cdns_xspi->acmd_info.column_addr = 0;
 	cdns_xspi->acmd_info.data_nbytes = 0;
 	cdns_xspi->out_buffer = NULL;
+
 	return ret;
 }
 
-static int cdns_xspi_pio_mdma_read(struct cdns_xspi_dev *cdns_xspi,
+static int cdns_xspi_nand_pio_read(struct cdns_xspi_dev *cdns_xspi,
 				   struct spinand_device *spinand,
 				   const struct spi_mem_op *op)
 {
-	u32 cmd_regs[6] = { 0 };
 	u64 xspi_addr;
 	int ret;
 
@@ -1217,52 +1299,19 @@ static int cdns_xspi_pio_mdma_read(struct cdns_xspi_dev *cdns_xspi,
 		goto out_clear_read_state;
 	}
 
-	if (op->data.nbytes > cdns_xspi->dma_buf_len) {
-		ret = -EMSGSIZE;
-		goto out_clear_read_state;
-	}
-
-	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
-	if (ret) {
-		dev_err(cdns_xspi->dev,
-			"controller did not become idle before read\n");
-		goto out_clear_read_state;
-	}
-
 	ret = cdns_xspi_nand_addr(spinand,
 				  cdns_xspi->acmd_info.row_addr,
 				  op->addr.val, &xspi_addr);
 	if (ret)
 		goto out_clear_read_state;
 
-	if (upper_32_bits(xspi_addr)) {
-		dev_err(cdns_xspi->dev,
-			"read address 0x%llx exceeds the ACMD PIO range\n",
-			xspi_addr);
-		ret = -ERANGE;
-		goto out_clear_read_state;
-	}
-
-	cmd_regs[1] = lower_32_bits(xspi_addr);
-	cmd_regs[2] = lower_32_bits(cdns_xspi->dma_addr);
-	cmd_regs[3] = upper_32_bits(cdns_xspi->dma_addr);
-	cmd_regs[4] = op->data.nbytes - 1;
-	cmd_regs[0] = cdns_xspi_acmd_cmd(cdns_xspi,
-					 CDNS_XSPI_ACMD_READ_OP,
-					 CDNS_XSPI_ACMD_DATA_THREAD, true);
-
-	ret = cdns_xspi_acmd_run(cdns_xspi, cmd_regs,
-				 CDNS_XSPI_ACMD_DATA_THREAD);
-	if (ret) {
-		dev_err(cdns_xspi->dev, "ACMD read failed: %d\n", ret);
-		goto out_clear_read_state;
-	}
-
-	memcpy(op->data.buf.in, cdns_xspi->dma_buf, op->data.nbytes);
+	ret = cdns_xspi_pio_mdma_read(cdns_xspi, xspi_addr,
+				      op->data.buf.in, op->data.nbytes);
 
 out_clear_read_state:
 	cdns_xspi->acmd_info.row_addr_valid = false;
 	cdns_xspi->acmd_info.row_addr = 0;
+
 	return ret;
 }
 
@@ -1334,17 +1383,17 @@ static int cdns_xspi_send_pio_command(struct cdns_xspi_dev *cdns_xspi,
 		return cdns_xspi_pio_reset(cdns_xspi);
 
 	case CDNS_XSPI_NAND_OP_BLOCK_ERASE:
-		return cdns_xspi_pio_mdma_erase(cdns_xspi, spinand, op);
+		return cdns_xspi_nand_pio_erase(cdns_xspi, spinand, op);
 
 	case CDNS_XSPI_NAND_OP_PROGRAM_EXECUTE:
-		return cdns_xspi_pio_mdma_program(cdns_xspi, spinand, op);
+		return cdns_xspi_nand_pio_program(cdns_xspi, spinand, op);
 
 	default:
 		break;
 	}
 
 	if (read_cache && op->cmd.opcode == read_cache->cmd.opcode)
-		return cdns_xspi_pio_mdma_read(cdns_xspi, spinand, op);
+		return cdns_xspi_nand_pio_read(cdns_xspi, spinand, op);
 
 use_stig:
 	/* ACMD does not consume this operation; execute it through STIG. */
-- 
2.34.1

