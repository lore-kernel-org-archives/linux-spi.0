Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB623C1F43
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080516; cv=none; b=aIw8vHQQ78FQbzdOQecIbstwfjyDYnTO/jHwrVhtPueHb6/uO56wjZbKTcTSosyvfrqwL5caT0eVeAW3eZa06P2mkm+VIKVDNiEPwgYVHjOpYdbK0w2plBHIdFGC22tpFL2lg5LhQGHSHzJnS00jb3OBlqR+9OkwKzsoZhhqjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080516; c=relaxed/simple;
	bh=QkseXkwbcvQ4Qb0VEBxHWRUVwl99L+rKtw0gZ9sxzW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu0mGX2fChZuIxAPhLsQd54N/MZqnbJPWHQroSiM2upYH36xsHCMPlbRE92KxKcFbjIa1CFrxBaUiuFgkO5aQA42ZBTrRVOO85aQWtnigJux4R5xg3YGDPJxVC4EVxbfAKSces5kztzunpxNZNPbWWURZipxBYluOkc0FX8JFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ee37dc91f5so1043767a34.3
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 08:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785080512; x=1785685312;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z2othaWJT08mqqPE000kDL5LKOe1CaEnxgsCt+8sKLk=;
        b=p+wu/5+p7aqESarj7Tsb57nCrgLnHHWqxpdBQUJHNtFJkfVZ1DYZ0pcOkyQ+L5mTqn
         zVNiRSi/noko/8fmON7XlI544W671ssUrCRhF2jpF42duc1SX0lrUwJs5JKdPfRqetTr
         DkGr6T8gDj6S67uraTYV92o7ltzl745HK/ZmlKELj4t8TGnOyAuFRloTQXj98VwoVyVj
         fORVQ9AawJxUX8ID8qa+FTuntjHPxHE0G/mAlMi7+41ae87XMPeSJ4QLWjLBny8B7hNF
         3FWEJnlrGeBaYnB76ZG/AkNuKx6UafFo9Nis0u145MTZmBPZ75/jmJxGQBfCuChZcaC0
         pKXg==
X-Forwarded-Encrypted: i=1; AHgh+Roj7haBIXAu2ydaNkPfs+EvhbWRSO4otDnAAwJGaeHR6bdKAwCi6Xhpur0JL+rDP1e0djJn2b9/zZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFfzREOKQliIPOMLQD6YuTlkrEUqDZQcfM8tVKOgZ52KhF1x5
	13O0waNcYD6vThWzojbh21tw9ZuetTSOtIiYsL1O9Zg7oNXNBMz3s4RjAq2KNoMaIw==
X-Gm-Gg: AR+sD11D2RcV8LNqGhXoL4RgVStw/GFNgLgL9r9nlVcpdtuJLXcnechLlS4D/K+fwYv
	B0peUVwHNMZU6hZSRJHd4zilWmGN5qMQvbQEn3WC0coZLAWUFe6lQ+rC0v1mo8gJgq3ld8Mjn3t
	zmVukUV3+ocD26Fj55D3CxGW/rzJ6yB2qwZhwBLEJ5f9Ic9OhJMwwF+vK3xRJq3E6JRxhR+sjf5
	PF0INEeHRHqgWdRViMQNNqSP65oU0be1nIAJgO8hJCPpUKJxqsKqY7I3fqaFXgvIk5LVcf3zOfj
	5g4g5qvYX3LnaxUooLfDYbT9aZjg4EghhUUPG0VM1Apavaq0TSbdvlEJrqnCFAsnXPFdvslqvxa
	5RXkL8kg/xqzNRkHcGbKk/RNJgmsZ39JVa/w0KJYDXD5Y7ajSSYd4zg8X3BrdT0x84aUbOAPi+d
	0hBmS3tQ5WQ5RU6CxTByios/YDmGO0g0SmUmEyo5XHsORmReXosmskuacSAerYDUx7DLx67vzQ
