Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EC2F7F01
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779047004; cv=pass; b=BN1btjBjlXUaGFzT9Fx1IPcIA8JJ6ByD654l2NwiidnFgfcQyVsHLJY0Gi3vLUGJ6Rn8+7jHOD0Ag8qMjeIXFJsBNq+48gFiyMGoMILM5QaXAbKdVrtgB/TW+PgLdQJpXLgYdmaj83kRIo0f1dZZtxeBVA4HLal1tN78tto9mv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779047004; c=relaxed/simple;
	bh=qohdw6c5XY/Mph5vnXjfspO9h70+dVSKRCgfLeBy8yM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPy8434HklgKV5Iws1Xo1LNe4gEdD5ywmy3omvSXm4xGzh5s6Xg0VFLCtduAmQOYb96MMp0Wo1X7/UVAdqKzig4f4yZL+enqszwhAUrYJBqGh1EnABygzsUOCUdiwdt3x7YvqQLMtClqYXUwukorhLp6B6PNQnabWF4Il8ArDAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=O1oKSyVv; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="O1oKSyVv"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd124546379so316957366b.3
        for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 12:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779047000; cv=none;
        d=google.com; s=arc-20240605;
        b=hGJyQRxIXk/7/m9BH+r8l5ji51+7sPZa8uSwkWIcrDnq/iw+hRpM7GqxIM1tAfAhKU
         BEiLODuA1nmw06OdgGJhhKAoo26S1Z7Pqh5E0gKO/BEiVWsvAL/++EXy8N+kvrTPS0K4
         biA3QR9GD3qGeG3knfEWXrPgeIMavE03+tTIS9YUAPN3IN8ZiERBg9JuTAkt0AYmE5ox
         jp616+l+d00WWYxTriYsaPXqwr2y48HM3CHP3h1qUmiZ9RrcL69RqqqZ6GFV4jr4JSRQ
         HRTUPyGapKr1NrmshUfADlVXi1PVz4dZ+pV2jo8S6Y0mm0NdMduXVJHUJMubQuxgz11L
         oxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=j6Mto1oYp8fxMNax/4CSsHkuQNzcdJnt+Yi59gbd/34=;
        fh=l8fVA0Gbj+5fPQcPg1pb/9aaNBdTDGIs1zm4OgrGNsQ=;
        b=ZJWgoJpFbB5t5LH/to/fnnisoFKIAXPkv1LYvx8Qp2ilcYGJ3n/OTiOH1zJTxT/BkD
         z1j9uYSLWjCvnj+VrXnIg/gFeCWmVaOy6svhy7lF+uW5HdPCDYYm2gDeES+hrDp/zvGM
         xKXd9HT4uaow1UI/u37gszyrOdnLGKkX9T0DGP4iqertEm27vtVAGQBSHVvU/do8Io73
         5wrDuAgRfFUVHDOYCQvkUtvt8cpL2TtKvlirlyF+z/quzvhylZU1wYJU2ilUqs1Mvgmu
         OTJ5kVb/25bzVShPcR5syao8WmbJE6Dz8ZRHtwuOg3hLfic1ECxIH2rx6j69010RMgME
         lgng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779047000; x=1779651800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Mto1oYp8fxMNax/4CSsHkuQNzcdJnt+Yi59gbd/34=;
        b=O1oKSyVvQI4s7vPrStCGQYiyPmyqNHQroE6uKzZDznpIG8Uw2DwXDmcYIj6LiDShMe
         o5RtRmwOAgxfQZLTb2mooQeDL+pX+WzD+G5aKl3PkQ9fCBaxwKcJhh7+W03gZ1TiGUAA
         mxlrVCj/iPTIu1aitA9noatwI0DlC6/yDBBGczPO3mmEyk79uQ3t0i7fZYnxkez3+2HN
         YTnoWBNfB/1DgnqJr2+aoNDgBd3NSw2WBKYcodMADb4sfNYH7aEPX+rv+lhXG0hDnyHF
         rwU6u3+Hhrj0bp+DWf+II0IGh8/Vtz+2GlR7WYYMeoR5+ne9fc3cEIYrBNXWwy/5IMRu
         G8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779047000; x=1779651800;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6Mto1oYp8fxMNax/4CSsHkuQNzcdJnt+Yi59gbd/34=;
        b=JO1BHRJtyDX9Fkn4ghawTmK7tCaTz8yoWxgzd699mjQgO8PJoZmXyhc4+Ftrr3EQ2Y
         P861isQEAyTzZD4hkJgyEEcl+J56HLB93++L6LRn0hX1INNpnGYKbhqhJcWkXRq76gOV
         U5jWad/RI+QGvTRNL/9e9rJvLLYou6oN6waqt4NOgW6wAHppzAyHg/9H92kUzHOaLArz
         Bg2XaMWMoCVW9KJsO5IaRpF4dAXuoRMcG0ZozAEbilH9iK0g8ugb1ruJycEcvqHJ/t9T
         MXPfxm3+umZVOeyzVPj2PdfNnkZXXMUB+UrIeXt0Echdalyei/OJSCpuhXrbA7iHIbv5
         KT0A==
