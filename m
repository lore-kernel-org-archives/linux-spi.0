Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082821;
	b=G86org0TSFFBfGG8O8YlMMThTOkCfPU4YFVm5wsRbCBS/gScA9Gpf7UiBu0OLnAn29tU
	 xiNIXZMwUbQilaPU7+oKchWGP7Kc1DpJpY2GSB7j4VlVPGhtYfbETXQC/m3FIyF6gNLgd
	 SjDhfovn9Gnj0lna/JT/q6n4B7xJp/P8a3LMdIz4wTIsQehf9OTTk9Ir9pU3FKi5KEiLk
	 gL9QIti9Lz0sHN7nIl1i9MoYqGHgBvAxV3XEipez0+Gj/HCbJCtXW6SzakdGLGXGHSTyI
	 fcyUuQ4agA0x1TcwZHnuzA975Lhwqa0C4N0l7zxGkdX7mxUnRdxvBMn0NbmhldotHpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082821;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OtXGF9BlKZ5sHCvMSC6EBs84mEPf2++AeHUIm7omh54=;
	b=lPVkSwCcDvnJM/X1GeSYBuISvw7/Arlb40UDMWKWQ/wtPd3ulDiAqDWfw4yyKA/ZkvrV
	 V6fg0+tiR/7J2pOhJLEzc49UPABUKfPOqxsa0LH0hIq9BB5dWk7nICVnBesMTotr5cv/R
	 jEaz0KCg0uNTS0fAopcUALo51AkFZJPLke6jeCv8bKWhshIfFi3rsuoTPN3kStFCNyd2k
	 3RPprOU1bKzq4rbvXZj6vJmIYpsOxm1MpKEjlhadkB8NQuNmQBK2ONzFujoz2oZIx+tPk
	 nVHva338IIk4BpAUoeSHm263JlJ7/dVbL7b2vwh9eB5x4nDXqnd7T7LQx86vYoEbk6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=FfFLbc8P;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=LC0Ticl5;
	arc=none smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05069606A325;
	Thu, 19 Nov 2026 10:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05069606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=FfFLbc8P;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=LC0Ticl5
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9QoFu2057589;
	Thu, 19 Nov 2026 02:06:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=OtXGF9BlKZ5sHCvMSC6EBs84mEPf2++AeHUIm7omh54=; b=FfFLbc8PHE32
	YoORRA9DF49xCoEGTkE8ti8qBRmjF/BnDszBuAxjNgOUNIseyn1RCcy83qHryGCh
	apbJsFA8mpWmozCX0/w3JwQIjSAdR844d0zbUUKLcMHZ8wy/DfBPLuThC5rjgbkJ
	4jITdub8pHTrmuPGKuDzMdS1Y6VP54QojHFudnf0A//JQsVpAT2hPaGY0VRHChGz
	QUk78UnTitSavrrCCtQK/cksP32+w3qFnwx/8UA2o7sy6kBVKMwj7xjjRDd9MAec
	HE+6omKlITIVr9OYtrq8lDBxIHc90Oo8z2AaNyWcri1k0A0jBVHD2NNgAqGRLdEe
	E3WNY3U+xw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4j1ny430ne-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1795082810; bh=Zuhrgxpzr8nkOfURF7YSfnVNTf0OXw1KB7z+8X46ask=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LC0Ticl508g+u5voxKd3WoNNx4fXAleXtyESI8vXqpRLDH0CNaG3mQkCBKX2ryrzn
	 QY/5P1EmPqbIgWlmla9nuWbFoptp0hC9F7HVg1rJqF1r4RRMh8HRXF/SZqtAxSvUKb
	 jqbmP07cehAbYrTar6O2zaH/8yd/+OleOi+t5sYsN6eHZT0ftgG81e0ol99IMMZL1a
	 vQVHZoIm3C6YZ0vF0mvX93nYlKZAXCbum65kvzhfHQ3vfrYHpdMjQvNvhBGCp3mLtd
	 4q5yHuNHM2nx0ODXoDomAMsnG2EPskZ3EmZ3KhNPIL7ORyw/FEPjwnD4xTF8EYUsnI
	 ZK1HVc39UUuFA==
