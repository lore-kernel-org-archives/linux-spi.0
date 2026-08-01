Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA33074B1
	for <linux-spi@vger.kernel.org>; Sat,  1 Aug 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606692; cv=none; b=jc+BcPPORgzQSqZpDmLqdcfmy9Zc149sAf4RfqVlXntoDDTryvIBCVuVhQH6nybAhOWwBhuloQBx2THSUAGYJGtHVeLSHVsYkOlYj/dB7IQihuzW93A5b9+jp3UPPISWiYnnXFjR/0s820pDKMdf2Oa5/7lOMtVsNfGYhb9Uro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606692; c=relaxed/simple;
	bh=yMtI9BK0fNpSFzuJ+wAyM1BWD3SMOzrFcrsFwAmmawo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q7AIRpQkE1IKr2ykqmf4g5BDVSo3tfJ81P9U2WA0g45LbCbLCfWxEu3cXTEYN6XID38viXsN+aOao8O/y0hD2ulK8G33LLlUUUm1bv8FeBT0QEILtFDUhpw0sPrnyf2pnXoGuMn6r8/L81iQtID/3VhblvTMimL0KUX18WcU7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dreQSDDy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dreQSDDy"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84874b52eabso2907706b3a.0
        for <linux-spi@vger.kernel.org>; Sat, 01 Aug 2026 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606691; x=1786211491; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s9EB+RS//J1LVLQYmJ1F9JsoVjN8nQoD7T3vVQUG2DI=;
        b=dreQSDDyCYl02bWeh//C17B9yHHWf42OguzFWJY36qy4sISjBk0MofkZoo6HxqWB+o
         JPRiusyDBrm5GVbwgiJI7bZJYbk5pgm10Lmb6mcXFK0IFo0R89FeJIPm66c17rELhDDN
         eOGINMqrrAGQcUdGvjYPWxObKP6iyWU/Ajem2ryfd4i1XGHeb+4/nfH/rwAuk2pwyPKJ
         v/x+BuhFaGiik16zTFEHkG3wPDApU8ahUO1q4QvLgcEZJzFT8LFHTpfc6jltkue3w9jq
         HPEyLVvXSpSMEoT9DLxQLjJSm1n6D5c49XEfba9MuxIqcCQaqARNgFgu/ngvauMRPko4
         ZFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606691; x=1786211491;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s9EB+RS//J1LVLQYmJ1F9JsoVjN8nQoD7T3vVQUG2DI=;
        b=Y2ex+H5ZENDGgIGz8rXCDpf57e/mjVPPaM9Dr9ooB9pfiENo7WtXMbl7dOm00h0sbp
         +2UoZua1nXxh5fk/8B0FDigCwjMMR/WQFGM7oWhH7jlm3iFfZV6pUyUTzFHaL0bo4Ih5
         ib17nSbBJ5hXLjKwYRiEzuWitw7IeQvvuaAQmWQWv+UC8W53ObLvLp+qFy4Sof1GsXbb
         Rom7NP+08HS0rugn2Y6f6EZiOZnnu2FrquJQ0heNJP+dihcd2zYrEYIH0p05aepb8pmS
         cK5uyGzG3HOfQKrE6KDWgphoLwD5luTY4i1utM4oboWXK5yZkzGRkxq+C2cGD12KTmf6
         b2xQ==
X-Gm-Message-State: AOJu0YzNs/hb2VNRDfbK6wdHkvGTwD0LR9BiiTi9Incje2bdSP3oMl5E
	qHod2U9LSKAqeqDv3BfbUa2QQLaBwAl5SYhOCAYrtJHLduWcKIzOdct0
X-Gm-Gg: AR+sD12d2rgd/lT8bMEcG3jGF6sTDnfbQ+xV4sE+lk9cVyIWtInUn5jO/gFTkGH/GC4
	AScxT60fbPULXvznSXrRgu4ixKXdGcmpgZrldvii7K9nP9aJoyE83YqFIbJXcQiGq2ydXdgkVVm
	rHTnx4VEHPPNlDOrt7JAcTsMfN4trH6mM0+0FpKEUa/uAR6EtN4bL8o/fbEBx1Fk70/JvM9Fzow
	ZQoOOFRpJUs6Wfc2K1GvnwQMptdzyKaIgKmQ20FpKMeQmQrz2DLRq1hB+Eu05ehiD/paKM236Ee
	VyWVAc6ydRvVVIn0TNeWRHbLuXA3mpDsY7dlQFkimQQsgpQcbECyLUJUY3rTWopJebvK+I6smQ7
	hj/latDyX2IlzO119Zg0GduN1EKy2XMsbsvtKGcup2FjMgdMlfIm8QDIO6XwlwQaCc76soE9ZFj
	dm137b5f2ttP1lOERBqpLNQE622602fjyquJ16+Md3AcvUGJeZsuZWecuHPmDTNjzFN0EpFT6lC
	RaZhSYWJq1W/qjXEbbXXUA0fBLCnCUPGQnScg==
X-Received: by 2002:a05:6a00:4f81:b0:848:2f77:e2e2 with SMTP id d2e1a72fcca58-84ee49b4dfcmr3807979b3a.75.1785606690871;
        Sat, 01 Aug 2026 10:51:30 -0700 (PDT)
Received: from [127.0.0.1] ([103.17.98.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963da0asm1851610a12.4.2026.08.01.10.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:51:30 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 02 Aug 2026 01:51:24 +0800
Subject: [PATCH v2] spi: meson-spifc: use
 devm_pm_runtime_set_active_enabled
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-spifc-v2-1-46e9d06a3217@gmail.com>
X-B4-Tracking: v=1; b=H4sIABsybmoC/12NwQ7CIBAFf6XZsxigiNGT/2F6ALpt19jSQCWah
 n+X1pvHSebNWyFiIIxwrVYImCiSnwrIQwVuMFOPjNrCILnU/CwlizN1jtW17myLl5MQFoo7B+z
 ovXfuzY/jyz7QLdt4MwaKiw+f/SiJzftvJsEEQ6W0NMppw/WtHw09j86P0OScv8eNlqKsAAAA
X-Change-ID: 20260722-spifc-336fbde9511b
To: Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785606686; l=1987;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=yMtI9BK0fNpSFzuJ+wAyM1BWD3SMOzrFcrsFwAmmawo=;
 b=6VtTQY9UDzYuad/EIaTRPmGT2JECVibG+R/klKIvnybHeF+an/RrExy+5fAkpr9Oe+g01/wW8
 UUVpgKTTUSeDht2aim/cUJxJiQ9JMVeQyIA2/Wk55yEu1mpxU2IROTf
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use devm_pm_runtime_set_active_enabled to replace
pm_runtime_set_active() + pm_runtime_enable() and drop the out_pm
error label.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Mark's comment.
- Link to v1: https://patch.msgid.link/20260722-spifc-v1-1-e4462a4c6a06@gmail.com

To: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-meson-spifc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index e36aa94bbdae..82c1c3c0c84b 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -325,26 +325,20 @@ static int meson_spifc_probe(struct platform_device *pdev)
 
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
 }
 
 static void meson_spifc_remove(struct platform_device *pdev)
 {
 	pm_runtime_get_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 }
 

---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260722-spifc-336fbde9511b

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

