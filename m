Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE252B9A4;
	Wed,  3 Jun 2026 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445855; cv=none; b=DMernOtoG5ucSZlGfXF+PW2LdhvXDcWzizvkIr/0K67dyil3vjNhyMpJqOExoY8CqxCZZ+RDWcl5s9h2nWA8hHqmawSGsDVsTudrmAG9Cuq/sGIzLZoMVBuDayfRnKh0Dgz/0LoMU2mlLwdfHH9GiKiZHva1JtHxW4tnkDpsXdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445855; c=relaxed/simple;
	bh=5cw33p4f8a+MMJ3x7wXO1CKsAkCUmS/7IeUm/m5DORM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlNXP/ccQBXd+fCOjKoaviXRoEkoKArTkLRqxLxCjFSIjah3NLv4XwupFmjD4I1vlzXOxoSVv7MHU2EFdG1f1SLkHWyFPe9CqVG/fzg9y5CneE9K2Yn36RxWj0l6TPjzjjRknsL0iK8AJ+Y0tkwJazf9l03+5cwt2Z4YqBRU5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw0qHs/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw0qHs/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFEE1F00893;
	Wed,  3 Jun 2026 00:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445854;
	bh=B2t/dIh3uyNkBAkSFFTrdNdHSg+qcUVfkzf2n6TYoIA=;
	h=From:To:Cc:Subject:Date;
	b=aw0qHs/Hi7NNuR/VdV/D0L4TyfqcjyQYVozIwxy8h4JwUOGXD4bwg5VpDbKB1Espz
	 qbWQxrtjne8nNA3HJryHEpfkjyfWHlIAs6PMi8jmSo6rCvGJhXJVrUBUXxMnlxuEtl
	 GLzu+lsTbm/BAFYVpirMo/Z3Ke+3XBp9EqlxEv7+WoNjfBsO7e8WUmNwAsgWCkhKB7
	 TudTcOJcXCcNFhrthiQoD48X4su6H5ie10ztvlujBjl6OUcNh0T7YlSrTTqQeb+QQN
	 eVIFPGSqx6WKsK4yHWK3CfvFIm6la2M94lToRC8FWM6x/aQsn6hE2o0/mL9/vYvuNS
	 rEWkVwWCHnEZw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] spi: cadence-xspi: Support 32bit and 64bit slave dma interface
Date: Wed,  3 Jun 2026 07:58:25 +0800
Message-ID: <20260602235825.28614-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cdns xspi controller slave dma interface may support wider data
width. Wider I/O width can benefit performance. We can know the width
by checking the CTRL_FEATURES_REG's DMA_DATA_WIDTH bit, 0 means 32bit
1 means 64bit.

A simple test with QSPI nor flash on one arm64 platform:

Use 8bit slave dma data width (now):
 # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
 1000+0 records in
 1000+0 records out
 8192000 bytes (7.8MB) copied, 1.368735 seconds, 5.7MB/s

Use 32bit slave dma data width:
 # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
 1000+0 records in
 1000+0 records out
 8192000 bytes (7.8MB) copied, 1.088787 seconds, 7.2MB/s

Improved by 26.3%!

Use 64bit slave dma data width:
 # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
 1000+0 records in
 1000+0 records out
 8192000 bytes (7.8MB) copied, 0.831104 seconds, 9.4MB/s

Improved by 64.9%!

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

Since v2:
 - use readsq/writesq instead of ioread64_rep/iowrite64_rep to fix build
   error for x86. Similar solution as cadence-nand-controller.c

Since v1:
 - the hw capability(slave dma data width) can be found by checking the
   CTRL_FEATURES_REG's DMA_DATA_WIDTH, so no need dt property any more.

 drivers/spi/spi-cadence-xspi.c | 53 +++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 895b4b3276a5..ab6f1c68a2eb 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -369,6 +369,8 @@ struct cdns_xspi_dev {
 
 	void *in_buffer;
 	const void *out_buffer;
+	/* Slave DMA data width in bytes (4 or 8). */
+	u8 dma_data_width;
 
 	u8 hw_num_banks;
 
@@ -573,11 +575,56 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 
 	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
 	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
+	cdns_xspi->dma_data_width = (ctrl_features & CDNS_XSPI_DMA_DATA_WIDTH) ? 8 : 4;
 	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
 	return 0;
 }
 
+static inline void cdns_xspi_sdma_read(struct cdns_xspi_dev *cdns_xspi, size_t len)
+{
+	void __iomem *src = cdns_xspi->sdmabase;
+	void *buf = cdns_xspi->in_buffer;
+	size_t offset = 0;
+
+	if (cdns_xspi->dma_data_width == 4) {
+		if (IS_ALIGNED((uintptr_t)src, 4) && IS_ALIGNED((uintptr_t)buf, 4)) {
+			ioread32_rep(src, buf, len >> 2);
+			offset = len & ~0x3;
+			len -= offset;
+		}
+	} else {
+		if (IS_ALIGNED((uintptr_t)src, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
+			readsq(src, buf, len >> 3);
+			offset = len & ~0x7;
+			len -= offset;
+		}
+	}
+	ioread8_rep(src, (u8 *)buf + offset, len);
+}
+
+static inline void cdns_xspi_sdma_write(struct cdns_xspi_dev *cdns_xspi, size_t len)
+{
+	void __iomem *dst = cdns_xspi->sdmabase;
+	const void *buf = cdns_xspi->out_buffer;
+	size_t offset = 0;
+
+	if (cdns_xspi->dma_data_width == 4) {
+		if (IS_ALIGNED((uintptr_t)dst, 4) && IS_ALIGNED((uintptr_t)buf, 4)) {
+			iowrite32_rep(dst, buf, len >> 2);
+			offset = len & ~0x3;
+			len -= offset;
+		}
+	} else {
+		if (IS_ALIGNED((uintptr_t)dst, 8) && IS_ALIGNED((uintptr_t)buf, 8)) {
+			writesq(dst, buf, len >> 3);
+			offset = len & ~0x7;
+			len -= offset;
+		}
+	}
+	iowrite8_rep(dst, (const u8 *)buf + offset, len);
+}
+
 static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
@@ -589,13 +636,11 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 
 	switch (sdma_dir) {
 	case CDNS_XSPI_SDMA_DIR_READ:
-		ioread8_rep(cdns_xspi->sdmabase,
-			    cdns_xspi->in_buffer, sdma_size);
+		cdns_xspi_sdma_read(cdns_xspi, sdma_size);
 		break;
 
 	case CDNS_XSPI_SDMA_DIR_WRITE:
-		iowrite8_rep(cdns_xspi->sdmabase,
-			     cdns_xspi->out_buffer, sdma_size);
+		cdns_xspi_sdma_write(cdns_xspi, sdma_size);
 		break;
 	}
 }
-- 
2.53.0

