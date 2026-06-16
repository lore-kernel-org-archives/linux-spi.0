Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3835CB6D
	for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612857; cv=none; b=qwf1IV4KQ6/C2UXO4TgT0OO905GPnhauj5gvfbBAp+R8QVZnFL+w/OaiVoGLKnacoumStyt8sAbV7prygBrnhqwzpGDcRXQvCp2f/iOwpy8hYJbj1rXhV5as/KFb4lLD2k+82iw9IkyJLnAC921/EUYP9fDDU7zQIDdeFp4abbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612857; c=relaxed/simple;
	bh=KNS1cKXInLQZxkR7LHfU2zXc7rmttuhI5LIzHA7EPoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gELCceohLjI0tnzkBcuwDQRJOa16InmpiEe4E0OaQVN0iMMRaY1cCVziazNeVHTEjlwYDw0gJ4A/lbSNINBRqsfzXRjCV/hjmLWXfP9qs2M/yVotiGIPJXr9EfXvovk4Hx0YGohiS7KqQkMkE4CEsF9elmQTOVEMFZLldGFoVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPu58oFS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPu58oFS"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8857a27041so1369011a12.1
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2026 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781612855; x=1782217655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2upLEhcEPsBGDX8WqyzO3sD02fVNZKxUDLDhAXzyQxU=;
        b=nPu58oFSvrHlfpFjoZwBRSL4woVNFL/IMCt1XehjI0U1VUdGs6s/lab8qG01kaiFXt
         Jk/Wu7zBIPsOVaF6V/0iV0uADtcI2prhiWYoE5ta3HuhESMQP82WKnm8hBGugaEgY8KD
         6YPVsZAa2cQ2rfX2rttPkgcSna3eARYHiGn11Vu4MmYdzMGbyCRM3y5LMNqZw4WhK3eT
         treeq/d++TAOINcnwHQQTuhLjd4qSpuX8d4nLRk9RCGGpSAlAI+kGioGjrmZmF6ILO2v
         9kej6YdhTwdPoXo4ri493iFtz7d/K3XtvSdi3ZKvLTwKSFxyjKS3jH9GsxvVKgsVknRK
         bjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781612855; x=1782217655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2upLEhcEPsBGDX8WqyzO3sD02fVNZKxUDLDhAXzyQxU=;
        b=rjjWMg9E5zwMaTJ7R6QQXV06YxkjHz4ikYFCiRlNENidVr2RROB0FYBweGeZ7utEeN
         y0kBFakyJ9HpKS7HT18GaUfVCCQhHafZ0+DRtHy3NxdiZ1D1DeQcZh+r+5yyFxzyvOTh
         A3DuMlErEJL1mtNGtrlya4pKPl0c4Q26PwjJ8JT1pIMxfc4sM59fcGxYgnl1qzzHIW7/
         YXjpVdhNRyb0Xa5yGbFCvbZjT9UJhSO/iQKsBdwBjR3c9n/dya3tHZBGYaTbsWXzpZpg
         WHukbCdfva0hLgmgHPgfWCp6ovRiK1mlCaN9B+HdYdWg1LypJTZ7TG4yGKKczqOQwvK+
         ZKRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IXSbBkZlY2pvO6wVlYpGFQih8lI/wwkd44shX2OlTQ5A5cyiiJM+9qXvzDa9QW07hfgTQCvT3dKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIydEk1SqTM3PDLneKdxKHGN7c+raojCtrEDM/j4A74zpJpBRB
	0rRQfbIcebX88QWa0D0rPG/smJkO0vHNWwkplORqdNRPqX4Zmubi3Kbt
