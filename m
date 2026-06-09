Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A732AABD
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014476; cv=pass; b=jjCAmbeqGWUdukMaUCbOkI8l3h2Le6+jY1UuNGsdFxu4M6cUbopN/HwpWkIujOObu7zblKDw0VUlGraHggA/w60gD+zQdjfLGCmb1u8iqF2x18xvKlXXbv8ImeEYyYCCErgmJR8AUGxwZ//rvu2wLTdmt4sAUOXK0FFf1bXwFPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014476; c=relaxed/simple;
	bh=Wt9b0GDOzfbd/0ns8DJu7GyOrhJ4Z/5e5VGfsnNYW50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGyGk0KZ4gxWajN2BkGc1RB0nP7I+RaoTB0OGD17yuTsqdDNt5wvHH1LWzFiLAL6R6zwY3fjtg68VZfg9us+fe80f+5KfgSXiv9NdroizWbiR4jIYIYNFMloqON14SCFFGLkTWZPeT2ZfKEZSOzd8yKSZzrrM+WFKhwKRc74vFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVkDsuBl; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVkDsuBl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso5525084a91.2
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 07:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014475; cv=none;
        d=google.com; s=arc-20240605;
        b=kWgBvdHgUgZ695LB794w6u9ZaJV3j91zOmtv6Xd+/kVCgzeHyt5yipVj05mRHXG3KI
         S2kC22W2DZ9W/vJWNiY15hhperSa0kERLwAMgtzQldJc3pxTEdlL2FXoktd5NFQXJH1V
         ht0anz+w0L/bAz0zDbUlqvmi45cIQxcoBIZ+AKDV4dusbNQg6rSyHjrT+GK+mrCPf2iu
         1bOSzL+QgdCbGL7GYjhzisUDX7HdtIm5Qym/lTaHq2paxLVzyzzNE2IGaT713c9XHMiU
         t66cwXzOEIQNi8j4rL8hvUZAns0k80eAoeTehe0sIgr057TcNtoiOKX/LAMvgColdJBy
         I67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YVCTP06+ReD7xAAc8z3Zxd2jt06xnT3/d3ueG+sZj3A=;
        fh=RL1m58encz5qvHAHz8V9cvcjVUicfpmY0TYo4nTb5NI=;
        b=NFvdPtx3QGDixYURixNlra1IsPAhZNhT5wI8IkPswCLuCoHYT3jTCDrEz4ZQwGb7Pn
         YUS1kpEn/hz7fnadwQR/v2f65ky3qL9TY/TZF22OlcnZMskdwt3uUVgzRzydFwswLMIy
         GqUPdsiXadp7u7zPAx+N6JnfuA1P0A/hHgMCgwYxOz1ONifPpfZKf63l4NtqXIEjEqDG
         tJZOelkj1hmsChc2+AZWbnvrzirBE7xI4HPaBp7Ep9LJGqghZduONCtxqrk9r9J8v/hp
         PDxXNBL26zxndvaDmcglTp6Fx9VwkhUd6IyFisU+qrJDH9d9zB5/1Rd2Fg6mnwc+Dn6J
         V1jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014475; x=1781619275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVCTP06+ReD7xAAc8z3Zxd2jt06xnT3/d3ueG+sZj3A=;
        b=hVkDsuBl01Ge5M5dAy+QxgOS9LQWkHB33ioPVqAlcCl+TdXELe99YQD//3QSxX/81g
         eekSaO87B3uipPBc2pfixMYXSRZ2Air01xlT4t4PqbsKG7WjWI9JEWt5/T7IKEcgDmyQ
         j/VX81B9OknFjzaKndLenwmrBcEHJX8BPK2Hsv/ShcDuGaKPIb8sBDEI0mTOTc3hvlt0
         gwVJu4H/SYcUnPIyLO4ck5OaSKc9w6iNzDkisERqsweDZBrKwmHHkxWX/pDaD6E6mV2O
         urAGTx66Fp/s02pXB+MLE8n10lLWHb3+xc4YXZXKFacpnr2iftzzZv08jbxmKwcGAIMo
         Gdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014475; x=1781619275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVCTP06+ReD7xAAc8z3Zxd2jt06xnT3/d3ueG+sZj3A=;
        b=CJyXU+ptRxNeQFA7DF6zpLeRRq7nyrpC3iZqYGJbOa/Lq+nD7WVa/gqXawCchCtjPr
         Rc6tKOwpmX87BxWoDUGP9XoW8Y0YGMz0MBcB2jF5K7L6wQz6/5wm1dtvqmXOogM0QJXK
         uHlxiebPIiSQadNid+OZ6eBLDcngz0QbjYQ16IYgXaJ9Tg3X/UvetK+U0LpGZMwzrQob
         EvK8WcR7Cmw24rgJswiMObCIYyqZryPb9xLlIszvbpYyIoPF+//U1eLCRVqbCL8u6CKX
         FU7hM2QO068xO2hqvYoOPlxMt6kAPmo0gfWND+OyxDZDapycj9aa7x5Wz6baEIb7IqLZ
         jwpA==
