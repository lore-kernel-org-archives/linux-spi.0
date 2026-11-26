Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662614;
	b=ql6o6AtQWNrtw8pkk3jLk000BpfyJz6ixOhnACIm7zb3aCktrtmRkxwKEdXW4LaLkvog
	 WO3xwArL3wiPEjesxX+agoPKlBcViY3rsrvTP1lFtoIPagtqbdvL+BOMGCTqawqiJe5OF
	 0tQxrlLEEDEnvNsQDp00OEFMct45aknOuet39BaQrU6pZA+zZ0KKoElwqmu2BMyqYXc2V
	 b/sVBj0ix3uJmFTP+X4PsfrDrvAl/viJjFBGm8TClNfPqkTiHOyazoXdY6EMnIFHfVMGz
	 CqMSlT0fGEjJ3uW8wWNU09Ogj7XFaZMNFMy2zTOIx7Q6nBgaX/RmwQBisOcJjbVIlzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662614;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=IjXU0+1UubX5FFQk0Wex754aARJrydtUNBmuPvryIQk=;
	b=B8NibtP6NlTV9ivT67u6F8wQYaGELhQu3mv1aCM7gBpZlXtRdj7gGkJgyG7ZWwfDMCjT
	 ytfVOSdVGUrLMG2rJV4GqVfwcny28nqaTwjE7r4io7+Mm5e2ud4eDvU3S6haTAQeX1ZJK
	 BvZOV8DXp2d3kShv3cIvAsCUjk7aC52F3lxHpBmfGNWCWTRCLMC/KMd3IAeOztUpewhfK
	 2geI/CpNftBw4gg+EKNx7YBRnzubsSpwFjlAQCCy3lvDSLzopY8isbMp436gUoO0nH7md
	 O2lI131W2aZ5HsyZwLynB374TOeuoKVtgZctvKDCcuatsYulBTha44xmIgbh9DTmtSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Slwd0p8q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64338606A336;
	Thu, 26 Nov 2026 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Slwd0p8q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662613;
	b=CaeFtufqp9Oc+B+lCpeSnJSG9yI/yCczdAw86KSXLgMOiKMy4tmTS+stobfo/f074STt
	 /l6eEKgais+i2HfqvP4peMlUhXVWPaxs4PoDHLk9eNVuVZbcRb2m0KWXxT1wGQuqb7/b3
	 Iu3F4SSiPjqvOWbxCwc2sWaKKWFbKjfHFzHVMT9jqm1967H84PAW/7CzZvVZhs9fWvymr
	 F0Pe/QZPH5o3lcFFGceudFhrK/GGLrZikbUn4nUsYw+173hFlf05+MTyRuO5BvxgTZQ1b
	 2CGkZJwnZL4X6o+GWWYJoRWUZWS8ns/rJkVC7umuY9YpzeXD3hj6IWuer6BPSsOh1Rw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662613;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=IjXU0+1UubX5FFQk0Wex754aARJrydtUNBmuPvryIQk=;
	b=TnSOJ7YDAKGp/LOvyb1wNLjoSUAH229GgnAWM+YelAP17weIInOsDHuNy7YD0lfEkhgZ
	 4g4go+G08T4PGagoQCzEE2wJoACs2JuMIrNq9Ylr51y/1yxE0mi4lgpImNKRxb95oQTnV
	 h/9yD4Se0n7EbzKSzDIg4p0xh5cKcmjXloLE9hV1+XVbBnz9f+WWUDlJGWEeUQlbf5gYp
	 vB37O50eNlEbWLEgVUgkr8DX4+ukjU2OWoRnVgci5OSjl17JfZ639/SnI56Ynmi5Tgor0
	 Qnb+cOtQhjMukDomz7tYR8YRDeo9Gb3xYbhs5lByI5r07c3D37PTBeyz2nKuRDqFfyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8B6761F000CF;
	Thu, 26 Nov 2026 03:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662613;
	bh=IjXU0+1UubX5FFQk0Wex754aARJrydtUNBmuPvryIQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Slwd0p8qbNtRRID6Yr1ZmacEUeFUR39FQoxE496r9zFat1rU9AHzFHQxSJmCZtD3n
	 CslRWLaTDTUWIMdR4D8MQjXbGDmZKwDMLASmnR1u7EGd6RpN3VSd2EXTWJ08414mTr
	 nVjJjQXG0xZzvQZLjam1zhb2YVkGnBG8DBw0OgNDV2DE5Nu7sW7ioPRNw7nyc4pRZH
	 Tqyf5bXWO0XVhtjvFkmbzrirpBjnpuaIBy/5hVXjSXqcx7ArydDAxzFQgQwX0BHPj2
	 Y3BqKD/0wokz1zUNpHPsjg1STHodENPA5Q35NNMxpTYShfnpTqxsaA/0eloekAR8dG
	 tNSdW5GQCEB3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 193D34D1E1;
	Thu, 26 Nov 2026 03:10:04 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] soc: mediatek: mtk-pmic-pwrap: Add MT6789 support
