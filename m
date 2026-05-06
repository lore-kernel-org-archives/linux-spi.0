Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE644B8DCF;
	Wed,  6 May 2026 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089919; cv=none; b=YFSH2J6WSCuMWk6Q81e4B5QJd2/13S5B2OG2C7ZYHe9arcfsUdLDHyMjtIvRT//OYj7FIkvxO0JPJq3OKg8xLCknVTqV5hNiUmj768r6+8hcU2lcXftYHABOH9J4qUQ2/6yl8B4sZJu8Y/d2AjfXdIZ0ib+C9mLcpvYRyHMYp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089919; c=relaxed/simple;
	bh=j+vj0b2qvC7RkbEimqlw8Ccn8JEhZeot+8jORHjR8xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBFfec6gpwpZdlJ9M974ORd1RqRiaMmrxAmQ0FblwkY9DxC3elWbgtj81vxrLI4YhBxTsJuPDVVTcIeOIZ1p0wpH9efArCISbFgyT7uQWsyg/FbBjpHu+dkHsebnkVHMgCDXz/1TUSSLeMGsxcD+ue+PxmQCFtmY/isjCK/Cv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OCXYVQiP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCXYVQiP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZhIhrzrQk3cuIdZiSPIRnT5icdPEWXf6gRX+saxJE/4=; b=OCXYVQiPZAWj9eduP5dmCHdb/O
	aAR4/Oh0/fHdHOZwJpOLOcRy4G8pgdbuBbijr5LKHnQ/E4rXuRBYco7xoCjQuPrOrtjmQjcM3WyYQ
	xuVIVGeVEQwbIXjsjU31nN7rjT3+sjYadgpc0fdZrdkNp21/Ld3x7bJSHOafVfsGRaabEQYI1B6TT
	QNLf1TdnBr0ExXfWRsZJsl/lqy623zTOjrtQhsIVDwLsF7+PODhErHbsa1PDzLKO3zFxzWO1H5IRM
	WClFb1ITmBMcCk7F3Yni4puwteYFuvgqo2wVHufCXOn4AJYuZvkpwcosxYkaVJVUUuX5NBg0xtPLD
	kZ6Cenyg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKgPR-00000001hLU-19mO;
	Wed, 06 May 2026 17:51:45 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] spi: s3c64xx: fix all kernel-doc warnings
Date: Wed,  6 May 2026 10:51:44 -0700
Message-ID: <20260506175144.449364-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: add tag; rebase & resend
v3: add Tudor's Rev-by: tag; rebase; add Mark to recipients

Cc: Mark Brown <broonie@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

 include/linux/platform_data/spi-s3c64xx.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20260506.orig/include/linux/platform_data/spi-s3c64xx.h
+++ linux-next-20260506/include/linux/platform_data/spi-s3c64xx.h
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
