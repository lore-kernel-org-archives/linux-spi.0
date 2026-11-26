Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795651646;
	b=T4trijPzTmAotvzW890aFNzwaOV9BjS64WDPnfnK6pk9+1acAI4FKGQaZhhF6AI+Od9h
	 Wz6Of9A1amEyVQ0p0ZwNoguqqwvce+b97b6vrM3DOtRaQSnc08Rz3xRWWc54bkOM+W5KB
	 dk5iUg5iQqVKwxNaa0UAIXMZH4A4dRMJ94YQSPlZoAKyKYAXuIl0g2W2bGsTw7g6H81ri
	 KOyEqe740MDESxbHCmr2q38cTRsyNqTmVWm2w5fCd7zs7SWyYe4p+t8DNuQYau0CJ5P+2
	 O50snULqFbv8h4tmSfVm1Lmc55bp/LyOoTTDo2SxzjUCKBN9ihKsjHRPq/s7AWJtcSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651646;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Rn2KPBKt2w0en3itYeKVuW8I/tdIWnTOo5q4ucbQO/I=;
	b=5SPZ3EPTX+qZ1ALXZWbHPmk3j2h6TEzBDcLR7bsG8IwZtpvnGKeddLiIaEUxfD7Zv5l2
	 bzKqNKx3MqsDjm6mw9+6mYgbzuaPUhnMsm+S/5ddKyyh2lbkS9VpkqyGFH4tLgb64cVD4
	 Ec+WEZOcIV3n4MGILijMewmGUXR1OBYJAwQzE4JvWZAaWamM5aaD5fHjJYQ5Fgxx6+CZ5
	 6ehdFOho3ECRDA0zDXCpCHg4wVxxD15r/1Jih7xi9s2JHLyYONON7W9nUZsYgEy8LZf3F
	 ei88/6eaSypWsq/40lfXQ3v1jalkDXRMf1UZ8LcpWOJXkaoXo6eJDO6Q5u914erloyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHBLR4yh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9E606A33B;
	Thu, 26 Nov 2026 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHBLR4yh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795651645;
	b=L5TQBVGT93iOnht1WH1atB4CVdRPidbiXSbdkxJE6qnx0H0Y9xNY6DtATwcqXusOmvp0
	 5wNBnQrxB8BX8iqZQxkTUfRwd9wXjS1m0DGEwx6s5tausBV4+SC8DHF1S4nZ/kdNB5+Xc
	 49HibY9IvxlX2FM4I+SsrXeHgqEA8DvmrJl5wDA2mSRVu8LF5XWP0P3zv66V02BbBXM1x
	 j7qFFDEeEwPEd46vJWKIERVHTv7zE3vI7Opr3CW9tdSAJmAt2xbPSzbKz2Fj7kJ4r9Ytb
	 4dX/7/n3ZwFnByx7kpWLTrLRWOoy4GvE7b1qfdR4/cMmyJs3TPn9xUUoEvcOoX/S58w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795651645;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Rn2KPBKt2w0en3itYeKVuW8I/tdIWnTOo5q4ucbQO/I=;
	b=pGmA89T0K6AbBXBzVWL4vU2ldlEmCa53hVZooBxu+TbgmOMXAyKziSS2oRY6SxMB/hut
	 oME9O6jqOPGGFJ2WK+40d7eKfIBb8dqq6Zz9+eG1C9rsOKgfEUPe1EiKY+w1cyyRC2duw
	 Ws3cVOHd4+xJEBlX+xwUsDEW2e1sM3sYLKti72kHltjz7cjSod/hG/+KjGapb/bx5yfyo
	 Cn8dD7cD5vWkLXYPW0yFikhP58LESf1QSqd6/OpeaanLWk2clJaR9CF+uv8rAAj5DdvZx
	 KmOSpH49Nmpx8gPDRe6DQwh2HHNIsyW/zBgUaZ+W7cfWq6MlAP0GXa5nA6Q2xzUk/1w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 90D181F000E1;
	Thu, 26 Nov 2026 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651645;
	bh=Rn2KPBKt2w0en3itYeKVuW8I/tdIWnTOo5q4ucbQO/I=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=jHBLR4yh/zYFUaJWe3iTANeWT90yT3i+uPj3UExpsjBIGDZspdStM7zQQLOPf7br2
	 6l3O8LbgnkmlGh5g8qqU8AzRD9QaI610vH0Bv7IzQxPFB6mnjo/8Ofb5CtyD2Pmuuz
	 Zbh4XYemcro5eNrjAVIMXJQsChr41Ss5cdaXGAv8qTAQnWxESd/6/vWrjdXiNCQQ20
	 JqvOooaT8L03X+aZ1F7ZeIT9yxA46wzReaDizkc11BAUj4thZDxOYpgNyr5pn+oI5H
	 k12op1Jlsa9WlVk3JtP1ruY7KTRYllsIb0osa0SWAAGf4b7UXDninub4MT4c7lacxV
	 Y9tu1T4Mr88ig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1FF484D0EC;
	Thu, 26 Nov 2026 00:07:12 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] soc/spi: mediatek: Add MT6789 PMIC wrapper and SPI
 support
Date: Thu, 26 Nov 2026 00:07:11 +0000
Message-Id: <20261126000711.16163-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795651631; l=1667;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=G9PMsIZX01zfzgZ0pzVqRvDuZFHrueTUpBX7CfgwtQg=;
 b=cHZ+Iqb33K1Qg1Hxu9iqpECjakPQEoxieY1fEJoT9k2aXuZWv5v1uPPcO3+bgX/MoBzx/Pa2g
 /fwDlcmBKP/BnFMcwnbLw+J90eqbJ7tzld9jYu/INVMLIfr1jNiw4o4
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com

This series continues the stalled July 2025 MediaTek MT6789 (Helio G99)
initial bring-up patches originally posted by Arseniy Velikanov (on CC):
- pwrap v1: https://lore.kernel.org/linux-mediatek/20250715225746.1321-1-me@adomerle.pw/
- spi v1:   https://lore.kernel.org/linux-mediatek/20250715231921.4527-1-me@adomerle.pw/

Original authorship and Signed-off-by are preserved on all three patches.
If Arseniy prefers to continue maintaining this series directly, we are
happy to step aside or coordinate on the remaining MT6789 bring-up pieces
(clocks v3, pinctrl, LVTS thermal, scpsys, and DT).

Changes since v1:
- Patch 1 (pwrap binding): rebased onto v7.4-rc4; carried forward
  Acked-by: Rob Herring (Arm) <robh@kernel.org>.
- Patch 2 (mtk-pmic-wrap): rebased onto v7.4-rc4; marked mt6789_regs[]
  and pwrap_mt6789 const to match surrounding SoC tables; register table
  verified on live MT6789 hardware (iKKO MindOne, MT6366 PMIC).
- Patch 3 (spi-mt65xx binding): added mediatek,mt6893-spi fallback
  compatible as requested by Rob Herring in v1 review.

The v2 rebase and binding audit were prepared with an AI coding
assistant.

Base: torvalds/linux master 4dce97c6c265.

Arseniy Velikanov (3):
  dt-bindings: soc: mediatek: pwrap: Add compatible for MT6789
  soc: mediatek: mtk-pmic-pwrap: Add MT6789 support
  dt-bindings: spi: mediatek,spi-mt65xx: Add compatible for MT6789

 .../bindings/soc/mediatek/mediatek,pwrap.yaml |  1 +
 .../bindings/spi/mediatek,spi-mt65xx.yaml     |  4 +++
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 27 +++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.54.0 (Apple Git-157)