X-Forwarded-Encrypted: i=1; AFNElJ8OSws8mKy2J6BKQsNfS2VpWcmAV6Zi1J19qKPUQzQbIjImAy0PlJgmGu+hn2bv9Cg5t8gHF9wJ9fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPTj/7Fi9M2Z1a1BEfLz25fptgCvImyx8If2UDoS7VXdrHhS5
	JAvkH35GLigcqZypez62ncYnzzfEvQUIm0tMNYWTZHUxa+Z366BJDm/gHqfYT0axr7CqNpZTyG/
	J4kDYM+Zxpu2jVi6/XmbfkpAQpXxMmag=
X-Gm-Gg: Acq92OGsSwh76Pd0Z+xrEE+93XYUUwx+DEs4d+BiG379ick87gzYyQFpNBclrxcE1B7
	eT/d0//xq6USS/Vl6nT88EEY8/m00oN3KV3+/UtNbkOsI0D0xeol73hJCU6Xr1pE/jZFc0msdt7
	oo6lNMKUkycGXo9EbTIbMBmwLsTUm9CG7aQnz+oD8icvLQGYzUGxqFzED2R+9fpsv01NteLJeos
	/Xlp7xD3uu1yO9IvO6mQ7sYxrOcQj5Ex+Lso0Mb3NwkuHXL33P2Spj4x1PDANDSEJmqqucBt/FB
	ArvuQ0Xe2AWSw3I2Fr+oGpdAEY+TchwaCu1neOE8sKnk1Sf4pM2e1XbSId4WnvWLMD5+QujqNQ=
	=
X-Received: by 2002:a17:90b:58e7:b0:36b:936e:73c8 with SMTP id
 98e67ed59e1d1-370f0e4ad33mr24408813a91.19.1781014474736; Tue, 09 Jun 2026
 07:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com> <CAMuHMdVEYciUYq6savTuOqDUQp6AqHGkeP30s6Z7PoZ3q-Pqvg@mail.gmail.com>
In-Reply-To: <CAMuHMdVEYciUYq6savTuOqDUQp6AqHGkeP30s6Z7PoZ3q-Pqvg@mail.gmail.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 9 Jun 2026 22:14:24 +0800
X-Gm-Features: AVVi8CegqVqtWbCTnlD2kodnPbitaAU8L0BkslvTa0l9OTb7Eanw1TWxLeemMds
Message-ID: <CAN4SLj0o+3Bjq0aBJUYbKU-YkXUeM9aPgRxiwmOHX_Fz-_Hq+A@mail.gmail.com>
Subject: Re: [PATCH] spi: rzv2h-rspi: fix incorrect readl() accessor for 8-bit
 RX path
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Jun 8, 2026 at 3:55=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Felix,
>
> On Fri, 5 Jun 2026 at 17:26, Felix Gu <ustc.gu@gmail.com> wrote:
> >
> > Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>
> Thanks for your patch!
>
>
> According to Chapter 7.5 Serial Peripheral Interface (RSPI) Subsection
> 7.5.2.1 List of Registers, the SPI Data Register supports access sizes
> of 8, 16, and 32 bits.
>
> However, the "Access Size [bits]*1" column header has a foot note:
>
>     "Note 1.  The read access size is fixed at 32 bits."
>
> Hence that means the rzv2h_rspi_rx_u8() function as generated by the
> RZV2H_RSPI_RX() macro is correct, but rzv2h_rspi_rx_u16() is not?
>
> Also, readw() in rzv2h_rx_irq_handler() is wrong, too?
>
Thanks for the detailed explanation.
I didn't check the reference, just thought it's a little weird here.

Although the column header has a footnote to indicate the access
size is fixed at 32bits.
But in 7.5.2.2 register description, it specifies that for registers like
SPDR, SPCR, SPSCR, SPCMD, SPDCR2, SPSSR, their access
size are fixed at 32bits, but for SPSR, there is no footnote to specify
the access size.
And SPSR is 0x52, readl on the register cause alignment issue?


Best regards,
Felix



> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
