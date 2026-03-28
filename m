Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F539A057
	for <linux-spi@vger.kernel.org>; Sat, 28 Mar 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714037; cv=none; b=ifaHQFdvBe+BLhP32MkVKixVXNqhD61MBJUWEXC2+QAfoXCt/Nf5Gvf6kfuQRSKDCcNha28MVxf7B5nh7wSWLFQN0MNbfCyQG/jOhVxiAFSnsh2oNP3oFxxZX4QQiuiH6mFKNGmxDStNDfBDtja5Jf+oROfbGv3QzPPa5IMIbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714037; c=relaxed/simple;
	bh=B2M6TmSMVm9Sf6C3C9nuArJeOUQJv3qKC5BIO5ffMLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erzLmaKpra1zsvJ/OOUmSB8faLMhawTfywelM6R7kIrVvEEMaRlwj0o+NJ3TB7aywejgo8Hg8hdFNOlvjGydyDlnbAvyCi6EGKftrC+NcinsHIuCmejNQHDSZ+zUwqrNSrBR0pRVsmAZY214cnd8ij78dFbDykXUMImttE0IKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuq3Opti; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuq3Opti"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2154711a91.1
        for <linux-spi@vger.kernel.org>; Sat, 28 Mar 2026 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774714033; x=1775318833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/qgP9gqmMpp2U/rdBQhHtYOkT3qsy2wmqdnlrMFSgg=;
        b=nuq3OptitzsTtith2LJCAY2l528IdOyXUFHj1go7AmLbnP99BSdgg7c1Q3FVC88/gO
         pYL3HnUC/ztJjvs3JHI5UHFvqhbiifRZGoq0tUapzvd2Bz6h4C1Qz0YqgoT2CvFSUhW1
         ubqLtxyKNZv/by46bcO0BySHagsT/NTx2hCkL13KATU5Wv9CWk+teZ/iXJFEKNl0Wt48
         r+AQmTtEM9fvni6bOCeOadA8Ry2x9oBPLrRZpF1eR6VG0+TxbBr1BJoM0ScDOn8hkIQ1
         rCKy7Cu7yInd05pGRmXtADhfQnGMJ21Q9Hp3HZXX3Of+jY8AI/hkBBxV8vxxdn5rkxuB
         GwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774714033; x=1775318833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6/qgP9gqmMpp2U/rdBQhHtYOkT3qsy2wmqdnlrMFSgg=;
        b=QTDr+/WvOly+FTNWd2B+z0K/HrI9xv2U0RidkWoAf+2n6PhehMGlyJhzW2kMXiPJZm
         9FT13qRpiLpSWK1yXYA4+NzykGiu17Ea2o1CJbLnTUUig5otyPo3dUZ9Qkf0GsJKB7v5
         BRsVQSB2ZshNzVP2HM6YYZyA5h3Dg1+QT/yQRWEJmujyBKjq803mv8l8nY2uZ9aaiXKj
         SjuirBf624bImjc4tqcpQybkkmSAhm3q4XDy3xfxd7Sf55s9Yt1D0nQhd87eklCFPYMD
         4tzMhls2vL4Jss6q7H1kMiPTx0gtk/wcaUtGAdoJh3Gf5MF3D8Nx5WLrarmWT0bSBoPg
         4GUQ==
X-Gm-Message-State: AOJu0YzEWydUagpXcN8l9W7XjgBOLfhbK9vA6potiM+0nyBksP5uoD/S
	9k2EQ11NNyKFPp78+2KY1F6GbSI7Ux7KFY4AnJF3pt0yOAhbkbsaWwAD
X-Gm-Gg: ATEYQzzx9Mu/u44sP4jYaaLviUWvToSdJ8vcWVDS0z4vygjlLmVIEYBTK5HDrfKwMe6
	SfmB+QLYnoWt5EOHwq+0+c1IRlHCvq2iDI7SLPSrqwbz6sgurJG//oSjsx4l4f2ku0/+4MBrDoY
	ADd9tSuo/wAU93199r8qho9iEnTSnLLIhY/tVBwyCnrfC/9P0nDEHFFSbZ/53uqTEWobTvwUUga
	eRz3LDTP0JKOUo/ZReSNDC8zI3X5wWx+cjXnpFvEL8EKYfQuIUk7p+2c9g/H7coqRHry+KhJ7H6
	XeB0RplWDYrvFm+RXoHhNFdGR5vahbRzqpPjl7XgpD8V2/KVQBgM4kAJ9OMFsyLOJ+BYJpiFCht
	JR5cglpvwcPpDRIRzJo/qrNO9NJ3s87ANnOjTjiiSikkKBfXUg8x+W1ffQt7C4CHIFqwbIJRqVV
	/N38Bbhf0pk1WG6yVWWNi2LZNCU0ME1mPjpSmH
X-Received: by 2002:a17:90b:1e4f:b0:35a:1b43:dff1 with SMTP id 98e67ed59e1d1-35c300060damr6402909a91.12.1774714033225;
        Sat, 28 Mar 2026 09:07:13 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2ec27da0sm1988140a91.8.2026.03.28.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 09:07:13 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 29 Mar 2026 00:07:06 +0800
Subject: [PATCH 1/2] spi: stm32-ospi: Fix reset control leak on probe error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-stm32-ospi-v1-1-142122466412@gmail.com>
References: <20260329-stm32-ospi-v1-0-142122466412@gmail.com>
In-Reply-To: <20260329-stm32-ospi-v1-0-142122466412@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774714028; l=1079;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=B2M6TmSMVm9Sf6C3C9nuArJeOUQJv3qKC5BIO5ffMLE=;
 b=K3icUELnLZRMgZ/cPYJO9EzPAK2OMYHOCr7hyQOJnzEc4OMrk33Ar+ZZkU3slL5LvqPmk2sLA
 mJOwZbw8vXjAsa1nv9Kt2X0dyD1JJSNopgTjyIp2Ct8Tin+OylPlzR4
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When spi_register_controller() fails after reset_control_acquire()
succeeds, the reset control is never released. This causes a resource
leak in the error path.

Add the missing reset_control_release() call in the error path.

Fixes: cf2c3eceb757 ("spi: stm32-ospi: Make usage of reset_control_acquire/release() API")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-stm32-ospi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index acf2d182e8b1..52997c3f7174 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -960,13 +960,15 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 	if (ret) {
 		/* Disable ospi */
 		writel_relaxed(0, ospi->regs_base + OSPI_CR);
-		goto err_pm_resume;
+		goto err_reset_control;
 	}
 
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return 0;
 
+err_reset_control:
+	reset_control_release(ospi->rstc);
 err_pm_resume:
 	pm_runtime_put_sync_suspend(ospi->dev);
 

-- 
2.43.0

