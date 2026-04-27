Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389A296BD2
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311725; cv=none; b=a/qyJe/PxuPH1jIBrYJkL5ogULPtVC2+rVeuM1MsrMzxsROmMfQonYCVpoN7cIabzDD6XCdcljEscg0QSKJcM5HxzTZ35rA+jfHecCumUqkUCEU/ttR2+c30y87jDX3qYTwyuio1eGshXeDdRmaZ76Cp5RzPVHUL8hCDIbihOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311725; c=relaxed/simple;
	bh=XeSwgOZMpfYnktBLdo2F/0kVCQFFtK/6gXhRKpyoyf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KAGegNtMG4Qh7o5DWauqRUQcriueadWPoHXpoL1kbvzW3XUjsCS2rsM4nVBgQuRUCwhf9eWez83b2INLzLDmrHS3gD3helL7N0CgLMvfsFGr8US0Ho2FLm9Vttzjyynh/xdnP73aVJImvjLa/0aqvUWZjnz+DzZW/7PMiXbYZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR6skv13; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR6skv13"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab46931cf1so78483565ad.0
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777311724; x=1777916524; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXUKL96HHtXT8Swed26n3AhG8V6vfxtBOdftEg8YXiY=;
        b=ZR6skv13/iwHogej3ghDieb56/dUYCR6Q9b44kGcZthkjfalH/heI5N3pBFb/1ympw
         TmtC9AJmEIMvgKzCTEJmG1VqD2LA7Uwmk2Lf+Oo0dcPawoFlPaXSZ9xg+7r/CNLPxwLe
         VOCvBZ2aO4P8l4x5d/rj2GEtCek/tErpW3KV7Sx0GvTAOUYULS57EZi9X1ujbKhPm639
         U+Xt3GHKHsiKLaXlGkWZ6yaevbCygx33Hflnoi4etV7sKxrY6FGpkCwduMCKG8tNANvg
         fOv0lwJvr7z0UjTZzeFc6shJ6667tZJVNhDjsY45+LqBx+C75ATjSqQsNbTJs3wv4syx
         7HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311724; x=1777916524;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXUKL96HHtXT8Swed26n3AhG8V6vfxtBOdftEg8YXiY=;
        b=Hg++3MSWFu8FpKjK5FopxvRcQL52m1ZI96OBJQA653uGJ/ngyUsIXBGXqoCmRjKbG/
         AsWzIVuF6UVB81e6LDndOp52nxV4sd7i5yvciRwH6lvofuzJ9PNDGWaDmH5mQIG1RT+K
         Jwuu+5Zc/6hAcmYSZBeTAlRevgHsSs7BoEOnCnUGxlgZjnTXSrerao5HwUEaUFg7LuWk
         kjXUDQwZ/wYTXIuIoqC0AF6WhR5BKrbtViZD8bEMAPTgrm9vxCNerxbTqs+cXxFqFfQY
         4bPdRurL6FZuzzBL4B97AloB2UacpFewcUEcVLuNN0830XrsXYyruPW8QACBRcMiOLIK
         eSkA==
X-Forwarded-Encrypted: i=1; AFNElJ+U5rudAN36jYkCegMRnq1SA+en4uExG2QGphoRqRI7ynwdArEA8RhzGzVMP+EOeAW4NIueihPHKOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6crKzBG4DZs/+V5BwnNpG0p0k2Dw+qSshKdxu7kHR5soldzUu
	RNzG2g4FopWF+SHodoA2fL/6X2WUBGJxEDqT0dTsHRJjCwSmM5MLPoAl5hh1p9RUq0A=
X-Gm-Gg: AeBDieu5GJjfnhGIB+3RRNuUa2rNgX0FvKfRPqg20+NzO+eZMQcJARO83Lycaf7h8Dn
	XoTNuOsNM62IRp7OrldgpwBTPnfVMpMvwAsS+WFBi7l7aAhacA1Xp174KCIFnCOhllX+ngDUrXq
	rL/T0+aQwbk/Q1fTmVKnlRtezjHuLlMz+0w5YRnigivMOnMcwk9qBV3tga7sgyHWabodK1I7Qg6
	oHg7aAXfLc3VVeQs3mAfw/w/MFn0dyfIc4NRIyL6bzSz4sbQKCLhOJtmrLH81/E22g29yoSY+oS
	RYHN646tGvS00Wb7VQdGR/0Twoc1xEOjA0nJJGG/zYdY7BmVVWC5DZvAVfuZuduu7EkPZi00du6
	zua6NeXkrdf++nFKF/+0B4cDpIZLnale5PBtqnUdZLQKxhw9Da034j2FnzJ2fhr3WG+vu94avIC
	J9m+lHQ/ClKY2bsOCBT4fmkMn3lwk/+iiXGpH8CPrluoB4sqOVDfRR9QtgSew+sztAzkikQbbwO
	5ELRyoT4lRAb727D+A/z/k3KAkmbho=
X-Received: by 2002:a17:903:2f4c:b0:2b2:5070:8b with SMTP id d9443c01a7336-2b97ae1a058mr216655ad.1.1777311723609;
        Mon, 27 Apr 2026 10:42:03 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aaaf65fsm755695ad.31.2026.04.27.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:42:03 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 28 Apr 2026 01:42:00 +0800
Subject: [PATCH] spi: amlogic-spisg: initialize completion before
 requesting IRQ
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-amlogic-spisg-v1-1-8eecc3b446d6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOef72kC/x3MQQqAIBBA0avIrBPMLKyrRAuryQZKw4EIpLsnL
 d/i/wyMiZBhEBkS3sQUQ0FdCVh2FzxKWotBK90po6105xE9LZIvYi+xbXuDrsHZWCjNlXCj5/+
 N0/t+3maipl8AAAA=
X-Change-ID: 20260428-amlogic-spisg-e5594ea3eb48
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311722; l=1265;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=XeSwgOZMpfYnktBLdo2F/0kVCQFFtK/6gXhRKpyoyf8=;
 b=OFIGxJd0HqHGcsDa69LDE+5exY7+qUnmI0oSnRQ2d+dvnySkgXxPzVkBoHZYuoB3sTJOnzLs3
 d6XGyssMtjIAQj+SEwMTKdL3bmfjaiVsFkiO/jv3yAvePG5yodt/Lbg
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Move init_completion(&spisg->completion) to before devm_request_irq()
to avoid a potential race condition where an interrupt could fire
before the completion structure is initialized.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-amlogic-spisg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 19c5eba412ef..f9de2d2c9213 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -794,6 +794,7 @@ static int aml_spisg_probe(struct platform_device *pdev)
 
 	dma_set_max_seg_size(&pdev->dev, SPISG_BLOCK_MAX);
 
+	init_completion(&spisg->completion);
 	ret = devm_request_irq(&pdev->dev, irq, aml_spisg_irq, 0, NULL, spisg);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request failed\n");
@@ -806,8 +807,6 @@ static int aml_spisg_probe(struct platform_device *pdev)
 		goto out_clk;
 	}
 
-	init_completion(&spisg->completion);
-
 	pm_runtime_put(&spisg->pdev->dev);
 
 	return 0;

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260428-amlogic-spisg-e5594ea3eb48

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

