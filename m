Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259DD3314D2;
	Thu, 16 Apr 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379262; cv=none; b=jpWHMA12g53dLpwXco4PFkFHqXT/vUZDDNAdupe2AarPY+eQnkp0gf/gCunSumyTtn1MISJ7tp8GLpqTkYc2PmmG0i9Qm5U83XDg1jfNfyZWHO+Q5NmS8TU7mahjAMJHu65k4WCFMZGKl+WIVaR15OAL/sb+RDZC4v2gCs2nues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379262; c=relaxed/simple;
	bh=0ytys30QXawU0JZqdm/tXTMpVZzSNU6/AjGlCiDcpOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCMuIFsEx4+hanlW69DCrRN1JiOg0TH6akxhMUNzfaWYRJ+LNw5baFZO7FM9r9B5bxDlgZ1ExUICgEFkQ/sCxcnP6g7cIWp98K3+6MZRQTiLV14dSWzH+Ie9MD7qhjO4PvzNLrtSgqpAcaoksGF4ZTNRmhtw9UCJUzYf8gZ8MdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wa2N02/R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wa2N02/R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZYzUQK3HvwVrA9+IJXuQqcU5jzSAy6sh4Hl6HOc0JvY=; b=wa2N02/R4p1ygV+3qj+zYF9IFn
	XgR43bycONwloaMTbybUOEcext1lWxjxNZo3lt+fE3TfnV1aYF1KcN06FOo+IHiRBZap2nbZhtg5E
	sx+UpCeAj5li2MuzRxmwrQ4bYBcR+yqgANkcjCyZEZBVN07RnJJ5kypO+IaXme7nrXVHV4ecadX0Z
	52I/BbjKS3sZrsxK9/Y9zC2lsmjch02bo9cnIGvQgbF9V1kzyKNYX0izkRaBx+qfH43NnoHuZtsdE
	Ji+kz0dAE9KZE7bCQCAJJdSy8DAEpGNpVdoZt6RQH3P58hF54nwfF17kGHJxU7KLMWKhXsktkcrto
	CXQsHuDg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDVOL-000000039Je-11nU;
	Thu, 16 Apr 2026 22:40:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] spi: s3c64xx: fix all kernel-doc warnings
Date: Thu, 16 Apr 2026 15:40:56 -0700
Message-ID: <20260416224056.985233-1-rdunlap@infradead.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v2: add tag; rebase & resend

Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

 include/linux/platform_data/spi-s3c64xx.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20260415.orig/include/linux/platform_data/spi-s3c64xx.h
+++ linux-next-20260415/include/linux/platform_data/spi-s3c64xx.h
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
