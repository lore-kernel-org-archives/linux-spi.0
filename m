Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795651644;
	b=wzdypezFvQmAx6vgBI0DR/xPcPP1VabzFVKmdiWGN8djD09h+IadbYLmzHVHyg5Nr+n8
	 82Dd8cjF7S7jCnR+ipAJstDr/HCyBg4u0u+LrUb/Cuhzo5lGF+89EThnzanvscjqaUf7e
	 S1g2CfwRNjVOqSbaDpVubPiKjj3no+njkZgj9lrNckKvSTuDhzPjTQBm2lXIB6aoGnDY5
	 YxxE+d7jL1eWsworSuiXyU0G7RdTTYxB69xdpFgLLk5XuUQXs4Wr8kW7glHLLH3RlN8ON
	 B20XXexnP0dc1+ufW1XJak3CEu0PpEJu4xOx/iv3J4JOTS46V3f6UiWJOJtBuxSr/gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651644;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hisJ57D82qW2wfu5UBTynuOURDKnlkhMoLWt3orFoqA=;
	b=u0vDAa7n2yyZmZs8UZP47XMFasToVmOs0jHbTyrbwlUwD/Dx/WkJXR2uNX+oESwySy5d
	 mIcfs5efVcqghwp2QCksdPcJfpfm2r+YzTrYYJpXe9c8wTPxqcRcyyulcU8SOmXyJWtl8
	 VbcYCJdbQWflkcJS1W+xht7KA6aApJwJbBICBMpVyQs21Mple3ycsr2npupNJNlg5Dxwh
	 ErJ6L4MYpX+FCXyOpFtoAvAmVbS4FlWgSFLjxdW2FQ4tQhksAss6HAdDH2v5kD+oRz8PX
	 f8yZ4ejqQpu3xJNbPISa+sh0hCB1FIZ4pkZBz0mJPir5FOkXcOQNbMoIJl/aoEvT3mA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7KZeoc2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A7606A331;
	Thu, 26 Nov 2026 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7KZeoc2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795651643;
	b=BK9jIC4vEGgGqP4AsOWcBQEFeoH8k+EI808Z4b0tavxIMBiKE4vt6qwuZo3sHpnEHUql
	 VfsxGDeEFMXfelNtXjLarK56KZ6/6Ya8ur7r29Bd03/tWPjpjYtn5SE8LPYlo4h86Ji39
	 PdkQhbUBpK3qKRIufUZQv1dOziOOPkYTBNtX0t14ouu/kEqC3t2deaYxq/GIIUlZUiuem
	 LQioZlAAyBe3KniMLWpgua/cofS2hLu2KPDsG2gTZ0e6EWU65dspTCSZxAuhx/g/xi9D1
	 ah4SKaHED+jPA0UTSgwivLTMLAOuREXktWREl5mCRPGQKMSslN9chAOH7f7UJLguYQQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795651643;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hisJ57D82qW2wfu5UBTynuOURDKnlkhMoLWt3orFoqA=;
	b=0Cm8rN5qOa6/7JbqTklzvT41DFG7tvT6mA5br1QiZW4v5LxXWKrmGTpRpEqlN1vqO9f2
	 ft/XRgqajOnZb2leT2IU0+8RUslDatAnwbO1fffWJagEuLQsKW9L11SOTBTRO/UzW/q8t
	 7AHQXIBjv9MW80CCPxi/53LhFoQFk0E8lLmBec3tPFyovdvnuvPftZp5eJtsruiBlTZe1
	 i/t8X8Ja4j0GUsu1cn2+C9i6B10g1FJN2tvciRgbqg37cYyd6h1RLcgbq3F+IEB5/F/SI
	 hKJO34M6M6vQd+BCYOZQz0k9zbq7MK4zIE7sRDem5TTVYDzsouwxvs5X6yFM5QzyO7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D22A11F000F0;
	Thu, 26 Nov 2026 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651643;
	bh=hisJ57D82qW2wfu5UBTynuOURDKnlkhMoLWt3orFoqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Y7KZeoc2GfeWD3tPk7uE9U0Ty4RN4B1TEbE2DRY/PgvxFS515NMnirkUAC4rlHvFZ
	 uICYpA5AWOmgItb4PK7c9QPvnS0X132G8O57awldVGmO0ncDS7U94i/kaWqgqf21m1
	 KObpu/m3ojeCeHhfhj4zktpS62qmIXmD3KqphTyLe6QMyGELScoidh6l/nAGAK7YD1
	 cMrGR5idzwNN6kwhDUb3tpZVtFeSuq/iMgJ4D5psbLZFqtonykRa3CUCdcsrzrhIWe
	 U1IwpKynDuhLAxjNYUeWNrl9+c2PbAPSyurYBPYD8F0fQKiyuAH8BUNnNR4nk/e6O9
	 cDqRlOYKIjByw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5F3934D0F2;
	Thu, 26 Nov 2026 00:07:12 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] soc: mediatek: mtk-pmic-pwrap: Add MT6789 support
