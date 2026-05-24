Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965F3148D0
	for <linux-spi@vger.kernel.org>; Sun, 24 May 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779657433; cv=pass; b=g+c6AIIbvDNFKT5qz3Up0ZJD396mSj5/LlvJM3dk0G+pZnK3zFnh4d5/oHFGRRJEM8bXElPb8BWHXs5dTyIUH8yXP/KBFN4f+9Rsb4orgx4afjDIxEELLEFAVxzbR3EZMWxaPQoj95e4BIVg7MHS0An7W3Exrb8ZqPlSDD0DlAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779657433; c=relaxed/simple;
	bh=qfr3PV+aenV2JpxF3FEwOoVdituPWH2TqiuNbdw2APY=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYMQES7K8AxReP4VqB1scEE3MJXH5Lg/xMdfpHRYRMCUl2/qceQ8w9L+mCksETPYiNVsIDKRV3HAmUBiM6Vie7nY3sasYB2wgyKQZ5f9kHJl0nLIw4pdv+laBFIOJgaOMQG6GKq9oS1blnDZdWtZNR4WZETdhEVFZwPZKc9v+n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F1bMJPdt; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F1bMJPdt"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68707d88626so9931104a12.0
        for <linux-spi@vger.kernel.org>; Sun, 24 May 2026 14:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779657428; cv=none;
        d=google.com; s=arc-20240605;
        b=gSQg+62Uk9Pz0RGH0rm5B3spjRqWslso4nHPP3FAqhyJ9tcGqih51g0t4uUj8Urlyt
         akLNdcnmytIeS08Mjg85ClpWT61ULH60+CtnDlyfEwcEUVQl44leNZvqi+LB4l1xKSU+
         5Llc+ikaQY9LW9+ft72ejbrCa7peEWd1bZONcxHfbsbtkgwSGPw5F8Dd1ORbMz+FIzAo
         cLIUdm+y9ImP7QV8RQgT9uBcRUyFUWkv4i03+yPvy1uD+WFyxFvfuJayw1RSSojpom04
         IpMP2UJEyoS9HPwIHxCRzWwmH5d+em9MwOCoyfvf4IZBp98ZMsos0MuOdyzj/2CdS490
         oBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        fh=IrnyetTKPXxr9gbkPGINQSjA7GHcjueHOqXH6IRrmmg=;
        b=URs/2+UDpfL9Lvi7/P5UBGv6D2nv85zE/a1Y8yIk/4w2ei7UnaAv6OLmS6/Zs208pz
         5Wf8mazR83bOTbEn/QQDqOlqUytBfN9ycNGpNqHjZ52XtNKkw4aWqqCKBC2/ahnA9TcB
         hovalbzWG1rA9sZ38m7gGgi1ChLWAzritobCruLGt3KnEI5uTvcvylb4MJSqMnnetlPv
         3M4G6LKnacUHUnHF7zKqTKeB39Tem0iW7Ks91to9SMxoYWXWI+mFEW6w10+mXW7kJ/av
         unFN+LeMIdrEu0bMoyIoBJPghCbCK5cImnMvY8TQJpZJ7F84UAh5+Bmhzta9BY3N/hQz
         6bTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779657428; x=1780262228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        b=F1bMJPdtZgkqyu65CsjIi2ZYg5QbFD7Y7uGdQ7uE6/w5Oe26j1eOnTsAdgHkCUL2e2
         ZCFd9WPpLhoWkrzVQylPo/yBj7h9eahiygtA5PLTStex4JFHWzGURgWQEmVJYVahTdTF
         tVrSTVhjG97cnaIFgfEdJ1PovFmar8znQH9RPzTWpD49DqB0m/PoYMcNs1v8jlBuaLEw
         S9g8r5d07Lj6Kl13piXqv+IVAEd+YRGmqCaW/VA+KxhPj1HNzhtXomG79r3EypvTljRJ
         3/oCNDItTkc2AffGkN7wSsX9UtmfWVb+t47+t31q3pEXAeF3iyf/Z5ILFVSwxC1vO5hh
         vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779657428; x=1780262228;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        b=Mnyp4qygKh4g+Ld7wwbTePKsfjGotYQdETDAhHwXAngv7nDYT+0OECZC7QceG0ncnL
         xOWwOeUXrmbA/0my71R4UQ59UuwGADI4XmXa5S76noVn04SPvCy+6I7AxDZGnDHtLKZu
         K3Fwkn08XynZBx0qWXyRihficD27d5q4kZzRL6zN9sQdC+f1vQCTgLGTdV1fvT9mJIi5
         Z24ZTjiwSn40yLYBWloHU2djahLs6zovgDCG48ic7diAAS2bpv0/XfFJrBv3DT38TsXb
         WMFZ6gVxnAtPgSnhl4KRUNYibg9kNEy9mZ4kAvqaE/C36JWXYR4hLvOkJffwFq4s2vBA
         EWmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iq1TBp2wLHPCnvJyyapZ8NJZJ/08nKoPC+Mu9pjh2XwkwsFN4A82AeH+5FHlS/ooKRItvx+J0wqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3KSsw3Jtyiv5lu9r2vnM31zQmCW6Qq9Qs1SUoqcGijHlLUyo
	x714PawI6f0Y6TyimF/Fpm70xC1J4bN+fy19fQog15QYeMRy5lQe407HWdb2+0D/QFVPtztPQcC
	nW47nGKnN0fsQrhYrKq3ZtgMkyMt3XHssOHeTyY1evBHyBPHDOOwiYe0=
