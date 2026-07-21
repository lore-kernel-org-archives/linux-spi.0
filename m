Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C04C955D
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647605; cv=none; b=jVSRaPhCavl9gmR3TyQUM/dsWZIBq3ZOwwM81u8Zmn/iDgSvJj6fdAZkUXXaorXVsDyLUlqglo+Lk5m/aMtZK0S24SS8ekG8dCNIiYcKO6z8mo93cVAAZz3GW1XY814CPkH2kkYcXc7T4LMqKmd3m7FIAkb6eHR5A0yA9/zVfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647605; c=relaxed/simple;
	bh=kZw7qQ58lr6F2XGvbI2dzLc1UOklc4S8nhzZJX8grdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujB39KUFDV+Eu9Q9pb7DyQWJN8bxJ4oOym1gkv/zb3PrpZl6q6Pl8zht/Wz6IVaN1N843QSqrkw2NvdCCH/2/3n0A1W+Kd6jrI/ADosZNRaYgCY0Bh5WXp1dKlFmBPgqTO1S9/tTul7gu4c4QR9kSr45vAtW+Nxbq6KHoN0P1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a3d9aded38so3915493eaf.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647603; x=1785252403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQ4oz64LgBujIP7CtqKYaHKZcr3Fx0Qobtjvcna58JE=;
        b=OriAegjCDD5Uv3zSIP73fWqSIlOxrFD/IlJ3ArgHKqNiLF+ssWryOpaWhZnPKyPbtM
         BM1xabGnVDtqjBfSdJSIhhrcRA56QUEArdlmqhjEf3amDBfJHnZDjodDgWodhp3TcO08
         v5I/3WkYYxzdRIG2P8ij2o/cSg3yUMy86e+Rki5GWnNwSodx8Gk5mOSraoFcxieo4m/W
         WdWMykbkVnNbBGLOcPHx+mm3zA1KONxKZmnXpV9Usn4zzs4iT3hClbVBuzO3vy8qq7zs
         LF39+xmgFSJsyDEdz3s58tqgdgK+LM5lGxDD6ZyRiI3pw6U364kzgYNBKIaszNo7TLMS
         cJEw==
X-Forwarded-Encrypted: i=1; AHgh+RoLQsjZNbPcsdthZeVrabDgeypHpXTW8mgEJKwl67EbvG3lr6hlCWLR17cV6b+19OdLMmsC+GHDDHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vg+kFZEqnnjNLXqM8sR8CacUMrt16eUdNu8qfYbsCGW22aau
	VL0BQ7+KtHN0Est+Q3zoje9GlX7iTT9OSP58uM9bYdPQ0PbncPDCxGcBytu5vhd3gQ==
X-Gm-Gg: AfdE7cnLK8slqg0C9Tt6KH/u/kOpgdb6gBM52INwt7QmQ8sdWGTXpVOcisw/FKSFfv5
	IfJoTxxySqrPeoaunTJZkhEAkA6BaOhhnIn1k4Nlwrw0S8JgRiRb81LsFT8vcP44xB1dUmc3orJ
	usYbjTL0WLje3yCPDZHKThGtZGM1GehA1dc99ZKiqUzPBt+8m+8FZ8+eM2rHo3gxfTdgJErDE07
	TblFQ3Aj09IttcxsoHosZZpKIB/BNamQH9riHJvWTTZmicoTQ57Q/X4LaaGrnD794oJUbU8Kaw7
	2I/sxyeb8GaToxsx4hpH8fdinpqb1RwR2DmTEXsDAKOvNwnZcGRCsGHKfrsr9Azx2SX5JJsT0eB
	dFlDoFpQmk+L8xG+K4qVZoR8HBx8yTqR6vWWZT1IX2iknmzJDtGYfii1AlnRLnxxq4mLIjPb3le
	JI0h18oadDyz9Rkh9JlXux5HiUSpJyBXSi3mqShYQAPJZFZcpeVCkg3etde1MtvCvwzVN6D1iC
