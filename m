Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476473C3C15
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644481; cv=none; b=FiEpZrCPEuEBqv/zbYTZpJaEbrI+DuoOxg8MGvK1K+rxVtrpvCI82H+UYIB/gLOO6ErMU/KSjlepzcs+TlQjeflPRYAF6mvlAMfiu3fO9YbyBWpqaaBUG6/0eETw1uD/lsCQI6Xhoz/I9R4PILR1WZmoMkBwg6uheK5VYhY8T1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644481; c=relaxed/simple;
	bh=BQA1kYm9Vt+Y/eZPXw0/25HNeiq2yjCaonWlAoc34XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqjF3CADpQQHHOnVpCICFjOq0fv8/WnYKpHCHb0DU9IgB3MJoD+eSzoBQ5vVo5dKy4/cxXnG6vmJEG8q6J7kr7h77FO7/8tcBlPDvOXQ2gbgHdMue9Rvc222BGRxy8uqKG+coFaRZQ7azUq3HYeD8V1FrRd9orH/qQo1Q+45a70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso8591549a34.3
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 07:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644474; x=1785249274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5+H7EWznrfUm4biYkVbS1OMts3mRMuEpbLctSEdJls=;
        b=kOOEKCzaJFrxBXeEPVLSGLwjk24CXI4ikGIY1ffrajG703H4qjqc/D9GTH35q3pPbu
         UpQNo/v3PsLrB7/cuhUaKXvE1pP1AJkAvk6iugMMqXWh4ER50grqFQ+zF4L/Wxk/TBkM
         6GoqTj4GFWOpupUoVyFPyN9e3LZB7wLRYKVbMW0GJhSQq4sGNOYdSVaVXAF4E+2mxGIt
         gIwEw3eJfVCf6Wabj3uwE0dvp3X72gtQSHw7AUh2JUnmEN7X70gv6IKyrbahICNltMpE
         uNhIPkGRfFJWCcjeDtFfYXmyZKA/fz7u4WZdJu0fKCqWTwkKvIm2aW7duc6nuwkwUsjR
         u1lg==
X-Forwarded-Encrypted: i=1; AHgh+RoZjtkwX9IJsq5stXtVVrcMd9d5YopW4C7sIzT/J/bh41pBrSUi0BOvhD2gq0N21idBLR7VP7UYybM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXpFgfrJWJrfU39JHtPuoGy5jcb+DUrUfKaAvfQrPTTcCFYDQ
	AtPbhFGKzHzCtA6TVzZJiyYfEuoVCD41hIoZojiR4T4RqsfqGDmDqthDSKAXa3UmMQ==
X-Gm-Gg: AfdE7cnOuBdOzGuZUjRGgVeRqQPq8aBI1Ok2LnRSmyBdHATnGqCsrihuI/nzlqFRapj
	5QkFtdAbAddf08L8APtlCVNkP1Sgf8b7GlJ45AuY/nQdjeNuTDvI1I++Eo+Ymw6IXuAAmHKjXxp
	oEOukmSJk8gE7SfLJelfDgnCsjOFL1gQd+BBQLq7gdwtthWXHaHIO1aSf1YOtWiHE0j2yzP+qkV
	rLPvZa6LoChXPXa1hP/F8VpEqgdPtC9qsbXch/3mv41/x/pH1qfLiz2F+bHlXxyw4weB9uPLdDl
	FPCsbMowor59PBZG8MW4SQ0r2x8wku0d3aK/pPUh+zVoVogJeTTbddJ/aGWUFr0n2KEZ16s773B
	fMZFik3HkqLkZ7l053xgZ35VSGXI7qlkwnSYqJ1D/6WAh0vFhpFlryS/ITiovyMLAKb2e4FaPzk
	cKQtg5ll0qVLnuaJHlZ688nHrGuPnUCKWQEeWS3ODWtNnGzVGe6IT9fKERQTWge7EBWTjCmMZc
X-Received: by 2002:a05:6820:4d01:b0:6a1:3e91:dcac with SMTP id 006d021491bc7-6a5367fadaemr9522839eaf.31.1784644474425;
        Tue, 21 Jul 2026 07:34:34 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa2d19c272sm142967eaf.4.2026.07.21.07.34.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 07:34:32 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a381bec3f4so7354420eaf.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 07:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpo10lndqkfzL93U+twXfvyTiDbVO0u/VX2LkcIRPtk22C+ojrdCpJ04CsidBmHK46SlMRgOygFKhc=@vger.kernel.org
