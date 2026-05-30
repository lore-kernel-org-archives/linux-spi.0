Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E39B960;
	Sat, 30 May 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780145784; cv=none; b=H7TX2ef5ZNffXseqIRB9ohM6ktIPyY6DHNk8tfiSz6r599sYDh76ItigU5Dxsll6X9qmdOu3TwixlGTe3/cL8JfsR2UgcFREJARaZHDNKUM63aLxjDoA/uACOuv5Y7ozd3JHpWYpvDNEPAZNf4Afl8sRUYLydsjFhSl4TUXLjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780145784; c=relaxed/simple;
	bh=7WAss+tTyZDKiz4Enhw2StslBjppB6peaPGcOZLcOuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svHx1/6kp8kNUgBv4LW30mQQhx8F9OdCyROi30mm5KCtHkY1FfWq1mVtjbGLk45k4zGCO2zZ64tAx5vzG/lXpC20LwR/Lr9ujLqInE2WLIP4s9TZOG0858fsrvh8P3T8iWgjDKFVuNlyXY1rpYafIsLiSGzV3QaA/8M77GiacD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtLjjx6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtLjjx6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D5C1F00898;
	Sat, 30 May 2026 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780145782;
	bh=t1ZW133WrR/EapzTCBVhGuR5z/KHbTjhKYyXzdvqqv4=;
	h=From:To:Cc:Subject:Date;
	b=jtLjjx6VrwYZumh85kSpyKEDnCKJmapxRiqg2wwKdwdQHDjjHOFReMt6JkRIDPr7Y
	 jVm8i+9f0SSSHGMH2m+kBdbBjYeJdyV1Q+IQr5GEgRCNaefkQTogT8Yb2DIhZuc84B
	 KIVIEVH6RzsugAOBj5D/gm/X/w5UFkAKOTjYVWmQVNzQ4VGzveT1J1dqc+yLdUtkM2
	 4zIK2UlGUl5m/WvVEQA0SDQ0bPPB7eVgLITYXv9E/2QPyzxEskxIUgA2Mgdf0TEa4T
	 tpwjkeuuRKYHBQ5XgoEKpgGRuYfMtoSLkiMEOD0EVYKAfJ6/srkEoZd40zquYs8Khi
	 +t9fWOEwbngYw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: cadence-xspi: Support 32bit and 64bit slave dma interface
Date: Sat, 30 May 2026 20:37:15 +0800
Message-ID: <20260530123715.25899-1-jszhang@kernel.org>
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
+			ioread64_rep(src, buf, len >> 3);
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
+			iowrite64_rep(dst, buf, len >> 3);
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

