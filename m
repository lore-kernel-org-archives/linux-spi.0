Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662619;
	b=xcBACiz6O3GBUFnLyOhaw+MSGLtc5inPQBf3onAwojjCEvD752CACFDJuxov/CtcOlq+
	 wdEMQPTvw8ezJYMDbgwdsTe45llBLewTZZX+TBiaKaNHFzxdcpZIfInkmOg2bS2WFnfrD
	 n07oV/AK71nzzsp9x11ELixRvhbeIstqliN++6m4LjKMV3OIOOn0X3tXVnzI4ngu9Omsm
	 xXTMo8HZ2dYL7diawY5GQfktAihjEYH0uzgjknG1Pn90wGkOYYiSOcCsnuOjSW8tl/gj1
	 2nv+6oaFweGqadBhgYjf1CJqABWP2QPhELcLyQpan/WthzH8wEEucGDb31GhVQydSDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662619;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AzVBp8V02xdvD1PAYYydGq6b1gRqHEclSPYHpIQmkxc=;
	b=CIfjYteS9sK3LU30lsQs7kXEQ/G0EYit17vZA8/1zK34kBVhexZlKrZmatDBFN+3oxqS
	 H6IDi6OcFn1aRQ57DPCT6lERoVp6amdGwkOgZlx1VZnKxUyH3U+LagbdODKEhp64DkfQo
	 nZbF0l86lxW/uB/tElTVl/tYM9gffFMRyzWOO5bc6bkXZdGpE4Xj4/cLirkCQ6HA6rOLb
	 1xnCsbPsXq3JGYExuHgE27fL0BkmSmZNMxbM5m1RJYPGf2oufIV5X6ggVryIdbgu2uCY5
	 jV8P+ypY18XLPEnIfc9Y6xZocKpTG3SQKj/jNs9hyS4JdOSEqa0545pLHPTO+pCropw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dm6bE+3p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B73606A326;
	Thu, 26 Nov 2026 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dm6bE+3p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662618;
	b=0rFSG9LMIFrfVH/zRJmFflcmF6acKAOHspKqN71YRYGdJj7fiSL1BeoBAYbqCW/VUU+d
	 kJFT1DChU8SyY9YABqO4vQKCfsYHMygruGxd26lqCD5OiT9daGM9TTlhSFddS+zDdL2gU
	 9Yge36/hx55rLzKVW/ncwzsGNZbJwgId6bNgV9x91MH4IKKhpQBEwHcK6M1o4ELt45fc6
	 9tDrcSQ8Kd/AmwpTaual/rhlyFoFH6WVYEzsqMrF9ITL8djQlbF0EUa1ZakeJAo0DtEFO
	 tQ4zcDUaeC2KTsF8FJUFQAmAIrygHMSVPGkxWdx9ASgjT1psPkcejA0vqhjCYRIZHRA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662618;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AzVBp8V02xdvD1PAYYydGq6b1gRqHEclSPYHpIQmkxc=;
	b=gRlf5yBEK9D2t4Pw/b7R4lUytWk1yj72NO3Tx1fP7qZgx5ZDdNYwYtD39FHl8nYtDD+6
	 ZEFZX2E1vgaQjKknAz5iYrWZUtOPw5V9JgsRCpC8Nk4T8JdopTm8rNA2fEYzu/r3htfQJ
	 9uJXHzrdqFsBZgevEPvtHDuJPoh6YywN1TwnG7bJt3vcP8/e29DDACOLKFBVyX667HC98
	 8qG5mZ6F66WmNZ7elUX8rwEvJGaG23NQ6HgvfzkT0b/PpRZ3/pEnRxUYcybjRXdeJJ/KA
	 aeK2uNt0OZSjIU7GHWfaVxQoYJ2zHoUm1oGpv5o9emyE7lBaPpE+6NNA8B9N7adwKew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6C71E1F000CA;
	Thu, 26 Nov 2026 03:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662618;
	bh=AzVBp8V02xdvD1PAYYydGq6b1gRqHEclSPYHpIQmkxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Dm6bE+3poryaAWZxRbfOpTVaQLLtoes/XIohvYqCls2MiLLAb2NqmS7Au93Tma2Zq
	 Pj+MrkJvZxJbEsF80aY5bkrZosVsjDFEa0MYApZm0GrZqCoyFCRG08ftf+cPQ6on/s
	 +QTIndf1B2SXQ1e05Mj9fI1fGBcDI5RTRQhupxxGIC7UBD62h6DfLmUKUzuD1/2b0b
	 a6A81AvQ8Ppay7//0vo7ik737pw4XcBfWGvhMf5ve1NBisa+6c0nNcf+ykVw3WRnow
	 THjaNjuhZq7Qpl1GPD50lucPg33S+pXsFkSJpoJKXFra1PG0bmP2INGJAOs7yt3Tvw
	 5FWGCnt+dPgVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EE4904D1DD;
	Thu, 26 Nov 2026 03:10:03 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] soc: mediatek: mtk-pmic-pwrap: Skip WDT source and
 init on arbiter SoCs
