Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596338B7C3
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722165; cv=none; b=HDrqOZ+pnGtr1EfQtBSwGEROdcEL68f9mndk68KJJlfJ+WwACiZxNvaR3x8JeWA21CaLxPdy+OUrjntA8GjxuIYgUX9vkmDrISgVt+ofXiypl03sHfX8Ucf3uobX6poHgZrs+/q0WW4rZkqO/zPTP++KQEK2aA1ETtMGHpzQA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722165; c=relaxed/simple;
	bh=c3pkZ4yaYJT5mT5XE0KdrjdNHM42/8KaKebxAgWgvPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nm+sPXB+xr5OoNkzsayaYnR/EynCUe66I40UqlvAZwApA9eL5Q0BC/TOwHh6A0qsITbXpr6i0Cs1wSXe7t5H+WR3+0cv6hwHUT0FK7W40DcII0HpCoBkm3kuwQxaWANG5/5+1dIBWY3CFDRicmVQvMxzj1OW2l17YoBApNvpkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br2qJjI5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br2qJjI5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e0688b859so266691b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784722161; x=1785326961; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JnCZkgkGfZi2Ykzq8Jw5LKRVV2duYzk4jC1BEsMVF60=;
        b=br2qJjI5bpKx1mb/2jg6BxHDlIiq5J26TQB/bzGo44h/KcZYRUoaCJB/V6W5SlHfUw
         Iu4nmNRDpbfocM4VSHNz3qKpqdMOGuexO+Oy52uPuWT7yqfgcWQkEuijaitVL5QIc1YT
         RV+DY4ctxFZA5QaMTsetga9/ad0Ppr4a+1vgYSHKCfCn/TmVDYhzDclwq6KGPJgWKGSm
         iJdesuHePbyEXz2tHjW/jxfsR6/3If7LVqsAzZgMG4dc+NUDTd3iKG0MjIsaezpBzVDy
         iR4yE0K9ISLvs0gyj5qw8zsagI2IdJ9rIILm31WgZL67o42CG49PQtfyhN9nW9nkzYT7
         F0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722161; x=1785326961;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JnCZkgkGfZi2Ykzq8Jw5LKRVV2duYzk4jC1BEsMVF60=;
        b=iMGU2pT5fITLIcoe7y16UJjUZx1LcIT2Vef6wgsvnbxIGwhZw1ordq0HniZ3Ld6ACg
         uTCSRo2eBuD9/RMxxIek1IOcMKhfN+brOrfU8+jHu4iMJun6v4Qe2lRJc4ChTgofo1Ud
         tq7oSuiToETFIU2mCyIfqbO9vqnQW4MxQtdR5O5OsfI4W/rn/AoEDJNFoQeJsDsde8oY
         v2Vj71Gh/t5Vj7E9NaoQ5Ef803YQIK/wysi5ZzV4sSFJi9uby1jjcBHzjR9tixDTsNeH
         xtmCgU0HmS/FSm6mDcgZeDoE00lkGqWbeQgH4CAGdplt6yFrOpVQsZmv4ZO9NGqGCJA2
         eQ8Q==
X-Gm-Message-State: AOJu0YxlS6F+bs6CxcTr2/QzAzwkxcb+Z56sTr5UrXzKvEPCoakBXCJn
	pHarNR/fMQhwTdf0kDztObg9umiufFgmXY2VSC9cTxUwYhifyKpSlURE
X-Gm-Gg: AR+sD11GtyPP1EC4kPqDD8Y449euKKVSuSz5eEJh3CUYjbGgFUnFS6E3/ShZOswlf1G
	Kx0iVyfjCXtWM0+S86/sijCOWV+ZtpLuVC30zEGoU3A2OGzcPyGq+WhhTKmZyq4fSWS312kCKln
	ftHsSFCNdMEXyLxCX6CmBuDLZqzYy8nqrM37cp9lRcEwmGVLJeuf0ZZgb95fpFlAlJ/AGSvIs9h
	U60H057hTz+RwMucQAG032QQD399ss89NDSXrDNfV/PIt3DUHQcV0o8WGCpFY88mz7czwltO64l
	hYeGVO7bCjT8CV2CowvonATOUQ3aWBpLW8WW/cpGmMXUzbatGY7BnD23QuNPa2+VH1tcGOfCn2y
	wSkD1itzwNkb2lf9/D7ylpgR4STkH9wTntQBibSbVbrSrrLr8CT38DwzkqtDDfhk2ApgmXfKVsX
	0wN4UJfEpjS9cdcY3VrEL1TqjRMXWVf7vYnP/FFW4xHPGJ03hvx3unD38nLTLMW5mJksNzzg==
X-Received: by 2002:a05:6a00:3c92:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-84c29305401mr23707166b3a.2.1784722161238;
        Wed, 22 Jul 2026 05:09:21 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17286798sm1200884b3a.23.2026.07.22.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:09:20 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 22 Jul 2026 20:09:17 +0800
Subject: [PATCH] spi: meson-spifc: use devm_pm_runtime_set_active_enabled
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spifc-v1-1-e4462a4c6a06@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOyyYGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3eKCzLRkXWNjs7SklFRLU0PDJCWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQBIqdjmaQAAAA==
X-Change-ID: 20260722-spifc-336fbde9511b
To: Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784722159; l=1841;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=c3pkZ4yaYJT5mT5XE0KdrjdNHM42/8KaKebxAgWgvPY=;
 b=LoDm1A0vxhBozG2ZbQAhtbUdmBpLnVMM36EGCfhoSXvay3NCvKqH10RJPwYb3BAxDUP0e9oA9
 12dhC8v+Fz+DGwjb2Oc++chA1I4nvnKvYojwuuCva2XpeIw0bXba4yQ
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use devm_pm_runtime_set_active_enabled to replace
pm_runtime_set_active() + pm_runtime_enable() and drop the out_pm
error label and now-unnecessary remove function.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-meson-spifc.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index e36aa94bbdae..f67a0d10b602 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -325,27 +325,15 @@ static int meson_spifc_probe(struct platform_device *pdev)
 
 	meson_spifc_hw_init(spifc);
 
-	pm_runtime_set_active(spifc->dev);
-	pm_runtime_enable(spifc->dev);
+	ret =  devm_pm_runtime_set_active_enabled(spifc->dev);
+	if (ret)
+		return dev_err_probe(spifc->dev, ret, "failed to set runtime PM\n");
 
 	ret = devm_spi_register_controller(spifc->dev, host);
-	if (ret) {
-		dev_err(spifc->dev, "failed to register spi host\n");
-		goto out_pm;
-	}
+	if (ret)
+		return dev_err_probe(spifc->dev, ret, "failed to register spi host\n");
 
 	return 0;
-out_pm:
-	pm_runtime_disable(spifc->dev);
-
-	return ret;
-}
-
-static void meson_spifc_remove(struct platform_device *pdev)
-{
-	pm_runtime_get_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -423,7 +411,6 @@ MODULE_DEVICE_TABLE(of, meson_spifc_dt_match);
 
 static struct platform_driver meson_spifc_driver = {
 	.probe	= meson_spifc_probe,
-	.remove = meson_spifc_remove,
 	.driver	= {
 		.name		= "meson-spifc",
 		.of_match_table	= of_match_ptr(meson_spifc_dt_match),

---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260722-spifc-336fbde9511b

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

