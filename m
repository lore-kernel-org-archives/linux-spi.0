Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B6420499
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119954; cv=none; b=byaO+kwV2RD0lHcZMqEMAIdwF9vAESiYueksO2G9vF3aWTiw/JUVtdJTngAiIWsdkWtvHdLJSz8RQO0qAxUAKDozZ9fuAI7v9lvHALik9oAjDtKThq8qQV4uWY1LkjEKBlZzpr1boSoHPXqdseiW1C18wO5YQO5tUlYPSLeINgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119954; c=relaxed/simple;
	bh=jC5K1NA2Qi20lryJrip427XM3Y5XYrk3Gmi9jleDf2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZNVHP8q4Cbt9cUOjqALSlAkwUtt8XTyGkcd0CJDaAoBPIazo8uenSvEhuwxmmtbR3ir2h3SQzA3nAKJ4i+ZByq0F2YYl/bXvgyTrUVe5dL/7ZLyo7jcfMffF37ohf9pJtN5Jlz4TE+HcdMKDdpen4fb8GZSs7UPJMYgW/RdXS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En+Y2EFt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En+Y2EFt"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2803095a91.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784119951; x=1784724751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RWcdIs2ci+zPyHZ1UgU5XfiAjrJantGzHWpSqVd+iVQ=;
        b=En+Y2EFtsEf4oRoe457udRunu//giD0BhNJ63jtqG8mtkEz0xSfJ+eBWu0MSnlb+FJ
         56wS79Wg+PUiZa1yXmrkFpECOGnVCyeQYveOvn4HX22mWzF06xFjvsjPNYUXKJYyWR5r
         P1hYGwAf75dQKsn5zJzLiTliSPSDqk+4llpx2iq9UVDATRt3QooqGY++PhXV4ScVr+YD
         X+n+ghnY6VShKZ+4qPiSvjpLBpCNTj1oQnQjqexmZrsarfAc/pmXqStF0bBHixJmuuQg
         DPqWyJNT5+H+s+Lt4JRQ8sd4V/YNJEjM3Rmf3QUCKetzfCsc8YRWu6UWvhXNab/Bx+d2
         rvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119951; x=1784724751;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RWcdIs2ci+zPyHZ1UgU5XfiAjrJantGzHWpSqVd+iVQ=;
        b=CDTUHK5DMU6NDfcyDFSQSafbdgWw/nxj6t++9Xa+MaZXQz+OMwRizc/idbJdLwfPWG
         Cu0/+VDG1YFhAlaUf03HTdKd1FLepvpCIf1XHyjrSiK3EPPaBZ/yHkQkNuQLXvf/7ebo
         zpvuYL/CnNaHLJBP9Lim00RurB60Mlf0zOoIzRUNo4dNxbRUFm6W5GFBhWkl+ioQtGST
         7XstaXQSimr7IwlEZZCLYEiqKvDykuQh1itXY8nEwa3loc9e06Xzh1PX8x1k1yPqBJXj
         xZKtpegG1+HuPoyWnzoi0XaRR1rS3byDlq0XoO1TBXyp5OyoEe18B178hfK+FJbzLt5m
         1cGg==
X-Forwarded-Encrypted: i=1; AHgh+RpBaZc3eBml60Lfu7m0Z9+u3yRgRKvdM3Lt2w0MW2SSZH7vO/cdfcTpC/03kAwCYcKZpmfS7Uzr8vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91YQO0ULB8jV/YdzJr6DEvAwGtp+/lpnnm8vy+dT9R33bZ1Oj
	SEdh76a5Ot838u9FmtxdBLmS2RrNBjtSP/cKW7/q7AIxFxmHclcsi6qy
X-Gm-Gg: AfdE7cluF1Hz0xUj2qqWwCIX5kMeLrLXe13b5SeFTrgaCHUG/o+A/L3mtOc6ZkAsJMg
	FMbZe/CPfeHV38157nYAiPinPTARWcB5B7fqawp0PYrdH2Zuy5pIeMmo1ToKbcA/tdTa928uY3m
	T8tyrUE41ZQP3OjlFRVzWnut2PuJzeMb1Vagv44w8WdcnH6vrsIJMRBH3+y0Xir1dB6RB/rJ1ok
	hzgpowEX9oYSWGxDPvr7iS8br+enRCqTN+VJyLo4G/Per0uTnL8gnQcSbDxbLlGd7TUBK5QllkF
	Yd3rIR5NRNZB4Z0EwcIjp/MXvRMbQ+wSSKJol26gNzqiEHhFKRInM9w2QhCaoKHeqfCwAmibHeY
	ZwtAMmNvl82O4uSjhod74xvQlp00qUQ0auGMVv6+OoDkKYMH2D+P81eEGWrNEuKlN7gwGDOlW3b
	daYw7ypZWrIAAXZumq16h+vvR8qPceW1ww67ibDOI=
