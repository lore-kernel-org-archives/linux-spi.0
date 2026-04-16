Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B03B7B9E
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344414; cv=none; b=jvL7Fv8MWkBChVEHAf/gSvbAB/+ir4rsAlmVQr3zWQthlT6CJ8dczCqKkrVetYRYJ2u5lKeeEaMq6xmMCT2yOviHAUP+fhMBS9l7npPJkfwy0KGm1On2H2T2NHsLgpG8acnkWZuoQLWL/0KORm7p4s3AttpX3cMdkUzIKsQwuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344414; c=relaxed/simple;
	bh=XkYW2/z4LPsF75ss8CCVDNVzt3DbKPrtELWOw2qUNpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iKfCAUV0zLDQ5Jeh6ZFVDoH/Of6OmgrFW90agZbhI02osIiFV3poTHbxq832eb8BAHkuqHr/XANMbGW3XPDYtlP8aIDrr4Tjkkfe6ndI+OPyrTRBDkMo+9louC71JhTzM2G3hN7zGGz+wen9liN08n/lznEqVWRGFOHMqcZDuuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUALjbk1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUALjbk1"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82748257f5fso371769b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776344411; x=1776949211; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17r2Zj41sTJHtEDMLkRaAXUCQQ2ej07SXH4WFnjsKcE=;
        b=eUALjbk1CROdcK2TzNxed3SNikjwjGGirzgTUGwy6f73dcDWGOCf4N+XsmbVZ0FRfa
         CmTxvmdmo1UAbPxmI5DSFTQPjICBSkSKRgpovjRktQXMvidXm8GV6ZyT67085tQk2Hzi
         szLxbQqo5tcUCo7lFVmIIh8J5oFDbdG2hujMOMh0qiw1C1WXHLKaG3mWFgi0Soq66zXu
         5spE/DGmKEpRjOpx8m7DATTWK6JgevtKU0S4PwYdutASxvRTCMfxPKCe3hNIdm+8xrVj
         7PRL0Rl5qwyHxPgYqgyBd5zGrLfKwWvc54ubk465j8iIpUW676S9QZ6rnsM+Wupe7NnU
         E3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344411; x=1776949211;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17r2Zj41sTJHtEDMLkRaAXUCQQ2ej07SXH4WFnjsKcE=;
        b=JLSTy8ycrvgsI6nRHd34SNWoEsC1bkWM5qeiFvEzJGV6cZ5NTHzjZMElFr0tPLfg4N
         sZXbHSmQCa+kybuu6bpm2vmxiWvUztbBmk7sN3QD33v2xTEFMnnLRE8dDgL+tzcxPm9h
         TfXaea5I8TCuoyYay/qBs9he2ubC6wfadFKTQdq+aDG8keWmk+Jlx68EYeYW7GZj1ug5
         VjGTKJD/RwDpGc6StQ8sI4RNnuOBWUT08kHBE6XpcDydt3xIs7vit2YJ8L8JN3wu2hMY
         4dp3DZJQlDGfQk/YpYnquoYYSz0/1Q4e/dwJRHUolChCq1rvwsVS4zlytL0dqA3XzUAh
         SdUQ==
X-Gm-Message-State: AOJu0YzIKdDV2RgrV8RQVijPCmiO8GAPv/rE+3NksiTdO0b0sw1ukPFi
	M7lH3C2LCgQEj5SPIjTNJBXLl6CcNCLleyLcfiqwCWq0YxLn0+U+7wof
X-Gm-Gg: AeBDietGkDQoj7p2VzPDMwWyMp9/tPXjqUYzALMJg4e6yRTl+DFY1lMuXNP/gsej9w+
	btAufm99YUkVnrHvIhQrR9cD1wH55NuysyzsP70/f8H26nJBMDj5FuhW7iNuWbTGxhiX2JAiiSM
	EOEFMfqFbL8pFMkaB+AUIMq2A/g9zpzrMK8CSs2maHwMaPA8wmAgH35S51XhcOBvDex5XeaawJ3
	5TSZlIffxpqUdoBOSAtr9BgoxeXg/jxjFg/Rdnnc0jv8e9i2P596EODXU3hhsQl3xzra7DLtykY
	E4y4rKbtqmX4N+3AGI7vjUsfBtTGQ1lVQKR9kYbrTqjsVx3Z5pGv/AI3MMIAfv5I0jcWDSibFzd
	DvHF309KM/4hFmVL//hvO0qrBnmirYj/CxqDo0E9Pzcv3KYTa+dcVpEKohiU2BqK2Bi2JoguR5H
	h//VyW3HY/A8V5gXpQY4hEn+vEXdMIp0RYZct8NcyYmOF8mVrZ7qorbi4P7Au1tsOTb0laG7S86
	oQtEROQiGBXWfoy4nppWsFvga8JMSdR/3qrTfJdug==
X-Received: by 2002:a05:6a00:4b4f:b0:822:69b2:7ed0 with SMTP id d2e1a72fcca58-82f7edb955emr1537377b3a.6.1776344411297;
        Thu, 16 Apr 2026 06:00:11 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6744c923sm5260199b3a.52.2026.04.16.06.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:00:10 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 16 Apr 2026 21:00:08 +0800
Subject: [PATCH v2] spi: mtk-snfi: fix memory leak in probe
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-mtk-snfi-v2-1-3f487689dacb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFfd4GkC/0XMQQrDIBCF4auEWdeikojpqvcoWVjjJEOrCRqkJ
 Xj32kDp8n88vh2Si+QSXJodosuUaAk15KkBO5swOUZjbZBcKt6KjvntwVJAYqoTptct5/JuoN7
 X6JBeB3Ubas+UtiW+DzmL7/pD1B/JggmGBq3FUWqN/XXyhp5nu3gYSikfnCK+3aAAAAA=
X-Change-ID: 20260415-mtk-snfi-651a984002ba
To: Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776344408; l=1691;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=XkYW2/z4LPsF75ss8CCVDNVzt3DbKPrtELWOw2qUNpY=;
 b=hvqwwc8rcn4/DHqZxkGuqafbHwwzm216tkjP8vosgvZYpH2kNLzP/08UlMoon7Cbdmk3csCV9
 2O2P1E4mabXD2roZXFjRAoh6MQB/XqRSgyNA6jP0ZBdKRjQIYEwkB0X
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

ms->buf is allocated in mtk_snand_setup_pagefmt() but was not freed on
the following error paths.

Fixes: 2b1e19811a8e ("spi: mtk-snfi: Change default page format to setup default setting")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Mark's comment.
- Link to v1: https://lore.kernel.org/r/20260416-mtk-snfi-v1-1-fafccfd288f9@gmail.com
---
 drivers/spi/spi-mtk-snfi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 73fa84475f0e..e616e6800e92 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1447,14 +1447,14 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	ret = nand_ecc_register_on_host_hw_engine(&ms->ecc_eng);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ecc engine.\n");
-		goto release_ecc;
+		goto free_buf;
 	}
 
 	ret = devm_add_action_or_reset(&pdev->dev, mtk_unregister_ecc_engine,
 				       &ms->ecc_eng);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "failed to add ECC unregister action\n");
-		goto release_ecc;
+		goto free_buf;
 	}
 
 	ctlr->num_chipselect = 1;
@@ -1465,10 +1465,12 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed.\n");
-		goto release_ecc;
+		goto free_buf;
 	}
 
 	return 0;
+free_buf:
+	kfree(ms->buf);
 release_ecc:
 	mtk_ecc_release(ms->ecc);
 	return ret;

---
base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
change-id: 20260415-mtk-snfi-651a984002ba

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

