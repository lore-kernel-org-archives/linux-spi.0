Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C534677F
	for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109426; cv=none; b=HeeDD54y9owN6tWIw4SXalL0J3zCeaYSlDcIgT+zqh0UOfTdFLEWtTsv9LLrkQjQjTfy9O8Tg4A/uHubByJzpLuNuKsa4sbxeKftAN7N9LuZtDT6+wRvn++S12wvG7jJWF+dE6YyfyqspEk0knmTgqYxgOJYXEzXsGYIe6pZQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109426; c=relaxed/simple;
	bh=XRwvQOJ2yl+WUlOR6pV8FzMv8Q8eNYsuggKIjYllsss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3H1v6KRhATZxqmzuE8qxMRciONRP/CBe1t7gE9Sus2lleISZjSpMq0pQlzO55Zsopwft6zczRvL9ScwjidqY0xSDFKE00fNK6RM+D1q8KvxLDthq56m2KsLVbwUtQAm/bqOp83I5HufPiMzrmKKMEUpSNtl2j8APUdKKqbOyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtpXoBx5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtpXoBx5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so141971835e9.2
        for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777109423; x=1777714223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wdzu/OjVJDdorng+o0yxXBdxT5kIS9RVZ5Y0mWK92GQ=;
        b=mtpXoBx5MSHMq6DV90eVGOPgXyIlK0Cc/OiF/v3Wu3p8gPYa+KEIkNOX/4wrIZE9H4
         zbQcX/sBSR0e7YY/xxoNFz+p54w2adBkw/tg5A5UB4YT8SyuoGgReKgN4ZFmXIRAWD86
         KdNqmpuMiO49LMqDr/dn7DjyfM4mkurqPzWDmNO+PJYHuEzxrdxPO0kUqqKWc2Y4G8VW
         bVYJC3baFVJo2PmOIVBscEqRQJPXJDGLcdcrX8g8PO2Jz9icV+FPsaS1OIS1DDDGmuT3
         P+11W6a6gViJWjQG0DfO5hmYXEt0mph/u+uX69MCjEmE1ggIiuYrRG6FaMCeghacIZfc
         lfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777109423; x=1777714223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wdzu/OjVJDdorng+o0yxXBdxT5kIS9RVZ5Y0mWK92GQ=;
        b=fRkl233poJkZ1oKRlhnfYHhkbb8Mix+WvXcgDUgUhsjN/dQpgdJUarUGTNypyyFeQx
         q58rQl4zo+I0vqnZ3TJ71QBMdNslI9YJFhpSoxbSMPV+21OW4QLczOhjpO1avxrnpNGJ
         iClCUd64llEhaC+8fCiJb8LDMDbgi+wN9rXEyqIcl+LdqyRCOlIoP7GLB/YDHcBnhHVY
         vNFWS4SiqpqT8dEddX7FLKx+5207E8+xol0Pxb1ysG6Q3pN10eBCL8DcAAW75ddS5kyp
         lskj/mXIAP4LStfQdrXx0nRsBPeaqTNezSbQ7+Cc5Vzi/1YUSF1VAh+jo4+RkhMe0iIl
         MUgA==
X-Forwarded-Encrypted: i=1; AFNElJ9Cm1DiPlSIxVDmGfLXK5riHMZpFM/FUR0ajCg6Ykc+nOYikgPMTVtS13veZhZz6o181j0ht3FAICI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCfnYtEKUdHubplgPFK0B74aMd72e3SPFqadF+IYjtGurFpCb
	ZT21CqKF+uZ6LqQhG4V5biPXYEzSO+tx7AUe5HDYoJ3cnKRludQmsI7j
X-Gm-Gg: AeBDiesD+/AI1n/1EmEm4lN4pseHOngy0HSDI2z6RJmB6N78E0NlFLYNgO4o/Jbkmof
	2GZKM5bu/LaAEortqdBIhCxIWHACqFczeVDP5pUYWxbk1SxwtSNn+f/BEI/V3ZpF0L95VkoJsxz
	2qNLgIYsyi2rxfvUCV15lkjmIzBdynIkMlGKveWpW7pDBjhcTwbzthqSXDOZnQ2C1TYGQ4NuhL2
	Kyy9CZe+FMOKNqnvLp+wYPgSjXlcMls1xHnqnludLQ1qCqjNH/z65an6lYrURgXpfb7PE6PVPSp
	+GlRMn+mNPO6XlCpeKvYZ0dkIWqw7nUEaG4faSLa3t7UCUbThJZVdeO28Zb7Bnss/PGDfRY69Xy
	5vduM+pDGbP6y/Xw4glegTGth4E5HeDMyLHoUxp46TzAeTxzrRpCoWeYblM4tgxNCEmkvcuIr7r
	NmNRR8P5i4Gfz3VbAUGZaAqgbSlTckkyJbVWZbWcpklPy2OBMsWLozw6hRrYhpxf2tS9+gryyVz
	gMH
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488fb765ab5mr507183895e9.14.1777109422978;
        Sat, 25 Apr 2026 02:30:22 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2716sm204422615e9.30.2026.04.25.02.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:30:22 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	heiko@sntech.de
Cc: jon.lin@rock-chips.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 1/3] spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ
Date: Sat, 25 Apr 2026 09:29:34 +0000
Message-Id: <20260425092936.2590132-2-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260425092936.2590132-1-john.madieu@gmail.com>
References: <20260425092936.2590132-1-john.madieu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rockchip_spi_isr() decides whether the current interrupt was the
cs-inactive event by reading IMR:

	if (rs->cs_inactive &&
	    readl_relaxed(rs->regs + ROCKCHIP_SPI_IMR) & INT_CS_INACTIVE)
		ctlr->target_abort(ctlr);

IMR is the interrupt mask register: it tells which sources are enabled,
not which one fired. In the PIO path, rockchip_spi_prepare_irq() enables
both INT_RF_FULL and INT_CS_INACTIVE in IMR when rs->cs_inactive is true:

	if (rs->cs_inactive)
		writel_relaxed(INT_RF_FULL | INT_CS_INACTIVE,
			       rs->regs + ROCKCHIP_SPI_IMR);

so the IMR check is always true once cs_inactive is enabled, and every
PIO interrupt - including normal RF_FULL completions - is dispatched to
ctlr->target_abort(), aborting the transfer. The bug is reachable on
ROCKCHIP_SPI_VER2_TYPE2 in target mode with a DMA-capable controller
when the transfer is short enough to fall back to PIO
(rockchip_spi_can_dma() returns false below fifo_len).

Read ISR (which is RISR masked by IMR) so the check actually reflects
which interrupt fired, and parenthesise the expression for clarity while
at it.

Fixes: 869f2c94db92 ("spi: rockchip: Stop spi slave dma receiver when cs inactive")
Signed-off-by: John Madieu <john.madieu@gmail.com>
---
 drivers/spi/spi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 14cd1b9d9793..de39f5da62cb 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -357,7 +357,8 @@ static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	/* When int_cs_inactive comes, spi target abort */
-	if (rs->cs_inactive && readl_relaxed(rs->regs + ROCKCHIP_SPI_IMR) & INT_CS_INACTIVE) {
+	if (rs->cs_inactive &&
+	    (readl_relaxed(rs->regs + ROCKCHIP_SPI_ISR) & INT_CS_INACTIVE)) {
 		ctlr->target_abort(ctlr);
 		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
 		writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
-- 
2.25.1