Received: from mailhost.synopsys.com (eudc-mailhost1.synopsys.com [10.213.161.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E5916401DC;
	Thu, 19 Nov 2026 10:06:49 +0000 (UTC)
Received: from prakriti-VM.internal.synopsys.com (unknown [10.150.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id 29CDBC0055;
	Thu, 19 Nov 2026 10:06:44 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: [PATCH 6/6] spi: dw-g2: Add XIP support
Date: Thu, 19 Nov 2026 15:35:13 +0530
Message-Id: <20261119100513.433044-7-prakriti@synopsys.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119100513.433044-1-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6afeca3b cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=jIQo8A4GAAAA:8 a=fvUquo0nGaCn0pyfim4A:9 a=hsPEK36a80pXNLzQ:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX1ysXL7HpoMOh
 3Mc5ry6nYUga+r9lnOZN6ngS78W80RrdWSw5GOGPo39uxaUuw8nQuMjlhRghlXt0LOkijgLDOdW
 QoG+yls15bnoPwfKV6LJBI7umnEZJILN7zJfnPS3P2xZxWFXqld/HPcFCR9zT6w9wE1FJPwsrSj
 b7boF0T5X1qUmmisCkFRfJttCtwG3ooov3Qp56zm564HYEnUok7goD+IICxZi9G97dHXkN3d/U7
 3ys2tyMNpMjxKQHWz6vtVLAhUbAD4RrtOz2K8/lYKuQzqaHGRR2QyqsnMkWH97TS9UGBbYKSh/q
 WBhro1dBR5mMUrfuOGvT1uQYP3TFO57vSCB4nhloCpPI7l5Xv7IG2hgrLjAr2mHmTf6+rpmgobJ
 yh8dBlx4mfk5paSGF9WP4aHBii/f8saAPlhXPR7Rdc4pEsG6N95DgdS4Ij5sdg+wDu9ceyD1gEx
 IeqobfObM61JTtzc1og==
X-Proofpoint-ORIG-GUID: OMvtacWxZJuhJyGrvOh8-73A_eS3dRHt
X-Proofpoint-GUID: OMvtacWxZJuhJyGrvOh8-73A_eS3dRHt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX9V6ljHkpV/eK
 DIdPhssA0h0r1Cc1VRgI79wltxeuEPQ48fT5w3G6nZOF+1hDMuc3S4z0wGO/kQchGsURS/5MSTB
 7sPUrpbR5DRkskbtHMrVusK+txzqUfQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611190040

Add memory-mapped execute-in-place through the spi-mem direct-mapping
helpers.

NOR page-program writes stay on the indirect FIFO path. XIP issues a
separate SPI transaction per access, and page program needs one
continuous transaction. Direct mapping can be switched at runtime
through debugfs.

Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>
---
 drivers/spi/spi-dw-g2-core.c | 1074 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi-dw-g2-mmio.c |  263 ++++++++-
 drivers/spi/spi-dw-g2.h      |  166 +++++-
 3 files changed, 1469 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-dw-g2-core.c b/drivers/spi/spi-dw-g2-core.c
index a94d4a7870df..2e265459381d 100644
--- a/drivers/spi/spi-dw-g2-core.c
+++ b/drivers/spi/spi-dw-g2-core.c
@@ -36,8 +36,112 @@ static const struct debugfs_reg32 dw_spi_g2_dbg_regs[] = {
 	DW_SPI_G2_DBG_REG("IMR",            DW_SPI_G2_IMR),
 	DW_SPI_G2_DBG_REG("ISR",            DW_SPI_G2_ISR),
 	DW_SPI_G2_DBG_REG("DEDICATED_CS",   DW_SPI_G2_DEDICATED_CS_EN),
+	DW_SPI_G2_DBG_REG("CS0_RX_SAMPLE_DLY", DW_SPI_G2_RX_SAMPLE_DELAY(0)),
+	DW_SPI_G2_DBG_REG("CS1_RX_SAMPLE_DLY", DW_SPI_G2_RX_SAMPLE_DELAY(1)),
+	DW_SPI_G2_DBG_REG("CS2_RX_SAMPLE_DLY", DW_SPI_G2_RX_SAMPLE_DELAY(2)),
+	DW_SPI_G2_DBG_REG("CS3_RX_SAMPLE_DLY", DW_SPI_G2_RX_SAMPLE_DELAY(3)),
+	DW_SPI_G2_DBG_REG("CS0_DDR_DRV_EDGE",  DW_SPI_G2_DDR_DRIVE_EDGE(0)),
+	DW_SPI_G2_DBG_REG("CS1_DDR_DRV_EDGE",  DW_SPI_G2_DDR_DRIVE_EDGE(1)),
+	DW_SPI_G2_DBG_REG("CS2_DDR_DRV_EDGE",  DW_SPI_G2_DDR_DRIVE_EDGE(2)),
 };
 
+static int xip_mode_get(void *data, u64 *val)
+{
+	struct dw_spi_g2 *dws = data;
+	*val = dws->use_xip ? 1 : 0;
+	return 0;
+}
+
+static int xip_mode_set(void *data, u64 val)
+{
+	struct dw_spi_g2 *dws = data;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val && !dws->xip_mem) {
+		dev_err(dws->dev, "Cannot enable XIP: no memory-mapped region\n");
+		return -EINVAL;
+	}
+
+	dws->use_xip = !!val;
+	dev_info(dws->dev, "Transfer mode set to %s\n",
+		 dws->use_xip ? "XIP (direct)" : "indirect (FIFO)");
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(xip_mode_fops, xip_mode_get, xip_mode_set, "%llu\n");
+
+
+static int xip_continuous_mode_get(void *data, u64 *val)
+{
+	struct dw_spi_g2 *dws = data;
+	*val = dws->xip_continuous_mode ? 1 : 0;
+	return 0;
+}
+
+static int xip_continuous_mode_set(void *data, u64 val)
+{
+	struct dw_spi_g2 *dws = data;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val && !dws->xip_mem) {
+		dev_err(dws->dev,
+			"Cannot enable XIP continuous mode: no XIP region\n");
+		return -EINVAL;
+	}
+
+	dws->xip_continuous_mode = !!val;
+	dev_info(dws->dev, "XIP continuous transfer mode: %s\n",
+		 dws->xip_continuous_mode ? "enabled" : "disabled");
+
+	if (dws->xip_continuous_mode)
+		dev_info(dws->dev,
+			 "Requires flash command supporting continuous read (e.g., 0xEB Quad I/O)\n");
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(xip_continuous_mode_fops, xip_continuous_mode_get,
+			 xip_continuous_mode_set, "%llu\n");
+
+static int xip_prefetch_mode_get(void *data, u64 *val)
+{
+	struct dw_spi_g2 *dws = data;
+	*val = dws->xip_prefetch_mode ? 1 : 0;
+	return 0;
+}
+
+static int xip_prefetch_mode_set(void *data, u64 val)
+{
+	struct dw_spi_g2 *dws = data;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val && !dws->xip_mem) {
+		dev_err(dws->dev,
+			"Cannot enable XIP prefetch mode: no XIP region\n");
+		return -EINVAL;
+	}
+
+	dws->xip_prefetch_mode = !!val;
+	dev_info(dws->dev, "XIP prefetch mode: %s\n",
+		 dws->xip_prefetch_mode ? "enabled" : "disabled");
+
+	if (dws->xip_prefetch_mode)
+		dev_info(dws->dev,
+			 "Requires flash command supporting continuous read (e.g., 0xEB Quad I/O)\n");
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(xip_prefetch_mode_fops, xip_prefetch_mode_get,
+			 xip_prefetch_mode_set, "%llu\n");
+
 /**
  * dw_spi_g2_debugfs_init - Create debugfs entries for register inspection
  * @dws: Driver state
@@ -61,6 +165,11 @@ static void dw_spi_g2_debugfs_init(struct dw_spi_g2 *dws)
 	dws->regset.nregs = ARRAY_SIZE(dw_spi_g2_dbg_regs);
 
 	debugfs_create_regset32("registers", 0400, dws->debugfs, &dws->regset);
+	debugfs_create_file("xip_mode", 0644, dws->debugfs, dws, &xip_mode_fops);
+	debugfs_create_file("xip_continuous_mode", 0644, dws->debugfs, dws,
+			    &xip_continuous_mode_fops);
+	debugfs_create_file("xip_prefetch_mode", 0644, dws->debugfs, dws,
+			    &xip_prefetch_mode_fops);
 }
 
 /**
@@ -152,28 +261,61 @@ int dw_spi_g2_setup(struct spi_device *spi)
 	dw_spi_g2_target_disable(dws, dws->cs);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_BAUDR(dws->cs), baud);
 
+	/* Configure RX sample delay for chip select */
+	if (dws->cs < DW_SPI_G2_MAX_CS) {
+		u32 rx_dly_ns;
+
+		if (device_property_read_u32(&spi->dev, "rx-sample-delay-ns",
+					     &rx_dly_ns))
+			rx_dly_ns = dws->def_rx_sample_dly_ns;
+
+		dws->rx_sample_dly[dws->cs] =
+			DIV_ROUND_CLOSEST(rx_dly_ns,
+					  NSEC_PER_SEC / dws->max_freq);
+	}
+
 	dev_dbg(&spi->dev,
-		"setup: CS=%u mode=%u bpw=%u speed=%u baud=%u\n",
-		dws->cs, spi->mode, spi->bits_per_word, speed, baud);
+		"setup: CS=%u mode=%u bpw=%u speed=%u baud=%u rx_dly=%u\n",
+		dws->cs, spi->mode, spi->bits_per_word, speed, baud,
+		dws->cs < DW_SPI_G2_MAX_CS ? dws->rx_sample_dly[dws->cs] : 0);
 
 	return 0;
 }
 
-static void dw_spi_g2_controller_reset(struct dw_spi_g2 *dws)
+/**
+ * dw_spi_g2_set_sampling_mode - Configure RX sampling mode
+ * @dws: Driver state
+ * @cs: Chip select
+ * @mode: Sampling mode to enable
+ *
+ * RX_DELAY uses RX_SAMPLE_DELAY. DATA_STROBE uses the flash DQS/RXDS
+ * input for DTR transfers. Must be called with SSI disabled.
+ */
+void dw_spi_g2_set_sampling_mode(struct dw_spi_g2 *dws, u8 cs,
+				 enum dw_spi_g2_sampling_mode mode)
 {
-	int drain = 0;
+	u32 ctrlr0, spictrlr0;
 
-	dw_spi_g2_enable(dws, false);
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
-	/* Clear all interrupts by writing 1s to defined ICR bits */
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+	ctrlr0 = dw_spi_g2_readl(dws->regs, DW_SPI_G2_CTRLR0(cs));
+	spictrlr0 = dw_spi_g2_readl(dws->regs, DW_SPI_G2_SPI_CTRLR0(cs));
 
-	/* Drain any stale RX data left from previous transfers */
-	while (dw_spi_g2_readl(dws->regs, DW_SPI_G2_RXFLR) > 0 &&
-	       drain < dws->fifo_len) {
-		(void)dw_spi_g2_readl(dws->regs, DW_SPI_G2_DR0);
-		drain++;
+	switch (mode) {
+	case DW_SPI_G2_SAMPLING_RX_DELAY:
+		/* Disable CLK_LOOP_EN and SPI_RXDS_EN for basic RX_SAMPLE_DELAY */
+		ctrlr0 &= ~DW_SPI_G2_CTRLR0_CLK_LOOP_EN;
+		spictrlr0 &= ~DW_SPI_G2_SPI_CTRLR0_INST_RXDS_EN_MASK;
+		break;
+
+
+	case DW_SPI_G2_SAMPLING_DATA_STROBE:
+		/* Enable SPI_RXDS_EN, disable CLK_LOOP_EN for DQS/strobe mode */
+		ctrlr0 &= ~DW_SPI_G2_CTRLR0_CLK_LOOP_EN;
+		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_INST_RXDS_EN_MASK;
+		break;
 	}
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(cs), ctrlr0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(cs), spictrlr0);
 }
 
 /**
@@ -230,6 +372,30 @@ static u32 dw_spi_g2_build_ctrlr0(struct dw_spi_g2 *dws, u8 tmod, u8 frf)
 	return ctrlr0;
 }
 
+static void dw_spi_g2_controller_reset(struct dw_spi_g2 *dws)
+{
+	int drain = 0;
+
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+
+	/* Drain any stale RX data left from previous transfers */
+	while (dw_spi_g2_readl(dws->regs, DW_SPI_G2_RXFLR) > 0 &&
+	       drain < dws->fifo_len) {
+		(void)dw_spi_g2_readl(dws->regs, DW_SPI_G2_DR0);
+		drain++;
+	}
+
+	/* Update RX sample delay for current CS if value differs. */
+	if (dws->cs < DW_SPI_G2_MAX_CS &&
+	    dws->rx_sample_dly[dws->cs] != dws->cur_rx_sample_dly) {
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_RX_SAMPLE_DELAY(dws->cs),
+				 dws->rx_sample_dly[dws->cs]);
+		dws->cur_rx_sample_dly = dws->rx_sample_dly[dws->cs];
+	}
+}
+
 /**
  * dw_spi_g2_get_frf - Determine frame format from operation bus widths
  * @op: SPI memory operation
@@ -456,16 +622,29 @@ static int dw_spi_g2_cmd_only(struct dw_spi_g2 *dws,
 {
 	u8 buf[8];
 	u32 len;
+	u32 i;
 	int ret;
 
+	dev_dbg(dws->dev, "cmd_only: cmd=0x%02x addr=0x%llx\n",
+		op->cmd.opcode, op->addr.val);
+
 	dw_spi_g2_cmd_only_setup(dws, op);
 
 	len = dw_spi_g2_fill_tx_buf(buf, op, false);
 
-	dw_spi_g2_transfer_begin(dws);
-	ret = dw_spi_g2_xfer_fifo(dws, buf, len, NULL, 0);
+	dw_spi_g2_target_enable(dws, dws->cs);
+	dw_spi_g2_enable(dws, true);
+
+	for (i = 0; i < len; i++)
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, buf[i]);
+
+	dw_spi_g2_cs_assert(dws, dws->cs);
+	dw_spi_g2_wait_idle(dws);
+	ret = 0;
+
 	dw_spi_g2_transfer_end(dws);
 	dw_spi_g2_controller_reset(dws);
+
 	return ret;
 }
 
@@ -629,6 +808,90 @@ static int dw_spi_g2_reg_op(struct dw_spi_g2 *dws, const struct spi_mem_op *op)
 	return ret;
 }
 
+/**
+ * dw_spi_g2_op_freq - Choose the SPI clock frequency for a given op
+ * @dws: Driver state
+ * @op: SPI memory operation
+ *
+ * Prefer op->max_freq. If it is unset, use a conservative fraction of
+ * the controller clock rather than dws->max_freq, which can overclock
+ * a slow flash.
+ *
+ * Return: Frequency in Hz to program into BAUDR.
+ */
+u32 dw_spi_g2_op_freq(struct dw_spi_g2 *dws,
+		      const struct spi_mem_op *op)
+{
+	u32 f = op->max_freq;
+
+	if (!f)
+		f = dws->max_freq / 8;
+
+	return f;
+}
+
+/**
+ * dw_spi_g2_program_baudr - Program per-CS BAUDR for a given target freq
+ * @dws: Driver state
+ * @freq: Target SPI clock frequency in Hz
+ *
+ * SCKDV must be even (or 1 for passthrough). Must be called with SSI
+ * disabled. If @freq is 0, fall back to a conservative fraction of the
+ * controller clock. No-op if no valid frequency is available or the
+ * active CS is out of range.
+ */
+void dw_spi_g2_program_baudr(struct dw_spi_g2 *dws, u32 freq)
+{
+	u32 div, baud;
+
+	if (dws->cs >= DW_SPI_G2_MAX_CS)
+		return;
+
+	if (!freq)
+		freq = dws->max_freq / 8;
+	if (!freq)
+		return;
+
+	div = DIV_ROUND_UP(dws->clk_rate, freq);
+	if (div <= 1) {
+		baud = 1;	/* Passthrough mode */
+	} else {
+		if (div & 1)
+			div++;	/* SCKDV must be even */
+		baud = div;
+	}
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_BAUDR(dws->cs), baud);
+}
+
+/**
+ * dw_spi_g2_update_ddr_drive_edge - Program per-CS DDR transmit drive edge
+ * @dws: Driver state
+ * @op: SPI memory operation (must have a DDR/DTR phase)
+ *
+ * At BAUDR 1 or 2 the drive edge is set for edge-aligned data so the TX
+ * delay line can centre the clock; at higher divisors the register returns
+ * to 0 (edge-aligned with sclk_out, default DDR behaviour).
+ */
+static void dw_spi_g2_update_ddr_drive_edge(struct dw_spi_g2 *dws,
+					    const struct spi_mem_op *op)
+{
+	u32 baud;
+
+	if (!op->cmd.dtr && !op->addr.dtr && !op->data.dtr)
+		return;
+
+	if (dws->cs >= DW_SPI_G2_MAX_CS)
+		return;
+
+	baud = dw_spi_g2_readl(dws->regs, DW_SPI_G2_BAUDR(dws->cs)) & 0xFF;
+	if (!baud)
+		baud = 1;
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DDR_DRIVE_EDGE(dws->cs),
+			 (baud <= 2) ? 1 : 0);
+}
+
 /**
  * Indirect read operations
  */