X-Received: by 2002:a05:6830:82b3:b0:7e9:e488:3bce with SMTP id 46e09a7af769-7ee78c3485amr5125535a34.6.1785080511829;
        Sun, 26 Jul 2026 08:41:51 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com. [209.85.160.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a0b37desm10202027a34.20.2026.07.26.08.41.51
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 08:41:51 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44cedfaab6bso649873fac.3
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 08:41:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqGmzvdbaiPyGFvfC3s6BRC1My2kwtiySGmpMg4ZyoslaTXFgL0VPuzyE0x0q6boWQvX70ajUCfstg=@vger.kernel.org
X-Received: by 2002:a05:6870:d629:b0:456:e129:9446 with SMTP id
 586e51a60fabf-457f23abf1emr4538214fac.3.1785080511041; Sun, 26 Jul 2026
 08:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org> <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk> <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
 <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com> <al_ZlTkEUHj-X1YS@ashevche-desk.local>
In-Reply-To: <al_ZlTkEUHj-X1YS@ashevche-desk.local>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 26 Jul 2026 23:41:39 +0800
X-Gmail-Original-Message-ID: <CAAT15mMaZWdkp9YRKvRDRw-WCA-4nWGGo8gge=D7oBKUr1yysw@mail.gmail.com>
X-Gm-Features: AUfX_myjmSRotxH1zLRimxUCvDVSz9Mkj6eNoqv1Zp2kNAxKWsuPvlHvnixM1FE
Message-ID: <CAAT15mMaZWdkp9YRKvRDRw-WCA-4nWGGo8gge=D7oBKUr1yysw@mail.gmail.com>
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@debian.org>, Lukas Wunner <lukas@wunner.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thank you for the detailed feedback and for explaining the SoC-level
interrupt architecture.

> Neither is preferred until we will fully understand what's going on there.
> Yes, DMI quirk is a last resort, but to come to that we need to try better
> options. See my other reply about the DMA case.

I completely agree that DMI quirks should be a last resort when better
options exist. I have removed the custom force_pio module parameter
from the series.

Having investigated the ACPI resource options and confirmed via MMIO
that the EFI firmware permanently holds the LPSS DMA hardware block in
reset (LPSS_PRIV_RESETS = 0x0), applying a targeted DMI quirk in
spi-pxa2xx-pci.c appears to be the unavoidable last resort required to
prevent system hangs on this platform.

> It's impossible. The interrupt line from DMA controller is an IOAPIC RTE that
> is programmed by BIOS, there is no "physical wire" in traditional meaning.

Thank you for the correction regarding PCH SoC interrupt routing. You
are completely right that within the PCH die, LPSS interrupts use
IOAPIC RTEs rather than discrete physical PCB traces.

> No, this analysis is wrong. There are up to 3 interrupts that may participate
> in the design: DMA controller; SPI controller; and SPI peripheral. The first
> two usually use IOAPIC RTEs for the interrupts (and hence represented as
> Interrupt() resources in _CRS methods on DSDT, plus CSRT for DMA), and the
> last one often is GpioInt() and has nothing to do with DMA at all.

Thank you for clarifying the three distinct interrupts involved in LPSS systems:

  1. DMA controller interrupt (dw:dmac)
  2. SPI controller interrupt (00:15.4)
  3. SPI peripheral interrupt (GpioInt())

On MacBook8,1, the applespi input device specifically uses the third
mechanism: a dedicated Out-Of-Band GpioInt() line (TPAD_SPI_INT_L)
connected to the PCH GPIO controller to drive SPI keyboard and
trackpad transfers in PIO mode.

> For old hardware (before Skylake) LPSS DMA interrupt line is defined in
> two places: DSDT (and/or PCI) and CSRT. Changing in one might not help
> as CSRT may have something different. Check drivers/dma/acpi-dma.c
> acpi_dma_parse_resource_group().

Thanks for the pointer regarding CSRT on pre-Skylake platforms.

Direct MMIO inspection of the LPSS DMA controller (PCI device 00:15.0)
on physical MacBook8,1 hardware reveals that Apple's EFI firmware
leaves the functional reset register (LPSS_PRIV_RESETS at BAR0 +
0x204) permanently set to 0x00000000 (held in reset).

Since the LPSS DMA controller is held in reset (0x0) by EFI firmware
and the SPI peripheral relies on the dedicated OOB GpioInt() line for
PIO transfers, forcing PIO mode via the DMI quirk in spi-pxa2xx-pci.c
accurately reflects how EFI configures the hardware, allowing the
driver to operate reliably out-of-the-box without system hangs.

I have compiled the complete MMIO register dumps, schematic
references, and physical hardware test logs in a technical report for
reference [0]:

Thanks,
Shih-Yuan

[0]: https://github.com/fourdollars/MacBook8-1/blob/main/spi-keyboard-touchpad-technical-evidence-report.md
