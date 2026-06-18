Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A693932C5
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770782; cv=none; b=FDkQMljOPSRddHCX8JDorzjoP7aV9ThYfs1dFb6kqRws3gDo1b0S+Kw0eUqP/DKQAjW9dM4hMNIV9sUM4r6jLBWFuqrbWuAhcPeiJVR5ut5pBeYSqNpign1rqLDLZ9LM8H1Kz3vNWKKGo1bMp2Y2LXrt47oBLFZkBCkAfowiuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770782; c=relaxed/simple;
	bh=Xzt9rXmi2mIhjT9h0euihHrxiLZwMnVlfFfCMypqG6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYR0NQiSbY0KRJlkhVlW5sUejXqOMGfwIwEvu4m54aPEM0aqDgyQfD0Dtv2Yta2k+gW4QN4mwk8lmcnYzMOhgcnl6NlL/ySYRDm/Ikvy/eVfaqk0o1fWw17XsVcqxzE5gRYaYoLv0ZKSRGr0AP1qMH8E3kHLdAyShfVKvUSyD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nagWTIae; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nagWTIae"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so13564475e9.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781770777; x=1782375577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHLUsMyTg74XhoXorVOA2VOwiCUXj1JJGkjU8JYr5ww=;
        b=nagWTIae4H08mWh8FGfhU2MK/LhMRC1vEd3sdQAR3cYPwO51L5OmznMexDpHi8LOMv
         wJPwgqxq1DAo1sdHoIsm3W34u1NJjerNBLj0lVOndI+gl/9Yk45aji72ei3WKylR32sx
         Us+zYsIiQ8vtTMt20Bc8/zN4Zg++cBNBH+qEbpLcL66D0X5gXY6vGmEu9l6VGvzuf3Gy
         2QwCpq9NdGrGZvBSnxJhe4qr9h5l34/ytEnshUy4pux/KtRgQ5KDdllj7BnTpbWBgq+9
         oacBtTudHJ1WZtKZjp7QZDJUUhTkhcu4CHmfWdjB7v3VYXSZb2J1j6E90ETQqriEHdyi
         4ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770777; x=1782375577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHLUsMyTg74XhoXorVOA2VOwiCUXj1JJGkjU8JYr5ww=;
        b=Ly/ePRhxvSzzEU08vZnKmsWLnDzp0mX36h+YuNQl3PfgsJtrSpwXA6zuxkoNpBAboP
         xNIulzNyzs8uxg8ec1WiCU5EMZ28UppSvDwo2aN1qZ79D/1TCyYJa7eupU+qMJ3ayvKQ
         XG+etQyMkmibdvIGnr2aZKCdCRLDZaEc8vM0xSf4ilP6LxNINnDyJeoZ5Qm+D7NnbK8c
         dBBNwtV/LUBdFB3Yq6C61VlP1QYJl2VsucfvtwHkOaSdZKjDFQMy087T585rusipdT7M
         xd4Kd6o1Ovciix449u3TfNGMIutZ9QXPioFIax52jaLAMdocu4ZfY420SbRLAbEIeg2b
         lASg==
X-Forwarded-Encrypted: i=1; AFNElJ9Uj4u1T3Bphni3WKehk/kIWOXTA3kHTzE+UcrItHZlu8zisN8jRepdf+cZZOReTclnAyGAtvAbHpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCT1LsmvDMMCj/p4R3WdalTCk2Qj/a3etSe/XlQaXhvN0RLsH+
	xcpItIw8hYTcKYLUy7JYD440t1cWNr1jCXLoD8vR1LjUbWgl15VvTdUs
X-Gm-Gg: Acq92OHBV5TBKd0ddqQKh9ENWK0g/T3d3hvAjsd/rH7GC9HRcbrzjKwigAcbnN6Y/Wp
	mqfAkySFctDvAK7ahwW4+ddK9fSsISLtRlHZaNlNwRFctw/rk5/JwHeSnctnkaExDWpIG/5F//e
	2Joo+NV5SuPt2x1UkLGJJTHQYq7GFGRUPY1vtGuJzw6ylPpfNflfm8nyeqjiPvNu9Yxh6uOZonY
	DGLyfDNJc+//wi8Rt8ZTxzzDuZxLbu+D20fPq/L/fE8Papxb9HQ/WD9N5fso4qFeaD+TkmbLlLh
	lFccwN3JDncGG+NyZKJl+aOpCKy3OEv7uttvu+0r+bCNsidrQ436CUl5wnBPj/LMeh6jU0oyMtA
	kEXKdkGelJIPjbttMVcpVbrDVqr+w4LtrDenJfAKjcVTthgGHnsp2iUFw1iVfH+MVrDRYWt0MW9
	kOz+VwX8EdGKzBjc7QYUef20T/tQdo5+J4UBCncQ==
X-Received: by 2002:a05:600c:e556:20b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-49238193273mr26940905e9.14.1781770776284;
        Thu, 18 Jun 2026 01:19:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f21:ea76:cfd8:a8b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923a1d3fcdsm25451445e9.1.2026.06.18.01.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:19:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Quang Nguyen <quang.nguyen.wx@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] spi: rpc-if: Use correct device for hardware reinitialization on resume
Date: Thu, 18 Jun 2026 09:19:30 +0100
Message-ID: <20260618081932.172168-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quang Nguyen <quang.nguyen.wx@renesas.com>

rpcif_spi_resume() currently passes the SPI controller device to
rpcif_hw_init(), but the function should be called with the RPC
interface device.

Retrieve the rpcif private data from the SPI controller and pass
rpc->dev instead. Also propagate the return value of rpcif_hw_init() so
that a failure during resume is properly reported rather than silently
ignored.

Fixes: ad4728740bd6 ("spi: rpc-if: Add resume support for RZ/G3E")
Signed-off-by: Quang Nguyen <quang.nguyen.wx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 1ef7bd91b3b3..b63c7856e758 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -206,8 +206,12 @@ static int rpcif_spi_suspend(struct device *dev)
 static int rpcif_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct rpcif *rpc = spi_controller_get_devdata(ctlr);
+	int ret;
 
-	rpcif_hw_init(dev, false);
+	ret = rpcif_hw_init(rpc->dev, false);
+	if (ret)
+		return ret;
 
 	return spi_controller_resume(ctlr);
 }
-- 
2.43.0