@@ -658,6 +921,12 @@ static int dw_spi_g2_indirect_read_setup(struct dw_spi_g2 *dws,
 			return -EINVAL;
 		}
 		dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
+		/*
+		 * In DTR mode two bits are clocked per cycle, so the dummy
+		 * phase needs half as many controller cycles as in SDR mode.
+		 */
+		if (op->data.dtr && dummy_cycles)
+			dummy_cycles /= 2;
 		if (dummy_cycles > DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX) {
 			dev_err(dws->dev, "Dummy cycles %u exceed maximum %u\n",
 				dummy_cycles, DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX);
@@ -693,11 +962,25 @@ static int dw_spi_g2_indirect_read_setup(struct dw_spi_g2 *dws,
 		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_INST_DDR_EN_MASK;
 	if (op->addr.dtr || op->data.dtr)
 		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_DDR_EN_MASK;
-	if (op->data.dtr)
-		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_INST_RXDS_EN_MASK;
 
+	/*
+	 * DTR mode with data strobe: set RXDS_EN and enforce mutual
+	 * exclusivity with the RX-delay sampling mode.
+	 */
+	if (op->data.dtr) {
+		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_INST_RXDS_EN_MASK;
+		dw_spi_g2_set_sampling_mode(dws, dws->cs,
+					    DW_SPI_G2_SAMPLING_DATA_STROBE);
+	} else {
+		dw_spi_g2_set_sampling_mode(dws, dws->cs,
+					    DW_SPI_G2_SAMPLING_RX_DELAY);
+	}
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), spictrlr0);
 
+	/* Per-op BAUDR: tuned ops use op->max_freq, others cap to safe rate */
+	dw_spi_g2_program_baudr(dws, dw_spi_g2_op_freq(dws, op));
+	dw_spi_g2_update_ddr_drive_edge(dws, op);
+
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR,
 			 min_t(u32, (dws->fifo_len / 2) - 1,
@@ -823,9 +1106,25 @@ static void dw_spi_g2_indirect_write_setup(struct dw_spi_g2 *dws,
 	if (op->addr.dtr || op->data.dtr)
 		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_DDR_EN_MASK;
 
+	/*
+	 * For writes, sampling mode is less critical but enforce
+	 * mutual exclusivity for consistency with read path.
+	 */
+	if (op->data.dtr) {
+		dw_spi_g2_set_sampling_mode(dws, dws->cs,
+					    DW_SPI_G2_SAMPLING_DATA_STROBE);
+	} else {
+		dw_spi_g2_set_sampling_mode(dws, dws->cs,
+					    DW_SPI_G2_SAMPLING_RX_DELAY);
+	}
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), spictrlr0);
+
+	/* Per-op BAUDR: tuned ops use op->max_freq, others cap to safe rate */
+	dw_spi_g2_program_baudr(dws, dw_spi_g2_op_freq(dws, op));
+	dw_spi_g2_update_ddr_drive_edge(dws, op);
+
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR, 0);
 }
@@ -893,6 +1192,679 @@ static int dw_spi_g2_indirect_write(struct dw_spi_g2 *dws,
 	return ret;
 }
 
