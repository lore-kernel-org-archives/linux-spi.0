Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65233325495
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785066522; cv=none; b=A8piaovyFRZYwgRevnR5KmrrNQ+CbHmcVd4HLa91vAOAolDSiGLP6+gPbawhNLdV7ulLAvcUGEDyg4u91aji5JN1yBf9BhHu2yTXFf5VQZ2hlddHLdFD/AgBcbSWINnTNuK+givx1PF+N7ZtdFfA/yg+RrEtiBwAs6xyefgUEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785066522; c=relaxed/simple;
	bh=zvmQG/lGdyM3HGcbfofiA2kkSC95RpQyu3hGAyu3tjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOt93+rmX/sY07mNOROgtEhIlkgdsp+Jr4OhjSv6xHvR+ejMlyAlGISpQcMajAeuTRnZ87bF0WArMtsrl9IjQ32tVRRDiwPLvjr7K6cWS3WCVRVxkLL6lgWgmW77z2fXX/t1u3Hdz+/RO2ZU2myKy/JzTnXOYSlVF0QDhxtAvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6ab077379ddso350895eaf.1
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785066520; x=1785671320;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ie395SkYdcDwaJTNPPgWSWv1X1WkPQvm9E70lq/i+kc=;
        b=kv0gm5jsyOC91HKih+OfP149hYQOqDgA/yR/Lwn7TlDvwtE40sqU8HrCOGCEvLSrbT
         NEaAua8zg0faMyEOamQm4Bbz4x0B54X5i3upxaCTx/4GaSYQ8xShLFZJog33tWjVaCvz
         iWxgjwYAAEsPLEG6bssnZfexqm5ibweFgS2Ub+Zg83RkeJCfT87knFnLJoJQoK7uIUI1
         zXMGUwoPUbXHRGymAbGbYRSb5xaRi3fHTuDp4p2VwLi5CNxuu6OPSzMH+uAwAB9lac5d
         cn545shDtHy7HuczyzP1x3uPQRoP8vF63QuI8f1ymZut4CgJrqkln9ug2XS39Vv9z+hO
         IS8g==
X-Forwarded-Encrypted: i=1; AHgh+RrMPPKg0PljVmb7NxNSBngYIuoEGNOD6Cid7SDhTNa4Mqi5VCLfSPl0XKZFFyU9yzCgSX0RMwOupeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdH8Eax9QHHxG2+pH9pTA4Zed+IzUfoYRZrPcBFBqIF3Jww8rZ
	MVZIvdGQN9mQRdMLoeSsgWSx6wWoap9I/8Agb4NCfH/tx1YV9NcsIwyd0d/gjJT20g==
X-Gm-Gg: AR+sD130lMKeYKV6f3zh40SkLR3ga06SzyN4wrF9Dqn/sCMNFtdIOLlBHqctEBbDFt5
	iUqSSQM0DGYh+CgTZha15BR2xHuQqnvy3opsL9a6towi71NPEIg9TrepmQlz7Ci1vXZismeK3EK
	JmnzZzx7u3QgXgtrPx+U4R9tvmA1m9fpFo+NzVhQcA5L/KPZH25mZF8LCcobS4uFi1eUwzXoQya
	9BHW92VPgdKGa3sDsXAAsxPew1P91moYJXtUC6OaTQe7VfC+NRXAI8+ThQFuKNdBGWTgg5ozG4k
	B1SgowQK7vw9tQQji7WvRIy6iR9mw8mpWIIxKU/+F74DpW6pUjDtmx8S1asmY1u5pN1TA6mebA7
	ZNgtCOYn0HCyWbGSiotPJxoDQEZyEQhB63jlPOwJ2ZNlXMf6u9mi8FzfYWn05ipurSNcG5NRooM
	682Yag1utZ4xo+VBHZ71xGlTPNTuZtKypSbyGde5YPFCoxbIFordCOVtMxsDrkpFcRTxMBRYq9
X-Received: by 2002:a05:6820:4b16:b0:6aa:e367:50f3 with SMTP id 006d021491bc7-6aaffb24eefmr4035769eaf.70.1785066520181;
        Sun, 26 Jul 2026 04:48:40 -0700 (PDT)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com. [209.85.160.51])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf92d0286sm3461779eaf.1.2026.07.26.04.48.39
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 04:48:39 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44cd237446cso1102666fac.1
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:48:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro7Mx5UzJ1VtCLXWK96LIBQY2aY9pyxfRDx9QugG3Yrn5ah4PGGfNcLE9BaVafvlGW5Vhe5mGbOtew=@vger.kernel.org
X-Received: by 2002:a05:6870:d291:b0:457:853e:82f1 with SMTP id
 586e51a60fabf-457f27f3ec3mr3942113fac.38.1785066518764; Sun, 26 Jul 2026
 04:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-7-fourdollars@debian.org> <al5-JasTYF5r8A-j@ashevche-desk.local>
