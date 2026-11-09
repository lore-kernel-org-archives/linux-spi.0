Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794189282;
	b=n7xFLd/D+3l34kJFlWa2K+fAEuMQs1vCw4YjU0kR/yknEIn22pAtS7fSEjYpn/evSA8D
	 Vdx1K7oHcbDfwh4IlCoHvhMmjWXJqKXRbS7JjrdBV4Xg95CA/FABjeNiS99Sq2Pu9Lb7h
	 l+RFQI0Bsv7mgr00nmSi+Txl9AqcEpXzZu0F4z1pRFndPHA+fAnjU7g+ercBS7pT+iJqb
	 022hndDpWJvzGHz+10JpL96fXcEo7YQdejsoNY94ycAjmDWsVmTLjX776HiXZh6CMc14r
	 oK74NL2TpberkJwAHpMdrmUJgAd7dlOHjH5ljJaiPyQbvKvHH/cw5J8zkKaum6/t6+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nEtIGyJBezdGLIxuour+D7woJTbOhHRcqzGvEkx1U0E=;
	b=sSPl1nn+J26+msEA1yr7Sn+K7SzZx2TIXCYAqzPiuJ2xEIuAAws+axOTUM7C34yLvrBp
	 AcB5uNS7KSUgL5hAOYQA4XBPUzxXhBmjYp3HvJxoJmy8wX8KlE0tEq3q5vqOLR/Jgw68A
	 xHNy9E9OejAY888Bpd4B9tIiSbXV42Z2ej1rdhxdRIbbDrXuEj/f9PXEsCKJWvk3m7Izi
	 XZU8Ra8T6kmFjTH27UJalwrUmD7S2LZ0y9tSPsDhnYH4YvHl51kSjJGk7p7Y+ZqSPY7K3
	 K06ud+SBiGRyHWhpluik1rZU1MnaMlHiplRia7/lj9fASMvLjqm/jXN2AIiqPq/weIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BleiJHLV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA003606A321
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 01:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA003606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BleiJHLV
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4d473cfff6so49967666b.0
        for <linux-spi@vger.kernel.org>; Sun, 08 Nov 2026 17:54:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794189280; cv=none;
        d=google.com; s=arc-20260327;
        b=jsd5UfPpgCqms+UYPIh2T2imLb5etm8aVjlF5+9vdPPdpvAetND12CmIBE4zUyDaI7
         MRSEJonpSWPcgbQml0R7bfjaAivvTDpQyha9fR9CH8ewDIr8uauW3aNp0ViGNEbJHCOI
         CMrofKrqAGTRNGJDyZXAwsqZR9WaYeD3yALvKTflPdBoDGJLokAfQTfXu3j3Mq4Gfvua
         kRfDDf2ZanatPkrJwdkZE0Vm2UfggX6P/cP4JutIXEle4u3vFpGPRD8mRgX1RA874ASB
         a7Z75IwyplyXw4HK3WQslkEH6e9AHPtIXn2uGYEvtP2/xf5I389oxRE3TdiTnE3qNn+4
         PM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nEtIGyJBezdGLIxuour+D7woJTbOhHRcqzGvEkx1U0E=;
        fh=OmuFzsSGNyHxbtls8Rts9CDPjgYCmvw8VLRCLhQ/AuQ=;
        b=HWcYk91NH0lsh/WVGIzI+m8ucn701wmifHy9uT88GqnL+gbdP4jkRlDDp0l8qgy1tu
         +bDQiO0LW6pr2g06CUnP6mVmOnd8qExN2DT5Ni7qTuz2y6LJVKxY6KfiE3tMkHgbDdYr
         M1H2BVUZOzrYLWaDivHZd9FtM4uj+V711dlCG/SEsrblLmFFedHPa4rbIXksNg8r0TaX
         47XAj2lWKL8RwuZosaZjenYQZY53FrrMadDmp9yypzpOZVzzCclm/J5H98dGI2VVqS1C
         FOBFs4AAIBOwv04bqGLg/exCoUWCjSCY52MknLOSL6VwXOzXeedkpVJAtuYu21CcpwCp
         GR3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794189280; x=1794794080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nEtIGyJBezdGLIxuour+D7woJTbOhHRcqzGvEkx1U0E=;
        b=BleiJHLV/sQlhj5+TmJyJUCO6T2QtlMiSpyv93D7VNdYB1iQ+pgt9dtcaSXftom9AK
         wcoLMhH01dLRky5aKgFSgtbD2bTmsSxd0spz/X8uSId/UZvUJbGw/oZJnNv9sVsFNgdg
         msWM5WzDHWnUZ5MkzHuSV3oFIng3FW5lzpdqQeJ53kCjOx0gMb5AsKXqnA70fsAmAsA9
         kbwG7i3geF18thOF9KONI82LVex0UVtNNPipZUsEByTGMCRhCu0IWLfGqGaa9FSMWIZm
         hYo4Dus1E6O01SxF4FWc1q44F002WEw/xa+ZnzXqCcgPSNjZEgg+BaROTqvlyMeWG6Jz
         rl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794189280; x=1794794080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEtIGyJBezdGLIxuour+D7woJTbOhHRcqzGvEkx1U0E=;
        b=fYMYL2fJ8QA1J53600iXR6AhWnkZnk5UNJSbSMsR93pksll2Y/7W20J+0fiF8n/Dr1
         DbYDc83gFSA+bSOK2CAF/Ly6rl9N0i6KHhP0vIxepsftJasQkZkzgxXTiRSYp0Vz5IdH
         3GixgRIbOBgHO5jQnxRcgHHyQtzhMuxl4o8ykmOdM6nNApJnB4O8PcB9vMP0SdW61rpW
         7YA209lh9dhymjNs1wk67ejRPw43mgFGJ+3370XfPMOzNbA0aDKhAY/OHxR5tco36Wwd
         Znql2Aw9ORJMqQyePPpGtdHr0bGfOaujg84vZFEuY1DaG0HDDrtlfcQg98khWMezcywt
         6JRw==