+/*
+ * ========================================================================
+ * XIP (Direct Mapping) Support
+ * ========================================================================
+ */
+
+/**
+ * dw_spi_g2_xip_setup - Configure XIP mode for direct memory access
+ * @dws: Driver state
+ * @op: SPI memory operation template
+ * @is_write: true for write operations, false for read operations
+ *
+ * Configures the XIP registers to enable direct memory-mapped access.
+ * This allows CPU to read/write flash directly via memory bus without
+ * going through the SPI controller's data registers.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int dw_spi_g2_xip_setup(struct dw_spi_g2 *dws,
+			       const struct spi_mem_op *op,
+			       bool is_write)
+{
+	u32 xip_ctrl = 0;
+	u32 dummy_cycles = 0;
+	int tt;
+
+	if (!dws->xip_mem) {
+		dev_err(dws->dev, "XIP memory region not mapped\n");
+		return -EINVAL;
+	}
+
+	tt = dw_spi_g2_get_tt(op);
+	if (tt < 0) {
+		dev_err(dws->dev, "Unsupported XIP transfer type\n");
+		return tt;
+	}
+
+	if (op->dummy.nbytes) {
+		if (!op->dummy.buswidth || op->dummy.buswidth > 8)
+			return -EINVAL;
+		dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
+		/*
+		 * In DTR mode two bits are clocked per cycle, so the dummy
+		 * phase needs half as many controller cycles as in SDR mode.
+		 */
+		if (op->data.dtr && dummy_cycles)
+			dummy_cycles /= 2;
+		if (dummy_cycles > DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX)
+			return -EINVAL;
+	}
+
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	if (!is_write) {
+		/* Configure XIP read control */
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_CTRL_FRF_MASK,
+				       dw_spi_g2_get_frf(op));
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_CTRL_TRANS_TYPE_MASK, tt);
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_CTRL_ADDR_L_MASK,
+				       dw_spi_g2_addr_len(op->addr.nbytes));
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_CTRL_INST_L_MASK,
+				       dw_spi_g2_inst_len(op->cmd.nbytes));
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_CTRL_WAIT_CYCLES_MASK,
+				       dummy_cycles);
+		/*
+		 * DFS_HC (Data Frame Size - Hardware Controlled): let the
+		 * XIP engine derive the frame size from the AHB transaction
+		 * width instead of CTRLR0.DFS. With DFS_HC cleared the
+		 * engine uses CTRLR0.DFS (which is 8, since
+		 * ctlr->bits_per_word_mask = SPI_BPW_MASK(8)) and packs
+		 * each AHB beat MSB-byte-first on the wire, which the
+		 * little-endian AXI wrapper stores byte-reversed in memory
+		 * (per-32-bit-word byte-swap on dirmap reads). Mirrors the
+		 * XIP_WR_CTRL_DFS_HC bit already set on the write path.
+		 */
+		xip_ctrl |= DW_SPI_G2_XIP_CTRL_DFS_HC;
+
+		if (op->data.dtr) {
+			xip_ctrl |= DW_SPI_G2_XIP_CTRL_DDR_EN;
+			xip_ctrl |= DW_SPI_G2_XIP_CTRL_RXDS_EN;
+			dw_spi_g2_set_sampling_mode(dws, dws->cs,
+						    DW_SPI_G2_SAMPLING_DATA_STROBE);
+		} else {
+			dw_spi_g2_set_sampling_mode(dws, dws->cs,
+						    DW_SPI_G2_SAMPLING_RX_DELAY);
+		}
+		if (op->cmd.dtr)
+			xip_ctrl |= DW_SPI_G2_XIP_CTRL_INST_DDR_EN;
+		if (op->cmd.opcode != 0)
+			xip_ctrl |= DW_SPI_G2_XIP_CTRL_INST_EN;
+
+		/* Per-op BAUDR: matched ops at op->max_freq, else safe rate */
+		dw_spi_g2_program_baudr(dws,
+					dw_spi_g2_op_freq(dws, op));
+		dw_spi_g2_update_ddr_drive_edge(dws, op);
+
+		/*
+		 * XIP Performance Optimizations
+		 *
+		 * Continuous Transfer Mode (CONT_XFER_EN):
+		 *   When enabled, the controller omits the command byte on
+		 *   subsequent sequential reads from the same CS.
+		 *
+		 *   Requirements:
+		 *   - Flash must support continuous read mode (e.g., 0xEB Fast
+		 *     Read Quad I/O with mode bits)
+		 *   - Must use consistent command across all accesses
+		 *   - CS must remain asserted between transfers
+		 *
+		 *   The controller automatically re-sends the command when:
+		 *   - CS is de-asserted (chip select change)
+		 *   - Transfer type changes (e.g., switching from quad to single)
+		 *
+		 * Prefetch Mode (PREFETCH_EN):
+		 *   The controller speculatively fetches the next cache line
+		 *   when the current access completes, anticipating sequential
+		 *   reads. This reduces latency for instruction fetches during
+		 *   XIP code execution.
+		 *
+		 *   Best for: Sequential code execution, linear data reads
+		 *
+		 * Both features are disabled by default for maximum flash
+		 * compatibility and can be enabled via module parameters or
+		 * device tree properties.
+		 */
+		if (dws->xip_continuous_mode && op->cmd.opcode != 0) {
+			xip_ctrl |= DW_SPI_G2_XIP_CTRL_CONT_XFER_EN;
+
+			/*
+			 * Program XIP_CNT_TIME_OUT
+			 * In continuous mode, this hclk-cycle timeout deselects
+			 * the target if no AHB request arrives within the
+			 * window. Must be written while SSI is disabled.
+			 */
+			dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_CNT_TIME_OUT,
+					 FIELD_PREP(DW_SPI_G2_XIP_XTOC_MASK,
+						    DW_SPI_G2_XIP_XTOC_DEFAULT));
+		}
+
+		if (dws->xip_prefetch_mode)
+			xip_ctrl |= DW_SPI_G2_XIP_CTRL_PREFETCH_EN;
+
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_CTRL(dws->cs),
+				 xip_ctrl);
+
+		if (op->cmd.opcode != 0) {
+			dw_spi_g2_writel(dws->regs,
+					 DW_SPI_G2_XIP_INCR_INST(dws->cs),
+					 op->cmd.opcode);
+			dw_spi_g2_writel(dws->regs,
+					 DW_SPI_G2_XIP_WRAP_INST(dws->cs),
+					 op->cmd.opcode);
+		}
+	} else {
+		/* Configure XIP write control */
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_WR_CTRL_FRF_MASK,
+				       dw_spi_g2_get_frf(op));
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_WR_CTRL_TRANS_TYPE_MASK, tt);
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_WR_CTRL_ADDR_L_MASK,
+				       dw_spi_g2_addr_len(op->addr.nbytes));
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_WR_CTRL_INST_L_MASK,
+				       dw_spi_g2_inst_len(op->cmd.nbytes));
+		xip_ctrl |= FIELD_PREP(DW_SPI_G2_XIP_WR_CTRL_WAIT_CYCLES_MASK,
+				       dummy_cycles);
+		xip_ctrl |= DW_SPI_G2_XIP_WR_CTRL_DFS_HC;
+
+		if (op->data.dtr) {
+			xip_ctrl |= DW_SPI_G2_XIP_WR_CTRL_DDR_EN;
+			dw_spi_g2_set_sampling_mode(dws, dws->cs,
+						    DW_SPI_G2_SAMPLING_DATA_STROBE);
+		} else {
+			dw_spi_g2_set_sampling_mode(dws, dws->cs,
+						    DW_SPI_G2_SAMPLING_RX_DELAY);
+		}
+		if (op->cmd.dtr)
+			xip_ctrl |= DW_SPI_G2_XIP_WR_CTRL_INST_DDR_EN;
+
+		/* Per-op BAUDR: matched ops at op->max_freq, else safe rate */
+		dw_spi_g2_program_baudr(dws,
+					dw_spi_g2_op_freq(dws, op));
+		dw_spi_g2_update_ddr_drive_edge(dws, op);
+
+		dw_spi_g2_writel(dws->regs,
+				 DW_SPI_G2_XIP_WRITE_CTRL(dws->cs),
+				 xip_ctrl);
+
+		if (op->cmd.opcode != 0) {
+			dw_spi_g2_writel(dws->regs,
+					 DW_SPI_G2_XIP_WRITE_INCR_INST(dws->cs),
+					 op->cmd.opcode);
+			dw_spi_g2_writel(dws->regs,
+					 DW_SPI_G2_XIP_WRITE_WRAP_INST(dws->cs),
+					 op->cmd.opcode);
+		}
+	}
+
+	dw_spi_g2_target_enable(dws, dws->cs);
+
+	dev_dbg(dws->dev, "xip_setup: %s cmd=0x%02x addr_bytes=%u dummy=%u cs=%u\n",
+		is_write ? "WRITE" : "READ",
+		op->cmd.opcode, op->addr.nbytes, dummy_cycles, dws->cs);
+
+	return 0;
+}
+
+/**
+ * dw_spi_g2_dirmap_create - Create a direct mapping for XIP access
+ * @desc: Direct mapping descriptor
+ *
+ * Sets up XIP mode configuration for the specified operation template.
+ * The actual memory mapping is expected to be set up by the platform driver.
+ *
+ * This configures both CTRLR0 (for data frame size and SPI mode) and the
+ * XIP-specific registers (for command, address, and transfer type).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int dw_spi_g2_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct spi_device *spi = desc->mem->spi;
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(spi->controller);
+	const struct spi_mem_op *op = desc->info.op_tmpl;
+	u32 ctrlr0;
+	int ret;
+
+	if (!dws->xip_mem) {
+		dev_dbg(dws->dev, "XIP memory region not available\n");
+		return -EOPNOTSUPP;
+	}
+
+	dev_dbg(dws->dev, "dirmap_create: cmd=0x%02x addr_width=%u dir=%s dummy=%u\n",
+		op->cmd.opcode, op->addr.nbytes,
+		op->data.dir == SPI_MEM_DATA_IN ? "READ" : "WRITE",
+		op->dummy.nbytes);
+
+	dws->cs = spi_get_chipselect(spi, 0);
+	dws->curr_spi = spi;
+
+	/*
+	 * Configure CTRLR0 with data frame size and SPI mode settings.
+	 * XIP mode uses these settings for all memory-mapped accesses.
+	 */
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	ctrlr0 = dw_spi_g2_build_ctrlr0(dws, DW_SPI_G2_CTRLR0_TMOD_TR,
+					DW_SPI_G2_FRF_STANDARD);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+
+	/* Configure XIP registers for read/write operations */
+	ret = dw_spi_g2_xip_setup(dws, op,
+				  op->data.dir == SPI_MEM_DATA_OUT);
+	/*
+	 * xip_setup enables the target (sets BIT(cs) in
+	 * DEDICATED_CS_EN) to program per-CS registers.
+	 * Clean it up so stale bits don't leak into
+	 * cmd_only / reg_op operations on other CS lines.
+	 * dirmap_read/write will re-enable when needed.
+	 */
+	dw_spi_g2_target_disable(dws, dws->cs);
+	return ret;
+}
+
+/**
+ * dw_spi_g2_dirmap_read - Direct memory-mapped read from flash
+ * @desc: Direct mapping descriptor
+ * @offs: Offset within the mapped region
+ * @len: Number of bytes to read
+ * @buf: Destination buffer
+ *
+ * Performs direct memory-mapped read using XIP mode. The controller
+ * automatically sends the configured command and address for each access.
+ * Supports 8/16/32-bit data frame sizes for optimal performance.
+ *
+ * Return: Number of bytes read on success, negative error code on failure
+ */
+ssize_t dw_spi_g2_dirmap_read(struct spi_mem_dirmap_desc *desc,
+			      u64 offs, size_t len, void *buf)
+{
+	struct spi_device *spi = desc->mem->spi;
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(spi->controller);
+	void __iomem *src;
+	u32 ctrlr0;
+
+	dws->cs = spi_get_chipselect(spi, 0);
+	dws->curr_spi = spi;
+
+	if (!dws->use_xip) {
+		struct spi_mem_op op = *desc->info.op_tmpl;
+		size_t chunk, done = 0;
+		unsigned int dummy_shift = 0;
+		int ret;
+
+		/* Clear XIP registers so they don't interfere with RO mode */
+		dw_spi_g2_enable(dws, false);
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_SER, 0);
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_WR_SER, 0);
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_CTRL(dws->cs), 0);
+
+		/*
+		 * Fold dummy bytes into the address field.
+		 *
+		 * To handle WAIT_CYCLES in RO mode --
+		 * the RX FIFO stays empty when WAIT_CYCLES > 0.  Work around
+		 * this by absorbing the dummy phase into the address: shift the
+		 * real address left by (dummy_nbytes * 8) bits and zero-pad.
+		 * This makes WAIT_CYCLES=0 while the flash still receives the
+		 * correct number of clock cycles before data.
+		 *
+		 * With TT1 (1-1-x), both address and folded-dummy bits travel
+		 * on the standard single lane, so the flash sees:
+		 *   [real addr MSB..LSB] [zero-pad dummy clocks] [data on x lanes]
+		 */
+		if (op.dummy.nbytes) {
+			dummy_shift = op.dummy.nbytes * 8;
+			op.addr.nbytes += op.dummy.nbytes;
+			op.dummy.nbytes = 0;
+		}
+
+		while (done < len) {
+			chunk = min_t(size_t, len - done, dws->fifo_len);
+
+			op.addr.val = (u64)(offs + done) << dummy_shift;
+			op.data.nbytes = chunk;
+			op.data.buf.in = (u8 *)buf + done;
+
+			ret = dw_spi_g2_indirect_read(dws, &op);
+			if (ret)
+				return ret;
+
+			done += chunk;
+		}
+
+		return (ssize_t)len;
+	}
+
+	if (!dws->xip_mem)
+		return -EOPNOTSUPP;
+
+	if (offs + len > dws->xip_len)
+		return -EINVAL;
+
+	/*
+	 * Restore full XIP register state. An indirect transfer (from a
+	 * prior mode switch) may have left CTRLR0 in TMOD_RO/TO and
+	 * SPI_CTRLR0 with non-XIP framing, which corrupts XIP accesses.
+	 */
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+	ctrlr0 = dw_spi_g2_build_ctrlr0(dws, DW_SPI_G2_CTRLR0_TMOD_TR,
+					DW_SPI_G2_FRF_STANDARD);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
+	dw_spi_g2_xip_setup(dws, desc->info.op_tmpl, false);
+
+	src = dws->xip_mem + offs;
+
+	/* Enable XIP mode for read */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_SER, BIT(dws->cs));
+	dw_spi_g2_enable(dws, true);
+
+	/*
+	 * PIO read from XIP window. The XIP engine turns each AHB read
+	 * into a (cmd + addr + dummy + data) SPI transaction.
+	 */
+	memcpy_fromio(buf, src, len);
+
+	/* Disable XIP mode and clean up DEDICATED_CS_EN */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_SER, 0);
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	return (ssize_t)len;
+}
+
+/**
+ * dw_spi_g2_dirmap_write_nor_xip - byte-by-byte NOR XIP write hack
+ * @dws:  driver state
+ * @desc: dirmap descriptor (XIP write template lives in info.op_tmpl)
+ * @offs: byte offset inside the flash
+ * @len:  byte count to program
+ * @buf:  data to program
+ *
+ * Single-byte XIP write protocol: for every byte we issue WREN
+ * out-of-band, arm the XIP write engine, do exactly one writeb() into
+ * the XIP window (the engine emits one cmd+addr+1-data Page Program),
+ * then poll SR1 until WIP clears.
+ *
+ * Functionally correct but ~3 SPI transactions per byte, so dramatically
+ * slower than the indirect-FIFO path (one cmd+addr+up-to-256 Page Program
+ * per call). It is selected automatically whenever XIP is enabled on the
+ * controller (dws->use_xip && dws->xip_mem != NULL), so any NOR write
+ * issued through dirmap_write() exercises the XIP-write engine end-to-end.
+ */
+static ssize_t dw_spi_g2_dirmap_write_nor_xip(struct dw_spi_g2 *dws,
+					      struct spi_mem_dirmap_desc *desc,
+					      u64 offs, size_t len,
+					      const void *buf)
+{
+	const struct spi_mem_op wren_op = SPI_MEM_OP(SPI_MEM_OP_CMD(DW_SPI_G2_NOR_OP_WREN, 1),
+						     SPI_MEM_OP_NO_ADDR,
+						     SPI_MEM_OP_NO_DUMMY,
+						     SPI_MEM_OP_NO_DATA);
+	const u8 *src = buf;
+	void __iomem *dst;
+	ssize_t result;
+	u32 ctrlr0;
+	u8 sr1;
+	size_t i;
+	int ret;
+
+	if (!dws->xip_mem)
+		return -EOPNOTSUPP;
+
+	if (len > dws->xip_len || offs > dws->xip_len - len)
+		return -EINVAL;
+
+	dst = dws->xip_mem + offs;
+
+	dev_dbg(dws->dev,
+		"dirmap_write_nor_xip: BEGIN offs=0x%llx len=%zu (byte-by-byte WREN/WIP)\n",
+		(unsigned long long)offs, len);
+
+	for (i = 0; i < len; i++) {
+		const struct spi_mem_op rdsr_op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(DW_SPI_G2_NOR_OP_RDSR1, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, &sr1, 1));
+		unsigned long deadline;
+
+		dev_dbg(dws->dev,
+			"dirmap_write_nor_xip: byte %zu/%zu @ +0x%zx\n",
+			i + 1, len, (size_t)offs + i);
+
+		/* WREN: latch the write-enable bit so the next Page Program is accepted. */
+		ret = dw_spi_g2_cmd_only(dws, &wren_op);
+		if (ret) {
+			dev_err(dws->dev,
+				"XIP NOR write: WREN failed at byte %zu: %d\n",
+				i, ret);
+			result = ret;
+			goto out_unwind;
+		}
+
+		dw_spi_g2_enable(dws, false);
+		dw_spi_g2_target_disable(dws, dws->cs);
+
+		ctrlr0 = dw_spi_g2_build_ctrlr0(dws,
+						DW_SPI_G2_CTRLR0_TMOD_TR,
+						DW_SPI_G2_FRF_STANDARD);
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs),
+				 ctrlr0);
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), 0);
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
+		dw_spi_g2_xip_setup(dws, desc->info.op_tmpl, true);
+
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_WR_SER,
+				 BIT(dws->cs));
+		dw_spi_g2_enable(dws, true);
+
+		writeb(src[i], dst + i);
+
+		dw_spi_g2_wait_idle(dws);
+
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_WR_SER, 0);
+		dw_spi_g2_enable(dws, false);
+		dw_spi_g2_target_disable(dws, dws->cs);
+
+		/* WIP poll: spin on SR1.WIP until the program completes. */
+		sr1 = 0;
+		deadline = jiffies +
+			   msecs_to_jiffies(DW_SPI_G2_NOR_WIP_TIMEOUT_MS);
+		do {
+			ret = dw_spi_g2_reg_op(dws, &rdsr_op);
+			if (ret) {
+				dev_err(dws->dev,
+					"XIP NOR write: WIP poll failed at byte %zu: %d\n",
+					i, ret);
+				result = ret;
+				goto out_unwind;
+			}
+			if (!(sr1 & DW_SPI_G2_NOR_SR1_WIP))
+				break;
+			if (time_after(jiffies, deadline)) {
+				dev_err(dws->dev,
+					"XIP NOR write: WIP timeout at byte %zu\n",
+					i);
+				result = -ETIMEDOUT;
+				goto out_unwind;
+			}
+			udelay(1);
+		} while (1);
+	}
+
+	dev_dbg(dws->dev,
+		"dirmap_write_nor_xip: END   offs=0x%llx len=%zu OK\n",
+		(unsigned long long)offs, len);
+
+	return (ssize_t)len;
+
+out_unwind:
+	/*
+	 * On any error mid-loop the XIP-write engine may be left armed
+	 * (XIP_WR_SER set, SSI enabled). Tear it down so the next op sees
+	 * a clean controller state regardless of where the failure landed.
+	 */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_WR_SER, 0);
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+	return result;
+}
+
+/**
+ * dw_spi_g2_dirmap_write - Direct memory-mapped write to flash
+ * @desc: Direct mapping descriptor
+ * @offs: Offset within the mapped region
+ * @len: Number of bytes to write
+ * @buf: Source buffer
+ *
+ * Performs direct memory-mapped write using XIP mode. The controller
+ * automatically sends the configured command and address for each access.
+ * Supports 8/16/32-bit data frame sizes for optimal performance.
+ *
+ * Routing rules:
+ *   - NAND Program Load (addr_nbytes == 2): XIP burst path, pushed as a
+ *     writeb() loop. The on-die page buffer auto-increments the column
+ *     counter on each transaction; the per-byte writeb() pace is required
+ *     because this controller's XIP-write engine only emits the first
+ *     byte of each multi-beat AHB store, so any wider PIO/DMA write
+ *     would corrupt the payload past the first byte of each beat.
+ *   - NOR Page Program (addr_nbytes >= 3) with XIP enabled: byte-by-byte
+ *     XIP-write helper (dw_spi_g2_dirmap_write_nor_xip). The
+ *     XIP_WRITE_CTRL register has no auto-WREN bit, so a bursted XIP
+ *     write to NOR would drop everything past the first transaction
+ *     (write-enable cleared). Doing one WREN + 1-byte XIP store + WIP poll per byte
+ *     is slow but functional.
+ *   - NOR Page Program (addr_nbytes >= 3) with XIP disabled: indirect
+ *     FIFO path. Builds one cmd+addr+up-to-256-data SPI transaction in
+ *     software; correct and dramatically faster than the XIP-write
+ *     helper, used as a fallback when no XIP region is mapped.
+ *
+ * Return: Number of bytes written on success, negative error code on failure
+ */
+ssize_t dw_spi_g2_dirmap_write(struct spi_mem_dirmap_desc *desc,
+			       u64 offs, size_t len, const void *buf)
+{
+	struct spi_device *spi = desc->mem->spi;
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(spi->controller);
+	void __iomem *dst;
+	u32 ctrlr0;
+	bool use_indirect = false;
+
+	dws->cs = spi_get_chipselect(spi, 0);
+	dws->curr_spi = spi;
+
+	/*
+	 * NOR Page Program (addr_nbytes >= 3) cannot ride the XIP-write
+	 * engine in burst mode -- the engine emits one cmd+addr+data SPI
+	 * transaction per AHB write but the SPI-NOR framework only issues
+	 * WREN once before dirmap_write(), so every transaction past the
+	 * first arrives with write-enable cleared and is silently dropped.
+	 * NAND Program Load (addr_nbytes == 2) is XIP-friendly because the
+	 * on-die page buffer has no per-byte write-enable gating, so it goes
+	 * to the NAND-XIP-BURST path below.
+	 */
+	if (!dws->use_xip || desc->info.op_tmpl->addr.nbytes >= 3)
+		use_indirect = true;
+
+	/*
+	 * NOR with XIP enabled: route through the byte-by-byte XIP-write
+	 * helper so the XIP-write engine is exercised end-to-end.
+	 */
+	if (use_indirect && dws->use_xip && dws->xip_mem &&
+	    desc->info.op_tmpl->addr.nbytes >= 3) {
+		dev_info(dws->dev,
+			 "dirmap_write: ROUTE=NOR-XIP cmd=0x%02x offs=0x%llx len=%zu\n",
+			 desc->info.op_tmpl->cmd.opcode,
+			 (unsigned long long)offs, len);
+		return dw_spi_g2_dirmap_write_nor_xip(dws, desc, offs, len,
+						      buf);
+	}
+
+	if (use_indirect) {
+		struct spi_mem_op op = *desc->info.op_tmpl;
+		int ret;
+
+		dev_info(dws->dev,
+			 "dirmap_write: ROUTE=NOR-INDIRECT-FIFO cmd=0x%02x offs=0x%llx len=%zu\n",
+			 op.cmd.opcode, (unsigned long long)offs, len);
+
+		/*
+		 * dirmap_create configured XIP_WRITE_CTRL with opcode,
+		 * address length, etc.  These non-zero values can cause
+		 * the controller to misinterpret a plain FIFO (TO-mode)
+		 * write.  Zero the XIP write registers so the indirect
+		 * path behaves identically to exec_mem_op.
+		 */
+		dw_spi_g2_enable(dws, false);
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_WR_SER, 0);
+		dw_spi_g2_writel(dws->regs,
+				 DW_SPI_G2_XIP_WRITE_CTRL(dws->cs), 0);
+
+		op.addr.val = offs;
+		op.data.nbytes = len;
+		op.data.buf.out = buf;
+
+		ret = dw_spi_g2_indirect_write(dws, &op);
+		return ret ? ret : (ssize_t)len;
+	}
+
+	/* XIP write path — only reached for NAND Program Load */
+	if (!dws->xip_mem)
+		return -EOPNOTSUPP;
+
+	if (offs + len > dws->xip_len)
+		return -EINVAL;
+
+	dev_info(dws->dev,
+		 "dirmap_write: ROUTE=NAND-XIP cmd=0x%02x offs=0x%llx len=%zu\n",
+		 desc->info.op_tmpl->cmd.opcode,
+		 (unsigned long long)offs, len);
+
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+	ctrlr0 = dw_spi_g2_build_ctrlr0(dws, DW_SPI_G2_CTRLR0_TMOD_TR,
+					DW_SPI_G2_FRF_STANDARD);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
+	dw_spi_g2_xip_setup(dws, desc->info.op_tmpl, true);
+
+	dst = dws->xip_mem + offs;
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_WR_SER, BIT(dws->cs));
+	dw_spi_g2_enable(dws, true);
+
+	/*
+	 * PIO write into the XIP window. The XIP engine turns every AHB
+	 * write into one (cmd + addr + data) SPI transaction, but on
+	 * this controller only the first byte of each AHB beat is shifted
+	 * out to the flash -- a multi-byte AHB store (writel/writeq, as
+	 * memcpy_toio() emits on arm64 with the MMU on) drops every byte
+	 * past the first. The corruption pattern in flash is unmistakable:
+	 *   buf[0..7]   = 00 01 02 03 04 05 06 07
+	 *   flash[0..7] = 00 04 ff ff ff ff ff ff   <- only +0 and +4 land
+	 * confirming two 32-bit AHB beats per writeq, each beat emitting
+	 * only its low byte. We must therefore push the payload as a
+	 * writeb() loop so every byte is its own AHB beat -> its own SPI
+	 * Program-Load transaction. The on-die NAND page buffer
+	 * auto-increments its column counter on each transaction, so the
+	 * full page lands correctly.
+	 */
+	{
+		const u8 *src = buf;
+		size_t i;
+
+		for (i = 0; i < len; i++)
+			writeb(src[i], dst + i);
+	}
+
+	dw_spi_g2_wait_idle(dws);
+
+	/* Disable XIP WR mode and clean up DEDICATED_CS_EN */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_XIP_WR_SER, 0);
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	return (ssize_t)len;
+}
+
 /*
  * ========================================================================
  * SPI-MEM interface
@@ -938,8 +1910,20 @@ static bool dw_spi_g2_supports_mem_ops(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+/*
+ * Controller capabilities advertised to the spi-mem core:
+ *   - .dtr = true: controller can run DTR (octal-DTR / DDR) phases.
+ *   - .per_op_freq = true: dw_spi_g2_program_baudr() reprograms BAUDR
+ *     at the start of every op, so the spi-mem core may set
+ *     op->max_freq below mem->spi->max_speed_hz on a per-op basis
+ *     (e.g. SPI-NAND cache reads capping at ~50-104 MHz, or an
+ *     SFDP-derived per-op cap). Without this flag, spi-mem rejects
+ *     any op where op->max_freq differs from mem->spi->max_speed_hz
+ *     (see spi-mem.c::spi_mem_check_op()).
+ */
 static const struct spi_controller_mem_caps dw_spi_g2_mem_caps = {
 	.dtr = true,
+	.per_op_freq = true,
 };
 
 int dw_spi_g2_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
