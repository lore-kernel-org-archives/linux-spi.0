Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F8435514
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885264; cv=none; b=jFJ2TNdDxdJhaR5uxg9LJgQvKofzlzNJp3Qq3fOTzNbECxM3SgnSqtkeWO+0ct5ASqpFZAhPGr7fMRVuLkUcKEjtGhPUDTMhJzcmCzghXmcgWxhWiUs1oYyFYdBmYUAzUaWdbZypoAWO6s11Shsiivzu6qh7VOr4GUwoZ708j14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885264; c=relaxed/simple;
	bh=+WIOHI3QmtDUPGRU34uGTrPgPXVtS+GgJA2+HRUOD0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIBnr62qvlfkWmvMCnIi9FUmcKcRRuk+m6fwe8MPnnzpNueo/vd9dnDitGw9kvIi11nvy6KAErcsLSTk7kqUnGkHHZ3FzGHGsZf8sVpyIhdDO/kj73rouoXNlEwWrS57mQaYRiopTQcL4sY4RU6PAffWufvOaiYQ8jvLKAILlkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYGoVkHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYGoVkHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC2D1F0089B
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790885263;
	bh=pHEjxeUGrGpUE2oT3OzLHarA0aOnh6BNDf3suT1GWYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZYGoVkHjMwWeUzCo5r8PVaQw+FKVZ+r9qZHsFxQKtlqdM0HV6oupbZuVVVqRNsE3T
	 GFGTLLCsjIE2S7qG0mXNrD+7wFPDf0vCMi+Y199NdpJdlqiqqqjDxifrwDJ72WxX9k
	 kzvI7rrSo3SNGB8Vrx/nAatlTcsf5/5URIDj0QdoAtVXk5cQqIEl7kYAswA/63LGvd
	 BwLr5mxWrzmKvU/ie7Z7o9UcWadrFbXIqEwT6C7bsb3BWMQlUxBmf1YKXIPwGsEl5L
	 bi05oHNUY+CpqKYkQqTqsQYO69o/kOQWWiE+NKic7e11MHD2t6yUCWP2tJRwHa9w+H
	 nv9KITnDFt/VQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b76694fb7aso1096011e87.0
        for <linux-spi@vger.kernel.org>; Thu, 01 Oct 2026 13:07:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx1Zi6ithgEY+Mr4+fm8vs92Fi4ZmEmOsu5r7ySiIa0v4KXkUTQ6YiTAZqxhe9eUqdZ0Dr2o4r7OFg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU+4/GiAQqYfSUKTMHHj2IW/kaIndlTA6k4wjzpbKgwhoL3/gD
	U0+fNXiJ3Aje4BPD22gBKEFxv9KGhG6YLlvGbTAqkka5SJE+9dbsrlZsOGp/jYSRuwiCUyotb8N
	f0EAl/wR5856KJUCt5l4IVUG4NDzkeZk=
X-Received: by 2002:a05:6512:2388:b0:5b0:6343:a298 with SMTP id
 2adb3069b0e04-5ba433db176mr1377640e87.7.1790885261809; Thu, 01 Oct 2026
 13:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925133804.2231004-1-yaojiale02@163.com> <TY3PR01MB11346E0C01A9337A3AF4D97DC868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <34472b57.1961.1a0dd3dff12.Coremail.19888972804@163.com> <TY3PR01MB113461CE3C9EB4A175879F5BD868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com>
In-Reply-To: <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Oct 2026 22:07:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
X-Gm-Features: AclHuK8iXXRgLnubLh6Art37FUrWTj2bfBNLg2EQj4uLxZ4XaQGVjy5EmCuy5W8
Message-ID: <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
Subject: Re: RE: Re:RE: [PATCH] pinctrl: mcp23s08: reject devices without
 match data
To: jiale yao <19888972804@163.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:25=E2=80=AFAM jiale yao <19888972804@163.com> wro=
te:

> I reproduced this deterministically with KASAN on arm64 QEMU.
> The SPI device has an unmatched compatible and a valid microchip,spi-pres=
ent-mask property, and is then bound with:
>
> echo mcp23s08 > /sys/bus/spi/devices/spi0.0/driver_override
> echo spi0.0 > /sys/bus/spi/drivers/mcp23s08/bind

[KASAN splat from spi_get_device_match_data() returning NULL]

But hey look in the driver:

static const struct spi_device_id mcp23s08_ids[] =3D {
        { "mcp23s08", (kernel_ulong_t)&mcp23s08_spi },
        { "mcp23s17", (kernel_ulong_t)&mcp23s17_spi },
        { "mcp23s18", (kernel_ulong_t)&mcp23s18_spi },
        { }
};
MODULE_DEVICE_TABLE(spi, mcp23s08_ids);

Why doesn't the override find the right data from the match table?

This looks more like a bug in the SPI bus implementation,
surely the bus should match a driver_overrid and return a
valid match data from spi_get_device_match_data()?

I think this is just papering over the real issue, you need
to dig into the SPI bus implementation and see why this isn't
working.

Yours,
Linus Walleij