X-Received: by 2002:a05:6820:2010:b0:6a1:549e:b46a with SMTP id 006d021491bc7-6aa4a02e88dmr32201eaf.15.1784647602810;
        Tue, 21 Jul 2026 08:26:42 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf9f1076sm11150654a34.26.2026.07.21.08.26.38
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 08:26:41 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-451fd21113cso3868148fac.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 08:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqvWYsNEV8e+uMs6g/F59lcfR2+08oWxaWUriEdW+7qQhxTu3P1sgKeUkG9nR+M5+hYC4vRmC1dNLw=@vger.kernel.org
X-Received: by 2002:a05:6871:e023:b0:430:16b5:909 with SMTP id
 586e51a60fabf-4576337c756mr31587fac.15.1784647598566; Tue, 21 Jul 2026
 08:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org> <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com> <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
In-Reply-To: <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Tue, 21 Jul 2026 23:26:27 +0800
X-Gmail-Original-Message-ID: <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
X-Gm-Features: AUfX_mxcLZ9MDAZV4isNPolsPsjelNX391zsUCu_4hyVZw3renDlpBWi3bMJ4kg
Message-ID: <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
To: Mark Brown <broonie@debian.org>
Cc: Lukas Wunner <lukas@wunner.de>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 11:05=E2=80=AFPM Mark Brown <broonie@debian.org> wr=
ote:
>
> On Tue, Jul 21, 2026 at 10:34:20PM +0800, Shih-Yuan Lee (FourDollars) wro=
te:
> > On Tue, Jul 21, 2026 at 5:26=E2=80=AFPM Shih-Yuan Lee (FourDollars)
> > > On Tue, Jul 21, 2026 at 5:18=E2=80=AFPM Lukas Wunner <lukas@wunner.de=
> wrote:
>
> > > > It would seem better to fix up the incorrect interrupt number in a =
quirk,
> > > > rather than disabling DMA wholesale.
>
> > > I appreciate the comment. Based on the Bugzilla feedback regarding th=
e
> > > incorrect interrupt assignment, it seems fixing the IRQ value via a
> > > quirk is indeed a better approach than disabling DMA wholesale. While
> > > I am not certain this will resolve the issue entirely, it looks very
> > > promising. I will investigate the IRQ mis-assignment problem further.
>
> > 1. DMAR/IOMMU Validation Failure (Error -22)
> > On modern kernels with Interrupt Remapping (DMAR) enabled, overriding
> > pdev->irq to 21 causes the dw_dmac_pci driver probe to fail with
> > -EINVAL (-22) during request_irq(). This is because the
> > DMAR/IOMMU strictly validates the PCI Requester ID (source ID) against
> > the GSI mapping defined in the ACPI _PRT table. Forcing a device
> > mapped to GSI 20 (00:15.0) to register on GSI 21 triggers a
> > source ID mismatch check, which the kernel rejects.
>
> That really seems like something we ought to be able to do, though I
> think the idiom here is to patch the ACPI tables so they are correct
> rather than quirk things in C code.  ICBW about the preferred approach
> there.
>
> BTW, if you're using a LLM to assist with analysis please don't just
> paste the output into mail.  Instead make sure you understand what the
> LLM is saying and write up the salient bits.
Hi Mark,

You are absolutely correct. The standard idiom for correcting firmware
bugs in ACPI tables is indeed using the Initrd ACPI Table Override
mechanism (compiling a modified DSDT with corrected _PRT routing and
prepending it to the initramfs).

Actually, I was just following Lukas's suggestion to modify
drivers/dma/dw/pci.c to do a quick proof-of-concept test, and I used
an AI assistant to help me write and deploy the driver quirk code.

I have previous experience with the Initrd ACPI Table Override
mechanism, so I can definitely try that on my machine next to see if
we can get DMA working properly by aligning the PCI routing and DMAR
mapping correctly).

Also, I will keep your advice in mind regarding LLM usage, and will
make sure to write up the key points myself rather than pasting raw
output.

Thanks,

Shih-Yuan