@@ -989,6 +1973,13 @@ static int dw_spi_g2_exec_mem_op(struct spi_mem *mem,
 			return -EINVAL;
 		}
 		dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
+		/*
+		 * In DTR mode two bits are clocked per cycle, so halve the
+		 * cycle count derived from dummy.nbytes before checking the
+		 * hardware limit.
+		 */
+		if (op->data.dtr && dummy_cycles)
+			dummy_cycles /= 2;
 		if (dummy_cycles > DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX) {
 			dev_err(dws->dev, "dummy cycles %u exceed maximum %u\n",
 				dummy_cycles, DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX);
@@ -1029,6 +2020,9 @@ static const struct spi_controller_mem_ops dw_spi_g2_mem_ops = {
 	.supports_op = dw_spi_g2_supports_mem_ops,
 	.adjust_op_size = dw_spi_g2_adjust_mem_op_size,
 	.exec_op = dw_spi_g2_exec_mem_op,
+	.dirmap_create = dw_spi_g2_dirmap_create,
+	.dirmap_read = dw_spi_g2_dirmap_read,
+	.dirmap_write = dw_spi_g2_dirmap_write,
 };
 
 /*
@@ -1075,15 +2069,7 @@ int dw_spi_g2_init(struct dw_spi_g2 *dws)
 
 	dev_info(dws->dev, "DW SSI G2 core init\n");
 
-	/* Disable controller and reset to clean state */
-	dw_spi_g2_enable(dws, false);
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DEDICATED_CS_EN, 0);
-
-	/* Mask all interrupts — this driver uses polling only */
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_IMR, 0);
-	/* Clear all interrupts by writing 1s to defined ICR bits */
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+	dw_spi_g2_hw_init(dws);
 
 	/* Hardware capabilities */
 	dws->fifo_len = dw_spi_g2_detect_fifo_len(dws);
