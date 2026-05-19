Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EDF38F233
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171434; cv=none; b=R0/czBtt+BbpDBRNjeNhkr8V94pRqK+2Z3Zbs/IG3LlOIyjhQcSog+2uCadPqgYq8YnRP/n9h6G44acJJ8HgXrDW0MYXwMIPeFc/o/7pIJvle+koGkdQSU0xHTe9mlH+KvC48FNslrNmsU3IWDmGRQ5WBNfvK1TuzEn6l4O9yOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171434; c=relaxed/simple;
	bh=QQ5srJ1k52NpjI+Q3HaLSa9pVnjXdE8OZht6hpCEbfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cx98XiHm4KRyLkfpSgZnUdvgblqhIBIyI4sAQm08XGQMZSAa4FHw5G/AxHLkLLzR2OcTvTvEM4zVVjcE7umv6HUCPkfBur5lmCHMucK5Hj55AUmzboDNFCRsr3sF/aQH1urimmJME/zZdOAzpdARxt6fQ0flAgEvcEiOwXv3bYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgPQoMFP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgPQoMFP"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so2576810b3a.3
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171433; x=1779776233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0chwJesI0BcvhVwn8jIR2v8RSVOpIFD5ULcDL4OMxNA=;
        b=rgPQoMFPLle+28rH1tSBPZIzNWSx/GoxgwnkZcpGHsRJu1fkpOdfWB7yoIAordyTXV
         kUMsJNfxbnRNcky2AulPpg8LrksLZPx81alNSAiBC8jh78iIuSoBedlomplm3BimyiTA
         Wg/wu3W3PgErxcOy3mxdeTVzX3Gw50K+3I6KfXBwDoXYzqGXbtLq2ShhaSjtpETMHjnJ
         cpkLYlGQ/44Gflqrm/2lXyypyBB/4jGFqaZULwlA3efe4fziefVuHy5detvzZeVKR2uR
         ZH9zLaq9w9EQcNGNwsPchHJWX0T4HN4XbQsEka4jIB9+oFU013YWvYaT9esHYt+kcsEq
         46xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171433; x=1779776233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0chwJesI0BcvhVwn8jIR2v8RSVOpIFD5ULcDL4OMxNA=;
        b=AggEn76+ZRuj3ERUZUljm+68zyP01EQWMijfqWqAFlh/Qh2zd5GW7LXQyZf6Id1/oY
         n+bXlk+vTpZGcc8UGTlkfoPSE3AKMzLWlWR81LwxfKwTNEh1D5OID9m41wdhPuOmuex0
         I2/XmEg+KbIBgQGS2Ljf4Eizq3CtVw/32o1l3oXU3+4xqxE/IslHWHnFfq1c/gTuBlq8
         jMvGIKPtIMYyjjiixqbBLWUQdSH698u/X4IaalBnsLQYz7i/DDbl2mhwreuYdLtqt4As
         hJsUXB1Wqv2/mqhjBkLDSBYbICCW2RfXNp9/tQQ8yDBkFK2dMQsdtecmP+DTZtyDpDep
         LCXw==
X-Gm-Message-State: AOJu0YwKSGFTSXDSLhiXaJXqE6HltYd9h0/bxbSOAvhV3b1F/sG1fvA1
	kRo0VJwEXRlvY9f17HT9Vfvcy7g7GbtGHW+7ISrwioU0domcjo61bnCD
