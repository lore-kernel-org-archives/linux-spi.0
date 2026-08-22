Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69527218EBA
	for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787383145; cv=pass; b=UpXpesjn99GdFYAdXcw5iySEu/2FfUum+Gh4jnp2oK604TRNAQkIgVTK1rjPv4FnEo45/r83399JXDbjuhyp8khGDU7LXQSfEWQaF+r65mLDyS+70nl+nZTu/DAVJLe43aBAOX3pb6gJ/o5Ly0fp9b6Meo8Z+Y0U9xd+B6urHJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787383145; c=relaxed/simple;
	bh=oM02a2mnkQuSYdKv1ayoKOy9Qu4BLdImQAtdLtY4ruA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdcSws5gLxzQmGh4sUXnTJetZjbk/lMbJ/QAjHO4IEyqtP14msTkZa7rdkYCbgo5+4AzLwxGaYnmKr3Jmk82zcXDtLNC7HsVEyTKm4NDhQVXPaedOYqMY+OJL4lX16h+06RS75R2XoMLtC3TMLM+CKlUVQkPUOkokoM1vlSnY90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJY2sAlT; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJY2sAlT"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836f34a0ceaso28042237b3.1
        for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2026 00:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787383143; cv=none;
        d=google.com; s=arc-20260327;
        b=reT0BCETR2Ik1C7KeAzJGNzNB/ndxkvLlaM/EmPlNMs5JYQR2pepSc4HZuX2LNKLTn
         NJT47n9Imb5RGhVy3RWF82/LlCUKRqCM+35jtN7NhAbBv+SAlDjsac8GmcE0yF2u1OGA
         iQtXo+jg6Cz+M5xJ8YMRImrayw/dM3ixdTBtRdQkzFTYLHNIwUJIHpHpfjAPMRf62PHU
         vcvHRsTlsCu2TENVtEFqwvb3eAX1FrZ9TkPeYn06LVD7UnfJZ6RszrylAdt5H2cF9/xu
         b9qkBLrY29Xd3Cpm1W8dtwSggBdy1uCzzE7kmu2zXzZ+bqUBeYouBzoTCzlNWDULHYXJ
         Ry2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EyolxnGOd3oJbXQjfAMl9517AL75MOEE5l1MmMpyIc=;
        fh=Ib/eNH+6sXaf63Qaij137zBp0Ag7lDNvhBobEM7riGI=;
        b=huyjWvPol8cs0CC83A/dw61ooMjaeFhRK1WlyvG9RCHS0sPDnuIhVWExiQf+luFCN7
         dD9P0o9IvVk6N7yQNZCIpuKGnqvIyj5wkMlETodFnm+6mbpJYCpNiNjP5DjdGQ+LZMcv
         /7n+yuNlJoY48+She3txdNmwF8umYD5oW8sEFIeCbMnvazTRuKNIEe+97zccJYN03sVF
         tzMfvillE+7rE6ppX9Dn980jZ/lBveOSkWJjGc3e7J1mX0/fxzF0yd54hnfcE0ClQz+L
         FVY0fVNzfD7EpLGLS/7gXPplP/BXZfDEQaEQJe+yGTupWTyrdqVpN90d2+/+O2VySOcd
         H1Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787383143; x=1787987943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EyolxnGOd3oJbXQjfAMl9517AL75MOEE5l1MmMpyIc=;
        b=mJY2sAlTpZn1zjmBzaDPA89UsIN5jMIwwuo7mtIUBfjTWcXD20Qfi3O4LruCOSI6JT
         1G2DGQscIZPLFdCFdHwf5GMwZnlbfaJCYPQVQyIcr2O4q+z/UWaPfWvWScTsJ9RjaqhX
         wznidl9JLkk7N3jwcurHGfUszQdAt0chMSX8SI/iQEmbIgPl5Drlseo7k+h192PwWBGp
         7h7HFEj9apKSwg719N858csjs9e5oVXxso/rVLQn215LXWW6lx+bxTx2l71HOsxgiehn
         W7MuREeuxxWJgi1dtTxO8ymQ4P3/uJDP3cxw47oXRpukSFhg/NdoarBlYGZ61//qOFYz
         FLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787383143; x=1787987943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EyolxnGOd3oJbXQjfAMl9517AL75MOEE5l1MmMpyIc=;
        b=PIdRe0ky05DVKmz74SVeGKy3ew7HSgd2U6YxkauLibLZVhUVMA/F4XpWHXeMlKTQrZ
         bhF09Cs7PNrIoFH2UOz8TlwgyaxNyaSVWvR8EpT8kN7v9qERgjYGiaEaqvq/yNVNsQxf
         X+TjqYc0MEWcKjrDrGxCLpXUwYJlRXcmAB+N8BeEXXxbTD2JtO84d/VYrLub0LcJGm0N
         hGqrssVIT/+nSeI9SsmduF/MxJH35wCnK/ZsqpoI/HXrD3GQgm7I/wlPN/I3l+atdPz4
         5/jRjy4c+K4SHyCG6f+yyD6Ww91KN9nh+CWAU/PtlJJmUvnACNYKu9/1F435w9GEp6R4
         Wqkg==