@@ -1126,6 +2112,42 @@ void dw_spi_g2_deinit(struct dw_spi_g2 *dws)
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_g2_deinit, "SPI_DW_G2_CORE");
 
+/**
+ * dw_spi_g2_hw_init - Re-initialize controller hardware after power-up
+ * @dws: Driver state
+ *
+ * Brings the controller back to a known clean state after clocks are
+ * restored (e.g. resume from suspend). Resets SSI enable, chip selects,
+ * dedicated CS, interrupt mask, and clears any pending interrupts.
+ *
+ * Does NOT reconfigure per-CS transfer registers; those are set up
+ * on-demand by the first spi-mem operation after resume.
+ *
+ * Return: 0 on success
+ */
+int dw_spi_g2_hw_init(struct dw_spi_g2 *dws)
+{
+	u8 cs;
+
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DEDICATED_CS_EN, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_IMR, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+
+	/*
+	 * Set DDR_DRIVE_EDGE for all CS. Value of 1 means data is driven
+	 * on the falling edge of ssi_clk in DDR mode, which aligns the
+	 * output with the sampling window on the flash side.
+	 */
+	for (cs = 0; cs < DW_SPI_G2_MAX_CS; cs++)
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DDR_DRIVE_EDGE(cs), 1);
+
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dw_spi_g2_hw_init, "SPI_DW_G2_CORE");
+
 /*
  * ========================================================================
  * Legacy SPI transfer_one interface (not actively used with spi-mem)
diff --git a/drivers/spi/spi-dw-g2-mmio.c b/drivers/spi/spi-dw-g2-mmio.c
index 6ef8f926e0eb..9620ae6e5c23 100644
--- a/drivers/spi/spi-dw-g2-mmio.c
+++ b/drivers/spi/spi-dw-g2-mmio.c
@@ -11,6 +11,42 @@
 
 #include "spi-dw-g2.h"
 
+/*
+ * Module parameter: select transfer mode at load time.
+ *   1 = XIP (memory-mapped direct access)
+ *   0 = indirect (default, FIFO-based, uses exec_mem_op path)
+ *
+ * Can also be changed at runtime via sysfs:
+ *   /sys/devices/.../xip_mode
+ */
+static int xip_mode;
+module_param(xip_mode, int, 0644);
+MODULE_PARM_DESC(xip_mode, "Transfer mode: 0=indirect (default), 1=XIP");
+
+/*
+ * XIP Performance Optimization Parameters
+ *
+ * xip_continuous_mode / xip_prefetch_mode:
+ *   -1 = auto / use DT property (default; DT also defaults to disabled)
+ *    0 = force disabled (overrides DT)
+ *    1 = force enabled (overrides DT, requires flash support, e.g., 0xEB)
+ *
+ * Both modes default to DISABLED unless explicitly enabled via DT or
+ * module parameter, because they require flash commands that support
+ * continuous read mode. Using them with incompatible commands like 0x6B
+ * (Fast Read Quad Output) causes data corruption.
+ */
+static int xip_continuous_mode = -1;
+module_param(xip_continuous_mode, int, 0644);
+MODULE_PARM_DESC(xip_continuous_mode,
+		 "XIP continuous transfer mode: -1=auto/DT (default), 0=disabled, 1=enabled");
+
+static int xip_prefetch_mode = -1;
+module_param(xip_prefetch_mode, int, 0644);
+MODULE_PARM_DESC(xip_prefetch_mode,
+		 "XIP prefetch mode: -1=auto/DT (default), 0=disabled, 1=enabled");
+
+
 struct dw_spi_g2_mmio {
 	struct dw_spi_g2	dws;
 	struct clk		*clk;
@@ -18,6 +54,119 @@ struct dw_spi_g2_mmio {
 	struct reset_control	*rstc;
 };
 
+static ssize_t xip_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(ctlr);
+
+	return sysfs_emit(buf, "%d\n", dws->use_xip ? 1 : 0);
+}
+
+static ssize_t xip_mode_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(ctlr);
+	int val;
+
+	if (kstrtoint(buf, 0, &val))
+		return -EINVAL;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val && !dws->xip_mem) {
+		dev_err(dev, "Cannot enable XIP: no memory-mapped region available\n");
+		return -EINVAL;
+	}
+
+	dws->use_xip = !!val;
+	dev_info(dev, "Transfer mode set to %s\n",
+		 dws->use_xip ? "XIP (direct)" : "indirect (FIFO)");
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(xip_mode);
+
+static ssize_t xip_continuous_mode_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(ctlr);
+
+	return sysfs_emit(buf, "%d\n", dws->xip_continuous_mode ? 1 : 0);
+}
+
+static ssize_t xip_continuous_mode_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(ctlr);
+	int val;
+
+	if (kstrtoint(buf, 0, &val))
+		return -EINVAL;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val && !dws->xip_mem) {
+		dev_err(dev, "Cannot enable continuous mode: no XIP region\n");
+		return -EINVAL;
+	}
+
+	dws->xip_continuous_mode = !!val;
+	dev_info(dev, "XIP continuous transfer mode: %s\n",
+		 dws->xip_continuous_mode ? "enabled" : "disabled");
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(xip_continuous_mode);
+
+static ssize_t xip_prefetch_mode_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(ctlr);
+
+	return sysfs_emit(buf, "%d\n", dws->xip_prefetch_mode ? 1 : 0);
+}
+
+static ssize_t xip_prefetch_mode_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(ctlr);
+	int val;
+
+	if (kstrtoint(buf, 0, &val))
+		return -EINVAL;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	if (val && !dws->xip_mem) {
+		dev_err(dev, "Cannot enable prefetch: no XIP region\n");
+		return -EINVAL;
+	}
+
+	dws->xip_prefetch_mode = !!val;
+	dev_info(dev, "XIP prefetch mode: %s\n",
+		 dws->xip_prefetch_mode ? "enabled" : "disabled");
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(xip_prefetch_mode);
+
 static int dw_spi_g2_mmio_probe(struct platform_device *pdev)
 {
 	struct dw_spi_g2_mmio *dwsmmio;
@@ -47,6 +196,24 @@ static int dw_spi_g2_mmio_probe(struct platform_device *pdev)
 		goto err_put;
 	}
 
