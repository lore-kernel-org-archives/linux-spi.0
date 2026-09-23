Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FA33ADBA
	for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174457; cv=none; b=bODdxzxbIkLuvv9hVpNTuMzi40tlPdlaI64ekrxH+9KkRoxfaDB9XSPLZHOgq2r7WzXPhP+Pma3AXjTbpjw52wMfxY/6Ti76pu5qzcxWlt2D6FwEEL3jOy7PtKML6CluTDa2PA6e+5kawiaLBrgvcEG5qGF9IhSDEgAQ27TKMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174457; c=relaxed/simple;
	bh=HAiG2uKeueum3NwR1fOOATsx3Nfb/2XuIB0lowPT5AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJDbYLoXbMkSmsQJHzmChfs0UwvI4Q3/wCd6ZG3pk+ORpZenEZfz6sgSsUZqIzNPGdXYQfGUwqmEVqAFIna5V4zw5RZkpu517lDFK6K3HeO+7MiRJNpMYRs/p5UxxQJsxixwCrMWZJwpqTSO3mBHPjXtAmsc84h3Oiw5mrFKLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78564319a92so317074137.1
        for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 07:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174454; x=1790779254;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3QXVYin3gKtafVdGEnWDbswOTPSZ/Xq4fs9pj7jQGAU=;
        b=SL3Dr5oHr7g6U2ssWTQjYRj4NjjfOt9axLzZqsz2/YI4bZuIBalkZPWe5ZZXKgMNC4
         KRS71gEMGNZ1IG5o3NxEnIGMdryrHLZvJFp72QTQ7/X4D3TiqN5TkpkL1p3C0D+0SumX
         bpe56ORSkkCjoITRoC1vcFPUf6CzTIRsHQAhYMNUXZT0b/A5bzVz83DMD2dPGNQ9Fqfq
         pC6y+C+BMQTHei1B0eKcMp5jJVjwiNXKXhL+lMwPPWecFoMFHmMfDSOqQjtSSm43CICX
         p8olk2GZvdqEGYslhokGDxIVD/XwGdeywTIO64QMGQ9sp7xhxhMCKbUw+MJtwoToNOlr
         Ldvw==
X-Forwarded-Encrypted: i=1; AKwUvBxU3EB6E1SKijNOmxNxSw10xMBcuGPmTPLcKRpgBPcG0xo3TaZpTDopyGCTEZ6ylAEd7ElRVJQ5p6o=@vger.kernel.org
X-Gm-Message-State: AFuF++kD0ugxg21fjEVTIIHQvlxYaCU7+t0fs6csMGN+SEIUx4uh++Tr
	Fh0yqJZRxg3pBo+JiHmSCnaC1r4mDgkA+jArNqAWa6h7SwAE2O+ddpJOkN8lRkJiNtE=
X-Gm-Gg: AYBFou1xVveFPSnZ6o9n4OxuoSiLbNUEl2LYfn6qHl9vyka54YmpkqWMmAJiwZhVxr3
	MNddLsGb4eH/2ojMby6q+Z4Hr3P7YvzaKkWGgQjGssbC5qUcsrMg4gtZwVzBAR5Rl5YWLCG6xte
	XrBroBVI9hd7NPIwq6jKocJBNJXwLAk0GMSGWotswoEzVdncrHJ6ReWoxEfmd/Lt2T4RP8Y072N
	eQxiAI0YJloRvJMtTeXgt9bx3PVS+KdEY2UA8jPLwVm1/5od06NqDBH0jpCenO4T24dpaBJR8q2
	qF8EwIrkVuiOCsaSZJ2mm7wrOzKQMFAFXnKw635e/+VNKR+nhylMBAfM4NhZoR3lCMVU/PpX7+G
	ATTMWVxdS72AOn6rYXSp31qGwlwT9OlmPhoWyAgxk4ia3xWYv0iDeSVEezYPzgWRTEG1oCTaH6v
	MakYm7YdynrxuuGjMYubmqqgL6YAnUwIJJM16721VRZ8nqIGfR70T0szCw8+CfWaPyw2EQyLCiI
	hdounjy29PuyeUpuPvwpLnfJh/Bn806jT/BpVqJV6tGe8fr9w==
X-Received: by 2002:a05:6102:5607:b0:7a6:f970:27d6 with SMTP id ada2fe7eead31-7ac1d2db5dfmr2199160137.20.1790174454370;
        Wed, 23 Sep 2026 07:40:54 -0700 (PDT)
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com. [74.125.226.235])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851a07144dsm2869607241.9.2026.09.23.07.40.53
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 07:40:53 -0700 (PDT)
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97e7c62dde2so341120241.2
        for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 07:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzKSj3wYLcelvrxslLBslG7T8kLxx26060OsflgaDU7vjzjscGDCHNPNykRXSSciW1YTAz6bYiCBRE=@vger.kernel.org
X-Received: by 2002:a05:6102:3711:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-7ac1bb45468mr2431267137.12.1790174453060; Wed, 23 Sep 2026
 07:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907134037.1855408-1-gerg@linux-m68k.org> <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org> <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
 <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org> <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
In-Reply-To: <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Sep 2026 16:40:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrRmvaEVjs4Whncybn-zVCKStC4gOpvwsnT+XRtm9Hbg@mail.gmail.com>
X-Gm-Features: AclHuK8JOpxbtBL9eo2JZ21xOlmZ2HJ-Q_I8grURwALj-s_IRRLbJXlaWaj0iq8
Message-ID: <CAMuHMdWrRmvaEVjs4Whncybn-zVCKStC4gOpvwsnT+XRtm9Hbg@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, arnd@kernel.org, wei.fang@nxp.com, 
	frank.li@nxp.com, shenwei.wang@nxp.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, nico@fluxnic.net, linux-can@vger.kernel.org, 
	linux-spi@vger.kernel.org, olteanv@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Wed, 23 Sept 2026 at 16:16, Andrew Lunn <andrew@lunn.ch> wrote:
> > The driver will always need to support big and little endian hardware, so I
> > am not sure how to avoid some abstraction like this.
>
> I was wondering if there is a linux standard set of macros which is
> supposed to handle this big/little difference, the macro knows the
> architecture and does the correct thing?

Unfortunately not.

Quoting Arnd:
   "fec is an exception to this because it happened to rely on the
    unusual macros: all the Arm SoCs using this hardware have little-endian
    registers (regardless of whether the CPU runs as BE or LE), while
    all the coldfire chips use big-endian registers (and don't support
    LE kernels). The powerpc variant of fec also uses big-endian registers
    but has a separate copy of the driver that hardcodes this. Other
    Freescale drivers already have a runtime endianess detection that
    is needed because they built both BE and LE variants of the hardware
    on Arm SoCs that could run the same kernel."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
