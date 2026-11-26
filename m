Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679225;
	b=kxXI+KxHxOpJhrXPUcve2rLbXnB3kJWIibNIAXT82/GD4KAKhuQgiFCUa2VnuXmNLN97
	 Ruu98LnKGCcSgGpESb1yj2ixM9lfxzqfhPJ1cA0p3HNDEzy47vC9jEJ1IBIAIrbgBix/K
	 zU0q86qY6boiyczMyhFGAdum1rfvbUK5iueXkHnidsKbhanvUsPItGoQdPQbvY0qMouBM
	 CYE726NUckMPJ2L4RhT+Iki6qfbszL2ikWmICUt8kGdJIMR5DjzLfI1C/fbpCJbr6EjhF
	 O7rnBdJmBtzENVLW7G/fy0wd7u42I2TfvcfVWU0Da3E7nOXx2j2doP8f5iFsiE0v4rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679225;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=UJo02l1mQ0uehbgfZzOdVT+lGxEStk6m8nYn67wZ5PI=;
	b=kzpcX9icTKD/kcl+MhGVAFrS1GxOkb2JXsTy5lB9+/gYJefw5Wr3IVXUTLQ2a3RNvQvu
	 DM4Q/y9ElBfChnPwuIlm+x7no6PC+1Kib/+P0m5CBGouHMLpY4VdUP4i5XOzW567ItYfY
	 UmX6KsnVZ9HlsmRYy6aj18oStVmg8K2Fmvw/C6mwzx3YJWH4vjk1QXs9/VfEmWuQ7CIWz
	 JjyxVCVoZwaYURZDjZxGiwmYGuTJRTUmn1wy+tZEi8j4xrmhLttgO315960B8TFn5X69g
	 SOX5khs1reEOhnKhM4vxrki4Xpt3ejc9Wu4/fw0KOnqRfaISwry1k4qtbhqVCn0BcnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=KbUuDHab;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC9606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 07:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDCC9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=KbUuDHab
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795679222; x=1795938422;
	bh=UJo02l1mQ0uehbgfZzOdVT+lGxEStk6m8nYn67wZ5PI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KbUuDHab3QGZ6vcSkm6e4V7lrGNVU+qERwBBTgOUU9CruBFEClSm0lb4SWSabiHrU
	 iYzSkSL1s9h0jBhB7IySZGsWbSI3hQpaZ+mlu2hC7oH4cKg1tnYKj/aMrseLlN2/ny
	 2u8SRd38peIAqFs2MbeiqOqnIa37LBrD91XkT3QcudO4et1zg3ktHizYRaB/FE1353
	 TuBeSfK55r4ZKJBikuAVpeFvgYo9tofUWNRhKIH4CLGixdiyzYu/AWIVw2sGCj0/UW
	 Kn04B8G3Tj7lzSd0hhqIzoz/yxFJGOQutGwuae/KDIBI+Y1edscITQdhUKuQjrKjEU
	 x24MZonFJPWZw==
Date: Thu, 26 Nov 2026 07:47:00 +0000
To: iasnezhkov@gmail.com
From: Roman Vivchar <rva333@protonmail.com>
Cc: broonie@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mt65xx: avoid division by zero when speed_hz is zero
Message-ID: <UsigaM3gd0dy3bL2g5S_b22RuZ_wwX5dQycDFYjkyLdeI1wdx_2divHB0qOXJaSQF54AZXolxH84aoupe8F27HQomLvpAuoMWhehxOFk7aM=@protonmail.com>
In-Reply-To: <20261126003314.49090-1-iasnezhkov@gmail.com>
References: <20261126003314.49090-1-iasnezhkov@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: bd172fa2e85f944e93f3e460554ef986a0a027ca
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

On Thursday, November 26th, 2026 at 2:33 AM, Ilia Snezhkov via B4 Relay <de=
vnull+iasnezhkov.gmail.com@kernel.org> wrote:

> From: Ilia Snezhkov <iasnezhkov@gmail.com>
>=20
> spi-mt65xx does not set host->max_speed_hz, so if a slave device omits
> spi-max-frequency in DT and a transfer leaves speed_hz unset,

It's better to set host->max_speed_hz instead. There's another division
by zero in the mtk_spi_transfer_wait() for max_speed_hz.

> __spi_validate() passes speed_hz =3D=3D 0 to mtk_spi_prepare_transfer().
>=20
> Because 0 < mdata->spi_clk_hz / 2 is true, DIV_ROUND_UP(mdata->spi_clk_hz=
,
> speed_hz) divides by zero (undefined behavior; on arm64 udiv returns 0,
> which then underflows sck_time - 1 to 0xffff).
>=20
> Guard the division on speed_hz !=3D 0 so zero speed falls back to div =3D=
 1.
>=20
> Found and drafted with an AI coding assistant.

This note should go below ---

Best regards,
Roman

> Fixes: a568231f4632 ("spi: mediatek: Add spi bus for Mediatek MT8173")
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
> ---
>  drivers/spi/spi-mt65xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 8b4deef..2baea0c 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -509,7 +509,7 @@ static void mtk_spi_prepare_transfer(struct spi_contr=
oller *host,
>  =09u32 div, sck_time, reg_val;
>  =09struct mtk_spi *mdata =3D spi_controller_get_devdata(host);
>=20
> -=09if (speed_hz < mdata->spi_clk_hz / 2)
> +=09if (speed_hz && speed_hz < mdata->spi_clk_hz / 2)
>  =09=09div =3D DIV_ROUND_UP(mdata->spi_clk_hz, speed_hz);
>  =09else
>  =09=09div =3D 1;
> --
> 2.54.0 (Apple Git-157)
>=20
>=20
>=20
>=20
>