X-Received: by 2002:a4a:ee0b:0:b0:6a1:9a5c:b60d with SMTP id
 006d021491bc7-6a536a94d40mr9887444eaf.65.1784644472073; Tue, 21 Jul 2026
 07:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org> <al81PmK1UMr2g8p-@wunner.de> <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
In-Reply-To: <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Tue, 21 Jul 2026 22:34:20 +0800
X-Gmail-Original-Message-ID: <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
X-Gm-Features: AUfX_mz1pHjxNDxH_DJazlQ2LnktVtEJm486_yXMRWbplACcG70nmLYfvBdWpHE
Message-ID: <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
To: Lukas Wunner <lukas@wunner.de>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:26=E2=80=AFPM Shih-Yuan Lee (FourDollars)
<fourdollars@debian.org> wrote:
>
> On Tue, Jul 21, 2026 at 5:18=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wr=
ote:
> >
> > On Tue, Jul 21, 2026 at 12:21:14AM +0800, Shih-Yuan Lee wrote:
> > > On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
> > > 00:15.4 suffers from hardware DMA handshake failures and interrupt
> > > routing bugs, causing keyboard/touchpad transactions to fail when
> > > DMA is enabled.
> > [...]
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D108331
> >
> > In the bugzilla comments, Leif Liddy writes:
> >
> >    "I needed to modify drivers/dma/dw/pci.c to assign the DMA controlle=
r
> >     irq value to 21 (which is what is listed in the ACPI table) for it
> >     to work. The DMA controller was being assigned an irq value of 20
> >     for some reason."
> >
> > It would seem better to fix up the incorrect interrupt number in a quir=
k,
> > rather than disabling DMA wholesale.
>
> This is a very good catch!
>
> I appreciate the comment. Based on the Bugzilla feedback regarding the
> incorrect interrupt assignment, it seems fixing the IRQ value via a
> quirk is indeed a better approach than disabling DMA wholesale. While
> I am not certain this will resolve the issue entirely, it looks very
> promising. I will investigate the IRQ mis-assignment problem further.

Hi Lukas,

Thank you for the suggestion. I have investigated this direction
thoroughly by implementing the DMI-based IRQ override quirk in
drivers/dma/dw/pci.c to assign both pdev->irq and chip->irq to 21 on
the physical MacBook8,1.

However, I found that fixing up the IRQ to 21 in software is not a
viable solution due to the following findings:

1. DMAR/IOMMU Validation Failure (Error -22)
On modern kernels with Interrupt Remapping (DMAR) enabled, overriding
pdev->irq to 21 causes the dw_dmac_pci driver probe to fail with
-EINVAL (-22) during request_irq(). This is because the
DMAR/IOMMU strictly validates the PCI Requester ID (source ID) against
the GSI mapping defined in the ACPI _PRT table. Forcing a device
mapped to GSI 20 (00:15.0) to register on GSI 21 triggers a
source ID mismatch check, which the kernel rejects.

2. The Mechanism Behind the Historical irqpoll Workaround
In Bugzilla ticket 108331, the reason Leif Liddy's workaround
functioned might be that they booted the system with irqpoll or
irqfixup. Under irqpoll, the kernel polls the DMA status register on
every clock tick/timer interrupt, which completely bypasses the broken
physical interrupt line at the cost of high CPU overhead and power
consumption. Without irqpoll, even if we register the handler
on IRQ 21, the driver never receives physical interrupts because the
hardware line on the motherboard is physically disconnected or masked.

3. Cross-OS Evidence (macOS and Windows 10)
  =E2=80=A2 macOS: Apple's native driver runs the SPI controller in pure PI=
O mode.
  =E2=80=A2 Windows 10 (Boot Camp): Interestingly, the Intel LPSS DMA
Controller (8086:9ce0) is left completely driverless (no driver
installed) by the official Boot Camp package, and does not register or
    use IRQ 20 at all. This forces the Windows SPI driver
(iaLPSS_SPI.sys) to fall back to pure PIO mode as well.

Since both macOS and Windows officially disable DMA to work around
this hardware routing defect, forcing PIO mode in spi-pxa2xx is the
most native, clean, and power-efficient way to support the
MacBook8,1 without introducing probe errors or relying on
high-overhead irqpoll workarounds.

Therefore, disabling DMA wholesale for this platform seems to be the
only correct solution. I will update the commit message of the next
revision to document these physical verification findings.

Thanks,

Shih-Yuan