Date: Thu, 26 Nov 2026 03:10:03 +0000
Message-Id: <20261126031001.27288-3-iasnezhkov@gmail.com>
In-Reply-To: <20261126031001.27288-1-iasnezhkov@gmail.com>
References: <20261126031001.27288-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662602; l=3028;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=kmTOzYxW78eOCC/oq6zgHXWDuldBs96hmayhgT5xr94=;
 b=XnE64xGk1/3ejwmRWpsc69rVihvwtSkCvqbIymy+W8gukuwrH4PEuRa+tlxCx+teR7ZuDq07v
 ErffP9ath3fBM18yREC1EWrds7AWv5VKQgEbvX1DZs1LdFg+145cB/W
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

Commit 9d498d0b4043 ("soc: mediatek: pwrap: add arbiter capability")
added PWRAP_CAP_ARB for PMIF-SPI arbiter SoCs (MT6873, MT8195, and the
upcoming MT6789), where the bootloader already initializes the wrapper
and the watchdog registers (PWRAP_WDT_UNIT, PWRAP_WDT_SRC_EN, and
PWRAP_WDT_SRC_EN_1) are absent from the per-SoC register tables.

However, pwrap_probe() only guarded PWRAP_WDT_UNIT with
!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB), leaving the writes to
PWRAP_WDT_SRC_EN and PWRAP_WDT_SRC_EN_1 unconditional. Because omitted
entries in static const int regs[] default to 0, those writes land at
offset 0x0 (PWRAP_INIT_DONE2) and overwrite it with wdt_src
(0xffffffff) on every probe. Similarly, falling into pwrap_init() on
PWRAP_CAP_ARB SoCs would write legacy non-arbiter registers whose
offsets also default to 0x0.

Extend the !HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB) guard in
pwrap_probe() to cover PWRAP_WDT_SRC_EN, PWRAP_WDT_SRC_EN_1, and the
cold pwrap_init() fallback.

Fixes: 9d498d0b4043 ("soc: mediatek: pwrap: add arbiter capability")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
New in v3 (caught during v2 review). Drafted with an AI coding assistant.

 drivers/soc/mediatek/mtk-pmic-wrap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 9067718..6b0d462 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2533,7 +2533,8 @@ static int pwrap_probe(struct platform_device *pdev)
 	 * The PMIC could already be initialized by the bootloader.
 	 * Skip initialization here in this case.
 	 */
-	if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
+	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB) &&
+	    !pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
 		ret = pwrap_init(wrp);
 		if (ret) {
 			dev_dbg(wrp->dev, "init failed with %d\n", ret);
@@ -2554,16 +2555,18 @@ static int pwrap_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize watchdog, may not be done by the bootloader */
-	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
+	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)) {
 		pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
 
-	/*
-	 * Since STAUPD was not used on mt8173 platform,
-	 * so STAUPD of WDT_SRC which should be turned off
-	 */
-	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
-	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
-		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
+		/*
+		 * Since STAUPD was not used on mt8173 platform,
+		 * so STAUPD of WDT_SRC which should be turned off
+		 */
+		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
+		if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
+			pwrap_writel(wrp, wrp->master->wdt_src,
+				     PWRAP_WDT_SRC_EN_1);
+	}
 
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
 		pwrap_writel(wrp, 0x3, PWRAP_TIMER_EN);
-- 
2.54.0 (Apple Git-157)


