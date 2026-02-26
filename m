Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B9332909;
	Thu, 26 Feb 2026 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082766; cv=none; b=FXGEOeHez1TTMbVzahPLa9gKdDvJqQwqF8UV+fM5T1xISO2LrstgBvfQtcm2Vogg7+cZkJMk5mz3aQvn0fj9vUgxTG2wejOoW1zprolXU4scQYNEVHQhk6mN3V5FLJpNNqhRaROTcS2B+E5aZg18MFXRFI6pHWcnKrBvRCoHBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082766; c=relaxed/simple;
	bh=fMgYq2PDaZBZ/wSt9cuVATEI5Kvmz1VS8TlIeuwbGRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sy7i35TnIMcqSoeY2I8/RXl9eSnZawaGNWs4MRxPjzw4z9NxZ266YaC3Miw6OUas2qAK9CaY15Lqn1mcpGwPEmZZlI3AeeQOmvOdaMo3ZoRXHxogBUardF6xJYos6GXQCi9Hx5OkeNVubEMP79DYQylD756lvwANp+l3OnOj2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Eo9c+ia2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eo9c+ia2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=46vgJhPG/YVPWGTPSjyw8RcvoaZIp217ejgrPwHtGCI=; b=Eo9c+ia2dnsba41ep9kPCiQFB6
	on5lu11EmlRxrmwcP6GpWQNAe2AjkxcvRz4wr9exVmrnMYyJtqthQDFN5zIu6jjUdry4i9xlGEhdF
	d5ZQLmxCfP2wV1WkJxqooxgfKmaMDOYK05t4AC1gRCzMAKEke+pBrgctSHMBsmQC6P8xsVthZCldC
	MwNhnCTMtsiIq5KmwRy9s/t3g4sWewO86JfI/d04dsHR5MPA5WxmIrX8hL7ocn4yrE9AhKpJafoTV
	fDogX2/e0QtXrnFSa91cZlRqVVY5RjufZsq1bVBrKJiPEk8d9QYgc2ydIEjsGtwqwsLhw62zm+peU
	RG2KKeGA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvTg4-00000005PLK-3sbR;
	Thu, 26 Feb 2026 05:12:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH] spi: s3c64xx: fix all kernel-doc warnings
Date: Wed, 25 Feb 2026 21:12:44 -0800
Message-ID: <20260226051244.552959-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc for one struct member and use the correct function name
to eliminate kernel-doc warnings:

Warning: include/linux/platform_data/spi-s3c64xx.h:40 struct member
 'polling' not described in 's3c64xx_spi_info'
Warning: include/linux/platform_data/spi-s3c64xx.h:51 expecting prototype
 for s3c64xx_spi_set_platdata(). Prototype was for
 s3c64xx_spi0_set_platdata() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org

 include/linux/platform_data/spi-s3c64xx.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20260225.orig/include/linux/platform_data/spi-s3c64xx.h
+++ linux-next-20260225/include/linux/platform_data/spi-s3c64xx.h
@@ -30,6 +30,7 @@ struct s3c64xx_spi_csinfo {
  * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
  * @num_cs: Number of CS this controller emulates.
  * @no_cs: Used when CS line is not connected.
+ * @polling: Using polling mode when %true (no 'dmas' property in devicetree)
  * @cfg_gpio: Configure pins for this SPI controller.
  */
 struct s3c64xx_spi_info {
@@ -41,7 +42,7 @@ struct s3c64xx_spi_info {
 };
 
 /**
- * s3c64xx_spi_set_platdata - SPI Controller configure callback by the board
+ * s3c64xx_spi0_set_platdata - SPI Controller configure callback by the board
  *				initialization code.
  * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
  * @num_cs: Number of elements in the 'cs' array.
