Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1016480DF2
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209339; cv=pass; b=tE2p78eLCOPH5sp56yc/zifVfTTC4Siz8lO01RRyHaatxes9DnAmzKzlV1122KzqE1Hfq1AyR7SY7E2Gyt21zoyHiw/6KjzeKUnOsD20j4uzB6m02Essv+BjrKcAzV4zDOT69820OG0zQ9UpJXNQQUeLMnTeotoivNe9BnBDoYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209339; c=relaxed/simple;
	bh=oH9Nrh5PMk8EWsTbmczz+vb5WQ2yNIkfnpOjRyzWjGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0ZM/t8VXM/2UtHxVN1q+hPKxctX2Q4oKqiWQ+rSFw8+TO38TJkwWM9qcOW+s76f7ezU1NnW05hdGrWATeAOqPzxuopwcV5dlExElPHf3Z9K4pwWMHaIiFVOnbjPABUDy78EtKYOa2VnipgwfbjANpsQmCJ5Kw87UhrfSV0YoVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLVtO780; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLVtO780"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39380e79936so40741771fa.2
        for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 09:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779209336; cv=none;
        d=google.com; s=arc-20240605;
        b=Nz36QbwvaUXNGdJuuM9G/XAg9U275slXlxV2O1FO2X6KOgb4+NeGVZw9/APqEULloP
         om2lEPFn+Duzo3zCP+7fuDqrwHHDpXAuRy701E0kwAzXKwWOcOBzD08U1VwUnf3HEmrt
         4LPQhR01RhRYO0VwzPi4nxsUuFLYTMB8UKB069lJh4JICJ0WQM355CXcU3SxUu2fXvpN
         rTKYf7veDNX5OuAmuxxLbPDHwa/r/7NljBzPlOqAYcXOEWRU6Eit99+t3PfpYnHuASQo
         whvHBQJikCSe5s3csDgqrCvOqkmupI7xhYBVepIt+JoMrHEsbgGB8WpAbvHsjlqbv/0B
         cQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=11HZunJH70CHsRXR3sppB58SVfwXvxQdgkcAB3E60NY=;
        fh=tFX0uOdM+TA9zHoUtgZWYcH7DHn//uWNI31gv65Dszs=;
        b=XdR1+KgTeWmbpoz6jQTLPCbueNE45QPrMI/sIaUa8i+jE8Sf12CY4yTP/bpBPAoeU5
         xf6DY/FAqTw5epRo2Q1vLSjgSSXivJjXhRIa/d5pIY2OUYTBpOjhYSGRzwa/VJMKJR7a
         gSzEOMTesLnEoJAfBL2xmN58AyqHL+Ba5hUiuG2+7dGn4WGoOamP+r3T0MAeMBH55RYX
         oj6UOr080u5nU5iEkChc+rquimDZT+eAEoJPa6xH4HWadNjmESBpSG5junxW5zHdHBpo
         xBayQN5pbOIi5jg+VpPWSg4g0juLPwtEsxGq+8tzsYK1ImbmSGKwqc+6WgSnuZEdziEN
         AfqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779209336; x=1779814136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11HZunJH70CHsRXR3sppB58SVfwXvxQdgkcAB3E60NY=;
        b=gLVtO780K47SFspwGpqSc7Hn+QCwa47HcFq9d5Fs2eigtexzUDgZp69UV7YJpNLLmm
         4yjJKMJFBW4droeX6NihF1HnMZFhcSf8AW2S3UysJIQsIUZqTyjIqG2TqOViDSIE47nL
         y9jQbQPl6jlBE5YMZcp8BpzHuqjDCr8msZcPIdSJZWWMqtWFwSs8nmh7/hhZjQKSeclu
         LfOTEuSb5WEdb9R04BdXXdvF6CeuxqTkUvLIqS55cV8DX/7pozi32y8Uo1Spfvyy0oYr
         QMmS39yXl0xLcgb6RfajpccClgzVYEr4NFdruagWCBfaW7Ncp5mg2VKbAtQznRBI+qoV
         eI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209336; x=1779814136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11HZunJH70CHsRXR3sppB58SVfwXvxQdgkcAB3E60NY=;
        b=dnvNEP9knteT5u2jygjFWr0H2kCCv6zrUxlDPKJGe/pHxmyttjxrOixoxayVZfgiUY
         n27TuVBdJJeljfgE+lBNWzFnqcZ4Y/y9yzQwmBkXpnF/h5yy6KmYcc41unJ87xZOh07A
         KVsFG5oSac7nzBL63QPwOEt4gm10y+yiqNU1++jQEfDwmQsTM/OM4k+jLUnhpJpQTA+s
         p5bXIvrpVOg7fW2b9JXtxaNhJmjXdYR4qa2XJpE+QvEt4OSUzSUjEmUrJCVnkuW4snAv
         wjwmH0xrzN0hwtbBr4X73FggahOL1UTEChL/hzX2RBvQzWQJORkYZz2DGeJLZ6609I3O
         rpUA==
