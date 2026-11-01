Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550763;
	b=qgzA9F1yXT35ZHEu/nsGrerAcPZJZzfnBLDRgqxLQtpZT1VOx9MyiKx9o7mBhP+UT+0K
	 nafERjPRuy51erdJS90JQDaA59WLovVoUGfOUfX4/3LDYwiwqioqnmS4TkCmZeQ9fBfTY
	 uOf+qWOcKGqrvxRzzdWm4BQYJBK4rRdXTh/MI7O9BWOEvBvQwWalON0234GnaZgAXiHAX
	 BYZTz5PNam+m0tRD8KAX6VJtlElUzwCGhF1RQmvnoReojgrmgCa+ISaL/Hi0u4LzY5xDY
	 NuM14ivDBPR5HbO7DF58UBoYcVxbo4RQGDLLiUQu7AKOhaYOPXmYl9QuHVM2pbv9eJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UCVdR2KBBx8WLXWoyaVSXl2ic20BPoQEkXA56hQM/48=;
	b=tgxUmABl4INts00n4xjkUm4mhrlfT6VMabIUdKqzA4Aa+xkWKgWTMVw8DiUlQM+Hm9IG
	 5/Ws1GjtCIx0jwmOdMj9bXvvNGfKRBf+JBHzdD3tJJxdj0aYTe/QpAZOWgsSeuvKJk+Q4
	 hdTAccsYSdo23BGOPzAR76dVH2CCMhJ3bEvmrxuE558bZHlspUHl5vMYYRjW+wlY34VjO
	 oIYfgPZhfqLA0IKMGmxO2rGVBqIt7rkjdcmEUV2st3sSbnEdjziMhYUI8OgLEz3XpLJxt
	 40UKINYGgQ591xRy6I3o+ZGltt42IS5rzktYvjzb247Qf/oqoJtiiKCSZ+EP/o7M45Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQqsSNPo;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A854606A325
	for <linux-spi@vger.kernel.org>; Sun,  1 Nov 2026 16:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A854606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQqsSNPo
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso10734485e9.0
        for <linux-spi@vger.kernel.org>; Sun, 01 Nov 2026 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550762; x=1794155562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UCVdR2KBBx8WLXWoyaVSXl2ic20BPoQEkXA56hQM/48=;
        b=aQqsSNPozk03xR9/D58dcN3ACHT6ds46Yk4IXM/IrTvX47XvTB7srSWWQqdaCoLYpG
         +X0E0SUmPSuW/75vBVdwwk6RJlLJpbhyDatwfAf+RA/u2jzJICPVZbliu1Yiv6qdH0Mb
         CmlJRwiyV6Nse+Fx14+MqbwlNeR5txaUfxz1PU9ylRNLCup14ztF6fljqlBCNMgiJrUq
         osF6Hm+8Kk+R2ExKRE+B/uKNLCgxQG2daZRJ/54RzD1Ed9eWf7UGJLxuwwpyMUc1AhLa
         oZMBTZu7yOjIriqHydC2t5pnPddIIz0jCn25eTjM+H/YdlOzKytvOJF023S3oXs9MQfz
         i5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550762; x=1794155562;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCVdR2KBBx8WLXWoyaVSXl2ic20BPoQEkXA56hQM/48=;
        b=D0pJOp01iCARWMytmCZYk6a3kPd0mAhveT6JIu9OO0W7zUnHS1263e54pi+9L+lSGY
         9sj1B5x9jzHR5o8+GH4ZkWgwBnK9EdbGnZEqAVDBunpVzfuCFpunlQt0qq0uJsZXW5e9
         9ic03LhleMAFT3kpyKC09V6/dvTYJEzzP8XiDQ4VeOHNBk8Pq2HpP1n96NRSz28deBpL
         c6sluC2JGfQOujx8OZQtMzjOC2bUjax43CX2AAHFRm1nmXckklZ+1y3qyaBRyVhhD4Jp
         hTfS9ptOyPbXkUWkNdGOU3MFy699c0pwlNqnmocjeET6K3J3X4C2AUaqOh5+xHmcr0d+
         /vPA==
X-Forwarded-Encrypted: i=1; AKwUvBw16GbRjA66G54pWGB7iqtfHjmdrZNhYgPdtbNM9ry1LjzGu0iw1UVlBK5px0qIyB/PgKRbVqxW1+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfiI8nALkfZnyh0KjoZOuRtH5y2ScsDPL79LJM/z4hsx4v+nJH
	iOaFjz78d/h4HBfsA2k4gdsz+JwzO0ocpw8i36uezBjx1NTafMuI6oqY
X-Gm-Gg: AYBFou2sOIDII5pYFK+V1/uOY6R+qqoMUr7Kw5gbqg21Sn1RwDumMbAjnhchGHKN1Dg
	fkbdzQ6B8EHKOHaV/2YYNK2KCFUXzHfXjb1Dm4unhA/NNY9WoTq0HwHg5BHHYMnnBoOwQv4BR/Z
	17AQ2/0MRRZIYuosLgI8oUvOyHOpXhjlISJ/Mrcb29RpvFAy8WolhKrCsGCVdeHK3QcyIZviX+Y
	TnIXaXRIF1ws1i5zUT+EHHktW14D9dNxvYeRR2blAXESAsKxIgtbodr1ua5v4u8De/RUX+AQQg9
	xrkzrZrrbJDEzJ7PYSY1fklCRgVldd8UvU39ECHLGr4nhyVOo+UyEdhqnWsT1oENaArkCEfAcJe
	DOqwJFFS12qq9HDvczzugK1cQw0xoJJjMrs84g90z+0NugCsJ+26gqw5UrjyFGnvxsc+gllCCvT
	Lqp/VbgQmVDY9hLxfI6yPwOCniSybQCggS4vQnhdAx3k44fjU0vFErYNfo1ijlYJbkvhlQsT4BX
	Uv7/PgvTfx1J+jd9aCh65kk8bV4WYxDIjRwProRdVh7nEi1U8MIszpaiia761EBYu3/o65TvWB2
	Y6VTH27zGgpBAJhnEFzaOshX5czAYvuIJQk6Aa3P6fgSFmBEAw==
X-Received: by 2002:a05:600c:a010:b0:4a1:7dcf:be1f with SMTP id 5b1f17b1804b1-4ac166ee4d6mr181601175e9.1.1793550761756;
        Sun, 01 Nov 2026 08:32:41 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm97219875e9.0.2026.11.01.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:32:41 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	Itai Handler <itai.handler@gmail.com>
Subject: [PATCH 5.10.y v2 3/4] =?UTF-8?q?spi:=20zynqmp-gqspi:=20Undo=20run?= =?UTF-8?q?time=20PM=20changes=20at=20driver=20exit=20time=E2=80=8B?=
Date: Sun,  1 Nov 2026 18:31:53 +0200
Message-Id: <20261101163154.2274099-4-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101163154.2274099-1-itai.handler@gmail.com>
References: <20261101163154.2274099-1-itai.handler@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 2219576883e709737f3100aa9ded84976be49bd7 upstream.

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time.

So, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20240920091135.2741574-1-ruanjinjie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 58b8c5c37f9a..167eb9072c3e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1190,6 +1190,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 clk_dis_all:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
@@ -1220,6 +1221,7 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
-- 
2.34.1

