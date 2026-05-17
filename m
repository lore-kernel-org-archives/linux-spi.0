Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E108330330
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779055473; cv=pass; b=OuXq9SD0gma9H3tqviSq5EaHNsf2O8wsMvURUwk3najUqrL+ymVPqG3TQ2k6e3Waj9k7OFfBFdZBbebHFjMYOVQHHa6G3kOce6llNrYF0s+CUe95WSmZO5C836nMtGy6d8j1O0Y06MYIoySGSB+32B1pmCgPQqKr/UHsZHpYDJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779055473; c=relaxed/simple;
	bh=gZHJrfIdPYrab0HpvH9DcCEOEOFnzCPNy8/jE8lgWog=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgGly2NkzdH8HuHs5KX9dLOhLhDsJAaDSmDskT1Tq15ZP+bPoOH0lqprg6SmumvvAi/4DgWO1848XSitRQAOYv1qN2FjIY90zGUGDcFSZcR27Avx72r+P1tP/7RNJfqrS6xPM1QbjUW4b4TgMHdPujW07CUSCS+ci4Yo3NSm8tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=LXAwF2Pr; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LXAwF2Pr"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd22b2abaa4so290415666b.0
        for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 15:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779055465; cv=none;
        d=google.com; s=arc-20240605;
        b=Lho+laeTuWfm0gO5VBWuSnyyqwY2Y3E5ZpbbQP9+yr4gwR9zXE3mEgZ9Oc5JwO3Rob
         kINT+w/udeI5/YKhPGJHezIZwfYZC0YiMB9r4xbyl9ZG+kxIIAS6jw03APFaS2z4OSon
         WTSr/B3tRuipv4LZNoOwC+6XTo679x41E08SZElI6T4Ji1RojfRqm99QOKHfT/y9CplO
         FEJ9OoJR6WFYhIz9l0MmMC64QufUVCSPoSElLvH57h8FUEqz6b4pzlSxgE/o19Kq9gtd
         Dg64Rtj7XZVtFrExMGOACjQoaSHiSX2tx2URntqRx5RfimsHw0RFcnmpVYquJae6fGc8
         pacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        fh=Pgw28IrmE7oI1w3xOKIATMcG7aVDqDpGkmOwzQRfLyo=;
        b=GQaiquIl8TgkJNbIfDiRpJefyvIXZRM5P13V3t6h+WOtu/Hz7ck6RD5TZDJNRgJ6Kv
         0V5l2U9kJI8TrsU63lR2CxTSnit4JIE0bGChovIZcfxWUtQCdAHs178IhbPhTPg/qClv
         A4F17N2ei7p7fIT800gEHOfjpKxUGHHV1nTBZCmqdBsyFEULDH9N1e8/elx++F9JJ/hI
         GytjOYRJE0PQGggcucKibYdt64u0lXEwe9PLQh7KnberEBA1Mld0wk9YfL9QyXNNrSXb
         ab9ZfkSNQ40ujidhm7sr/VD3wpJx+MAqZqg0OYZxVnqBKQbAD3eyrAhho+ckdzqeu1T7
         Qr0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779055465; x=1779660265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        b=LXAwF2PrT5A9q9fuByASsT3Wn/hhfhryTp/ed5JOL1JhYOtxs9V+nCy97YzXUfp4kz
         VT6nlWpF8Sd90IQWMWpP8IVAu/vhMQ26OSOjaC0Ugc8TnDq0/SBbJNiABkL26hw3DB8N
         OHMkEEQupPKPoeZmdRjOa/a0mvtC3FwpJCyhKo9ADBIqdbpQQfjwNKLqt9kdxima/dRd
         HZFqr+5fAgH/K2Z678tylyWv3L74Q2/vWpc63Bf+vgdjaeruHqNsz7J6z2TIauN9AVQ+
         hfDrcihuGzHPLRwa3YYfY9utzd3YOCXFlAo3qCShBVqPyYvX+sS6sRzni7ejQ1BcRYuO
         fktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779055465; x=1779660265;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        b=geTJk8eEMGC1LTv5DI8mAz3q1zvANEIYs0crhwtD2Z/HfiluCMShRivRRSw7IJMcRK
         TXgYXQmxKhnFSsH1K0l7yWO3Wugb3YfYLUPfwW4qtPDc9DLfsqKCmQEk6qMg9H6+6RUR
         z9DHkRZtazIkGBLWw8MmJ/WjXgl/hokF8kISM3lN2R7EouiA9J2F6+eLy9vDaKYXLdmJ
         nhslM0vpmCz/TtpgzgeDd4dDC4o9et1OaFHfm4gEQEZEPPJLD9qmgV7Q4SGwWmCpDtU8
         uoYXYi5FZMiy9TWarJn7Hy4wBfii8TGWuOEM9wDHxzL1HLikHGRHsI/QXpUAHc8IVq9v
         1WTg==
