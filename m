Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662607;
	b=a1WYpYnK/XK1WBHuiL3x64Wz8k+LbX1Tk3kggs7innCwp5STuhrYNILpbKvRlBZitB6Y
	 Lse+1Cx4KfKqVVDhP8Gq2oE0LzPHKKN3HegM6fr/ROSARyP0hvbWTuhwNuLU5I7JzGSiO
	 L6PGPyRn796pKABKOc/CoeUtafXu5YAVAgG0DIk0vDU5p5iM/dkzGMTlJlIku7Ekkrzmm
	 NiK4ouId1CKlOTuwDlJWgK9IosETgAn4IU8eTBm5wUxGnTflp9ola/aXp3iBbxUDuAWsj
	 RbGcAmG/s5rwPABnHA88/aDcRgfVkeodc341ItV466x51JMxc6r8ZeR50ijpADmYbuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662607;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uHOK7KrGkaPUSjstehlKPZRXCrxWsl59afQRh8DG1TE=;
	b=ThYV/SGeVGF9XdkJ2fzGVVno15HqK2o6qxLlACC8P2Qf+intj4Z6joKSGsyQ0Km8w9QL
	 St3trs0NePjVroPfDzfhO4FhVtmFeQIARsn8m6CIVsnpZ+KwWbxt5vPVbE1hfcysF+2RV
	 3DBAKNuuU/IiLMBFwJaQCDuMvASEiokXuAySL4c9M7/FtECjKxra0BgApVRBQQeym26+p
	 VZwTtUzpANo22gx/mgJqlupXozw5aRP4TPvqnwA3rcbAFhgHPklMDETzn75OeWB6RBGyA
	 iP5pqYbmeHFn5n3fBh6VT6GTfvOKXUOPw5zx1+Wiw7mavR0An84jlrMrjdn/9WgoFjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqF3Z4eS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC1606A31E;
	Thu, 26 Nov 2026 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqF3Z4eS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662607;
	b=tQ88yuCnMKrRjJ3QuD2J2j/7d2OpChzcduaFsWuZ2mtNXjn7mASOhv5B01T8Q92MMDyR
	 0QAhobUldUZ9b3QfEZJewav7cuyeTS8NVfUKkx3EA66IYPyo8kJwyX6UCYaZ+/ARDHbXj
	 6TVe63XtCJQx7U1Ybm04ZoYjQe+Cwcjyq8hz37Ty2G/JsBX7iKLglx8sdVJrrdqmtbw+O
	 y5XNW7whOLMhmICijmudST+WL0zOz/KUD3Dfcs9aJuxHr46D7YjQV89AuOCntAlhPijJZ
	 6YuDSPzEnipT00PtnXyXwmdkL2ghDgY5Ty0D9NQlY57/AkG6lbMTRYdwhr9wIPWrFVw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662607;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uHOK7KrGkaPUSjstehlKPZRXCrxWsl59afQRh8DG1TE=;
	b=Dhk2Jp1JZmluu44YEwRkfeVeplIVONjV8spuqBvr99xGIFkmglvzkwBAF4Kd6pJCY1nG
	 jB4HzsOykY6QSr6ccYumrx2DA+Z+BnVT3ZU/dlVE6TetP7lI0MNDYjj99EDhvuArkLkXf
	 KI7464EAHT/e61i6GQs1uxFECwmExSsx6ZqDLHIrndDpvlX5/X1SR/krjBz1gSWLEPZqc
	 q1E57e/TBQrBIhGyESn53/WmmnZV1hKTznAgTZaZG/bzJ6J/rPykTliJ5GcoeHtlk9cXy
	 ubqGRM0BLf/ix0BWQ00fGolopXg5kKK3l5mf5molMq7OtHW4Cj2lytJoWhF4Hof0oOg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D3B71F000C0;
	Thu, 26 Nov 2026 03:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662607;
	bh=uHOK7KrGkaPUSjstehlKPZRXCrxWsl59afQRh8DG1TE=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=NqF3Z4eSMg4cbcNV3n90ddbF5nojdjAS/bGFj9+y2HJEnzuRLcFC1vnu63PAhg5JO
	 xdCAQqGGte98ElXBp4dAZT/bTSfMOZyXR6N7LwznUk0BgBo36H19okR713JggxbGke
	 5K09kDG7yuSflZ5zWiLZcvL0YyiHfDr9fl20WjGsVwvL6YXxLKsGIKoXu8sixiRpjh
	 pJtNXWVZ1GPgrmkN4uwcq1adfbiqzXWSSe4ATDBmFKaxkEtB94cID9AeW5iw40AlZ8
	 sLXd3yUlfSc/WHRwzG/AknNgOOqzcV3zfhqRkBcmA2OxVj6z/SUir4kH7hCQ0CZzzx
	 Thw34N1tddtQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF89A4D1D9;
	Thu, 26 Nov 2026 03:10:03 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] soc/spi: mediatek: Add MT6789 PMIC wrapper and SPI
 support
Date: Thu, 26 Nov 2026 03:10:01 +0000
Message-Id: <20261126031001.27288-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662602; l=1679;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=SSX2MYOf3hgS1EqmIn9zqqUiKL7h1Rp1ieInLyB7OCU=;
 b=kZ4V4FHt5o6RJ84Bp3g3s0xjpvWPzQOsDjGML3O1B52VHOCFPMhhOum+G1PN6q3ETTWrCUKcU
 ZUq2vfVPek7BUFMMOgYFhTO4q6ONCAGHkmYUEs1mxts+L7MRvCsmp34
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

Original authorship and Signed-off-by are preserved on patches 1, 3,
and 4.

Changes since v2:
- Patch 2 (new): guard PWRAP_WDT_SRC_EN, PWRAP_WDT_SRC_EN_1, and cold
  pwrap_init() with !HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB) so
  arbiter SoCs (MT6873, MT8195, MT6789) do not write wdt_src to offset
  0x0 (PWRAP_INIT_DONE2) during probe.
- Patch 3 (was 2/3): add [PWRAP_INT_FLG] = 0x458 and
  [PWRAP_INT_CLR] = 0x45C to mt6789_regs[] matching PMIF-SPI bank 3
  (INT_EN at 0x450, int_en_all = 0x180000) so pwrap_interrupt() does
  not clobber offset 0x0 and leave a level-high IRQ asserted.
- Patch 4 (was 3/3): renumbered to 4/4, unchanged.

The v3 rebase and fixes were prepared with an AI coding assistant.

Base: torvalds/linux master 4dce97c6c265.

Arseniy Velikanov (3):
  dt-bindings: soc: mediatek: pwrap: Add compatible for MT6789
  soc: mediatek: mtk-pmic-pwrap: Add MT6789 support
  dt-bindings: spi: mediatek,spi-mt65xx: Add compatible for MT6789

Ilia Snezhkov (1):
  soc: mediatek: mtk-pmic-pwrap: Skip WDT source and init on arbiter SoCs

 .../bindings/soc/mediatek/mediatek,pwrap.yaml |  1 +
 .../bindings/spi/mediatek,spi-mt65xx.yaml     |  4 +++
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 44 ++++++++++++++++---
 3 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.54.0 (Apple Git-157)


