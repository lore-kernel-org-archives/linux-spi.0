Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6B36405A
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298204; cv=pass; b=qkhJOst9AGf7Dqvw8DZxFU7ujRDG+yb9mylj4xUKfglOz2f86WKQQCNWYyAiydlhcBzJ2nPynKP4mPRkPk7qvv2qY004zbtIL84NR1M7mGdQ3Fkjjww7yPGecXk/AA4lLoS4r2CucRmepvnQlhfLRiDtsg/zz+Jv4luT8hrAkzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298204; c=relaxed/simple;
	bh=AxJKt3npx/5olYpRGoq298LXQ/po4wFjS8RwWFAvF84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcjgI9Vlke9Y2f5s5r281DvVKvWqgarVjHq4GB1I7qS2P5rlYzvXc2Yv9UKFmcOi1VK2Cn1Ktu3BeL3AmVzELsXIcEbaIjPPWNRXWAbRXzLE0/KFf20lfYEli1ip/bfxPVfwDZo36s+qNVVDTDgs9Ot0/kmfo+6Jd+mCMkhvFQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCiTtgM9; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCiTtgM9"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39380e79936so54939331fa.2
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 10:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779298201; cv=none;
        d=google.com; s=arc-20240605;
        b=cu82f6izKcvw6falCgjFbQAkWkZXPW0x/jwnZY1ZbACbfsKqBcWsvvaTsK7XB78/uP
         DVRKrzrUKvdVOZ2UJOIAZgoJe08bX97RiFdaOQazvNn/cpSgFF3Rt1XvOkkASh7UhIMm
         igITOHKOQ3SZSyg+PvmmEgBmbNkpDpA10eMV5y+wUw8q9J8zavR0F17UkN6ZsEdSTOTh
         vl7n/kuJl6l9iju6i6HndrJ6xnl0ic5kKrVprKeH7kEBPz+Q70wKDjstOuTzqV7w0TmA
         IVaHs9l6mHGMBgRI2n1qNyGdkX3zLWKuFddtGSfT3+zd2E+l2iKi0AmQaRV0Vcr/wspr
         5kFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sqX6X7nWtjyIR3qederrBeJlDMfIxrgMnvzCbwNNfdY=;
        fh=u0k0leVq96ybioSTBnr7FeRpv+8xHV3OoeF2EYM5pJw=;
        b=Vbr750rMv/suMmSv3fesWV8qOWS3CH7lyXDNi6KAl+XD/ABGW0mqkNFsdFHf4S8XoU
         AdTy/4DM8WxvRtTSTYNGgS8D3uUPdvoU+tDoGDAg2nxocPgVKT5W9+6nRJ4USt6yUEqx
         U+rAvwca049jpGqjWaaF0tfF+aOJj+xLIL6td9eA2pnqtELxz5enklJvLaefqFgU7LVN
         fL8BZK5ujbcDT7Smv5VaIA4bnnHDzJ4NxlSInVWo9Gw04fs9ogrnUuLt86Giev5Bqi7m
         8qxThTbi9rDfCMJZvQa/HzpC1ENr1j4ExpQwoNLgTDd+KUrsCEoBAh/f2jESVqr7Yf0e
         t7Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779298201; x=1779903001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqX6X7nWtjyIR3qederrBeJlDMfIxrgMnvzCbwNNfdY=;
        b=pCiTtgM9+8Bg8icQNwyyQj8BmgJ4pc7kwCekh88YUppF1+v4ke+830RzDiJ08r5jK5
         IR5P9TAhoz1+ma6fv6i9QUVg4X5u0k8cV9NOJZt/rnDPBGuRo/M+2nIor5TPltBPA4gk
         TOQMUj5m8g9D6JHlv4mpZsVxstIs8m+u0Z5jEDttAsJ21VdKEWjirrKSGzyVrSQwWS5T
         oTlgHZRnDVeWwKWYyJQ+AVfqI0By7JqiyN20e85pLwjpRRbYnX4F5mePTouyuaqYPNIo
         c++oS6LQaCvrpAXGjDyNCGry1+AeWM7EnE95UUJ/qXzbWkkzf1kkvEII8C9rYBPwat/M
         1FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298201; x=1779903001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqX6X7nWtjyIR3qederrBeJlDMfIxrgMnvzCbwNNfdY=;
        b=nNpIpZW6xTpevrYONDYY1XD87ubi1A2rWmTRclrIXDgXLHwaJW7EbQUfdK8BNJUi9W
         XOaQDTLN7PjtgyDZdskS98/lVNYdHaP81Voy11KKCFXhob2CFTqTLZGKf6HhRpQ8oBPR
         tKoLZwZeI6cD/obaFdvVMLn6GIMlrJI7zZkfzmo1o8pDH8W7QlP8P6B1+ShJUnBv1bzr
         HoFim+8YI768tMsAh7AYtdugC/PH/KoYJgtTiatbVci6kgoNIDQ1N9ywhw0wpZgSAthS
         Vw6aSKw30+EBlXx/v/Q8mLYtjFLZQn6eu40sQYvFMjpkuntX5rIR8G5Att0Hd5Hd4vso
         Recg==
