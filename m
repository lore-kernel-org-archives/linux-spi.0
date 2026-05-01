Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309F3C060C
	for <linux-spi@vger.kernel.org>; Fri,  1 May 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644004; cv=none; b=NFwshyugZM30jymGxnVhoqBB1sjwbFxgri9H+d2PHjeswfW6U/vRwq9TAsRn5fhd8eq06JtqZQ9g0ko+0wa1BkEVVkObq+Q1ceDc8vmHBpKH7MLC1Xev+iHBW0hfy+8BZPPwdGapnOlcuWMRW7+TjeLOBS3kNSAHjgAvHc5PWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644004; c=relaxed/simple;
	bh=FPDrMq+XXIYVnA2vxX/dXx8+DI8MvzMK7n/I8l8+h0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fnf4MlseDlyqom7ahgLJDdQ11hVbmoVuR1S0D6IyN4P/MymCzHvHjmTP7gJ6hsVIsad6pv0gneYMqXYGvQNS5wC8jZa5IBwa/0log7BDlwTWw7ykHkV7tsUTn71snj+QqHufLlVUeiTYahuljFrBQHHN79OkIS3qn2hKpV27Uys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpEV4CgH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpEV4CgH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so31387025e9.2
        for <linux-spi@vger.kernel.org>; Fri, 01 May 2026 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777644001; x=1778248801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV29etHKmeXpNOvM6Yg7tazjewCc3IV5UL8KyxdRZok=;
        b=NpEV4CgH9bLaAomUyEEbnAYQcSvLD4yPF0q/pNbuSBNO41D636WTeVb2JlCiZpmcpi
         wmhhBUHEGZEuIrJ9c3tK2ONSs7zR6G6zW0JLfTf7LAco+itrdxzkdFPQgfs2GmEdWVA1
         C4rEGSzhNTMJYrgVvu+3NPIUqYLwhLscS0qwlZp1oZtg8ZuTlQD+Ru50BISWEthUnn+l
         hOFyvysnsKXm6+4RV7PR9hwzFfxg/YbYqr6WAGTt5AKF7giw4R8pZn3JdCZU2hZYlGAX
         E89S6vaFV+vp6iQp/U5++60dSsLtVuHqHZA2y0LhEs1StjgFMLU8UZZE0LrQUo1NVV0I
         AQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644001; x=1778248801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV29etHKmeXpNOvM6Yg7tazjewCc3IV5UL8KyxdRZok=;
        b=GR8W3HWxEhXFviA87dbX1OnYkcbnCmIonTcAUPENI/TPlMVq68CzYRuGbVvH3xkfV7
         DcNYZZ6x4000dfqpfe1/4kKm/gtq78rf/X0XRlcqFaRpZ7gwLL/DbBRlThsctKd52qPq
         8IsyVr7aZYh124GhxyB8zAepYhLVnGekKszO3cQ2KvVNvInnT/Ti2W28QqYD/eLlbH+E
         O4eETgY4ABpkg+0Q1+/4gSNF5QywFSjCmUo/LubeX1RYF/vqwoSURslBSGxVmsKQez8o
         ILxVcq1dLvCvUNQqwfztxU8gjYdkVjqfdQbxLFsYMKfd73CwRVqG+aHWcBGNTQdy9HPp
         YSZQ==
X-Forwarded-Encrypted: i=1; AFNElJ85KBCNCSxDQhATWL7ukym5d6egEFfCLJ24obYZ9iyM/grL3TS3EQf+5yE1jS+Cz1um9m+/BVeHIC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweidkkYcqThLL3PSjhNDQXqLuk/7lyfT9DY+uCh0dQQPVdEkVG
	PYMZzHmml5GgxuRa1o77cNZLz+jpNmxcSJA5EewY4rZYvmr/dKsK4AqH
X-Gm-Gg: AeBDievBDlYIPyscJIr5PbdWba5V+RnrbfMLOpIcBNsIInqXHZHyScg8Gav06jC4I6F
	UFcBuiGlMhjNgiwKtFulKUoktbsHdPnI1iuwq0lZF9qjB/nbB/WrVF/mTLBHyObLOHygmZpiAVh
	dEg2jngzuKwy7cWEM82Il6dhfnNJL1NbwaKZT+dhFJel4J6dKWEXQEJSig5QPnmKAvoDbzgER/s
	2BnYpoU9j94k4V6QFacOXxp0d3zgQz1ayS9wYYpefYle+CiwE8H47uHIeqHws0AXtmn8xRQ9Dyk
	Feh0aw1MeTn2gUlENn+I31kTv0QdZr4iJO2TYSAEpOf9s8sQOEvY+sC/fg4Rcp494O73FtV+ekF
	NmFXPtOhSSSVvLzPGAmnvxo52wEvl/BDy1Z4BGRsNuHQd8VXIcfIMm79Iofz3QzzD7TR+ta+gAy
	vijyfNUN9t59geqUlmvwqgUihypA7S2dLHNGgkNtCYwrOtHY2UVLcNjiF7/MV/Rta7eA/96HKHD
	+3c
X-Received: by 2002:a05:600c:a401:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48a84452161mr92478485e9.10.1777644001371;
        Fri, 01 May 2026 07:00:01 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b768fdsm4823539f8f.33.2026.05.01.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:00:00 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 1/3] spi: imx: Fix precedence bug in spi_imx_dma_max_wml_find()
Date: Fri,  1 May 2026 13:59:49 +0000
Message-Id: <20260501135951.2416527-2-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260501135951.2416527-1-john.madieu@gmail.com>
References: <20260501135951.2416527-1-john.madieu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watermark search in spi_imx_dma_max_wml_find() reads:

	if (!dma_data->dma_len % (i * bytes_per_word))
		break;

The unary ! binds tighter than %, so this parses as:

	if ((!dma_data->dma_len) % (i * bytes_per_word))
		break;

!dma_data->dma_len is 0 or 1, and `0 % x == 0` for any x; `1 % x` is
0 unless x == 1. The condition is therefore false in every case
except dma_len != 0 with i * bytes_per_word == 1, i.e. i == 1 and
bytes_per_word == 1.

The loop almost always falls through to its end, leaving i == 0,
which the post-loop fallback rewrites to 1:

	if (i == 0)
		i = 1;

So spi_imx->wml ends up at 1 for essentially every DMA transfer,
defeating the entire purpose of the function. The DMA engine then
requests service after every single FIFO word instead of using
multi-word bursts, hurting throughput on every DMA-capable variant.

Add the missing parentheses so the modulo is computed first, then
negated:

	if (!(dma_data->dma_len % (i * bytes_per_word)))
		break;

Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA mode")
Signed-off-by: John Madieu <john.madieu@gmail.com>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e5c907c45b87..7ae8078c10ef 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1836,7 +1836,7 @@ static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
 	unsigned int i;
 
 	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!dma_data->dma_len % (i * bytes_per_word))
+		if (!(dma_data->dma_len % (i * bytes_per_word)))
 			break;
 	}
 	/* Use 1 as wml in case no available burst length got */
-- 
2.25.1