X-Gm-Gg: Acq92OFaj1bP8On1QklcW+oHjp6KKFHV9YtVyvmlp8lIshpvGGpl1hpaNH8MBZ49fod
	fdNYRDEvLQ9mviAWHGt6vplaL88fAa73p2Gc/1tJimAmcZsnYYQRi/FRiv8XL2M19FF3GWAJ1+h
	HGyjS7npvJimsQxUES7r9eTeyqngacYIZsP5gKbJ+8VtxK8LOguYlDdbzEd0fm0X7l5Q93I55AB
	sImW/RLhMdgQ8ledh7ma0omVeipSCIp9wPT923s5hsFcJmFHoofNZtyto7qrrO7FgRji6uIEvfs
	ap/xCXsvw/VNI7L3s0RuehL92sjeDWMQZhik
X-Received: by 2002:a17:907:7290:b0:bd2:4aa6:1a9d with SMTP id
 a640c23a62f3a-bdd2360237fmr744344866b.16.1779657428216; Sun, 24 May 2026
 14:17:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 14:17:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 14:17:07 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Date: Sun, 24 May 2026 14:17:07 -0700
X-Gm-Features: AVHnY4JHtsLYNvdawYYzb7h3_2sEIhQJt9TYhOw6--5OCNVF-hms1fU3-Y2rI9c
Message-ID: <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Greg Ungerer <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Sun, May 17, 2026 at 03:41:31PM -0700, Angelo Dureghello wrote:
> Hi,
>
> On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> > Hi Arnd,
> >
> > On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > > >
> > > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > > >
>
> About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
> i probably lost some dma config option.
>

so i worked on this open issue above:

- moved to master and rebased,
- crated a wip/edma branch,
- bisected and found the offending commit, before this, mcf-edma driver
  and connected spi-fsl-dspi (using edma) was both working correctly.

7a360df941a4bd60847208de59f1ac8b166265a2 is the first bad commit
commit 7a360df941a4bd60847208de59f1ac8b166265a2 (HEAD)
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Oct 12 09:52:27 2023 +0200

    m68k: don't provide arch_dma_alloc for nommu/coldfire

    Coldfire cores configured with a data cache can't provide coherent
    DMA allocations at all.

    Instead of returning non-coherent kernel memory in this case,
    return NULL and fail the allocation.

    The only driver that used to rely on the previous behavior (fec) has
    been switched to use non-coherent allocations for this case recently.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
    Tested-by: Greg Ungerer <gerg@linux-m68k.org>

 arch/m68k/Kconfig      |  1 -
 arch/m68k/kernel/dma.c | 23 -----------------------
 2 files changed, 24 deletions(-)

So i can try next week a patch for edma looking what has been done
in fec, and since i am probably the only with mcf54415, will test it
here.

> > > > DSPI is using edma, i will try to understand where the issue is asap.
> > > >
> > > > About how it works:
> > > > - for accesses to edma module (IP) mmio registers, must be native
> > > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> > >
> > > The twist here is that with the way that readl() is defined on
> > > coldfire as a non-swapping operation, and the generic
> > > definition assuming the opposite in
> > >
> > > static inline u32 ioread32be(const void __iomem *addr)
> > > {
> > >         return swab32(readl(addr));
> > > }
> > >
> > > the function called ioread32be() actually tries to access
> > > the registers as little-endian. I can see two possible ways
> > > we got here, but don't know which one is currect:
> > >
> > > a) the device actually has little-endian registers (like it
> > >    does on i.MX, but unlike all other coldfire devices), and
> > >    you just never noticed because using ioread32be() worked
> > >    as you expected.
> > >
> > > b) you tested the driver using an ioread32be() definition that
> > >    did not have a byteswap and it correctly accessed big-endian
> > >    registers at the time, but the version in mainline today does
> > >    not.
> >
> > Ok. The ioread32be now works properly since i had applied Greg patches.
> > I generated an error in _probe on edma channel 2, reading status reg.
> > looks consistent:
> >
> > 	iowrite16(2121, regs->erqh);
> > 	iowrite8(0x77, regs->serq);
> > 	iowrite8(0x12, regs->ssrt);
> > 	
> > 	u32 status = ioread32be(regs->es);
> > 	printk("%s() status: %04x\n", __func__, status);
> >
> > [    0.140000] mcf_edma_probe() entering
> > [    0.140000] mcf_edma_probe(): allocating data
> > [    0.140000] mcf_edma_probe() status: 800012f8
> >
> > If i am not loosing myself in this r/w labyrinth, the path should be:
> >
> > 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> > 2) So the ioread32be swaps the standard LE read giving BE.
> >
> > Am i correct ?
> >
> >
> > >
> > > > - for accessing the "tcd" memory structure, that must be, from what i
> > > > remember, anyway in little endian, independently from the cpu core
> > > > endiannes, this is the reason that big_endian flag is needed, it is
> > > > used for tcd area accesses, so the IP module was built.
> > > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> > >
> > > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > > that is used for normal register access, so from what I can tell,
> > > they always use the same endianess here.
> > >
> >
> > If edma_readl was using
> >
> >         if (edma->big_endian)
> >                 val = ioread32be(addr);
> >
> > and never changed, without Greg patch, it was likely returning little
> > endian for coldfire and correct LE for other arch ? :)
> >
> > I remember something about tcd area was coded LE, but will investigate
> > better, now i am over midnight.
> >
> > Regards,
> > angelo
> >
> > >       Arnd
>
> Regards,
> angelo

Regards,
angelo