X-Forwarded-Encrypted: i=1; AFNElJ96AnNWWU+GvsK+Um982xRtkWybx7CbH9Trb7E823eHX/y07syGuwBHV2ClAwQuzE2oIxxZEiLWPjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnbCirMdukw+hirtFcWhFn9tVtOsP9pDePWP1NWKO1Y90OdSK
	M2/u1M/RvvQ2QLQqxMBbciOKyxWqxR6cRcKglxina2YGo5rVh4xkB6B4qfrC1NF40Heni/Wtte8
	rpQqr1o4dL5Jj9dFsbOmez4LWwmSsBNQ=
X-Gm-Gg: Acq92OGPNzzMddr7utDeRxo+kPLf9B7l6P4mdgnDnzcKkyzEEzBeO4OvizmhKmdnKDT
	yp1CgEpOyut9INW0tud5VKqElXdSIcx7nm9Rwtj3CgwxSUJ9UgZV2Vj0GUV6OIipLUaRL/N14ms
	ApV/d8hEop/N0/yAJCqkcot2PDFDQSy9/4q1sHuRaCljqMvOTmz77vClAXfEu+lnzJG73DqZjfA
	h5OmsnkIZUJB7GPeu+2npMoe+P23Vb9v/YVuVxsuwforcnAYytnhumnpZMmDvDCdeIlbR4vDNmD
	oTo5l75DPK+aDznT+/hC9qOKd1XNQ4HdHQ6GW7G3AX4ikvgvPs6+41aDOtCu+p9U94IGuP5/Kfz
	wAHQ=
X-Received: by 2002:a05:651c:4187:b0:394:378:b53c with SMTP id
 38308e7fff4ca-39561f312afmr68643811fa.29.1779298200654; Wed, 20 May 2026
 10:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
 <20260515-tegra194-qspi-iommu-v1-3-57dfb63cd3d6@gmail.com> <ag2fjPWwKJmrdYMl@orome>
In-Reply-To: <ag2fjPWwKJmrdYMl@orome>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 20 May 2026 12:29:49 -0500
X-Gm-Features: AVHnY4LvroBWjQk9zP1yNxXjFt1vwSYbmuS4SgnDFGII4R-emIrKxrHn6Q0vFZ0
Message-ID: <CALHNRZ9+X-QMmse-+KOAgt4psobecQvizqXMPufx-BnEd2wujA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 6:49=E2=80=AFAM Thierry Reding <thierry.reding@gmai=
l.com> wrote:
>
> On Fri, May 15, 2026 at 03:35:29PM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Without iommu and dma enabled, flash storage such as the spi-nor on the
> > p3668 module times out and cannot complete any transfers.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot=
/dts/nvidia/tegra194.dtsi
> > index 1d659454a6f9fe..0e0a20befe9e68 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > @@ -923,6 +923,10 @@ spi@3270000 {
> >                                <&bpmp TEGRA194_CLK_QSPI0_PM>;
> >                       clock-names =3D "qspi", "qspi_out";
> >                       resets =3D <&bpmp TEGRA194_RESET_QSPI0>;
> > +                     iommus =3D <&smmu TEGRA194_SID_GPCDMA_0>;
> > +                     dma-coherent;
> > +                     dmas =3D <&gpcdma 5>, <&gpcdma 5>;
> > +                     dma-names =3D "rx", "tx";
>
> dmas and dma-names are the only properties that you should need here.

This is where I started and it didn't work. Without the iommu
properties, I get endless mmu faults upon accessing the qspi flash
device:

[   62.313833] tegra-mc 2c00000.memory-controller: axisw: secure write
@0x00000003ffffff00: VPR violation ((null))
[   62.324542] arm-smmu 12000000.iommu: Unhandled context fault:
fsr=3D0x402, iova=3D0xcd21d000, fsynr=3D0x80012, cbfrsynra=3D0x820, cb=3D1

I know downstream kernels aren't always (normally...) the arbiter of
sanity, but I did pull these from the Nvidia downstream 5.10 kernel,
which is where Nvidia was starting to try to align with mainline
paradigms. All of these properties are set there.

If the qspi node isn't supposed to set iommu directly, then there's a
larger problem here that I don't even know where to begin to look
into. All I can say is that dma fails with faults if they are not set
and works when they are.

Aaron
