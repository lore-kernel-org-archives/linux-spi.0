Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135D3909A2
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490030; cv=none; b=FRle/a3NwgA/xnBpTxYX9GeZ8i4bAdpHkIIQp37XyB06PjiFuk6tW+UcQB8fTDsd0CVo2/iNdwvOVAdCoVHL5bCmAeaW4/LSvmJBOdXlIMMtSCMqNqAzYkzVTtPhZaUBWo7VXeyx8/BQ8H+YonjSeOkchmQ1oSrL1j5XusFx1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490030; c=relaxed/simple;
	bh=nYXqTiHo10dtSNfnAo7DD+bsKJSvSj2cDsnWEaTfvUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2ooV1zvCIBExD224iB0UxB3u4Whp3dpxJjyFciqM6QSUBBDEclXMOplQih7BVV8RwY8gy+pvkHb8fEU378Dd3cwi9E/0iDeZ841Ijqp+mDi3v3ilaSmT3TgycWoDhTkdABKFZYp2P7oFwSDKc3q9MpUr/zyKoZy+Xm9jXcNl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJtPS69w; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJtPS69w"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389fb626b67so78341611fa.2
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772490028; x=1773094828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONkOXxIQWVnb1+anzni8v6vBr1Rywoh4igMBRPKykbk=;
        b=UJtPS69wmXc4E2CSsWKdOIA2AY/jbmneaosQCRYGeczuAWY7f1QTfloljYpr1yhvwZ
         Z652jvbkQBOzIRuJfj0wJj8X2HlbxxAZilbZxBIS+UVYAokjmnDBigMwrbo+GMw2tP+h
         qsgZzmMOalq46BtYqaX4lNxImfgno8o/e+J2qSPtwZGxy5rvvqoEdSIXzmmRbrdhZEE4
         0PsE2xFvWKZZ9bqe2rAu9aQ8u5wK3N9xHnIyoOD17ROV66BVlrt3zNwaIZPPkL1+/T8v
         tnmaJJlAX4TpgIUTMuROccOztd18TCQAh89ZasCbwHMCdsgA3lScjh6EBrvau62z8Bsx
         Bj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772490028; x=1773094828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ONkOXxIQWVnb1+anzni8v6vBr1Rywoh4igMBRPKykbk=;
        b=DfsqCfvjoExdQjIaNJwWN4jxZI8qpnP+mjWH5kmXtAplkPhMORnlH2sGga+0uSIwPZ
         PiQF6fLhEdtJCIEUXJdMgwNBRQ8pKnLSSPiG8jU3bWh21poA3aYQ+YKG4fo4wcULfIgr
         SAzVwvOmwBO3wSenPKmPblu0Uu10CEYOigboBaEel5jhC9L42KQ+WdSGTE6AVIqvCQyl
         SEbLW/P6DroYL74pxAtTeLMxf7OUqxBnycOaQj6M6bU+eBAeUx/ZBDmrowisczNZnlUN
         JZnWmD/CjKKEUZrgrJYufXrUeipvzDdcHEK3fNkkG3ghMVD3pSQhyF6gTJz0CJjSa9hM
         tw3w==
X-Forwarded-Encrypted: i=1; AJvYcCV4qikc95Gv1wi20O8lQBnS+i4v11nlDJMWEepWCaDXZ5DsgWicCl1lcH7WvACyuMF4xBShDtVtjrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIm1OvA0rGOsnzkrwqS4m91c8wjO/tNmLJaAhYDr5vjgCFMSv9
	kAkAJQ54+IR5SEzZW0JiPL7ogQb7x4BGys26qjgDNa5U/vZoBqN5RUQI
X-Gm-Gg: ATEYQzxRQHS7BTJIVymwoMR5iS2n9J0s6gdJZXUH/JoSxA9t3XJSO4MANKnhqHu2NAH
	Kd9glAAYm/8PxmV67c2gYWD99IkeHOfU653W6wPHT02UlCc0U+ml6EpvVFh4hRDeOBS093f+tbl
	ivUIBkEard8+BRdEeE49bzUvri/zSNDO2cFTuBnk6rrP81P+0jNN07Dg8kWO2d2EoKsuZJBucZM
	Yu/tarQzNjgN4D3gM2Y+K5VN5VDNvEr762rN+PSa2IeYqoPkIY2prP0T8GTjA0zBNRnypJ3NNVH
	5I1rtsmQ5O1xUFHFTiU34yWLrpvChkjy6ymQyF2Lv4XoLS0cZnJYkoUviyZNaaCVfZ8MVneFbrM
	ZJwav0fJwuY87uqpV4vnbi1rnzavWd8SNp3EdleugLuh8lSXDvaRl/fwMe/+I89zAXqD+99S39H
	3swpUNjqvgpRk44dImK18vfjLpyc0QSeWt3i9RtTkLPA==
X-Received: by 2002:a05:651c:1511:b0:385:e793:fb11 with SMTP id 38308e7fff4ca-389ff350b5emr90028181fa.20.1772490027626;
        Mon, 02 Mar 2026 14:20:27 -0800 (PST)
Received: from vovchkir.localdomain ([95.161.223.42])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5a12356ff20sm159739e87.78.2026.03.02.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 14:20:27 -0800 (PST)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Yakovlev <vovchkir@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] spi: spi-dw-dma: fix print error log when wait finish transaction
Date: Tue,  3 Mar 2026 01:20:17 +0300
Message-Id: <20260302222017.992228-2-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: 20260302113233.773414-1-vovchkir@gmail.com
References: <20260302222017.992228-1-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs, the device may not have a current message. In this
case, the system will crash.

In this case, it's better to use dev from the struct ctlr (struct spi_controller*).

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 drivers/spi/spi-dw-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 65adec7c7524..fe726b9b1780 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -271,7 +271,7 @@ static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 					 msecs_to_jiffies(ms));
 
 	if (ms == 0) {
-		dev_err(&dws->ctlr->cur_msg->spi->dev,
+		dev_err(&dws->ctlr->dev,
 			"DMA transaction timed out\n");
 		return -ETIMEDOUT;
 	}
-- 
2.34.1