In-Reply-To: <al5-JasTYF5r8A-j@ashevche-desk.local>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 26 Jul 2026 19:48:27 +0800
X-Gmail-Original-Message-ID: <CAAT15mM_5t9YuEsEKN8UkJh_AoY_PPVkstVujdBM6QJpq7O0=g@mail.gmail.com>
X-Gm-Features: AUfX_mwb4b-EFAMFA0DQeuXV_jGYugz1ypvxdPQKNESF7_iyUWMeJ-4Hz_uawa8
Message-ID: <CAAT15mM_5t9YuEsEKN8UkJh_AoY_PPVkstVujdBM6QJpq7O0=g@mail.gmail.com>
Subject: Re: [PATCH v16 6/7] spi: pxa2xx: restore LPSS private register state
 on S3 resume
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

> Is this series AI-assisted?
Yes, I used an LLM assistant to help format and polish the commit messages.
However, all hardware register analysis (such as inspecting BAR0 +
0x204 LPSS Private Resets), DSDT ACPI overrides, schematic
verifications for logic board 820-00244-A, and physical S3
suspend/resume hardware testing on MacBook8,1 were performed
empirically on real hardware.

> > Intel LPSS SPI controllers lose all private register state across S3
> > suspend because the LPSS power domain is fully removed. On resume the
> > driver only re-enables the SSP clock, leaving the LPSS private registers
> > in their power-on-reset state, which causes two problems:
> >
> > 1. LPSS_PRIV_RESETS (offset 0x04 within the LPSS private space) stays
> >    zero, keeping the functional block in reset. Any MMIO access while
> >    the block is held in reset causes a PCIe Completion Timeout and a
> >    watchdog-triggered system reset. LPSS_PRIV_RESETS_FUNC and
> >    LPSS_PRIV_RESETS_IDMA must be de-asserted before any other register
> >    access on resume.
> >
> > 2. The LPSS software chip-select control register must not be blindly
> >    restored from its suspend-time snapshot: if CS was asserted at the
> >    moment of suspend, restoring that state corrupts the first
> >    post-resume SPI transaction. Instead, call lpss_ssp_setup() which
> >    unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
> >    the state established at probe time.
> >
> > To resolve these issues safely:
> > - Wrap S3 suspend/resume with pm_runtime_resume_and_get() and
> >   pm_runtime_put_noidle() to guarantee active clocks during MMIO
> >   access and preserve PM reference counting.
> > - Restrict LPSS private register save/restore to LPT, BYT, and BSW
>
> ^^^^ (1)
>
> >   platforms via pxa2xx_spi_need_lpss_restore() (newer platforms are
> >   handled by intel-lpss.c).
> > - Save only the first 6 LPSS private registers (offsets 0x00..0x14) in
> >   drv_data during suspend, avoiding reserved offsets beyond 0x14.
> > - On resume, de-assert resets first, restore saved registers, call
> >   lpss_ssp_setup(), and clear drv_data->suspended to prevent unclocked
> >   IRQ access.
> > - Add error recovery paths for spi_controller_suspend/resume failures.
> > - On the resume error path, call pm_runtime_set_suspended() before
> >   pm_runtime_put_noidle() to align the PM runtime state with the
> >   already-disabled hardware clock, preventing pxa2xx_spi_runtime_suspend()
> >   from attempting unclocked MMIO via pxa2xx_spi_off().
>
> This is an ugly hack.
>
> Saving context is done in drivers/acpi/x86/lpss.c (see #1 why this file).
> If something wrong in the flow it has to be fixed there, not here.
I checked drivers/acpi/x86/lpss.c and its LPSS_SAVE_CTX mechanism.
However, on MacBook8,1, the LPSS SPI controller is instantiated as a
PCI device (00:15.4 / 8086:9ce6) bound to spi-pxa2xx-pci.c, rather
than an ACPI platform device handled by drivers/acpi/x86/lpss.c. As a
result, acpi_lpss_restore_ctx() is never invoked for this PCI device.

Physical hardware S3 testing (rtcwake -m mem) confirms that across S3
suspend, LPSS_PRIV_RESETS (BAR0 + 0x204) is reset to 0x00000000
(functional block held in reset) by the PCH, causing all post-resume
SPI transfers to fail  continuously with -110 timeouts (applespi
spi-APP000D:00: SPI transfer timed out).

I understand your point about not doing context saving in spi-pxa2xx.c.
Would moving the LPSS private register context save/restore into
spi-pxa2xx-pci.c (the PCI glue driver) be an acceptable approach for
PCI-enumerated devices?

Thanks,
Shih-Yuan