X-Forwarded-Encrypted: i=1; AHgh+RrKWzrJA6ZFkTvput4+9C9c219kr4ykslVFSRxXQ4/cA/e8zrd17PLdS4Opn2uhUD31sMkS5Yinj1A=@vger.kernel.org
X-Gm-Message-State: AFuF++lnhEZXBH33gIHbhrNnKlEOdHDBO2j4wQFU4YE0EjGv4mlgoDBy
	qxM1q9HFcGG8KVp737ecXFx7L3XfV7z78SlrnhZpe/cjFBX+KJa7a1SrjlE2oAuJ9eddhBV6ql6
	E5GR4sbkTdBUdJv/Sx9yYGyjUz3KI2yM=
X-Gm-Gg: AR+sD13rw+bnE95v21slfEpQRBAbVR6S2RtW1iKWfe9BpiTq4eBBdkmeQEHDYCifAaS
	bQy8yN5vNZ2VtZSDbQBf3/bn1Uk0YUnjhxI098TpgQm+Vs71MwqYC/pjcs0YlSOeQylz65B2i7I
	FjXD/ZoxqxmjdLI6NdPpbmT9VkOO2JN4msT9eexu6eNKvMWE1UF2/gj9wp8d1bCLIhgj0yRBkMB
	li4eJjnlRBBLDQ3iO4wz/8/9RdcJQYL30w+BE6H5EKLg2url9SJKF9LaRbVYMe3hZFM4maGHgae
	gWito8aRYgQsp64JVIAdSiqyPdXSbZn9NhPA3ozzaBA38ihz5uO+SvtwdAZfCSqiuXEckRgfO+8
	=
X-Received: by 2002:a05:690c:6512:b0:825:468e:e0eb with SMTP id
 00721157ae682-84a1ac40605mr45066577b3.15.1787383142939; Sat, 22 Aug 2026
 00:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814083221.34606-1-challauday369@gmail.com>
 <e7efc91b-9d8f-4344-982b-c2b5014985b6@sirena.org.uk> <20260814190759.GA2496807-robh@kernel.org>
 <20260821143242.GA3830037-robh@kernel.org>
In-Reply-To: <20260821143242.GA3830037-robh@kernel.org>
From: Uday Kiran <challauday369@gmail.com>
Date: Sat, 22 Aug 2026 12:48:51 +0530
X-Gm-Features: AcwNN1Uis6UfIZ0co-b-UtUGD8A07GKsu-HIrWVBLcEcN-_X7pT5x_d88yjoLbc
Message-ID: <CAAj-GBmHCUb-ArgjHLZ2mxc9261eJ2Z4jL8ZaAaG1d8w8ivGPQ@mail.gmail.com>
Subject: Re: [PATCH v4] spi: dt-bindings: microchip,pic32mzda-spi: Convert to
 DT schema
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, krzk+dt@kernel.org, conor+dt@kernel.org, 
	skhan@linuxfoundation.org, me@brighamcampbell.com, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Aug 14, 2026 at 02:07:59PM -0500, Rob Herring wrote:
> > On Fri, Aug 14, 2026 at 03:54:55PM +0100, Mark Brown wrote:
> > > On Fri, Aug 14, 2026 at 02:02:21PM +0530, Udaya Kiran Challa wrote:
> > > > Convert Microchip PIC32 SPI controller devicetree binding
> > > > from legacy text format to DT schema.
> > >
> > > > +maintainers:
> > > > +  - Mark Brown <broonie@kernel.org>
> > >
> > > Try again!  :P  I think the DT people had some default they used for
> > > cases like this, but ICBW?
> >
> > I'm the default, but really I wonder if pic32 could just be dropped. No
> > commits from a Microchip person since 2016 on arch/mips/pic32 or
> > arch/mips/boot/dts/pic32. Almost all generic cleanups otherwise. These
> > chips appear to max out at 32MB (SiP) or 128MB DDR2.
> >
> > Perhaps I should send some AI patches against it...
> >
> > There's this[1], but no updates in 5 years.
> >
> > Arnd, Thomas, any thoughts on this platform?
>
> Thomas agreed to be maintainer on IRC.

Thanks, Rob. Understood. I=E2=80=99ll update the maintainer to Thomas
Bogendoerfer for microchip,pic32mzda-spi & microchip,pic32mzda-sqi dt-bindi=
ngs
and send the next revision.

Regards,
Udaya Kiran Challa