+	/* XIP memory region for direct mapping */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (mem) {
+		dws->xip_mem = devm_ioremap_resource(&pdev->dev, mem);
+		if (IS_ERR(dws->xip_mem)) {
+			dev_warn(&pdev->dev, "Failed to map XIP region, direct mapping disabled\n");
+			dws->xip_mem = NULL;
+		} else {
+			dws->xip_phys = mem->start;
+			dws->xip_len = resource_size(mem);
+			dev_info(&pdev->dev, "XIP region mapped: phys=0x%llx len=0x%zx\n",
+				 (unsigned long long)dws->xip_phys, dws->xip_len);
+		}
+	} else {
+		dws->xip_mem = NULL;
+		dev_dbg(&pdev->dev, "XIP memory region not specified, direct mapping disabled\n");
+	}
+
 	/*
 	 * IRQ.
 	 *
@@ -126,6 +293,74 @@ static int dw_spi_g2_mmio_probe(struct platform_device *pdev)
 	dev_dbg(dws->dev, "HW_CAPS = 0x%08x\n", dws->hw_caps);
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
+
+	/*
+	 * XIP (Direct Mapping) mode configuration.
+	 *
+	 * XIP is enabled ONLY if ALL conditions are met:
+	 *   1. XIP memory region available in DT
+	 *   2. Device tree has snps,xip-enabled property
+	 *   3. Module parameter xip_mode=1 (or runtime sysfs)
+	 *
+	 * This provides safe default (disabled) while allowing controlled enabling.
+	 * Runtime control via sysfs: /sys/devices/.../xip_mode
+	 */
+	bool dt_xip_enabled = device_property_read_bool(&pdev->dev, "snps,xip-enabled");
+	bool param_xip_enabled = xip_mode != 0;
+
+	dws->use_xip = dws->xip_mem && dt_xip_enabled && param_xip_enabled;
+
+	if (dws->xip_mem) {
+		dev_info(&pdev->dev, "XIP mode: %s (DT=%s, param=%s, both required)\n",
+			 dws->use_xip ? "enabled" : "disabled",
+			 dt_xip_enabled ? "yes" : "no",
+			 param_xip_enabled ? "yes" : "no");
+	} else {
+		dev_info(&pdev->dev, "XIP mode: disabled (no memory region in DT)\n");
+	}
+
+	/*
+	 * XIP Performance Optimization Configuration
+	 *
+	 * Both modes default to DISABLED for safety - they require flash
+	 * commands that support continuous read mode (e.g., 0xEB Quad I/O).
+	 * Standard 0x6B (Fast Read Quad Output) does NOT support these
+	 * optimizations and will cause data corruption.
+	 *
+	 * Resolution order (last wins):
+	 *   1. Default: false
+	 *   2. DT property (snps,xip-{continuous,prefetch}-mode) enables
+	 *   3. Module parameter (xip_{continuous,prefetch}_mode) overrides DT
+	 *      Use module param value 0 to force-disable even when DT enables.
+	 *
+	 * Runtime override is also possible via debugfs/sysfs after probe.
+	 */
+	dws->xip_continuous_mode = false;
+	dws->xip_prefetch_mode = false;
+
+	if (dws->xip_mem) {
+		if (device_property_read_bool(&pdev->dev,
+					      "snps,xip-continuous-mode"))
+			dws->xip_continuous_mode = true;
+		if (device_property_read_bool(&pdev->dev,
+					      "snps,xip-prefetch-mode"))
+			dws->xip_prefetch_mode = true;
+
+		/* Module params override DT (>=0 forces explicit value) */
+		if (xip_continuous_mode >= 0)
+			dws->xip_continuous_mode = !!xip_continuous_mode;
+		if (xip_prefetch_mode >= 0)
+			dws->xip_prefetch_mode = !!xip_prefetch_mode;
+
+		dev_info(&pdev->dev, "XIP continuous transfer mode: %s\n",
+			 dws->xip_continuous_mode ? "enabled" : "disabled");
+		dev_info(&pdev->dev, "XIP prefetch mode: %s\n",
+			 dws->xip_prefetch_mode ? "enabled" : "disabled");
+		if (dws->xip_continuous_mode || dws->xip_prefetch_mode)
+			dev_info(&pdev->dev,
+				 "XIP optimizations require flash supporting continuous read (e.g., 0xEB)\n");
+	}
+
 	/* SPI Controller Setup */
 	ctlr->bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
 	if (ctlr->bus_num < 0)
@@ -151,7 +386,29 @@ static int dw_spi_g2_mmio_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pm;
 
-	dev_info(&pdev->dev, "DW SSI G2 MMIO probed\n");
+	ret = device_create_file(&pdev->dev, &dev_attr_xip_mode);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "Failed to create xip_mode sysfs attribute: %d\n",
+			 ret);
+
+	if (dws->xip_mem) {
+		ret = device_create_file(&pdev->dev,
+					 &dev_attr_xip_continuous_mode);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Failed to create xip_continuous_mode sysfs: %d\n",
+				 ret);
+
+		ret = device_create_file(&pdev->dev,
+					 &dev_attr_xip_prefetch_mode);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Failed to create xip_prefetch_mode sysfs: %d\n",
+				 ret);
+	}
+	dev_info(&pdev->dev, "DW SSI G2 MMIO probed (mode=%s)\n",
+		 dws->use_xip ? "XIP" : "indirect");
 	return 0;
 
 err_pm:
@@ -168,10 +425,14 @@ static void dw_spi_g2_mmio_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct dw_spi_g2_mmio *dwsmmio = spi_controller_get_devdata(ctlr);
 
+	device_remove_file(&pdev->dev, &dev_attr_xip_mode);
+	device_remove_file(&pdev->dev, &dev_attr_xip_continuous_mode);
+	device_remove_file(&pdev->dev, &dev_attr_xip_prefetch_mode);
 	spi_unregister_controller(ctlr);
 	dw_spi_g2_deinit(&dwsmmio->dws);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(dwsmmio->rstc);
