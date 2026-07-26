Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B6322B8F
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785064354; cv=none; b=ipPa9aB1ywXkmS6EhcnCu2umPlEPFtm30K1V3/K3ty9fMOfymrMPjgZD5o1KD3ZAN3cjc5dfjYqIXMIREGOldGjDJJikK3Mk9JpXXAVGAhSocZxLE52RW/rZdEFekmuWOxQCkfrQcfq1yhQRXXs6Jo3FjevV+/NXEmZkVq994fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785064354; c=relaxed/simple;
	bh=CrO3m5lVOVX9pKW7m5uGi7Il6Sad2PRx5vibMcDIgCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUf3BnYguadjEAZqo2M1/Mac75MeuN/rNTRUwcRecke31Yc5bp/IkSM/34oNTM07K8cMe667D1GsKXD3tpo16qOGLKJ2VfVLvsHQ/Ua7zM/0/VchbhGL2h9QtwhZ+WnPvPZWxlWyfpFdMyqM0HPq6NbR8sl1YfOJyu40XyCML6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-45133d2974fso1478672fac.1
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785064351; x=1785669151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKU0QhAvsBejgAlbDaY2+1ClKAxRltlgTuy03z+3isE=;
        b=IT8uaEGYz8Ynl0pyDfFLeBIL5uNoYTTFHk/ALpCWPz6MCSAxDatT6DGLwvmkL9fAA8
         M7ggRPC54vwGmNn3QnKJZ9oN52M8/OMfl2xzA2ajXkeCShVL4hpYX5BWQnuuopipgMjc
         0+DFd0AkYrcwvE3PTiMt5bC3/yH02wWTgsRMOIJ0HZWhyRXKvcbUfAUJWCKOCGS/YqVp
         92/kjuBIa0AIARDD9cVTXecWZb3g8EDuAYsV7/irl7A9MitkYoilpCjesW02AyJsOpTt
         jJB5S0aatyBSyQp+ksI9+GarEbATPFYUOWHQ/lxNetbzL9dxZZ5/ReLk1FTzJVnNiOC5
         /Gmg==
X-Forwarded-Encrypted: i=1; AHgh+Rrci4nTEMxB7lBk0aLRrN+bGZPJ2txUNkvoftJgcI15XWahHeGGPZxNCdjHH7nZiwei97VNbOUXqm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaj3BgtX76GabuQAZLprlguiimWJnMS+hcN9Nrci4GrzHii1U5
	YNTPMCTe8ISDrSTNIeim4nXNAS2icw/6jU3uDg8sN0qoJO46kvgPw6A9EUFKIX51CA==
X-Gm-Gg: AR+sD11heQcSL/PYthEdg8eNenHDEZUkbOq4fEBOgFv4q3BqTfTjONlM1iPqeMiMNfZ
	Ur6thd1l+CYD9RF6L8ZeE47KP87TcaxR2o9w7x++lJTJh0TV7irLuT9xZWVZSWEJofDKCm2mbyC
	elLX+wGRFUQ6L4hAxzMNMzGa1XAXMOvgxBk+YOWAmZbAJEELkbiN+09UTLBd3jxp6AslvNaWqk3
	6kk82LEU/P2sF1gccm9S3hZMdmTgdqhmexlUgsbfEg2Nw0ghO6AsjGx2N1z0T1cc80c6/vzsuiB
	nZ2SEG+43epDf6PfhPSutjxFZvieDwvAbmz6HJSIrJSdAc9x3S/0PlLkyanUz1cUqEKvnDgJevL
	IA6aocWLmfHrpyTf/8AtT8ltXG5MrN022MEqCTFpuNrWm9qZVUlrl6G3xHDQZYktrKNlSEZCvGS
	Et1S8OM1hXIuqdFmk54knmkbW01R6z5DC13nS9t+yxsG1RDBJDayEg4re3L23WoXUXmCkIxzyp
X-Received: by 2002:a05:6870:a116:b0:447:2ca4:918 with SMTP id 586e51a60fabf-457f278c8ebmr4277339fac.33.1785064350855;
        Sun, 26 Jul 2026 04:12:30 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e7d640sm12063413fac.4.2026.07.26.04.12.29
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 04:12:29 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb6573bd52so1171070a34.3
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:12:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqncLN8w6w9WRiAB9F5FZ1BQLHj3ftAhsITBitv2UOyRK4eZaOhMIwKA7w6/rH9d5dWtWdPgHPIYQo=@vger.kernel.org
X-Received: by 2002:a05:6820:4d0a:b0:6aa:d792:e078 with SMTP id
 006d021491bc7-6aaff87594fmr3257957eaf.27.1785064349448; Sun, 26 Jul 2026
 04:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-4-fourdollars@debian.org> <al58ubdrmJpPtr0F@ashevche-desk.local>
In-Reply-To: <al58ubdrmJpPtr0F@ashevche-desk.local>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 26 Jul 2026 19:12:18 +0800
X-Gmail-Original-Message-ID: <CAAT15mNAKHdJTrxqctHe4o99TTN18481r+TVAL0ubA44zM1Yug@mail.gmail.com>
X-Gm-Features: AUfX_mytscuS4j8uP2M1eAMvyLvFoGxgNoXb9GjOvRAaNp-ItKcKS9Ve7cJtouU
Message-ID: <CAAT15mNAKHdJTrxqctHe4o99TTN18481r+TVAL0ubA44zM1Yug@mail.gmail.com>
Subject: Re: [PATCH v16 3/7] spi: pxa2xx: overhaul teardown and suspend
 sequence using pxa2xx_spi_off
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:53=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 12:21:12AM +0800, Shih-Yuan Lee wrote:
> > When removing the driver or suspending the device, the clock must not
> > be disabled while shared interrupts are still active. Gating the clock
> > before waiting for in-flight interrupt handlers to complete results
> > in race conditions where the handler performs unclocked MMIO accesses,
> > causing PCIe Completion Timeouts.
> >
> > Overhaul the remove, suspend, and runtime_suspend paths to use a strict
> > synchronized teardown order:
> > 1. Disable hardware interrupt generation at the controller level.
> > 2. Mark the device state as suspended (suspended =3D true) to prevent
> >    subsequent interrupt handlers from attempting MMIO reads.
> > 3. Call synchronize_irq() to wait for any active interrupt handlers
> >    to drain completely.
> > 4. Gate the clock via pxa2xx_spi_clk_disable().
> >
> > Additionally, commit 29d7e05c5f75 ("spi: pxa2xx: Avoid touching
> > SSCR0_SSE on MMP2") documented that disabling the hardware block via SS=
E on
> > MMP2 SoC platforms corrupts the RX/TX FIFO. Instead of calling
> > pxa_ssp_disable() directly, use the helper function pxa2xx_spi_off(),
> > which respects the MMP2 platform quirk by bypassing SSE register writes=
.
>
> ...
>
> > +     /* Wait for any pending interrupt handlers to complete */
> > +     synchronize_irq(ssp->irq);
>
> Unneeded. free_irq() implies that.
Hi Andy,

Thanks for pointing this out.

Good catch. Since free_irq() internally calls synchronize_irq() before
releasing the IRQ, calling synchronize_irq() right before free_irq()
in pxa2xx_spi_remove() is indeed redundant.

I will remove the explicit synchronize_irq() call from
pxa2xx_spi_remove() for the next version, while retaining it in the
suspend() and runtime_suspend() paths where free_irq() is not called.

Thanks,
Shih-Yuan
