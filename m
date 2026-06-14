Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42142777F3
	for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426163; cv=none; b=DzMOUFheoTSVFOUWd2wVi39xQgnG/NagCsy9/1kGCrs6kF5+xrwPN9OQlom2kxkHz5MTDpEVVO9ZqnFRrBfCGtYJGCQmWeVi/CGDmBbQu63YYIlBxDuK9Hi1DeLdRZHvFr9AD4AHpqEY0JYTlgQerAMNaKFgWVShPmDKaHhuxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426163; c=relaxed/simple;
	bh=s4L4ukk0KyujJ0HblA0DbVk6Hm5VHHVGY6UKqtf8+Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg30+oy0CYPeW2qxEotI5Tb7Tyj5W4sxUNE2Cj9p6jOvnWAhHc2JhDbkwgef/yW9Bn31i6a3yKMGCPGD9bFxPvru19e4R3roDkvZY84V3eccxnD/yNmKA4EfH4al0tGZ2Fe39P0Tuv/Xlz+1um0OI/KTj/7Fw4CbyZoHhryC5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3PtJMUi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3PtJMUi"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8857a27041so368658a12.1
        for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781426162; x=1782030962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAITfEL9UqrO9L8OmSD1zMxFdEqiUvJMm9blfi4uSXM=;
        b=S3PtJMUiS69D2k614mFzce4tH101RiTzfiLa6MNdtGYTKbLUH2MyZX4iRptmSwkRkq
         Ynjs+HSRlIo3jYfkUFSAOgVCzJNIJ2PhTTaQGnNCCcWerqAvaQiWB6FhTgrySRzBqYhO
         VuFuRecYUA2i94dScZopATd8ceW21jYU56EeOxmEFVwaFT0ML4cIZGzaMF6vclzr61w9
         jf6PhVLQHayy5QxuNEnZzedbCnYzQQxwAtPTpttiBU2MzySW2sKbpENJG9lk8nO+JNZY
         eTkLw/hpX2kn9fLcjaSV2BmL0rbmehs24xF3kIbpUnrA29IZ7WctWCpRD/N2uh+UT7p6
         KleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781426162; x=1782030962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAITfEL9UqrO9L8OmSD1zMxFdEqiUvJMm9blfi4uSXM=;
        b=SIP8jfC7wPOTy4G2/GLrhpKrHv/RfBqr0u/8sBUDaU7yFZ9uakQLbsliejP6nA16L/
         Dfpj9XiqDYV/n3V+FBP6wu9ld8+5yZuArU6htqliC7rSo0fdcIRnBLwghurlbftJ5V+n
         yjoWhhJHUUFi6+HUd0pxs3ULUN5V/4Q0C+eQdq6T+9J9Lq9f6p8qsCda4I8UtVUBWpYt
         oFeupaTTbr1Sds+cXDlgl00SbwabHtqhUeV3+uaLeyoknWjvOAqfkF5L6YyUkWYF/WYh
         eQ5nT3QVRJ1byCxJQcHJzLLdReZflIQswIuSEPEg0WuwRtYAyw0LmhxxuOcjxogVYXGl
         7zyg==
X-Forwarded-Encrypted: i=1; AFNElJ+BfcFaC850LWMwu3ehwI51mXelExYpE0mk5apuJLx937dNdWqfO3hiu90Z+uALBfhcdESCYuWDhi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDGeQN14EyEkWQ4hj0H5Zx0grH2PaM49Z9lgygRmqVBEFie9/
	k5XgO6Gi2jymPz6xTN2MYDbYr9CTjPUC94CT8jW4jKdsWahHz2Wvqfte
X-Gm-Gg: Acq92OFTaMRDKg04S2QozjRoZY+8gtPhMXkqsp6RCKUCeKShDMIRxoWiCqEgbgQ4A5r
	877gHCOOQM1VPG2ei3Fw485Z1jhAmHG8yJPbyGwcauVPHY7D1SF98xL7c971+Njvfa3wgte97Qt
	+5Ol0ubngotGqD1SbEpkAFAJeXr4pH139/I9PHMCjkfxIUnCjXyvQVBftIXlYWm54NV78P/sQsU
	d/fDj76omDMaIdJXonsAINPVqA4FyG66L3wXwJ8LnmWRBmd7d+b2BxqH8kBYL1tdROo2YW/Ifnk
	jhU/KwjkS3BTzsRAfLCWQ4q8LbQyncPN6sTudKM7gE7TCCQ1o2mwj3ePtceKg6dejf36EGZugTw
	Ap+Bh1Io5+7ll7y7ff3sQXMO8d2QU9bT3ACkUm//pUb45DIqyTfQuvjzzVhKeHwNbacsAkLkbgx
	pdrQnxdzWGWg+9gvy0DGMMMA==
X-Received: by 2002:a05:6a00:3390:b0:842:5634:3c1d with SMTP id d2e1a72fcca58-844e199926amr6606163b3a.19.1781426162161;
        Sun, 14 Jun 2026 01:36:02 -0700 (PDT)
Received: from nuvole ([2408:844f:2361:d7cd:deb7:4e0e:26d0:4076])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8fc7sm7263053b3a.37.2026.06.14.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:36:01 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
Date: Sun, 14 Jun 2026 16:34:24 +0800
Message-ID: <20260614083424.464132-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614083424.464132-1-mitltlatltl@gmail.com>
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
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

Introduce the "qcom,force-gsi-mode" device property to hint and force
the controller into GSI mode during initialization.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/spi/spi-geni-qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..eece7312f780 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -102,6 +102,7 @@ struct spi_geni_master {
 	int irq;
 	bool cs_flag;
 	bool abort_failed;
+	bool force_gsi_mode;
 	struct dma_chan *tx;
 	struct dma_chan *rx;
 	int cur_xfer_mode;
@@ -655,6 +656,9 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		mas->oversampling = 1;
 
 	fifo_disable = readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
+	if (mas->force_gsi_mode)
+		fifo_disable = 1;
+
 	switch (fifo_disable) {
 	case 1:
 		ret = spi_geni_grab_gpi_chan(mas);
@@ -1133,6 +1137,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(&pdev->dev, "qcom,force-gsi-mode"))
+		mas->force_gsi_mode = true;
+
 	ret = spi_geni_init(mas);
 	if (ret)
 		return ret;
-- 
2.54.0

