Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD626982C
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151452; cv=none; b=RGGpuJmTKjg4HpyeJ/HOE0V8VZkYUDc7UwT0EtYLVkx0AmyiZpTRKPJuCylQ0V+KFqRiWh5OKGcTtgOzLccUIEHgxNH6ii4IAwwAAnOUR1xNZFuohvSJmX4nfjYo4FmGaKb1CM70ytD89un9L0hy1pRGUHN3LvozVWVIUfq/5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151452; c=relaxed/simple;
	bh=V8sxUejU3oshy12nannqMe4zDCxxI9tmMfyPnXIdqXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/IPYrO4wq4yDin8nh/TiZF22GrSHN6uqCaobf/hssnzbtSTik5k9gzQEQDoab/lQGd+Po3o1wq4D9DNrrPhV2CN8eXVnLamNO2zS6qPQM5765jAt0FpG97v7wPXLEFAjpqz9+LNs/lJxIaeF4JJJpXC/7/CBq5piTTWQcOCycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqItUkfu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqItUkfu"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80170db7d6so1218833a12.0
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779151450; x=1779756250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdC8zYkA0OPJUTYgpu1b0/aN5X6hmebuEheSTqkok7c=;
        b=cqItUkfuT0DjCT0OZrmgx8veUj7GXJpPK3THIjn0qEmv85rneG1tD8uKEG9gW8Tz97
         F04C9ezaBxMWasyYjueKfdcdjsigKI5GX217E0U7PfU6N5CekuQ/BRf+6ZM6cMzyQiA8
         xjWl45TwvSTkIHfFzmFCS0rl5LXbqZxrOb2QbpVQ3jpQOsiM8x2afXB9EmW9A0oasnqJ
         LG9foHBKI+PhcLPHOqqt6iE3xJTBQfuoUBXk7+iKkoH7G/6mBWvk/+qufqIYC2BZ0dpR
         5sqxXeXgBE10DVI8G033UAzG0CXBaqFM3DH96/BLXCARjTOzVn5IO3h/6IApz6DUaD2F
         vNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151450; x=1779756250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdC8zYkA0OPJUTYgpu1b0/aN5X6hmebuEheSTqkok7c=;
        b=E6yRoCfP/HbrddVm5LhH88JL2Y6O7tyc9eFL6B9dzSGrgPGlNveLgUvn9Uya2iWtrW
         4CJEdqLLOanqIACXy0uCGHyMmNj8M9MefCA7GamgoMBVxyt/3S9Nj59kzlauboOfxg8U
         Y1ANjkKF9KosQDOTUniA09hxbIwLhS9l8sGm1sL1aWncfRLK/tckG9JyMbbLO6vro1h8
         KCfUaa1EvTKFXPL8l13jz7W0RamH3UJ1agSnUY1rhbPQaie7GNvzZuzWkCWrghDMIjHe
         E8nkrqxo66EZC1EBySHt1xCVwJiGHuLh+GLQS1R+UrXvFW2BKgrhaR3kmNmnFrb9BNrV
         Cd7A==
X-Gm-Message-State: AOJu0YzsxPbAbDABq7MWAw6N5jDjXgGdb3DW2cXjkZtVOcaxk+6GP/CA
	0uAvhU+/oG+d+GoB1sFP2bOw8bvg3sa9L5LvAPioPDdtcN/ds2AAe3gCirBjNbmW
X-Gm-Gg: Acq92OGhbdfAncN8pZm8Il/5JyxdDjAsHpXOUpVAOdEelddaByRCCuRsU9uIF4dwstj
	8XI3u3XGsFhiWqNLUlA5VHFPEtt/wZ0aWD1dmGMPMk1XnRislisNUZIrrF5FtEN5S12ag3BT+Vj
	Cjch289lCVsfr8m+iP7mK1rIye3bOve8vd1d6onlkejZR2WyEJc0IwtbsIfzQipFTRw3wsY0CDw
	pHy0LwFyXtuFYs+ndGR5Dwa7RSw7qlJd2TEFSYNtdTIKKL9ZzW66oELW6MW97eb24Zas/DLlDZI
	CZtfU721ysX/DLcrYE2wmMzkxnbKE0qjetTSTSIR2Rh87IewQiGUyaNDHcEHbrziLUqKVjHfNxf
	qJ8CSuX9BiaHK216HFWm4SsVhap1YJG3wj7ML7Lw13gGLw2+ss3G+iBsp/IApnmPZp9kSnUbuKa
	r3L66QYxMQZIZnqSu1Wpcc5ZRqAg2LFZ8Jo1iQOFUJyMx4Zbu8mZsuqsQCXpRafp2ELpvGNOerN
	C9Gh/Pnz63sdZpVKNWfG8owFqJd2Y6Ef8g=
X-Received: by 2002:a05:6a20:e212:b0:3a3:a5cd:5621 with SMTP id adf61e73a8af0-3b22ecf84f9mr18771668637.51.1779151450175;
        Mon, 18 May 2026 17:44:10 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114c08sm15413080a12.23.2026.05.18.17.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:44:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: omap2-mcspi: Use of_device_get_match_data()
Date: Mon, 18 May 2026 17:43:52 -0700
Message-ID: <20260519004352.627148-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_get_match_data() to fetch platform match data directly
instead of open-coding an of_match_device() lookup.

This also lets the driver drop the of_device.h include.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d53f98aa0aac..9cc078acc13c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/gcd.h>

 #include <linux/spi/spi.h>
@@ -1481,7 +1480,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	int			status = 0, i;
 	u32			regs_offset = 0;
 	struct device_node	*node = pdev->dev.of_node;
-	const struct of_device_id *match;

 	if (of_property_read_bool(node, "spi-slave"))
 		ctlr = devm_spi_alloc_target(&pdev->dev, sizeof(*mcspi));
@@ -1509,10 +1507,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	mcspi = spi_controller_get_devdata(ctlr);
 	mcspi->ctlr = ctlr;

-	match = of_match_device(omap_mcspi_of_match, &pdev->dev);
-	if (match) {
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (pdata) {
 		u32 num_cs = 1; /* default number of chipselect */
-		pdata = match->data;

 		of_property_read_u32(node, "ti,spi-num-cs", &num_cs);
 		ctlr->num_chipselect = num_cs;
--
2.54.0

