Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843954A8421
	for <linux-spi@vger.kernel.org>; Mon,  7 Sep 2026 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784551; cv=none; b=cWU2q6LzAAGCHgOH+vsUi1RA38OzCdXWH+rvt5uCLc4G03rMBy3WiXIBgMMhLr5+4/Qcbo+FzoKpKgzZ6woF2EfZVF/Sbb+s+CJk/poVwKl/v+l0/jQab7td4a/goc+SHhJc98PT+8oJP2FpxRl+4XvuuRBYrbR3T6/Z0euWYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784551; c=relaxed/simple;
	bh=BLhbselfkKqOBVWiP4lT6W58q9Wfhi9f6WUsewOl1Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nb8NhfS4re6QjKvWZtlRH92IMojauWcaA5wI5XHzKtLDm8RFMZLf6AnMFjqwyfXSqiRgWgiM5BeMjU32r2moaYkOC2AKDt5VkoIwYwKe4VSFuzNDiLtKNw4BkHrX9Ux3sugJOUQujCp5GLQz+6ZLTT74v5a7BycQMpN0mtY7wPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnEZhpbC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnEZhpbC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so2967067a91.1
        for <linux-spi@vger.kernel.org>; Mon, 07 Sep 2026 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788784549; x=1789389349; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2Lms/wFPVMGmY+9gbS2lDfdGM1WBdzhI1fanedp3MG8=;
        b=WnEZhpbCYWOb4xtsf1SoMjOTmwLPUx3EfbMLA++TLgaOl2RCl72Dht6FlzrLNYQrUR
         7Ctdy8NwODkAr38cZdOciQTlrkF6XA7/4xx0EuTXOZyezjOdYJyqurRJD1ta3v6z+oWI
         IEoyrB4dgoXvFiRIBB7Otbrp8q4D+OXVxTrTMkFJJvNPVLyNg+O6E4LUnKi8vpj2TOe+
         B/6GNIr2WmdzkzvS9PBRocIdKVcO8rRNObxVmn/frhsRL7JZEeLHn0DyLErQZVAkWYE1
         gM6t7ClVdtBSOr9xPBVgiDCXmAPjj5mqAH6TVE30UnkYARTZ+aAMaASJa6FINbPJHl4j
         KmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788784549; x=1789389349;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2Lms/wFPVMGmY+9gbS2lDfdGM1WBdzhI1fanedp3MG8=;
        b=dixpd6025cwVRJBmRtPj6J2vLo9ZzA0b2qtamnAtPfKnWLilH+itewFSwYlJxw1+90
         FLR25J5sirMHhDpAOu/7jEGS0WQQ8T+QFD3gLfVa2U+Hq1V1cSEeWp7pYWFXuOwsV8YL
         9pIp2OKbqjWTUVITWaqS75dK6/kKpVN3Bi/pnRWkvCMBQIz0HUpooVBuoQW0CCptz3Cu
         D9LB4WxEs9Ye5sbVUeYb3idhCzpb4goBt1etKlCXIJhEKxmP9fna62ApW5nu/fitq3RT
         FLS9/JJsH1iheFVh0v89Obnfs4NDwubIVJ3r+L/+r74/9dyQqJbZ+zi0mCQJA+tK8C3b
         yJuw==
X-Gm-Message-State: AFuF++npx7TUhZ76qjjprBL/jVlT9u0jVUx6piqwhWoFn1y6yKTjjoJ0
	6+OyJuOCmd93U0vl4tPNNGb6xcwIpq8dIVK+c8nmUcxWjyyeZvkAvOAA
X-Gm-Gg: AYBFou1ZXGlMdYnMptWsGD+iShibufGqptc1ydAVbEc9ItMNDq0aZtTTT6MGnQHgBTI
	BCpPKX4LghZrqVj1zJMsB0u4EjxxVqc7xXRI0PjnKxOoxqO14eTcLWEhzu0mJcPY0tpBgVyKVDN
	RZPU57JGRTaBfLHylEKNx5/58+hYt3GCpymLN84aEVwmNOsVAGgAJUG1TbPeHrnjFQghoExtBds
	ScZ/ekXY5qema9FxEgfsq+AfbYy5NWmgjXEvUJeKBRxDTJzJsrPHz9b1ezmSraMmBXanZgBRDHO
	s+i36L1PrgLIZfaLnkKAqrF9oR/rY8hE3aBM3InDdzllN7ng1kHvSUNJ7c5C45B3J8srorWZvbK
	Q7booW5Gv1oZmm/7wPpAOwsl8Fn+zEFxTQ4wpToxTTpzZfrsVgnfUXHRbBMt7XwpZp/sVbHtHy9
	SdIm+JoaYMdHE09MLQWyIZGwXbuYup2DBEMPw0MUEvUsbE25vv3atQG0I9RbE5qOnM/KA8qZ16W
	El9Tu3EK5CEdhsx0dIHv5WDJ/bKGQaHn6qHh/XhacMIVZCNlHPhO2Le
X-Received: by 2002:a17:90b:3b8c:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39b26242a75mr31333923a91.18.1788784548566;
        Mon, 07 Sep 2026 05:35:48 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b4b72f62esm14340890a91.5.2026.09.07.05.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:35:48 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 07 Sep 2026 20:35:45 +0800
Subject: [PATCH] spi: ar934x: Convert to devm_spi_register_controller()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ar934x-v1-1-71327eb482bc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNz3cQiS2OTCl3DNBNTw6TUZAsjixQloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AOySnrGoAAAA=
X-Change-ID: 20260907-ar934x-1f451bec828d
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788784547; l=1498;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=BLhbselfkKqOBVWiP4lT6W58q9Wfhi9f6WUsewOl1Xo=;
 b=HpJj81hqivICkbzn4O2Jkitr7MIqfrmBY13a8xfPgwUVZwkfP2wAlwFAARIC55NvKobTj0KOn
 5BHe3sj/jfNAPzKcJyCL3aC4oVEgf2lQ2e6368jSy5Eamj5tteukaXL
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Switch to devm_spi_register_controller() and drop the unneeded
.remove callback and dev_set_drvdata().

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-ar934x.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index 2210186feab8..01e51a30591d 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -197,23 +197,13 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 				   SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 	ctlr->num_chipselect = 3;
 
-	dev_set_drvdata(&pdev->dev, ctlr);
-
 	sp = spi_controller_get_devdata(ctlr);
 	sp->base = base;
 	sp->clk = clk;
 	sp->clk_freq = clk_get_rate(clk);
 	sp->ctlr = ctlr;
 
-	return spi_register_controller(ctlr);
-}
-
-static void ar934x_spi_remove(struct platform_device *pdev)
-{
-	struct spi_controller *ctlr;
-
-	ctlr = dev_get_drvdata(&pdev->dev);
-	spi_unregister_controller(ctlr);
+	return devm_spi_register_controller(&pdev->dev, ctlr);
 }
 
 static struct platform_driver ar934x_spi_driver = {
@@ -222,7 +212,6 @@ static struct platform_driver ar934x_spi_driver = {
 		.of_match_table = ar934x_spi_match,
 	},
 	.probe = ar934x_spi_probe,
-	.remove = ar934x_spi_remove,
 };
 
 module_platform_driver(ar934x_spi_driver);

---
base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
change-id: 20260907-ar934x-1f451bec828d

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

