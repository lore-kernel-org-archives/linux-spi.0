Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D04C8FFB
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645375; cv=none; b=hVt4t5nEHdIwlkB4FssNYe4Tienc2xUFb3WaN/+l/q2e6OZFpZiGhwM0osU+8oAaTmuH71+4MGrOfx3qHbukmA3IHZPKfDU+BJ19Di5CFVyRQH+Ljz0EJ5FVvRu4+5vXeIO4gZPrCZacPvvAiuTTqIj0ns0fJ6TeUwg7PvUcnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645375; c=relaxed/simple;
	bh=v7TC/D5OPm4K9Z2doK43KBHfZnFOkb3ZUVZ4v6l6p9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHZVWJtJzB2oG8vM30v0FO+SelTVY6+MnIpYbiOYivQhTNAwl4ejSiIB3GRS9bnQQdPsgndKT0G5ISvZnCKaT1BS9tTw88JWv1Y9yi02pj6Cq+9Q7tperU2q9swV2zZBBFWaRpAf2w0iaVGXaGYDJ0bRswaJNRuEacjbYn1/TBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9dc546f40so2537158a34.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 07:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784645373; x=1785250173;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2R9K/s8hikEWkG9ffFJdeORUUckoMZXY6IlqHFkEGrY=;
        b=WIhs2mqAT5eiFt5sySl9Y5Eaxya0zSuLme0hU9B3kfG4eh6aZx8D26MyUI6zlR0SWX
         3wMydMkLL4uVy5AMs9e6OHLuQCzZp6vHBlV0kad5HqNxuJc5TsbuN/9MhYap0ARkaGHG
         PDVjaOOPcKgXKMcbfld0ku5V0vqzLd2iR1KO7KpGSzHLCFYJWMw1pBaPQEAt+dlF/QSF
         8Ws+tGJoVeq1LtWfXbLvsCZzAwL4bdVUHnzAINz0JW6Ux4mSEh+D7Jc18mkDaYmNNN+C
         rYml65q8QnbE/AfUQIboaqN7Dn0MpI4zXdn5XkmvAgfs+7VY0qPtWz5pMsYmgXpmlx5h
         5TeA==
X-Forwarded-Encrypted: i=1; AHgh+RooMbzrDtF0sAm8XMOegah6qilxdPUUpY05k/e3rvIIcWweTOhJ8BmYIAGk44jzhaOaJ6nW7GOiHEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNGu46b++gVh8ZZHVTX660xNep/KpD0FQyNBBG3cr5Rawk/wO
	EkCDF11Eb2k01+F9gW/gXhM+FKTFC45vdlJeZWRrj1AGo6rl32DFtXDk+aC0379fkw==
X-Gm-Gg: AfdE7cmxGWwW059hn/YGTNFjCBBqgKOdcI2y1zXCWwkKfntr2I/hv1tFXE7Mwl5ex5x
	d54V1IUASQx2IhVmOJWbmS1eTTPTApifbAgECztC6hsj+9WRbdMhCYhy8wgLaR2WXwIzJtCI8Se
	qA9XbiHzKXllqKeeam2CU0N7IQoly0C7+3OVKrDYLyi9K7VnYTRlwbv+2rSbHibDhMsOSHoKtsy
	M2kPFa1pkD7BA1Yg69u27aVTo6qD2QQoKOKSzolg0EwviY5+enMiNdgUFUZi2nn8CjdNxyIjSpZ
	8FnnkYDxbscpv6Uom8c5jJX8cf/9Tpge6jg6+5X0rNYZCFCWN97DyKwmAS5wX9PkRfNvtfiMo+i
	0vqLTHQk5sSsYuaqw1Z4oM+gp4kHvltPowNiaBWpZQMQXZtJuXcNQdEGBhbaWYh8HdzL/aJCXWG
	3E9z38nlxt057qClO3cVBhr7jEJik1Kw1WYZgxM31V6WeDUIKEUvyW2eS4XkU8CtKNNxsAfpEB
