Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680677;
	b=ip+WitHlVvPIxRJP1SgZzVaoh7JIwstrXgEp+nw5ejD2+59shXN5xbf0ReIiCRGWiN2X
	 t8PmrCwcpoReHb08KXAXuKGpaJd+J1Yj2mdGAkPguEmb+fCyyxisnMnV55u4Nct25OdTA
	 B+FgQMvqjHDALOpO6ASd/MN4DQTXRWvm84BmhjyD6f1G2w87t0Uwd8Wbnj6qJ9Ro/uIiK
	 W7xgdxrrtrnQ0CMJI5yP3XzmUFOhd3dR/go5CG+ncGtb+GGd2nvlSrY1WACX9uwJUFtfR
	 ZjEVmcca/0iWbZpz57OkP9CZzmu/Vx42OaEylg0WDbnm2fRSopNDkXGzEGO09Ach3cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680677;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kx8h+Ar+4Gc1qWaoobGzkg9ZynxpfsO5B9MeCPzrIdw=;
	b=QfXIP4Mv0xxgqDbzDjtn5wUJTo5arTD8wOnX/1l7lVWFUsTmxDv+2drGcrYNJq9aoI1s
	 zGbjvqiOtBOGe+X4Ckl4iSC9HNjsRx5bbjZRnnm/Ha1+VaiF6Q7LsYMEms5ZARUOGAMIX
	 vPnbJsKsvNIzCBTofDu8CRgmlT+5dcTDEPjSqF97ELDeTX+3TLQtbpFvjOS3Jg/GcfUUt
	 RtVoym+WkTcaV/wnWK70dF0IP4MG4CAYHMLJAtHc02vimN/FzdhnLiWKHRUNBnY+GiGhv
	 bi+6iewdVvAs81iGPU/Q3ZiXgs+8Lb7HOirn3vQUrIv/fOzNjh5QYndIVewAJ7c7ADA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Zdh3mf8Y;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B5606A31E;
	Thu, 26 Nov 2026 08:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67B5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Zdh3mf8Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795680673; x=1795939873;
	bh=kx8h+Ar+4Gc1qWaoobGzkg9ZynxpfsO5B9MeCPzrIdw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Zdh3mf8Ysd87iU3bY8C49poOuhDda4EevLwzGVf9g1ZyfEwOU/tAd1jpnLWIGqcYv
	 7VHZM+bpTx4hUBBYmlw82aoCdxIdEStqu6SbH1LE6hjlD3Ckdm8ILyCNZxI/u13EHL
	 Y2EZCWKrBn1ou6wtKYPr6rGxUbE1MjSNatlEN9uJamdJ++999OPHQ/OXq7mC/+PDjw
	 exd7/5Au2mTVTuHHqYeM+Sx0Sc9eeT4qZyFbj3KdcFdWG1Dt1WZVL8EVwDzUHMRYAL
	 hZesa1h+hDGUfar5TTU+la7ad9GpbLweV7sNw75+YV2d8KKb00d6ngJILCeCZjLxsE
	 d0XNoLJwl/HEw==
Date: Thu, 26 Nov 2026 08:11:07 +0000
To: iasnezhkov@gmail.com
From: Roman Vivchar <rva333@protonmail.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] soc/spi: mediatek: Add MT6789 PMIC wrapper and SPI support
Message-ID: <0Af_vuU3D7JCxCsHmjyJZCQhptiOPd3Y325yrg4ufwjT3C5cz6cgJxU4CHY4qfES7Hhzcb-sxm0o7dj-diOzMJPCcw5bSyrYi5CWUNsXQus=@protonmail.com>
In-Reply-To: <20261126031001.27288-1-iasnezhkov@gmail.com>
References: <20261126031001.27288-1-iasnezhkov@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: f5e5584ad9f8c9446847ecc24663ff6184cab23b
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, November 26th, 2026 at 5:10 AM, Ilia Snezhkov via B4 Relay <de=
vnull+iasnezhkov.gmail.com@kernel.org> wrote:

> This series continues the stalled July 2025 MediaTek MT6789 (Helio G99)
> initial bring-up patches originally posted by Arseniy Velikanov (on CC):
> - pwrap v1: https://lore.kernel.org/linux-mediatek/20250715225746.1321-1-=
me@adomerle.pw/
> - spi v1:   https://lore.kernel.org/linux-mediatek/20250715231921.4527-1-=
me@adomerle.pw/
>
> Original authorship and Signed-off-by are preserved on patches 1, 3,
> and 4.

Why this series has both spi and pwrap? There's no dependency between
them.

>
> Changes since v2:
> - Patch 2 (new): guard PWRAP_WDT_SRC_EN, PWRAP_WDT_SRC_EN_1, and cold
>   pwrap_init() with !HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB) so
>   arbiter SoCs (MT6873, MT8195, MT6789) do not write wdt_src to offset
>   0x0 (PWRAP_INIT_DONE2) during probe.
> - Patch 3 (was 2/3): add [PWRAP_INT_FLG] =3D 0x458 and
>   [PWRAP_INT_CLR] =3D 0x45C to mt6789_regs[] matching PMIF-SPI bank 3
>   (INT_EN at 0x450, int_en_all =3D 0x180000) so pwrap_interrupt() does
>   not clobber offset 0x0 and leave a level-high IRQ asserted.
> - Patch 4 (was 3/3): renumbered to 4/4, unchanged.
>

All notes about addressing review in your patches should go below ---,
otherwise they will be included in the git history. Alternatively,
you can put them right here.

Best regards,
Roman

> The v3 rebase and fixes were prepared with an AI coding assistant.
>
> Base: torvalds/linux master 4dce97c6c265.
>
> Arseniy Velikanov (3):
>   dt-bindings: soc: mediatek: pwrap: Add compatible for MT6789
>   soc: mediatek: mtk-pmic-pwrap: Add MT6789 support
>   dt-bindings: spi: mediatek,spi-mt65xx: Add compatible for MT6789
>
> Ilia Snezhkov (1):
>   soc: mediatek: mtk-pmic-pwrap: Skip WDT source and init on arbiter SoCs
>
>  .../bindings/soc/mediatek/mediatek,pwrap.yaml |  1 +
>  .../bindings/spi/mediatek,spi-mt65xx.yaml     |  4 +++
>  drivers/soc/mediatek/mtk-pmic-wrap.c          | 44 ++++++++++++++++---
>  3 files changed, 43 insertions(+), 6 deletions(-)
>
> --
> 2.54.0 (Apple Git-157)
>
>
>
>