X-Forwarded-Encrypted: i=1; AFNElJ/xyfVkbkr23TY0D3OZb/4/bYnhT5lzfBMgPhsC6jrjINmznQeoK8Q6pXGOW9Jwb0kxtRFKeVCj4zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYr2xU1sNuzRiJbM7FR7Zus0HAq6PKITqwddYc3PZ+ayaM+gH
	llt0Drad9UkXOnI3cmAlp03IzAC+rtqn+ydDpqdeInXJJ9+MocJRQXo2EwnAzoZ46Rud++RTDQ0
	EF7PLPj1pgRqTPWgTbBJZy0m/ueYvlhNrM7bUu0g3TpdGinyV7iU2BoM=
X-Gm-Gg: Acq92OEF51pgGETwixRw4awDe8hTV6gVJPW6sXwLI4ArQAJCc6SWXDansQ1kWgsen8w
	v+52qbuImgxK4JOa9D1c7PDBiF7kj5bReFuCtXyt2X7/Se2ZDswGJtEVKpnGtHjW9b61Y+83UZN
	Pr4Y24FcBO3KyYSDc67iRZqPt6gMo1jztRUWiKZ4b9VeaOj1a5gyv1jC7PeWA9BedXH3VFcNdW6
	NUALfnAnAQ9HF8L6CEq2tkZMLMwMFhjkdEramTWZkupL7B5jmaR7YDnB7ugIxB3AXzF1VgVIQAF
	MS0yfx5OmhmqQPwW0EK7NcaNENKvsXBhQqUl
X-Received: by 2002:a17:907:3cc7:b0:bd5:18e8:1ad8 with SMTP id
 a640c23a62f3a-bd518e82334mr600884066b.4.1779055464251; Sun, 17 May 2026
 15:04:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:04:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:04:23 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com> <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
Date: Sun, 17 May 2026 15:04:23 -0700
X-Gm-Features: AVHnY4IqhiV2sSnDG3bDc8vtXUEslTxnP4xgh859XRbJ5eiok2HZwd1skAiBlBc
Message-ID: <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Arnd Bergmann <arnd@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@kernel.org>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> >> On 7/5/26 05:12, Arnd Bergmann wrote:
> >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> >
> > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > [    2.290000] spi_master spi0: noqueue transfer failed
> > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> >
> > DSPI is using edma, i will try to understand where the issue is asap.
> >
> > About how it works:
> > - for accesses to edma module (IP) mmio registers, must be native
> > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
>
> The twist here is that with the way that readl() is defined on
> coldfire as a non-swapping operation, and the generic
> definition assuming the opposite in
>
> static inline u32 ioread32be(const void __iomem *addr)
> {
>         return swab32(readl(addr));
> }
>
> the function called ioread32be() actually tries to access
> the registers as little-endian. I can see two possible ways
> we got here, but don't know which one is currect:
>
> a) the device actually has little-endian registers (like it
>    does on i.MX, but unlike all other coldfire devices), and
>    you just never noticed because using ioread32be() worked
>    as you expected.
>
> b) you tested the driver using an ioread32be() definition that
>    did not have a byteswap and it correctly accessed big-endian
>    registers at the time, but the version in mainline today does
>    not.

Ok. The ioread32be now works properly since i had applied Greg patches.
I generated an error in _probe on edma channel 2, reading status reg.
looks consistent:

	iowrite16(2121, regs->erqh);
	iowrite8(0x77, regs->serq);
	iowrite8(0x12, regs->ssrt);
	
	u32 status = ioread32be(regs->es);
	printk("%s() status: %04x\n", __func__, status);

[    0.140000] mcf_edma_probe() entering
[    0.140000] mcf_edma_probe(): allocating data
[    0.140000] mcf_edma_probe() status: 800012f8

If i am not loosing myself in this r/w labyrinth, the path should be:

1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
2) So the ioread32be swaps the standard LE read giving BE.

Am i correct ?


>
> > - for accessing the "tcd" memory structure, that must be, from what i
> > remember, anyway in little endian, independently from the cpu core
> > endiannes, this is the reason that big_endian flag is needed, it is
> > used for tcd area accesses, so the IP module was built.
> > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
>
> edma_read_tcdreg() calls into edma_readl(), which is the same function
> that is used for normal register access, so from what I can tell,
> they always use the same endianess here.
>

If edma_readl was using

        if (edma->big_endian)
                val = ioread32be(addr);

and never changed, without Greg patch, it was likely returning little
endian for coldfire and correct LE for other arch ? :)

I remember something about tcd area was coded LE, but will investigate
better, now i am over midnight.

Regards,
angelo

>       Arnd
