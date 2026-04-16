Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C423E358
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356883; cv=none; b=t3YFcW8GGbMHJVw4Bgf4oboOQw8kgD5ddpEKNy6MBVk16+obsh1Lirhk2Ogspj1oDPT9tfck0T2hRSVtYLiSCb6BCHWaatLxNhOhMAXsMcPjADfq0vT4sxK1OoYmZO+farEOHp4SMd/I7OOmZgRPci2EecyMZVlcxwBrOcHTACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356883; c=relaxed/simple;
	bh=an05gz3snFqSWIlqPugud+8QDXGo85nlpAZJRtcNXQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QK+UlXaYfNLJg7AJGjJDr82WRQWm3nAFAujPRrg5o1+DBWdquYEIvc9qxi4aVbUfBK+eNBaSTJ23/Vd7Qu3cogJ0eurnnXINlpDtr6YFbh7bhfTAxnjnTaYxf3P8tMnHElg1ZPSbC8a9j/6K+Ko9YhleWn9NqQkNXz3QGzY/E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBmUitbY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBmUitbY"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76b6abdb73so5705372a12.1
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776356882; x=1776961682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5saRJRACUrKVG09khw6yNyktdUzYLnpf0xS5TC2JSYI=;
        b=UBmUitbYRoY49LVN4gtXElvt9c74Wb1ChQuPaQ/4zbQuFHWsEc3kgiG7RjG1sMtCDc
         b6A88FauHJSM7FXINgSxaTtEfcSss/dpFlA0kWYspMS56Nfyg9/FiGnjFOCF3UO1kHRz
         Z9XijqGCmQEv1ICOnvOag0pmfhgc8NkTzJhYk6Wfzld6E8gZsKZzeVUpgMgeQBLvfYIn
         OBOkjElK3FxQtcpLsrbpIrs2b0Pq4RWY6VDmSxlhAVLjQKWc0rx5SNLhfHSm6bJ1Sxo0
         PlbCxuqTzr7vniDAUSn/ZTi06ZzrETfsBSdOpJcWiBH/6M7I8xhi16pljzpy2x/VYX3f
         RZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776356882; x=1776961682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5saRJRACUrKVG09khw6yNyktdUzYLnpf0xS5TC2JSYI=;
        b=Gs4+nVl5kZCUkh5nJujikr/KcOe+32gj6d7VsnUMjEL+dRDmEy0x7sfC1oO4G23PaA
         HU5d5YjEnw52RexNAN4wqh5+pFNs9VIwhY8R7+gmg0HFMrE3qtEAXVyPj0Af0bkNeW5T
         RyW8sNX90WBPXPI5mdpCu9EKWzMG2W/25sbudqif4Vhgbd47giEiDzNpajXQSZnt2xjy
         3lqVqC7TIrpmnCH59hw4PncwGUv2+TgYnjbOOFUzhZdOn08TADX4YltRnhpOCfwTdQVJ
         yW97YjJeuzIlbPca9pQpaux9xg7e45WrJbqF5PKo6NmMis1mk2RyoXfEf6iXOHW06SLc
         /frQ==
X-Gm-Message-State: AOJu0YyjtJ41TmeMQw/sy1c17H8hyAhm+g4oYErReiVffPo3Y2famKRH
	ntMur/OT3L9OhhooZxUX6PaJ3xlXlpaGr3o3b6iHH0coyf1tdSeOViEm
X-Gm-Gg: AeBDiesFJpUdg+Fy4namCOf3ctdOAgT6jYAMk3cr1tAi0e6UaMTKIQqwZKc7bx/rkWO
	8kSU8vEsi/5jNK6LzNzfeW/OdzCa4Jy5uKMSnWekVXjtqqMJG/WwaSJWjEJcx031OZuywkZEG87
	R7mmBaiQYwaKYZY6lCMKe5GI1Je/ckFCocR7TSLx2TSV4pEWpNOsdKh3g8sPm9bi4C+VNUahXYH
	z6YKhjvB6fDPKLyxhriO/gFPV74Tr9AM/iNsscJZct7KM5wNUtR6r5k9OderZ11KC+anfbC0Kcv
	ussVcosWeSjq6re1gb4bynhonuRoOSG7M6JvdIZVfGxMCBlRSsQ9xFSKg6txbtBdm7DBsW2UInO
	hCxUH+nMJQnNXcl+1GJ4FGSS/LpY0mIB9kRdUJCIxCqlJj0/CyQAnpbXP/X0WP/KRqY4PVrcX8C
	BDDgU8Y1bVWDcs6B7XY8ogyxzkavRH4rz7SygLD9bIKFJS699P4IKmtZ6VRUeWdtlgCNRtuug5/
	UxpWVYKEvm5hZj23WFmb+/4Ge3d888=
X-Received: by 2002:a05:6a21:3389:b0:398:bbd6:80b9 with SMTP id adf61e73a8af0-39fe3d824f2mr29670119637.23.1776356881767;
        Thu, 16 Apr 2026 09:28:01 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957ed03f1sm4899852a12.3.2026.04.16.09.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:28:01 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 17 Apr 2026 00:27:54 +0800
Subject: [PATCH 1/2] spi: atcspi200: fix use-after-free when driver unbind
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-atcspi-v1-1-854831667d63@gmail.com>
References: <20260417-atcspi-v1-0-854831667d63@gmail.com>
In-Reply-To: <20260417-atcspi-v1-0-854831667d63@gmail.com>
To: CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776356879; l=1365;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=an05gz3snFqSWIlqPugud+8QDXGo85nlpAZJRtcNXQM=;
 b=cjG8jOqLKAqc0lTGEmS/vsVLhr4Xxmy3lD1F7AbH8ZfaDKWDgkpKdiOfBAv2+CznMGceUGzLN
 iAyqSjcOKkDAfm3kZ0rdLGTRLzbVmsVTbFe7OMlylmgvnzSZ3riLxAM
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

DMA resource is initialized after SPI controller registration. So
when driver unbind, this can trigger a use-after-free when DMA is
torn down while the controller is still alive and triggers DMA transfers.

Fixes: 34e3815ea459 ("spi: atcspi200: Add ATCSPI200 SPI controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-atcspi200.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index 3832d9db3cbf..c5cf1aa2d674 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -575,12 +575,6 @@ static int atcspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_controller;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
-	if (ret) {
-		dev_err_probe(spi->dev, ret,
-			      "Failed to register SPI controller\n");
-		goto free_controller;
-	}
 	spi->use_dma = false;
 	if (ATCSPI_DMA_SUPPORT) {
 		ret = atcspi_configure_dma(spi);
@@ -591,6 +585,13 @@ static int atcspi_probe(struct platform_device *pdev)
 			spi->use_dma = true;
 	}
 
+	ret = devm_spi_register_controller(&pdev->dev, host);
+	if (ret) {
+		dev_err_probe(spi->dev, ret,
+			      "Failed to register SPI controller\n");
+		goto free_controller;
+	}
+
 	return 0;
 
 free_controller:

-- 
2.43.0