X-Forwarded-Encrypted: i=1; AFNElJ9m+rt5Qf8ewKsl4mcYtDKkIPHDkeNgNORkAA9Ry5y28H6rfsJhJk9HwoBt9zrQj8lb9dZo19HHN8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OZ64ognTPvk6uFRKQ96yil0OYxo33ab2Tjv3dQd5C7CVOLan
	20dXXnXGxIRF/fJgpcJ4oMviaXUZz4MuJY0fpGKWAnM0hfrjcQqpCf3WVmmNJ+3ZGuh5CO1/pn/
	S6uSZ53G1qaRv3IHR5bCsey9coffVUJM=
X-Gm-Gg: Acq92OH41AfDuqsKLxTKofA7l+5Y17gCoAfYmAa4UZWEh3FADh/ubwUJNjZmv8T3Jt4
	wpTIBTRVeRq41DqQvzO+2SLPsOrqait1VNQDNrhrI0jMsrzh2vd3o5vS0XePm6OZKgvoZvbT0vk
	FrahZ6/q8eYdb4Cn7vFEL6xJRj2jGUetnrN8ZNu1a2s/fupwYEeSR5vEEJYAvZOddleKKOMzrHp
	ZnYrHNEpKv5fFvucDczukgNF0eLe7PBNNGAdQZvBbUriqEVtJ13AgQTM5Le7BHcCJWvuBmDA4kb
	4DVQidDkbIma7ubaLAhleQefwVHxxyj89WPahx4KSVl+QxvlWUzt9V+XII3KC3vtL122
X-Received: by 2002:a05:651c:3252:b0:393:cdbb:2253 with SMTP id
 38308e7fff4ca-39561adf7e7mr61614631fa.5.1779209335774; Tue, 19 May 2026
 09:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
 <d10a46b8-2a01-45d8-b1a4-7d003fdb25bd@nvidia.com> <91fc534a-6529-4880-8c92-a8713118242d@nvidia.com>
In-Reply-To: <91fc534a-6529-4880-8c92-a8713118242d@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 19 May 2026 11:48:44 -0500
X-Gm-Features: AVHnY4Ko7WL-VuNyAXTNlEEFJFIPxQ3R5xh1-foib4BiOS2nRxwB08ZNB4h1Wpw
Message-ID: <CALHNRZ_Ke_pC4tept4_vGOB0ArwjcaMu=mc=wJrQ0x79MKid-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:50=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> =
wrote:
>
>
> On 19/05/2026 15:43, Jon Hunter wrote:
> >
> > On 15/05/2026 21:35, Aaron Kling via B4 Relay wrote:
> >> The reason for this is to properly support the spi nor chip on the
> >> Jetson Xavier NX module. Prior to this, it would time out on all
> >> transfers and sometimes even trigger a cbb fault, locking up the entir=
e
> >> unit. With this, reading and writing to the flash memory works as
> >> expected.
> >
> > What kernel's do you see this on? With the latest mainline/-next I do
> > see ...
> >
> >   tegra-qspi 3270000.spi: cannot use DMA: -19
> >   tegra-qspi 3270000.spi: falling back to PIO
> >
> > But I don't see the crash. However, on linux-6.1.y I do see the crash .=
..
> >
> >   tegra-qspi 3270000.spi: cannot use DMA: -19
> >   tegra-qspi 3270000.spi: falling back to PIO
> >   tegra-qspi 3270000.spi: transfer timeout
> >   tegra-qspi 3270000.spi: error in transfer, fifo status 0x20400006
> >   CPU:0, Error: cbb-noc@2300000, irq=3D15
> >
> > So I believe recent upstream changes in the Tegra210 QSPI driver have
> > fixed this.
> >
> > This series does fix the issue on linux-6.1.y but I believe that is
> > because this is really enabling DMA support and so PIO is still broken.
> > Ideally, PIO should work if DMA support is missing in device-tree.
> >
> > IMO this series simply enables DMA support. May be we should clarify
> > this in the commit message, but otherwise, I am fine with these changes=
.
>
> BTW, that said. This is a much simpler way to avoid the hang on earlier
> kernels. So I would be happy to get this merged and backport to stable
> as a fix. Again may be we just need to clarify this a bit more in the
> commit message.

I could update the commit message to be more like 'Enable DMA support
for Tegra194 QSPI', sure.

The primary kernel version I'm working on currently is 6.18,
specifically googles android common kernel fork of it. I also
replicated the issue on 6.12 and android-mainline which is currently
7.0-ish.

I was not normally seeing issues on boot, though I think I did hit
that a couple times when jumping around versions. Where I had trouble
was active use of the flash chip, like read/writing the slot metadata
for a/b support or writing the flash for inline bootloader updates.
The issue wasn't always triggering a cbb panic, but it was (almost?)
always timing out and failing to read or write the flash chip.

Aaron