X-Forwarded-Encrypted: i=1; AFNElJ+UrrAP4BjW6dRFT2+CsgHVpgnUwNwCCLz15pLDcZiqEddgHRAPcPEc6o9Pw8W8ED4YZgayjiyo1is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIO0m+ejTGNWoFCaABS3EC7b8X08T7ohZ7+ykt9KkVGOqDn+WT
	wA95z+/1xYlFuy9IHr75wzEH12CB8NOteB3jM/7EVUxYyZXEM9kYnqQvx/1j52edFv/70lDYrC3
	ubdt3asyQGQyoNT1Dt1oXLzm7EF7s1ldzXmcwPYQX5A==
X-Gm-Gg: Acq92OFWMDRr5ZJ+7pwq3kk4El5biIarTSYd4HJEaQ/zhbFJa7pf39L+utEPQ31P4iu
	JfflITR5tTT4k550PWXOwo1nDzHRxD6/Sk6Y8UaXRmGaTZu9TBBKjdINe7Ja1rpkLYyPIaKZece
	YRLIRzKeWf0Uw9Y72+CILalsx3GBZUwbVrVY4pw9kG9WEqnfnYR7ExfrkSkjZUijZ6SdgPIsztI
	NrEWk9Vf7/I3RwZW0f4JpCJmGcmTJUQu9Q59kX0RVf/BmiLExIPK2hj4Wc8Ns2ls4Kecm1CUJAM
	sqVgUj6JnFC78esrI50rpfIk7BIiYTxSrwS7f8Nnt3m8VkE=
X-Received: by 2002:a17:907:1c9c:b0:b98:40e:f335 with SMTP id
 a640c23a62f3a-bd51795070cmr615382266b.34.1779047000052; Sun, 17 May 2026
 12:43:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 12:43:19 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 12:43:19 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
Date: Sun, 17 May 2026 12:43:19 -0700
X-Gm-Features: AVHnY4LTi1UepgBp7RlwHGhgQikPAAttg6_8VSJjgHVMj7UNTEH_cv4_jkSHs5E
Message-ID: <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Greg Ungerer <gerg@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, Angelo Dureghello <adureghello@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

sorry that i could check this now only, hope is not too late.

On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> Hi Arnd,
>
> On 7/5/26 05:12, Arnd Bergmann wrote:
> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> >
> > > drivers/dma/mcf-edma-main.c
> > >    Supports big-endian access by setting the big-endian flag of
> > >    the drivers struct fsl_edma_engine. But locally should be using
> > >    ioread32be() and iowrite32be() instead of ioread32() and iowrite32().
> >
> > I'm still a bit confused about how this works at the moment,
> > since the drivers/dma/fsl-edma-common.h file already contains
> > checks for the edma->big_endian flag, which is set in
> > mcf_edma_probe(). The version after your patch makes sense
> > to me, but it looks like the existing code cannot work.
>
> Yes, it certainly doesn't look right to me either.
>
> Angelo: you look to be the original author of this driver, can you shed any
> light on its working status in mainline currently?
>

I was some years far from this driver (and the kernel itself), but i have
seen there are several changes in the edma common part from that time.
I remember i reviewed/tested some of them, some other unfortunately not.

I realized last month, that i was back working on this board (stmark2)
that somehting related to edma or dspi looks broken in mainline now:

[    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
[    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
[    2.280000] spi_master spi0: failed to transfer one message from queue
[    2.290000] spi_master spi0: noqueue transfer failed
[    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5

DSPI is using edma, i will try to understand where the issue is asap.

About how it works:
- for accesses to edma module (IP) mmio registers, must be native
big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
- for accessing the "tcd" memory structure, that must be, from what i
remember, anyway in little endian, independently from the cpu core
endiannes, this is the reason that big_endian flag is needed, it is
used for tcd area accesses, so the IP module was built.
The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).

Anyway, tested the patch, nothing looks changed nor in better or worst.
Will look into this in the next days.

>
> > > drivers/spi/spi-fsl-dspi.c
> > >    Setting the regmap format_endian flags to use native endian will
> > >    force driver to use appropriate big or little endian access on
> > >    whatever platform it is built for.
> > >
> > > These drivers have only been compile tested.
> >
> > I would suggest marking these as explicit BIG_ENDIAN rather than
> > NATIVE_ENDIAN. The effect should be the same since coldfire CPUs
> > cannot run little-endian code, but the way that hardware usually
> > works is that the endianess is fixed at the bus level to one way
> > or the other. NATIVE_ENDIAN to me implies that the registers
> > have configurable endianess that is switched along with the CPU
> > mode.
>
> Ok, will change. I chose native endian in this case since the regmap config
> entry used for the m5441x family is also used by the vf610 devce (which looks
> to be an ARM imx SoC). So it will need a duplicate setup with those endian
> flags set to BIG_ENDIAN. But that is no problem.
>
> Thanks
> Greg
>

Regards,
angelo