X-Gm-Gg: Acq92OFRrMKEpuvrHv/voYO3ndQuet+fG3JTVaZMfqgZ97FufWwiZgwAmfPqA7Qx3qj
	5l6sxjRbbYo1xNicxq9QF5LVCVHBvftYyCajvAn/YZ3gjw/zwl0t5tmyE/+u0SSRVNd0cCeDszE
	x1eacqPC4Aoe3gMzAxApTqtebhJ9lf8mi1GrnohaIOvPTd5az1Fkwnt/dQpsv5naDNrKQGchDSq
	gMVzMHezodXL9iOCbLgu29EdCEc9/Ijvm3bCOuUy+ku5S2sI0Elo+prusA5L7eSorcN/c8lrj/Q
	reSky9SzHpAyJnJiUK4MdMEUUoF79qn/LQOhCtcKK0z3j/Da8mFVR2hwzDP6T7OfDqUwCY1nENu
	JxzIgvebDDhES225AwjLeZmpHoI8MEoyXHbzIRQrbJ8pszmic2llaLx5QSAke+8rnADFMxB6QzE
	3uFdzYqRTyYt3Mg5iAA/a26vlwyvKhtQ==
X-Received: by 2002:a05:6a00:1797:b0:835:5aa3:2dab with SMTP id d2e1a72fcca58-83f33c333f4mr18789859b3a.6.1779171433260;
        Mon, 18 May 2026 23:17:13 -0700 (PDT)
Received: from [10.240.146.115] ([2.27.148.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7f202sm16112266b3a.43.2026.05.18.23.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:17:12 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Date: Tue, 19 May 2026 14:15:56 +0800
Subject: [PATCH 2/3] spi: fsl-qspi: add SpacemiT K3 support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-k3-pico-itx-qspi-v1-v1-2-c32afeeaf741@gmail.com>
References: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
In-Reply-To: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Zhengyu He <hezhy472013@gmail.com>, Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=QQ5srJ1k52NpjI+Q3HaLSa9pVnjXdE8OZht6hpCEbfA=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqDABXIRd9mve9a3LQBUJIUGDCj75EfmGr6SWgm
 EgLvgHfmoaJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCagwAVwAKCRDN9pw2gLgN
 2B0UEACbVrBMVl9AKoDlOthIdXOqinDtkvcCtGfWilREm6uKD0VHDaDqUbYqUyyngN2LzVqqsbM
 4fPTAtLTqOVySq3qbYFX3li10q48NOGWn5QFQ5v+JNkNd/Fe2l8mLhiSiKRtYG4M34VtWUBChoL
 L4FVnsJ7mLlU5zChZFZYySvPDRsgheMHCJpL1MUvfnB3Ln3iitWB2cyhV1Ir1LHYUnALTrVSzIU
 X7a/fAWMFmGN3z3Oiow1a11VMmZPFgW3jtrXMavZ3hVCYbUtnpZkwuYRUAReJqNEdFfm4m2WOYe
 +8PnK2BUOn2U7pnF4I8qnlcAqU2h1xxUGSXXywuRLuPigKDnpTAmhYwhtZqkpJTt4UDNkMbt57j
 JwzUhz1F16xy8nm2mHzgB2folx/0lKSpcxEz9VkjmixyFn6WA/SAUzBCQnK84kXdhFuJxavaN0v
 YeIJ9Fms027WtDd8alyE6tnGz5Nue//wz9sXiIcd9dbi/Y3vA6y5gMtXVsQ80hTZ9XkfEcm1n0S
 orR0nudtNEWioux2TH/BmzcDbRE/rxyUAzeC5Y6Be484DxyHtGdNjw1RxFS4WKD4ZJs8PaHivbf
 B0OcC9+Y6MuCpmZjh0N8Cb22uSIcdI9nfNP5iPdRJNBPgeWp0uaweU83FV4ew/fE7d6tYYYY267
 UwbX6qasCIKqbwQ==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

K3 uses the FSL QSPI controller with the same programming model as the
existing SpacemiT integration, but has its own compatible string.

Add the match entry so DTs using the K3 compatible bind to the driver.

Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
---
 drivers/spi/spi-fsl-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 57358851029b..bb94fae32609 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -1015,6 +1015,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
 	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
 	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
+	{ .compatible = "spacemit,k3-qspi", .data = &spacemit_k1_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);

-- 
2.53.0