Date: Thu, 26 Nov 2026 00:07:13 +0000
Message-Id: <20261126000711.16163-3-iasnezhkov@gmail.com>
In-Reply-To: <20261126000711.16163-1-iasnezhkov@gmail.com>
References: <20261126000711.16163-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795651631; l=2846;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=IA1yemFDEOZNDoYKUosrewCxTfRZEAv/5k2Ga2MkOj8=;
 b=dJOot0y/qw2URUtWW9W4oQHtwzXKvNti4YmwQx9F6cY8yot7j0l1upOnW+59sUfb/nu+pLVHa
 REgt3SqIGdsDD4RrmAZuQm/XUcMQx7rLXiAQVlfTrDCaUgZEzPIG8Dy
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com

From: Arseniy Velikanov <me@adomerle.pw>

Add PMIC-Wrapper support for the MediaTek MT6789 (Helio G99) SoC.

Register offsets (0x0, 0x3E4, 0x450, 0x880, 0x884, 0x894, 0x8A4, 0x8A8)
and wrapper parameters are verified on MT6789 hardware (iKKO MindOne,
MT6366 PMIC). Updated from v1 to mark mt6789_regs[] and pwrap_mt6789
const matching the surrounding SoC definitions.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 9067718..c74e916 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -640,6 +640,17 @@ static const int mt6779_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =		0xC28,
 };
 
+static const int mt6789_regs[] = {
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x450,
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
@@ -1316,6 +1327,7 @@ enum pwrap_type {
 	PWRAP_MT2701,
 	PWRAP_MT6765,
 	PWRAP_MT6779,
+	PWRAP_MT6789,
 	PWRAP_MT6795,
 	PWRAP_MT6797,
 	PWRAP_MT6873,
@@ -1852,6 +1864,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT7622:
 		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
 		break;
+	case PWRAP_MT6789:
 	case PWRAP_MT6873:
 	case PWRAP_MT8183:
 	case PWRAP_MT8195:
@@ -2302,6 +2315,19 @@ static const struct pmic_wrapper_type pwrap_mt6779 = {
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
@@ -2448,6 +2474,7 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
 	{ .compatible = "mediatek,mt2701-pwrap", .data = &pwrap_mt2701 },
 	{ .compatible = "mediatek,mt6765-pwrap", .data = &pwrap_mt6765 },
 	{ .compatible = "mediatek,mt6779-pwrap", .data = &pwrap_mt6779 },
+	{ .compatible = "mediatek,mt6789-pwrap", .data = &pwrap_mt6789 },
 	{ .compatible = "mediatek,mt6795-pwrap", .data = &pwrap_mt6795 },
 	{ .compatible = "mediatek,mt6797-pwrap", .data = &pwrap_mt6797 },
 	{ .compatible = "mediatek,mt6873-pwrap", .data = &pwrap_mt6873 },
-- 
2.54.0 (Apple Git-157)