+	dw_spi_g2_enable(&dwsmmio->dws, false);
 }
 
 static const struct of_device_id dw_spi_g2_of_match[] = {
diff --git a/drivers/spi/spi-dw-g2.h b/drivers/spi/spi-dw-g2.h
index 3091697238d7..162d23390298 100644
--- a/drivers/spi/spi-dw-g2.h
+++ b/drivers/spi/spi-dw-g2.h
@@ -3,12 +3,16 @@
 #ifndef _SPI_DW_G2_H
 #define _SPI_DW_G2_H
 
-#include <linux/spi/spi.h>
-#include <linux/io.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/irqreturn.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/irqreturn.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -24,7 +28,7 @@
 #define DW_SPI_G2_DEDICATED_CS_STRIDE           0x14
 #define DW_SPI_G2_DEDICATED_CS_EN               0x50
 #define DW_SPI_G2_CS_OFFSET(cs) \
-		(DW_SPI_G2_DEDICATED_CS_BASE + (cs) * DW_SPI_G2_DEDICATED_CS_STRIDE)
+	(DW_SPI_G2_DEDICATED_CS_BASE + (cs) * DW_SPI_G2_DEDICATED_CS_STRIDE)
 
 /* Dedicated CS Blocks */
 #define DW_SPI_G2_CTRLR0(cs)            (DW_SPI_G2_CS_OFFSET(cs) + 0x04)
@@ -33,6 +37,84 @@
 #define DW_SPI_G2_CTRLR1(cs)            (DW_SPI_G2_CS_OFFSET(cs) + 0x10)
 #define DW_SPI_G2_SPI_CTRLR1(cs)        (DW_SPI_G2_CS_OFFSET(cs) + 0x14)
 
+/*
+ * XIP (eXecute In Place) registers for direct memory-mapped access
+ */
+#define DW_SPI_G2_XIP_HEADER                    0x124
+#define DW_SPI_G2_XIP_SER                       0x128
+#define DW_SPI_G2_XIP_CNT_TIME_OUT              0x12C
+#define DW_SPI_G2_XIP_WR_SER                    0x134
+
+/*
+ * XIP_CNT_TIME_OUT fields
+ * XTOC[7:0]: timeout in hclk cycles to deselect target in continuous mode
+ *            if no AHB request arrives within this time. Max value 0xFF.
+ */
+#define DW_SPI_G2_XIP_XTOC_MASK                 GENMASK(7, 0)
+#define DW_SPI_G2_XIP_XTOC_DEFAULT              0xFFU
+
+/* Dedicated CS XIP register base offsets (per-CS stride = 0x10) */
+#define DW_SPI_G2_XIP_CTRL_BASE                 0x22C
+#define DW_SPI_G2_XIP_CTRL_STRIDE               0x10
+#define DW_SPI_G2_XIP_CTRL(cs) \
+	(DW_SPI_G2_XIP_CTRL_BASE + (cs) * DW_SPI_G2_XIP_CTRL_STRIDE)
+#define DW_SPI_G2_XIP_MODE_BITS(cs)             (DW_SPI_G2_XIP_CTRL(cs) + 0x04)
+#define DW_SPI_G2_XIP_INCR_INST(cs)             (DW_SPI_G2_XIP_CTRL(cs) + 0x08)
+#define DW_SPI_G2_XIP_WRAP_INST(cs)             (DW_SPI_G2_XIP_CTRL(cs) + 0x0C)
+
+/* XIP Write registers (per-CS stride = 0x0C: 3 regs × 4 bytes) */
+#define DW_SPI_G2_XIP_WR_CTRL_BASE              0x270
+#define DW_SPI_G2_XIP_WR_CTRL_STRIDE            0x0C
+#define DW_SPI_G2_XIP_WRITE_CTRL(cs) \
+	(DW_SPI_G2_XIP_WR_CTRL_BASE + (cs) * DW_SPI_G2_XIP_WR_CTRL_STRIDE)
+#define DW_SPI_G2_XIP_WRITE_INCR_INST(cs)       (DW_SPI_G2_XIP_WRITE_CTRL(cs) + 0x04)
+#define DW_SPI_G2_XIP_WRITE_WRAP_INST(cs)       (DW_SPI_G2_XIP_WRITE_CTRL(cs) + 0x08)
+
+/* XIP_CTRL fields (SSI_CSx_XIP_CTRL register) */
+#define DW_SPI_G2_XIP_CTRL_FRF_MASK             GENMASK(1, 0)
+#define DW_SPI_G2_XIP_CTRL_TRANS_TYPE_MASK      GENMASK(3, 2)
+#define DW_SPI_G2_XIP_CTRL_ADDR_L_MASK          GENMASK(7, 4)
+#define DW_SPI_G2_XIP_CTRL_INST_L_MASK          GENMASK(10, 9)
+#define DW_SPI_G2_XIP_CTRL_MD_BITS_EN           BIT(12)
+#define DW_SPI_G2_XIP_CTRL_WAIT_CYCLES_MASK     GENMASK(17, 13)
+#define DW_SPI_G2_XIP_CTRL_DFS_HC               BIT(18)
+#define DW_SPI_G2_XIP_CTRL_DDR_EN               BIT(19)
+#define DW_SPI_G2_XIP_CTRL_INST_DDR_EN          BIT(20)
+#define DW_SPI_G2_XIP_CTRL_RXDS_EN              BIT(21)
+#define DW_SPI_G2_XIP_CTRL_INST_EN              BIT(22)
+#define DW_SPI_G2_XIP_CTRL_CONT_XFER_EN         BIT(23)
+#define DW_SPI_G2_XIP_CTRL_HYPERBUS_EN          BIT(24)
+#define DW_SPI_G2_XIP_CTRL_RXDS_SIG_EN          BIT(25)
+#define DW_SPI_G2_XIP_CTRL_XIP_MBL_MASK         GENMASK(27, 26)
+#define DW_SPI_G2_XIP_CTRL_PREFETCH_EN          BIT(29)
+#define DW_SPI_G2_XIP_CTRL_RXDS_VL_EN           BIT(30)
+
+/* XIP_WRITE_CTRL fields (SSI_CSx_XIP_WRITE_CTRL register) */
+#define DW_SPI_G2_XIP_WR_CTRL_FRF_MASK          GENMASK(1, 0)
+#define DW_SPI_G2_XIP_WR_CTRL_TRANS_TYPE_MASK   GENMASK(3, 2)
+#define DW_SPI_G2_XIP_WR_CTRL_ADDR_L_MASK       GENMASK(7, 4)
+#define DW_SPI_G2_XIP_WR_CTRL_INST_L_MASK       GENMASK(9, 8)
+#define DW_SPI_G2_XIP_WR_CTRL_DDR_EN            BIT(10)
+#define DW_SPI_G2_XIP_WR_CTRL_INST_DDR_EN       BIT(11)
+#define DW_SPI_G2_XIP_WR_CTRL_HYPERBUS_EN       BIT(12)
+#define DW_SPI_G2_XIP_WR_CTRL_RXDS_SIG_EN       BIT(13)
+#define DW_SPI_G2_XIP_WR_CTRL_DM_EN             BIT(14)
+#define DW_SPI_G2_XIP_WR_CTRL_WAIT_CYCLES_MASK  GENMASK(20, 16)
+#define DW_SPI_G2_XIP_WR_CTRL_DFS_HC            BIT(21)
+
+/*
+ * NOR-XIP-write helper constants (used by dw_spi_g2_dirmap_write_nor_xip())
+ *
+ * The XIP_WRITE_CTRL register has no auto-WREN and no auto-WIP-poll
+ * support, so a NOR Page Program issued through the XIP-write engine
+ * must be wrapped per-byte with WREN + 1-byte XIP store + WIP poll.
+ * These opcodes are JEDEC standard and apply to all SPI-NOR devices.
+ */
+#define DW_SPI_G2_NOR_OP_WREN           0x06    /* Write Enable */
+#define DW_SPI_G2_NOR_OP_RDSR1          0x05    /* Read Status Register 1 */
+#define DW_SPI_G2_NOR_SR1_WIP           BIT(0)  /* Write-In-Progress in SR1 */
+#define DW_SPI_G2_NOR_WIP_TIMEOUT_MS    100     /* WIP poll timeout */
+
 #define DW_SPI_G2_SSIENR                0x4C
 #define DW_SPI_G2_SER                   0x54
 #define DW_SPI_G2_TXFTLR                0x58
@@ -49,6 +131,7 @@
 #define DW_SPI_G2_ICR                   0x7C
 #define DW_SPI_G2_IDR                   0x88
 
+
 /* ISR bit masks (interrupt status) */
 #define DW_SPI_G2_ISR_TXEI              BIT(0)  /* TX FIFO Empty */
 #define DW_SPI_G2_ISR_TXOI              BIT(1)  /* TX FIFO Overflow */
@@ -76,7 +159,32 @@
 /* Clear all writable bits */
 #define DW_SPI_G2_ICR_ALL               0x0003AFFF
 
-#define DW_SPI_G2_RX_SAMPLE_DELAY       0x24
+/*
+ * Per-CS DDR drive edge registers.
+ * Controls which clock edge drives output data in DDR/DTR mode.
+ * CSL offsets: CS0=0x218, CS1=0x21C, CS2=0x220, CS3=0x224 (stride=4).
+ */
+#define DW_SPI_G2_DDR_DRIVE_EDGE_BASE   0x218
+#define DW_SPI_G2_DDR_DRIVE_EDGE(cs)   (DW_SPI_G2_DDR_DRIVE_EDGE_BASE + (cs) * 0x04)
+
+/*
+ * Per-CS RX sample delay registers.
+ * The register at 0x24 is DEDICATED_CS_RX_SAMPLE_DELAY_OFFSET (a pointer
+ * register, resetval = 0x200). The actual per-CS data registers start at
+ * 0x204 with a 4-byte stride.
+ */
+#define DW_SPI_G2_RX_SAMPLE_DLY_BASE    0x204
+#define DW_SPI_G2_RX_SAMPLE_DELAY(cs)  (DW_SPI_G2_RX_SAMPLE_DLY_BASE + (cs) * 0x04)
+
+
+/* CTRLR0 CLK_LOOP_EN (cleared for RX_SAMPLE_DELAY / RXDS modes) */
+#define DW_SPI_G2_CTRLR0_CLK_LOOP_EN    BIT(18)
+
+/* RX sampling modes (mutually exclusive) */
+enum dw_spi_g2_sampling_mode {
+	DW_SPI_G2_SAMPLING_RX_DELAY,    /* RX_SAMPLE_DELAY register */
+	DW_SPI_G2_SAMPLING_DATA_STROBE, /* RXDS/DQS from flash (DTR mode) */
+};
 
 /* CTRLR0 fields */
 #define DW_SPI_G2_CTRLR0_DFS_MASK     GENMASK(4, 0)
@@ -198,6 +306,9 @@ static inline u32 dw_spi_g2_addr_len(unsigned int addr_nbytes)
 /* Default FIFO depth */
 #define DW_SPI_G2_FIFO_LEN	256U
 
+/* Maximum chip selects supported */
+#define DW_SPI_G2_MAX_CS	4U
+
 /*
  * Maximum baud rate divisor value for BAUDR register.
  * BAUDR encoding: bit[0]=passthrough_en, bits[15:1]=SCKDV (divisor).
@@ -223,7 +334,7 @@ static inline u32 dw_spi_g2_addr_len(unsigned int addr_nbytes)
  * fifo_len entries (typically 256); we use a compile-time cap here and
  * check against the runtime fifo_len in is_reg_op().
  */
- #define DW_SPI_G2_REG_OP_BUF_SIZE	256U
+#define DW_SPI_G2_REG_OP_BUF_SIZE	256U
 
 struct dw_spi_g2_cfg {
 	u8 tmode;
@@ -252,7 +363,7 @@ struct dw_spi_g2 {
 	/* Current message transfer state info */
 	const void		*tx;
 	unsigned int		tx_len;
-	void		        *rx;
+	void			*rx;
 	unsigned int		rx_len;
 	u8			n_bytes;
 
@@ -260,9 +371,32 @@ struct dw_spi_g2 {
 	struct completion       mem_done;
 	int                     error;
 
+	/* XIP (Direct Mapping) support */
+	void __iomem		*xip_mem;
+	resource_size_t		xip_phys;
+	size_t			xip_len;
+	bool			use_xip;
+	bool			xip_continuous_mode;
+	bool			xip_prefetch_mode;
+
+	/* Per-CS RX sample delay (in SSI clock cycles) */
+	u8			rx_sample_dly[DW_SPI_G2_MAX_CS];
+	u8			cur_rx_sample_dly;
+	u32			def_rx_sample_dly_ns;
+
 	/* Flash type detection for timing workarounds */
 	bool			is_nand;
 
+
+	/* DMA support for FIFO/Indirect operations (External DMA) */
+	struct dma_chan		*tx_chan;
+	struct dma_chan		*rx_chan;
+	struct completion	tx_dma_complete;
+	struct completion	rx_dma_complete;
+	bool			use_dma_indirect;  /* DMA for FIFO operations */
+	bool			use_dma_read;      /* DMA for XIP (placeholder) */
+	u32			dma_caps;          /* DMA capability flags */
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 	struct debugfs_regset32 regset;
@@ -309,6 +443,9 @@ int dw_spi_g2_init(struct dw_spi_g2 *dws);
 
 void dw_spi_g2_deinit(struct dw_spi_g2 *dws);
 
+int dw_spi_g2_hw_init(struct dw_spi_g2 *dws);
+
+
 void dw_spi_g2_update_config(struct dw_spi_g2 *dws, struct spi_device *spi,
 			     struct dw_spi_g2_cfg *cfg);
 
@@ -319,6 +456,17 @@ int dw_spi_g2_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 
 irqreturn_t dw_spi_g2_irq(int irq, void *dev_id);
 
+/* XIP/Direct mapping support */
+int dw_spi_g2_dirmap_create(struct spi_mem_dirmap_desc *desc);
+ssize_t dw_spi_g2_dirmap_read(struct spi_mem_dirmap_desc *desc,
+			      u64 offs, size_t len, void *buf);
+ssize_t dw_spi_g2_dirmap_write(struct spi_mem_dirmap_desc *desc,
+			       u64 offs, size_t len, const void *buf);
+
+u32 dw_spi_g2_op_freq(struct dw_spi_g2 *dws,
+		      const struct spi_mem_op *op);
+void dw_spi_g2_program_baudr(struct dw_spi_g2 *dws, u32 freq);
+
 /* Helpers */
 static inline void dw_spi_g2_enable(struct dw_spi_g2 *dws, bool en)
 {
@@ -397,4 +545,8 @@ static inline void dw_spi_g2_transfer_end(struct dw_spi_g2 *dws)
 	dw_spi_g2_target_disable(dws, dws->cs);
 }
 
+/* Sampling mode configuration */
+void dw_spi_g2_set_sampling_mode(struct dw_spi_g2 *dws, u8 cs,
+				 enum dw_spi_g2_sampling_mode mode);
+
 #endif /* __SPI_DW_G2_H__ */
-- 
2.34.1