X-Forwarded-Encrypted: i=1; AL+hErH1U3zkNtB1LxKDgkEEqo4H9xRefUewUlEbuvd3ZOMc1rIoiKhdvATvcqyBnGqPVg63n75GNHcraR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sgHnsIgqxCHZfABKdXvPGK3bZ4mOSB9W7YIwsZqQE742qYEtC
	nwAeQ9EN7UGHKwQjAD1xOOSWfwKvlXbELnVZCvvNeoCQ5ArWa1U0itEY5RZpz/ep4vJPbR0bPKg
	n4agnWt8atG45Me1KdoOiZ8zR5nybJvQ=
X-Gm-Gg: AYBFou3HSUdNszO3UHhWi0PZEWAYWhiN03GxVXiSwg2XsThzSBcMvGlGZ54a1sOk9h5
	CGnBpf4wIdyC0iFFXfArgTek1WiEhHMJ/Zfn9bWLNRT6SlvvFPPqXJnzazKXYGwBJAjAj05UOtw
	bEtfaPRzGl2CyNKOYgmS+ygpcIyYXVwtwJ5ahUq8lgprAGAz2t6wT8ppZOk45KcU2+BRwP/XLsW
	GaUn/Rw8kQfjC96vnMUjRxGoIvw1efSWbblacJGcmVOCXM4rfzwrDgmr0/xS07bbRZusGPi3eWv
	5SkGG9kW11nFJm1bCmYKAae3s8C97z4p0WYCh958agpUB7F6uVjHfeCY1nHbGJm3su556l8wJXV
	KB3NKsCmeXQQykVq2DTBnaPTYMzpk736ywHXpJg==
X-Received: by 2002:a17:906:c106:b0:c2b:f3d5:2090 with SMTP id
 a640c23a62f3a-c4d6db5e6a6mr158843666b.27.1794189279792; Sun, 08 Nov 2026
 17:54:39 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793689461.git.zhoubinbin@loongson.cn> <4b36ba4220b30e5dcc1dccf4db3a49a57c65122a.1793689461.git.zhoubinbin@loongson.cn>
 <179406466807.3424803.15440704784819901040.b4-review@b4>
In-Reply-To: <179406466807.3424803.15440704784819901040.b4-review@b4>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 9 Nov 2026 09:54:26 +0800
X-Gm-Features: AclHuK9sQ15Njn9dcE238QYk0OOW35_g1OnBC1YFjlWFkhfF7av3tfo76_-1uxY
Message-ID: <CAMpQs4Kj2HcECfgYuQzEg7UKsEMbe6BxY_g56YuLtGsa69F_uw@mail.gmail.com>
Subject: Re: [PATCH 4/8] spi: loongson: Fix clock divider calculation with
 explicit table
To: Mark Brown <broonie@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark:

Thanks for your review.

On Sat, Nov 7, 2026 at 11:17=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> > loongson_spi_set_clk() previously converted the requested divider into
> > SPCR.SPR/SPER.SPRE using rdiv[] and fls(div - 1).  The rdiv[] mapping d=
id
> > not match the actual divider encoding, so the programmed divider was
> > usually one step larger than requested, and the maximum divider could
> > index past the end of rdiv[].
>
> > -static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, un=
signed int hz)
> > +static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, uns=
igned int hz)
> >  {
>
> > -     div =3D clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2=
, 4096);
> > -     div_tmp =3D rdiv[fls(div - 1)];
> > +     if (!hz || !loongson_spi->clk_rate)
> > +             return -EINVAL;
>
> Does this DTRT for ACPI systems without the rest of the series, where do
> we learn the clock rate from them?  This is tagged as a fix but not all
> of the series is.

It's true=E2=80=94as a more reasonable approach, I should have placed patch=
-5
before this patch and added the `fix` tag.

>
> > +     if (i =3D=3D ARRAY_SIZE(loongson_spi_div_table))
> > +             return -EINVAL;
>
> The driver should really set a min_speed_hz so drivers know they can't
> lower the speed too much (though it's unlikely they'd want to).

I think both `max_speed_hz` / `min_speed_hz` need to be added to `probe()`.

/* Expose controller capabilities to the SPI core */
  controller->max_speed_hz =3D spi->clk_rate / LOONGSON_SPI_DIV_MIN;
  controller->min_speed_hz =3D DIV_ROUND_UP_ULL(spi->clk_rate,
LOONGSON_SPI_DIV_MAX);
>
> --
> Mark Brown <broonie@kernel.org>

--
Thanks.
Binbin
