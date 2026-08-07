Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9746EF8D
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098593; cv=none; b=X/22OQljm1hMPOdukGjgLeJ5AwbtKHGP/MoqvmcBemM6UN3ZcemRSzdWbbPgDdgAuQJV4iK5e4jftW8QxMRorwLUX6PtcffUe+hjmJzd19hkROpBiP6TPm/6LRZUVUDRMScJjt+DPpT+I4bZdeOidI6HVHV5qk7htTlnoxrlQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098593; c=relaxed/simple;
	bh=WWAAQdVCBeXAfxIC2KLs+oriyhRks9JZ8iBNmRWlKIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfakkkRVJ/qMePLXN2nZ2ckHD9PGM9Q14u/vDi25G/pH9AT8HkylTO0y1ZZrpzhzuwr85JKCN2K5+fM8jQULTMTYz2JoonpjHYirAjnlAZMP4Nzq21tqVOkkg3dNUhrB+HLAgzKJpxHZNxbDWYGwlICwcx97u7vUA2vBPQ2EiYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azaWnCjg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azaWnCjg"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so3398867a91.0
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786098592; x=1786703392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZTcrQzGXuunNIwct3+GtblbyDkGvD9ZQvC5QSvDxeM=;
        b=azaWnCjgG887j/YkT0g3cR43WfIGzJbl95dM65UShK6e3zkZMSubJHJaK8UOL2ABPn
         /r59IQn+KlBFDwfm4VFnjmFjrvUN7Qs6b/pAGqRp8sWu7gVSumQvM9p5TZR0VLDOSB/S
         xkcJzRPP1KJHDflD3h68jG1podk5rE2/swT8GyQE5iMLH94jiPfN0KPH+mpaeTk/wZdR
         pRtmkHOGuSFgyoTCi2Y2ao5Cc16XxaZHHMdvUHqgI9pljSRsn5Lcy+ijKoSMY7ZvnTaD
         wxo7PbLnJmg4tsBcuCXYWByOmAvz6K5vJvyG0+fVWslaaEJFF3BepB/Yd6DPK8UWlhWR
         scXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786098592; x=1786703392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZTcrQzGXuunNIwct3+GtblbyDkGvD9ZQvC5QSvDxeM=;
        b=YjkdC5vRiHs+ZkTjqDa5uz787iXvjoTaHmRJtOiDeejKgzRcvaz6yLE290Ov5F0nU3
         y6G0ggvodtn2QP59akrSwEAXMmUfSeZ21ueFYBg9onYFiRhBfhMw58hgROA/VRPh3cgz
         awfrE1ZxHJ3tofi4+VxaulCQDR7GLpBva82/LtNr3tEPWl4nJMRtdPczWPvJCgJLtYy3
         j01sFPt9UEZHr8VpkTKsmT/oucA6DNCUV8McguxalJborcquo1G5oEmEa8IWOdTHutny
         t+cxIc+t9iR3Cgnou3ZqH38ZxP8b3INAiQfGzZ14E3ae84qyMs26DPNbS8lEia2HXG9l
         fGGA==
X-Gm-Message-State: AOJu0YyyXSRxLCWLzxfl9wRqh5QGBXhNgzHdrI103TfdrFv0cbwg994z
	i31uy4C8ck4amdenR28yjtf+3+zxcmuGFcYrA9hX0DPgULda7ZUK4su3
X-Gm-Gg: AR+sD10vIASCu3EQvnq+x/volySqgh4qL16xxL/+KPwDSfHfGhaFE/C0I7v0l174KHj
	1f2RyC8xzHzIAToomgo7OlGEk1thim1VL1bm9RedEIYyonL5rd13mr/8V7bt9Rd4zZQG/bUDL2d
	o/OOrPq3uWXdVx03PbYMMr3HePeHVaStGvktLrCrGp6/uMRjVlQxuXlfT3X6rq+cIDVssFgqI7r
	kIhya5c8dz2oytldzEE3cUIpNvNXuzN2/TPrZ+OvLKaAZvCbH2/q2CbMP3CagXNHps8rUmMk/hj
	DrMErS33HPUFRvULJPtMxICOkgQQFm8HIM8raqV2AUQa25onRrCsUgcqo13gTqdLvkoJbwFP6Gw
	RnrAJJz31aTmC3JjbCIjoSj8YncheutdNJ6jLeNfE6OSHR3pJup3fVmDP6b6qF6036jL4AtDHJ2
	Q9IYCPQIE6THTlEHzi+mWxXx1yKxEK1Phy1cdE6H62djXtjWEaja8Y2XEGzCzx4CFdH5+nL6TDJ
	af2avbqnHptgDhgsfkN0RsYOJdaqwGKV5qTB4iVUEMHCenB0EE4WYiz/TOLLjnCF1OPGg68hlQQ
	6/pp
X-Received: by 2002:a17:90b:1d10:b0:390:b41a:b92f with SMTP id 98e67ed59e1d1-390b41acf77mr3051923a91.18.1786098591764;
        Fri, 07 Aug 2026 03:29:51 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b1389e1fsm1133614a91.0.2026.08.07.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:29:51 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/2] spi: mtk-nor: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 17:29:30 +0700
Message-ID: <20260807102932.45785-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
probe without the IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/spi/spi-mtk-nor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 74f34537b02c..6b9a5d728549 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -895,6 +895,10 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	irq = platform_get_irq_optional(pdev, 0);
 
 	if (irq < 0) {
+		if (irq != -ENXIO) {
+			ret = irq;
+			goto err_disable_clk;
+		}
 		dev_warn(sp->dev, "IRQ not available.");
 	} else {
 		ret = devm_request_irq(sp->dev, irq, mtk_nor_irq_handler, 0,
@@ -928,6 +932,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
+err_disable_clk:
 	mtk_nor_disable_clk(sp);
 
 	return ret;
-- 
2.43.0

