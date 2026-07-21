Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3246C4BA
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650205; cv=none; b=OdSc6AhAu8CYcGZ6cmslHgpEU2AMV19/c/pHIELWPzHp9qsTZl2JlvqRKAOTZNvjqrtAeGEBY0fhK8TzSZNQnMH0DhY/bpO9wQJvkMSpbCNZfwOmYjOyo+zPrYWvjcMP8iSZdUHRKAoEPAr5Ea/u2WLp7/0TKyUdJHw2THdC7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650205; c=relaxed/simple;
	bh=fQB9oIxNfqpn53ka/+6MVy5A8owe5aFUZu1mThaZBvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WocthYjW/qPBRffb1PSaUrN/g602L6wZ01QzeURDUCRx9V4NwTBbQAGfCaLYOzMaHqAvE8csSmOJMrpgUyhUhPYJsEKgQWmq8zBPoljcYZUqLOUv5TSnlWa6/MOKdnoJSyhpIeKTyrFAQozLsbD0u0i0EFZXjooCrnbMDbtyMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb787dec99so6726706a34.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 09:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784650202; x=1785255002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJoXRdywqN2DaaAN/lfg1M4EsGj3RKn7SLFFiZ5LcSQ=;
        b=fMA4GBuTVbOiuEjl5cP5VGdq49Gb9kCLj8oTRfOl8MfCVegaFM044DCDo1hZ7EgARG
         gzcCAt9XGgQRVpwicQ64QkpPyduenfdsNxjItTjGFs8/CWDNk0tUeB66sTdA7jy7PBPU
         J787moPRzSDIut1AVoaJfyAVD1uJFu/NagK6jelsnMVusu/WU58n2Ow7aELBg81bLCjF
         IPcAc1h6dr27SR1oDnzihe6IxPI09mdEiQzf7Avb988Y0dmpf9/LzPOLvBWtJYIcAYLF
         seUTZYIH1a0vZZqZgEtLmxnzhT4Ptu2q2LUQxxnC8vY/7kQlw7T3lnyh9o0R2MbTXB7a
         Aa6w==
X-Forwarded-Encrypted: i=1; AHgh+RpNXcp7fUL/XDRMqaq1rB4a3Gv7HqUQ+rc/pEn/ZV/VKChPew+2XeowzUbvTlag9IsKiOCjdgSSg7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkvl5y8AGX66thAb5c6uc4WqAHeFbIPZ3xCAEGArSWyaInkoUH
	GKLKHw6EBr9FJSLxIRezYppiCXlv8caBD7oF+9STkPG6DAKgI0jVs0FeJeBTrhzZ7Q==
X-Gm-Gg: AfdE7clOsODO5acmsE8Z2U5LRj1jZ9Q+GFyD5oEo7MbQkx83GAbwf10dVQJ//jv+6Rl
	tQAkdrLiSxg4tSosVybSQhMlAHKIBc4YBGgEh55KUcgeXSkbrad0AKuW/sugZPmFarJq0aDUJbE
	AcalralMrZ0wwLZ+dYQz7PGElI0xWjEq9OfkmdMj9MLBjpGC3yhPKtAm8GHx6QfPYSPkoLSMUNn
	JQlZePIbjxdTcAzc+2DtoN0ZGoqi+L9OATOQlA+JRNXsDLFKcBjwBfiAP5/XxzfhCfUJUpW3e8+
	KqPwLsxyyxZeBZDVkpOKFL1llwdnLUmy6mcVMqgdAg6BwtU+MI0HutC3fG6Di9Npg74JVwdE8Ux
	bU+55jqhjS+XMZ3L3nqFmSrfiVt0U0XnEwWmiwCY+NlP2/eZsjU7TwYy8JwwSvE9xnwh9M/4NiF
	veTtd7bUIFrDs1vjhNOBL2EwzsNedsLR/VNypA3iawcwrfOr0JGdp4Y4kIrmhOJvQJRXnVZVCc
