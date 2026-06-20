Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E931D86FF;
	Sat, 20 Jun 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944817; cv=none; b=jsTFd0IgjTA6P2ipv3ZxeoKMnzv3+B3jCq7rxz2Wb0tdo0x+ay1sveeCVHmr8hCZk1QX17sI/KqrFR9FK8YtH+gFvUKEV/wZDXqJdzAIha4qC+nr06HQ8UdctCVbomzbbfyruRH/rcW9OOio79+cNUOOnO2S00YznC0ppvMASws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944817; c=relaxed/simple;
	bh=3S9eSWWek2bN3TaSaS1j0UMKZVdctpXL4+b++lVw/tE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EDCEi9dln1dbfJbHIPyi9p61IwLU4shg3Ec0nANbAaCDMXMTremIhISRL/ocWyHrXwt+NjzW3otyH67f9Q4fo6Za06ROUuvhlfsu5IPsNrQ9SXhTWdtXWzTAhlq3UK1SfP7R6tVTJuUL4XdSfubMxvio+XorjpMfY6yZHqitX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gGiyrxXI; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gGiyrxXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781944812; bh=aalBlmXxlpfF8ZNaaynm63K6Lji5zIPqViiYBR5+bL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGiyrxXIT+s2IMcVx86IgDAzJsXw0WnX41WI2SeGJgEQoQTb9FLx3FUKo21yrLhfp
	 hWprCg3/ZFKBvvqdhI1lkbGXN5xq1yoM6y+6gJlyAoWa9Silk7NJmHpcpcx421Xwzd
	 ZAOgoU4lCBxrR3OFfFOYW/wWGZqc6+VI6s1G0M8A=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9E3A1AF0; Sat, 20 Jun 2026 16:39:35 +0800
X-QQ-mid: xmsmtpt1781944804tazv0x18o
Message-ID: <tencent_427FA55E3D59112524886E9C931CA0F92F06@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+vq0/mw4YvO55qP+MzgFZgfbzkqsN9MOWxgOmn/DB5XCGijUNZO
	 Ax3Ia3/x5dorb9rrfPO8zlAGUaDC/m/JncnkCJ5oSMhM6asF3tg18SgPStu4aB2BQu5+XqJah84K
	 n/bEhLeHES3z91wo6nnSUelbQgkLYoesINif34SBjzNw9k5zcxG9xiZJVIyuCTYVNd1rSk2Tw0QR
	 AZVCtOity74HoX8/R80H9y0o1t1HuAuT4RDd7lmuulU7IKoAWECloSBm8nN6NP/QGjE0HKVkYJEX
	 iewdeSxBqTF2WyhyI56VHi5aevCuXZ1du94DfdFLvXQGEpBzApDj9Dz7hkPHiSNsehu1VI+0Lmco
	 SMnz0M9Pp0XnrMHWpiAZgzKH2/80RmYRh76GKwoTLuGIyXyasCCDVm5X3nl7Pyt7h5xbBNxCoxd2
	 B++pvhLiyZyrPqmSymNWbpmnx0/V+CgJWFY8Cv2wKI75SBQrUcMur56AYV/KTBC/v/yxUlrpVgPJ
	 IPW/VybvwFzAx+RX9aQSEHGecv+VxCNChBlAk8t+3Z05uMbNiA2GPKOTwC8TsmmNsnhWtl3kTM8i
	 2wwlMoqSzDdeuj25vVbfFH7axzPXY+vVJLlkc5uxlfJ3U8OGBDwmQM0cThpeK0ZgdAp1Vo4IqwY8
	 ftFxh3HxIJ12KS4MFHWZFn9pf7dZs/HVjxKvEjpcBv5u9docFmgr/vCFCEYxKbQn22ZXgpOu0ydt
	 zBIcAMjY6/FN5ZcDxILLFLw4qeELo/tbVnWFC8KWZbIWcCanuT97lFENntUHwxTvZlUh8mBM/ujT
	 XiZnygoFllJS4ozZl2MASlstZk0V1ONGmYkTgJ/pTkZyFsg9QvTE5ZGL7CzoObstQ2qHm56nYoHm
	 zBocyTvuHoHeiGQ9Zeo6OtH31EsXD9IN1fuf9A+slFvF2N45WHc5UQN6o5z7gb1h3k2eC4MYYmsL
	 nNvY8ga3HIkhxTbQXxgTxRXrcXiJhaqEkIfa7ylsFGKi08CyMrv52OJv/jzCVFLx53OCaR/OS+Jv
	 nrVfvP8cVbC+Up1TxQk2pILggO408xhlizKlDCj1oxmruSJZvF96dbJls0ZXLzG71OCU4ICg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
Subject: [PATCH 3/4] spi: fsl-dspi: clean up after failed suspend and resume
Date: Sat, 20 Jun 2026 12:39:30 +0400
X-OQ-MSGID: <20260620083931.1120616-4-1298662399@qq.com>
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

dspi_suspend() disabled the IRQ before spi_controller_suspend(),
but ignored a suspend failure and kept tearing the device down.
Restore the IRQ and return the error if suspend fails.

dspi_resume() also left the clock prepared if controller resume or
hardware init failed. Route those failures through clock cleanup.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-fsl-dspi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 019d05cdefe6..c2d283876ef8 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1464,10 +1464,18 @@ static int dspi_init(struct fsl_dspi *dspi)
 static int dspi_suspend(struct device *dev)
 {
 	struct fsl_dspi *dspi = dev_get_drvdata(dev);
+	int ret;
 
 	if (dspi->irq)
 		disable_irq(dspi->irq);
-	spi_controller_suspend(dspi->ctlr);
+
+	ret = spi_controller_suspend(dspi->ctlr);
+	if (ret) {
+		if (dspi->irq)
+			enable_irq(dspi->irq);
+		return ret;
+	}
+
 	clk_disable_unprepare(dspi->clk);
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -1485,12 +1493,15 @@ static int dspi_resume(struct device *dev)
 	ret = clk_prepare_enable(dspi->clk);
 	if (ret)
 		return ret;
-	spi_controller_resume(dspi->ctlr);
+
+	ret = spi_controller_resume(dspi->ctlr);
+	if (ret)
+		goto disable_clk;
 
 	ret = dspi_init(dspi);
 	if (ret) {
 		dev_err(dev, "failed to initialize dspi during resume\n");
-		return ret;
+		goto disable_clk;
 	}
 
 	dspi_set_mtf(dspi);
@@ -1499,6 +1510,10 @@ static int dspi_resume(struct device *dev)
 		enable_irq(dspi->irq);
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(dspi->clk);
+	return ret;
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.34.1

