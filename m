Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABC3B5318;
	Sat, 10 Oct 2026 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791646501; cv=none; b=AJLArDXhdhKzo+OFQwi1e+Re6oMU4eZrVkmavVZeI54rjbh3+fePG10NItyurJkkrxiV5bJF0k8RESkpNZk3cDGS4/E2MKprWuWzjCDltRY69q+hEhAqgQSFUNyNgJkIrF12rJhCkPttknDOuORJRLdQoZujRA5hTnG6Gau4j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791646501; c=relaxed/simple;
	bh=nUgAQ8LBy1l6/sNie+HqiU6j1TZZ6qrG3pWv7UuQOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2i81JPyxxIjzo7Y4l+cVwDx6UjLFW3E0WAMh1pThKa5EhOp/DlqqYOGB1WqcQb/mL1RKBfOrrCtQ98LRugJX39f+4ACmQ3nGuXVAV3M8CJE/YJWGskv0hKPisXgZttmJ6Stx7+EgOVyu5nc/h/KtVwZdl8SmXggzENZkE/C6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFLw97Nv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFLw97Nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914801F000FF;
	Sat, 10 Oct 2026 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791646500;
	bh=8tRhGPyi9t9cMaCia6L3xeLTu0sJut6Ylg8NHyYufH0=;
	h=From:To:Cc:Subject:Date;
	b=nFLw97NvKN2WC2GF5toaKHDIx2wvbSfEyARbFHOH8xithuKEIv2cSFOZGe/sfuuyO
	 d8kijw1GZeI3scQDtMPFbQ+WEwp6fWEjwa51cAIwPMLgUOQ3JZSP7U2ZhYXcdshUMr
	 HfPZKsQCvpyLYr4Vs5SqqXlu2s/sAvekJfCe6HrrR0CnaPrvW/puQtXFIKUjR6p8Z7
	 4lzJBfOvzqIudThSaM9AQ4Pip037heI03zP2/UaOmxzabbyC9bn85XEq25FU1UKTwy
	 Z0jf0zphzSb/ffcFgC7yesfOR8VvZUQdgRjuY14t94c9UpvlNkhVasGgKhGrykfZqB
	 Md+oCeGlRna5A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: Make dw_spi_update_config()
Date: Sat, 10 Oct 2026 23:14:59 +0800
Message-ID: <20261010151459.30560-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit da0a672268b3 ("spi: dw: Remove not-going-to-be-supported
code for Baikal SoC"), no users of dw_spi_update_config() any more.
Unexport it and make it static. We can also move two structure
definitions to spi-dw-core.c at the same time.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 21 ++++++++++++++++++---
 drivers/spi/spi-dw.h      | 18 ------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 1f0e93800908..2d671e31413e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -32,6 +32,22 @@ struct dw_spi_chip_data {
 	u32 rx_sample_dly;	/* RX sample delay */
 };
 
+/* Slave spi_transfer/spi_mem_op related */
+struct dw_spi_cfg {
+	u8 tmode;
+	u8 dfs;
+	u32 ndf;
+	u32 freq;
+	u8 spi_frf;
+};
+
+struct dw_spi_enh_cfg {
+	u8 wait_c;
+	u8 inst_l;
+	u8 addr_l;
+	u8 trans_t;
+};
+
 #ifdef CONFIG_DEBUG_FS
 
 #define DW_SPI_DBGFS_REG(_name, _off)	\
@@ -342,8 +358,8 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 	return cr0;
 }
 
-void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
-			  struct dw_spi_cfg *cfg, struct dw_spi_enh_cfg *enh_cfg)
+static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
+				 struct dw_spi_cfg *cfg, struct dw_spi_enh_cfg *enh_cfg)
 {
 	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = chip->cr0;
@@ -406,7 +422,6 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		dw_writel(dws, DW_SPI_SPI_CTRLR0, cr0);
 	}
 }
-EXPORT_SYMBOL_NS_GPL(dw_spi_update_config, "SPI_DW_CORE");
 
 static void dw_spi_irq_setup(struct dw_spi *dws)
 {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index bfdf371bcacb..c16225c5c887 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -158,22 +158,6 @@
 #define DW_SPI_GET_BYTE(_val, _idx) \
 	((_val) >> (BITS_PER_BYTE * (_idx)) & 0xff)
 
-/* Slave spi_transfer/spi_mem_op related */
-struct dw_spi_cfg {
-	u8 tmode;
-	u8 dfs;
-	u32 ndf;
-	u32 freq;
-	u8 spi_frf;
-};
-
-struct dw_spi_enh_cfg {
-	u8 wait_c;
-	u8 inst_l;
-	u8 addr_l;
-	u8 trans_t;
-};
-
 struct dw_spi;
 struct dw_spi_dma_ops {
 	int (*dma_init)(struct device *dev, struct dw_spi *dws);
@@ -345,8 +329,6 @@ static inline void dw_spi_shutdown_chip(struct dw_spi *dws)
 }
 
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
-extern void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
-				 struct dw_spi_cfg *cfg, struct dw_spi_enh_cfg *enh_cfg);
 extern int dw_spi_check_status(struct dw_spi *dws, bool raw);
 extern int dw_spi_add_controller(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_controller(struct dw_spi *dws);
-- 
2.53.0