X-Received: by 2002:a05:6820:615:b0:6a1:477f:ffaf with SMTP id 006d021491bc7-6a53684a179mr10308467eaf.41.1784650201603;
        Tue, 21 Jul 2026 09:10:01 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a51a22011asm11158564eaf.11.2026.07.21.09.09.57
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:09:58 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-45691990234so3017677fac.3
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 09:09:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RquMITutb4Qgb3sFXfhpO6zlVl+6nTyjOeeSddlBuMoZi6yz0vnFsN4aQleUBmC2+2c9+NEClspS1A=@vger.kernel.org
X-Received: by 2002:a05:6871:b09:b0:456:1b93:abfd with SMTP id
 586e51a60fabf-45690474565mr9621422fac.22.1784650197151; Tue, 21 Jul 2026
 09:09:57 -0700 (PDT)
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
In-Reply-To: <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Wed, 22 Jul 2026 00:09:44 +0800
X-Gmail-Original-Message-ID: <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
X-Gm-Features: AUfX_mwDAN5Hdj4ikCE3U0XJJmrKdOPGNrEtPHZTpEhNWKCHoX6RdF9b0NfuO7U
Message-ID: <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
To: Mark Brown <broonie@debian.org>
Cc: Lukas Wunner <lukas@wunner.de>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 11:26=E2=80=AFPM Shih-Yuan Lee (FourDollars)
<fourdollars@debian.org> wrote:
>
> On Tue, Jul 21, 2026 at 11:05=E2=80=AFPM Mark Brown <broonie@debian.org> =
wrote:
> >
> > On Tue, Jul 21, 2026 at 10:34:20PM +0800, Shih-Yuan Lee (FourDollars) w=
rote:
> > > On Tue, Jul 21, 2026 at 5:26=E2=80=AFPM Shih-Yuan Lee (FourDollars)
> > > > On Tue, Jul 21, 2026 at 5:18=E2=80=AFPM Lukas Wunner <lukas@wunner.=
de> wrote:
> >
> > > > > It would seem better to fix up the incorrect interrupt number in =
a quirk,
> > > > > rather than disabling DMA wholesale.
> >
> > > > I appreciate the comment. Based on the Bugzilla feedback regarding =
the
> > > > incorrect interrupt assignment, it seems fixing the IRQ value via a
> > > > quirk is indeed a better approach than disabling DMA wholesale. Whi=
le
> > > > I am not certain this will resolve the issue entirely, it looks ver=
y
> > > > promising. I will investigate the IRQ mis-assignment problem furthe=
r.
> >
> > > 1. DMAR/IOMMU Validation Failure (Error -22)
> > > On modern kernels with Interrupt Remapping (DMAR) enabled, overriding
> > > pdev->irq to 21 causes the dw_dmac_pci driver probe to fail with
> > > -EINVAL (-22) during request_irq(). This is because the
> > > DMAR/IOMMU strictly validates the PCI Requester ID (source ID) agains=
t
> > > the GSI mapping defined in the ACPI _PRT table. Forcing a device
> > > mapped to GSI 20 (00:15.0) to register on GSI 21 triggers a
> > > source ID mismatch check, which the kernel rejects.
> >
> > That really seems like something we ought to be able to do, though I
> > think the idiom here is to patch the ACPI tables so they are correct
> > rather than quirk things in C code.  ICBW about the preferred approach
> > there.
> >
> > BTW, if you're using a LLM to assist with analysis please don't just
> > paste the output into mail.  Instead make sure you understand what the
> > LLM is saying and write up the salient bits.
> Hi Mark,
>
> You are absolutely correct. The standard idiom for correcting firmware
> bugs in ACPI tables is indeed using the Initrd ACPI Table Override
> mechanism (compiling a modified DSDT with corrected _PRT routing and
> prepending it to the initramfs).
>
> Actually, I was just following Lukas's suggestion to modify
> drivers/dma/dw/pci.c to do a quick proof-of-concept test, and I used
> an AI assistant to help me write and deploy the driver quirk code.
>
> I have previous experience with the Initrd ACPI Table Override
> mechanism, so I can definitely try that on my machine next to see if
> we can get DMA working properly by aligning the PCI routing and DMAR
> mapping correctly).
>
> Also, I will keep your advice in mind regarding LLM usage, and will
> make sure to write up the key points myself rather than pasting raw
> output.

Hi Mark,

I just tested the Initrd ACPI Table Override on the machine. Here is
what I found.

I patched the _PRT table in the DSDT to remap device 00:15.0 (Pin 0
and Pin 1) from GSI 20 to GSI 21 to match the SPI controller's
interrupt line, bumped the OEM Revision from 0x00080001 to 0x00080002
so the kernel would accept the override, and prepended it to the
initramfs.

The override was successfully applied:

  ACPI: Table Upgrade: override [DSDT-APPLE - MacBook]
  ACPI: DSDT ... 007EB5 (v03 APPLE  MacBook  00080002 INTL 20251212)

After rebooting, the DMA controller loaded without errors and both
dw:dmac168 and the SPI controller 0000:00:15.4 now correctly share IRQ
21:

  21: 0  0  0  0  IR-IO-APIC  21-fasteoi  dw:dmac168, 0000:00:15.4

However, SPI transfers still timed out with -ETIMEDOUT (-110) and the
IRQ 21 counter remained at zero =E2=80=94 no interrupts were actually recei=
ved
from the DMA hardware, despite the corrected ACPI routing.

This confirms the root cause is not a software IRQ routing issue but
rather that the DMA controller's interrupt line is physically
non-functional on this motherboard. macOS also does not use DMA for
this device, which is consistent with that conclusion.

It is also worth noting that Apple may have intentionally mapped the
DMA controller to GSI 20 =E2=80=94 an otherwise unused interrupt =E2=80=94 =
precisely
because the interrupt line is not physically connected. On macOS and
Windows, no DMA driver is ever loaded for this device, so the bogus
GSI 20 entry is harmless. It effectively acts as a silent signal to
the OS that interrupt-driven DMA should not be used on this platform.
Since the DMA interrupt line is physically unconnected, no completion
interrupt ever fires, causing all SPI transfers to time out with
-ETIMEDOUT (-110) and ultimately deadlocking the applespi driver.

Therefore, forcing PIO mode via a DMI quirk in spi-pxa2xx-pci remains
the only viable out-of-the-box solution for this platform.

Thanks,

Shih-Yuan