Date: Thu, 26 Nov 2026 03:10:04 +0000
Message-Id: <20261126031001.27288-4-iasnezhkov@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662602; l=3276;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=qbRExgNIXMO4nE5/slFdmSgfJvIRSfGusTpiIDiDri8=;
 b=ceYqBOI8k8xQMEDeVr7d8USS02DXQezeIQoq8ugPWj/G2rBAE7hANVEDI/C5eKNuG6rPtJ2lb
 Dx0CYCPX0qQDG03v7OvYorYsLCwVj7jodcNK7qnMQjLkGH9lCVumcnY
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com

From: Arseniy Velikanov <me@adomerle.pw>

Add PMIC-Wrapper support for the MediaTek MT6789 (Helio G99) SoC.

MT6789 uses the PMIF-SPI arbiter interface with bank 3 interrupt
registers (INT_EN at 0x450, INT_FLG at 0x458, INT_CLR at 0x45C, mask
0x180000) and WACS2 software interface at 0x880..0x8A8. Register offsets
and wrapper parameters are verified on live MT6789 hardware (iKKO
MindOne, MT6366 PMIC).

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
Changes since v2:
- Added PWRAP_INT_FLG (0x458) and PWRAP_INT_CLR (0x45C) matching bank 3
  PWRAP_INT_EN (0x450) so pwrap_interrupt() clears the real status
  register instead of writing 0xffffffff to offset 0x0.
- Depends on patch 2/4 so probing does not write wdt_src to offset 0x0.
- Updated with an AI coding assistant.

 drivers/soc/mediatek/mtk-pmic-wrap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 6b0d462..f3b97fb 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -640,6 +640,19 @@ static const int mt6779_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =		0xC28,
 };
 
+static const int mt6789_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x450,
+	[PWRAP_INT_FLG] =		0x458,
+	[PWRAP_INT_CLR] =		0x45C,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
+};
+
 static const int mt6795_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -1316,6 +1329,7 @@ enum pwrap_type {
 	PWRAP_MT2701,
 	PWRAP_MT6765,
 	PWRAP_MT6779,
+	PWRAP_MT6789,
 	PWRAP_MT6795,
 	PWRAP_MT6797,
 	PWRAP_MT6873,
@@ -1852,6 +1866,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT7622:
 		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
 		break;
+	case PWRAP_MT6789:
 	case PWRAP_MT6873:
 	case PWRAP_MT8183:
 	case PWRAP_MT8195:
@@ -2302,6 +2317,19 @@ static const struct pmic_wrapper_type pwrap_mt6779 = {
 	.init_soc_specific = NULL,
 };
 
+static const struct pmic_wrapper_type pwrap_mt6789 = {
+	.regs = mt6789_regs,
+	.type = PWRAP_MT6789,
+	.arb_en_all = 0x777f,
+	.int_en_all = 0x180000,
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_ARB,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt6795 = {
 	.regs = mt6795_regs,
 	.type = PWRAP_MT6795,
@@ -2448,6 +2476,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
 	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
 	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
+	{ .compatible = "mediatek,mt6789-pwrap", .data = &pwrap_mt6789 },
 	{ .compatible = "mediatek,mt6795-pwrap", .data = &pwrap_mt6795 },
 	{ .compatible = "mediatek,mt6797-pwrap", .data = &pwrap_mt6797 },
 	{ .compatible = "mediatek,mt6873-pwrap", .data = &pwrap_mt6873 },
-- 
2.54.0 (Apple Git-157)