X-Received: by 2002:a17:90b:4e8f:b0:38d:e658:5959 with SMTP id 98e67ed59e1d1-38e17d96412mr7448999a91.5.1784119951167;
        Wed, 15 Jul 2026 05:52:31 -0700 (PDT)
Received: from MacBookPro.lan ([2408:8256:3310:8e00:f02b:c960:26d3:2b22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cba1fsm3036140a91.5.2026.07.15.05.52.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 05:52:30 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Yixun Lan <dlan@kernel.org>
Cc: wefu@redhat.com,
	Zhengyu He <hezhy472013@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Peixin Xie <peixin.xie@spacemit.com>
Subject: [PATCH] spi: spacemit: Correct TX FIFO slot calculation
Date: Wed, 15 Jul 2026 20:52:15 +0800
Message-ID: <20260715-k1-spi-tx-fifo-fix-v1-for-next-v1-1-02024223b08a@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260715-k1-spi-tx-fifo-fix-v1-for-next-43cdd0d9213f
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=jC5K1NA2Qi20lryJrip427XM3Y5XYrk3Gmi9jleDf2o=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqV31qlRwpRvEkyvTUy4uncIOL9TlEAlgjz+Jsp
 RUGLads05eJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCald9agAKCRDN9pw2gLgN
 2BgLEACEiMAXQf5d7wzj918XbzCyvgH3JojkX5J45Fs6Qk5AP0sNvlewOxIYinhm1gTStnxa9Ta
 LB+21b+WXPxgVfgGrCnDfxpK/rR7SLZkmgiJNmpXhebrKDHY/2DMvzafZu37EiihZLNqX/dRhTa
 EpZgLe0zfD3pn6czo561TLMaV9SQDzNLLitsnJIfpKtO5FrRq4ChBsUnYNp8CQpk5DMXEaYRbVY
 VNz6e05pjjA8Q0YDd3yhVMAV1KVSgclq81Q+qERowiEDzKDo4oQDxS53et25Fxtj4UkzXwx11t0
 TCAS9FPA30049y1aqfKDMs9d3czb0X8GOj3oLBVPkc9CEX1v7ae32kwjCshr27whNfjFmEGmbRb
 PqzWfjtJ4cWUDJ8oCaOtellab5Eo6PhQ9tlyG1R3W/V55IHTGu9uq7zMKcDMYA8kK8I2js/OR/1
 PaXRfvSdg5kBgkjJ4KRAn3bpyW5s1HlrWOVYzA/XOogRS54EU3UtygZ0ymdFIJ3U/soev51RthE
 cuErPy7pM9cbzy1lFw4/Qisy00azAyJn3mMqsK6knbU/X63chY3FChgNTo5jTa5ptFvSAMGt3Um
 yysNS34cLkUBmFq/IVKS320JKIEoANLVZ1c6n2VjDW19ineJEXurLCk5HY8pwRhMIH5lhE8CQJL bg0AgFEW2lf4GaA==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp; fpr=26CA97B1A229C229822278F254AF850165158959
Content-Transfer-Encoding: 8bit

In k1_spi_write, the count variable is intended to represent the number
of slots available for writing into the TX FIFO.

The current implementation uses FIELD_GET(SSP_STATUS_TFL, val) in an
attempt to determine this count, but this register field returns the
number of occupied slots, not the available space. The previous
implementation attempted to handle this via a ternary operator (? :
K1_SPI_FIFO_SIZE), which incorrectly assumed that the hardware returned
0 when the FIFO was empty (meaning all slots were available), leading to
incorrect accounting of the buffer space.

Fix this by calculating the free slots: count = K1_SPI_FIFO_SIZE -
FIELD_GET(SSP_STATUS_TFL, val);

The associated comment has been updated to reflect the logic change: The
old comment reflected an incorrect assumption about the hardware
behavior, which was the root cause of the previous buggy logic.

This patch accurately and concisely describes the purpose of the new
calculation.

Signed-off-by: Peixin Xie <peixin.xie@spacemit.com>
Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
---
 drivers/spi/spi-spacemit-k1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index 215fe66d27b4..0faf7ffed676 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -494,8 +494,8 @@ static bool k1_spi_write(struct k1_spi_driver_data *drv_data, u32 val)
 {
 	unsigned int count;
 
-	/* Get the number of open slots in the FIFO; zero means all */
-	count = FIELD_GET(SSP_STATUS_TFL, val) ? : K1_SPI_FIFO_SIZE;
+	/* Get the number of free slots in the FIFO */
+	count = K1_SPI_FIFO_SIZE - FIELD_GET(SSP_STATUS_TFL, val);
 
 	/*
 	 * Limit how much we try to send at a time, to reduce the

---
base-commit: 51ed53630915c9cc290036fe4f430849e23bbf8e
change-id: 20260715-k1-spi-tx-fifo-fix-v1-for-next-43cdd0d9213f

Best regards,
-- 
Zhengyu He <hezhy472013@gmail.com>