X-Gm-Gg: Acq92OECDv+OXrMmLFhCR8vDfj7sgd9yKPzT6KJfInwY0KdMd1wdVvF1oUQR0qPSFTk
	CIgw6HHeE/nNIHNFSEQNegHePwAPoY1OmOYY0OM/HhgcJ0+8NhChwiFjP5urx5SARNfVWn+c2sS
	gwLZQaU/MLLRNZ499IN99Af7nibHTYZQvmgYrS+RJVkxJHpvA+zA1eQ7i+g6lqQ+HEWv0YV83hc
	C7EZe2YuEpSvw5QIcEjBwGsD5OLu+troVusHySsjj4DEoFwPSTGqey1B+c5srvs/UqvY89Ub+qU
	qFjeVl7Qy5S4CYFjOBTJKncDiwPJjoHGjKo+EqYIz5NQLBZLBJnjTQPYCL4HFUKMp/yJnI2A4Qv
	RgzuEi7p0RsRCUUUNXy4rACBsPpXMjlrDNs5V7Iw02cZaAsU7WNXvaWNogGb8xwWeEoeIqyakN6
	Ho+9NTJ5WbvB8AWEhjbJsw
X-Received: by 2002:a05:6a21:6190:b0:3b4:81b4:9b79 with SMTP id adf61e73a8af0-3b79642264bmr17424361637.40.1781612855241;
        Tue, 16 Jun 2026 05:27:35 -0700 (PDT)
Received: from nuvole ([2408:844c:a00:6006:ce44:869e:4d94:f839])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186828sm10663771a12.21.2026.06.16.05.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:27:34 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2] spi: qcom-geni: Use GSI mode if DMA channels are available
Date: Tue, 16 Jun 2026 20:26:05 +0800
Message-ID: <20260616122605.668908-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices (such as gaokun3) do not disable FIFO mode, causing the
driver to fallback to FIFO mode by default. However, these platforms
also support GSI mode, which is highly preferred for certain
peripherals like SPI touchscreens to improve performance.

So try GSI mode by getting DMA channels first, fallback to fifo mode
if it fails.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
Changes in v2:
- Determine mode by checking DMA channels. (Dmitry)
- Link to v1: https://lore.kernel.org/linux-arm-msm/20260614083424.464132-1-mitltlatltl@gmail.com
---
 drivers/spi/spi-geni-qcom.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..d2fcd0bb0732 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -654,26 +654,21 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	else
 		mas->oversampling = 1;
 
-	fifo_disable = readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
-	switch (fifo_disable) {
-	case 1:
-		ret = spi_geni_grab_gpi_chan(mas);
-		if (!ret) { /* success case */
-			mas->cur_xfer_mode = GENI_GPI_DMA;
-			geni_se_select_mode(se, GENI_GPI_DMA);
-			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
-			break;
-		} else if (ret == -EPROBE_DEFER) {
-			goto out_pm;
-		}
-		/*
-		 * in case of failure to get gpi dma channel, we can still do the
-		 * FIFO mode, so fallthrough
-		 */
-		dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
-		fallthrough;
+	/* Try GPI DMA mode first, fallback to fifo mode if it fails. */
+	ret = spi_geni_grab_gpi_chan(mas);
+	if (!ret) { /* success case */
+		mas->cur_xfer_mode = GENI_GPI_DMA;
+		geni_se_select_mode(se, GENI_GPI_DMA);
+		dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
+	} else if (ret == -EPROBE_DEFER) {
+		goto out_pm;
+	} else {
+		fifo_disable = readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
+		if (fifo_disable)
+			dev_warn(mas->dev, "FIFO mode disabled, but couldn't get GPI DMA, fall back to FIFO mode\n");
+		else
+			dev_dbg(mas->dev, "Using FIFO mode for SPI\n");
 
-	case 0:
 		mas->cur_xfer_mode = GENI_SE_FIFO;
 		geni_se_select_mode(se, GENI_SE_FIFO);
 		/* setup_fifo_params assumes that these registers start with a zero value */
@@ -683,7 +678,6 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		writel(0, se->base + SE_SPI_CPOL);
 		writel(0, se->base + SE_SPI_DEMUX_OUTPUT_INV);
 		ret = 0;
-		break;
 	}
 
 	/* We never control CS manually */
-- 
2.54.0