X-Received: by 2002:a05:6820:178b:b0:6a3:7816:cbe2 with SMTP id 006d021491bc7-6a3ece56f31mr12151733eaf.35.1784645372595;
        Tue, 21 Jul 2026 07:49:32 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568e748463sm11783189fac.17.2026.07.21.07.49.30
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 07:49:31 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a3ea601aa1so4012140eaf.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 07:49:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqc/iu5sEmDc59VWb4AAK4+T6cbgMvfkjxhYlNcOrOboe7rAzNtO7cDLCK8dq9itvi3n4v0BMvf4u0=@vger.kernel.org
X-Received: by 2002:a4a:ee0a:0:b0:694:85da:3f92 with SMTP id
 006d021491bc7-6a3ecd43928mr11855381eaf.17.1784645370351; Tue, 21 Jul 2026
 07:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org> <al52kpB1hklx5guG@ashevche-desk.local>
In-Reply-To: <al52kpB1hklx5guG@ashevche-desk.local>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Tue, 21 Jul 2026 22:49:17 +0800
X-Gmail-Original-Message-ID: <CAAT15mOxrJxb+jRf1P=yu=vXgDj9kRhrdSLkB8v4tEbhHOZ+Pw@mail.gmail.com>
X-Gm-Features: AUfX_mw226UgTY6rMnVPL8-sIg7vbBm9DW7Wdl6k0JdY8caXAiwtC13tS0iq5dM
Message-ID: <CAAT15mOxrJxb+jRf1P=yu=vXgDj9kRhrdSLkB8v4tEbhHOZ+Pw@mail.gmail.com>
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:27=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 12:21:14AM +0800, Shih-Yuan Lee wrote:
> > On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
> > 00:15.4 suffers from hardware DMA handshake failures and interrupt
> > routing bugs, causing keyboard/touchpad transactions to fail when
> > DMA is enabled.
>
> Why? The thing like this I noticed on some other HW which required differ=
ent
> DMA settings. Have you tried to investigate the issue more?
>
> > Move the forced PIO mode DMI quirk to spi-pxa2xx-pci.c (the LPSS host
> > controller PCI glue driver) to avoid layering violations in client
> > drivers (such as applespi).
> >
> > Add an explicit DMI match table for MacBook8,1 and a module parameter
> > spi_pxa2xx_force_pio to allow forcing PIO mode on demand.
>
> This looks like a hack. Please, if you have a hardware, try to dump the e=
rrors,
> collect the data corruption or timeouts and provide more information. DMA=
 for
> SPI on LPSS hardware never was a problem (unlike UART in some cases). I'm=
 almost
> 100% sure the problem is in DMA configuration / setting bits.
>
> ...
>
> >  #include <linux/dmaengine.h>
> >  #include <linux/platform_data/dma-dw.h>
> >   +#include <linux/dmi.h>
>
> Keep list ordered.
>
> >  #include "spi-pxa2xx.h"
>
> ...
>
> > +static bool spi_pxa2xx_force_pio;
> > +module_param_named(force_pio, spi_pxa2xx_force_pio, bool, 0444);
> > +MODULE_PARM_DESC(force_pio, "Force PIO mode (disables DMA) for SPI tra=
nsfers. ([0] =3D disabled, 1 =3D enabled)");
>
> No. There is no room for module parameters like this.
Hi Andy,

Thank you for the review and feedback.

Regarding your question about why DMA fails on this hardware, I have
just sent a detailed reply to Lukas in this thread outlining our
physical verification findings. In short, I confirmed that the
DMA controller's physical interrupt line is not functioning on this
motherboard, and macOS and Windows 10 also completely bypass the DMA
controller. Please refer to that email for the DMAR/IOMMU and
cross-OS analysis details.

Regarding your other comments:

1. Header Sorting:
I will fix the alphabetical ordering of the include headers in the
next revision.

2. The force_pio Module Parameter:
The original spi-pxa2xx driver is designed to hardcode DMA usage if
DMA channels are available. I introduced the force_pio module
parameter for two reasons:
  =E2=80=A2 It serves as a diagnostic tool for users on similar hardware to
easily test and verify if their issues are related to DMA.
  =E2=80=A2 It allows developers to easily test and debug the PIO code path=
 on
DMA-capable LPSS hardware to prevent regressions.

That being said, if module parameters of this type are strictly not
preferred, I am completely fine with removing force_pio and keeping
only the DMI-based quirk for the MacBook8,1. Please let me know your
preference.

Thanks,

Shih-Yuan
