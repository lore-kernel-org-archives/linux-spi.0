Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D87340411;
	Sat, 20 Jun 2026 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944874; cv=none; b=diERG9odwVDgRza9UJlAQBZVunPwQKipUj4IbBxZzyZxB+KQfVp21QSY1klLRX9cK31TSUXE02TgaOmi4VnpXVTFcdtU/ZLF5mAd711sO7q/+ZK//CofI0waKY8GxJxplCDU0j7ldroB595Jib/NWjPkdI1MQ9r1xeCXj1vgLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944874; c=relaxed/simple;
	bh=VnFkOyDtqkw80Ar8YKo3b40bRfwXEv4jYWE0QQHIE+g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=krcljR3QQ1v9NWvUS8lizWoDsS0KWgDp4WNK97QZyivwadC4K9P72MA3ZckeVvoeSLzmpZiTSHBeZNQe9+h2WZUNFsS/3AII6PFmDwtlDkrtl49WBiWnJvGrSDitLKPquZADLC4YRHNAwBgUgjvg9AQH5XLpldFdwSnIdmMNHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pNous2Wy; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pNous2Wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781944868; bh=D03O6ATATGrr3scsFYQ1Lrg2abyiiRBzhuWJ6hFuinM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pNous2Wy5YQzdkJzXsrmTzWMdPklQLAYYyq5u84n/M4+6Q+gBn64yLF45UGMiNJnO
	 AbOD2oBNeACZUkfvGCoBVFXGLXk4bHkUFU+iIA/lodzI1cXOgmvGqPTcc5rCRt8X5g
	 l33kZAiWbT69fg470LjnODDhTJlFEgtFRhZoJmD8=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9E3A1AF0; Sat, 20 Jun 2026 16:39:35 +0800
X-QQ-mid: xmsmtpt1781944785tosn3rekl
Message-ID: <tencent_306FA547FD68D10EE4B2AE9C132060F12F06@qq.com>
X-QQ-XMAILINFO: NXDkzr13SnKZvhEbCsrtLcb2CGzyO42zywHjolfeRYCQG1N5xSOFYyKmLxXViE
	 v6GA40KEV5EIZOQiqirml0yl9V7jJok19BPNpZhsHKzUWbZtTbFe1UtFl9G1clbOJDnN+Ee1797O
	 LF4m5pjt1em/uP9PGcOiZ76YbLJfKHZLC91vIdD2pPJlNiyl+5Munih3GruclPJGAlvPldNivcE7
	 9HbjLL6D2n0sCaMgulo9JvbTdHYsTcs9uxx5ia4OHFffwlp4qOLXY4ZFrQ0eQjmviXkyouEpCF++
	 vEPtqh0H9ABlksa3SKUkCS58N5tGqeLOObJFM5cp+r/S3fKhs5m63aofa7maYmv+8V7TL0L8TO3P
	 EfU53JWDNacJqT7ib73P7zoDyig9p2/XE3ssvYYYz3uBE/FV3qDyFl2MxpOIOMBiq4I74ZkGnD4Q
	 vd2J99di6wseSiNiYdlNLPQlC8FICltWRycpeThqk6/me6dXZOho/FU2JCxt9shySpkoF+G3K8Kc
	 xwRTU6KVm98BJX6iXleassTfDM+B+rLpqIRql3d7Z3geJp7AMvB8kj72+44B4GrrA1ABAxOOuLSa
	 HVGbgLXM1xbwm/TU8eeauCvOdc+17jC3TwwZ2/N3FB2hB7ZAQXqKt3Jp48t7ESuWGmpeoqGBIYR2
	 VC9+KbKhlFQZ6sSJFjWZeCGxaCQmSyulL9DztchGIZM+cX+YYsGdcuUpHXX5I5xq5P+Bt6/+4cfM
	 GainmLbceOasnX9Zn9Zzy6x0AnGaAyZsrvOYb8f8ql5f2SeKOGvCKK9m5p4i4Km5kA55MKTAT8hn
	 x4hrVMsZgvPvRimOk6IcTenoh2rnSPKnYypPgik+VhEvjDYqqMIYtbLWQx9rtVizhgmxgMBeufpb
	 Gaz2IUd3HRkZTIkmnK0P98rcR3vIaB4K/Khbjay9Wx5cd9m7lYdCoqca//qn/cXe+/9wywtflYg9
	 CAmmX/cy/Gv/+PWuvogn+vKhlzXAmhXI14Goe8alWwJu6u/lvY0O7eu/lnl9XrsyTjC86Up5bL6O
	 w8u0j5L7Vhk6N0pfEmvFm12HHDkQcEu2e0Rltu1mzpJWaCgjTQw4iTEC2Lz9YgFv1sFzXzvd+cNR
	 hk4DnKvXW9HKtUjYvJk63b6Lc5FXSqhUB5xE1VgALYE1hGi4O/ThEfeHqH11O5vroMOT1f91HQ8k
	 lamQXI4TBaCOfKGw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Jiawen Liu <1298662399@qq.com>
To: broonie@kernel.org
Cc: cl634@andestech.com,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	anand.gore@broadcom.com,
	f.fainelli@gmail.com,
	rafal@milecki.pl,
	olteanv@gmail.com,
	han.xu@nxp.com,
	haibo.chen@nxp.com,
	yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 1/4] spi: atcspi200: return error from failed controller suspend
Date: Sat, 20 Jun 2026 12:39:28 +0400
X-OQ-MSGID: <20260620083931.1120616-2-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260620083931.1120616-1-1298662399@qq.com>
References: <20260620083931.1120616-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_controller_suspend() can fail when the SPI core cannot stop the
controller. atcspi_suspend() ignored that error and disabled the
controller clock anyway.

Return the error before disabling the clock.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-atcspi200.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index 6d4b6aeb3f5b..e0fd101a62bc 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -599,8 +599,11 @@ static int atcspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct atcspi_dev *spi = spi_controller_get_devdata(host);
+	int ret;
 
-	spi_controller_suspend(host);
+	ret = spi_controller_suspend(host);
+	if (ret)
+		return ret;
 
 	clk_disable_unprepare(spi->clk);
 
-- 
2.34.1

