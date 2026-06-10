Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7E386C36
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078023; cv=none; b=R3oSsYdfNFePKLbtdzYDev3OVdnzmAHd5H9RPIe7j8E42zVbJDj617O/eFI4KSiVBUbHLt2XbgG1uak2/YGw1b8aV/dbTR+VZiRmhNA+jmfpNw7o1nF2pg5ktCVli/FSeiuH4WvtjZbFzywnB0J0tM1a/lm0+mSwJ3Zy3/JIHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078023; c=relaxed/simple;
	bh=M2D7SBf4dRDUJ+Ur1iXcza/iv4YTCZEkWRE8cycidYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiP/PWY2mV22n8QQv8WcFpAZyyqTc0FuYrOZmAynq9N06en1xtZSn+y4D3dZkY2bEJi2WgTjNuJtvrGBLmZCAqBtO+kVI3TU94mnoPnqemnT7+8aKfBC0U0xWzalN2iNistmnGFgT1E34TL0pYcgDuOtntzBizdcjvhyCULzyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so4609693e0c.1
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 00:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781078021; x=1781682821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uhja3s+QnnKNsouvy5bcWC3fS0M3t/Mpg37n9Vd5ieA=;
        b=EROrsK0YO1FBCzIeroppKs1/LEuA1AXAxZB8DuTNFamAlUPE2RBxbc3RWfBlp/1D/G
         +BKNS8798MIpi5J09Cl+AdC1tq0hUhKsP9RMvDb2JUyotG9/yvOrjv+9AHmjcgvMJ0h5
         czfVF2fpJsKBsSW1C5SNAx/TGTadk0ezIRwcvXCn+tzWwYiygP+0vvbgXScZUXnbfRAy
         Ccw7e+aj6b1tiKtW80A0tJdTA2xaHGOlqe4GZmitJQD8LFQicy1d6+39pcN0E46FNuxH
         6PcJBEnqfygv2YJQeGbyy2ZRWdzykp6v9StsS+REGIpquOau6TRDgdpDIvs7GrG+XEA0
         sL4A==
X-Forwarded-Encrypted: i=1; AFNElJ+v0TaF4VdXt1EYvSJhDnMv5lqD9cZzeAEdJ87pAoRpJGHc2twJXvjdWszRTi3+8eMy0rFsGSnhoj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfs4KbVbesI2Wm9Qbg5dWVk9+sMZGMMi9Wcz5U5PjSqanzarp
	xp3aVrSoW4WmVuZzpvwG7Rwrkx9RJvz19qlPGghPiGi9LsW+Jl16rNY85GeppZQ0FKQ=
X-Gm-Gg: Acq92OHiIWSzhGJ4ZszVDlHqltXtnauWNUeV/PpDYzD9FTjetqRXPGH23E3UCEBfFVG
	95QSqV7vL3dKD8WnHVmXoMVDgmVgdwtMUpByQQMA/cri1M/fTn633D3yY8LebWMzmj4YlTm+kLo
	chnDHI257QAFqMw8z//wGrNVSGir1oTHWJr2+iwMeIqr73lJET07xLBIKUNWiBGJaeANwq5JSFn
	f0jqDYcW10ClkTLAWVpcPBzpiJ/JERojRWw0HWo9vZvcq3WBzwdiGFOdO2mUL4uDBQxrygmyK3n
	6WMpHZb0bvCMpODLy1zqOQ2Ui/oF3WJZIzOIbTzpo31GMdXGEDb655TZM3l6c4M20mAWYuhduvF
	/rzMEiFGVEsBrveRw4LcpJ86XpypbqPz8eLwk2neKMl4WFJAywctBHGkBkM11jENY03UOZDLALA
	t6yW8Z/p5I+LNtpN8Q2YZtf+jxVfIh+/bkxIppK7pF8tl5RvodX0yKjuuLlYDVqupq23XlBVTBR
	ZXzLwE2Ws8ZkQ==
X-Received: by 2002:a05:6122:8282:b0:5ab:26f:49f5 with SMTP id 71dfb90a1353d-5ac50312b75mr13340705e0c.6.1781078021373;
        Wed, 10 Jun 2026 00:53:41 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d06a491esm19110098e0c.0.2026.06.10.00.53.40
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 00:53:40 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59d07df448bso4995754e0c.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 00:53:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9WZFFaS++FoMzuF8ZOFM9zzNaqLkNA68dlqrjdofhzP2LKjkNiCgoDFAdo2BGBuIgxG3GSdyOaKXg=@vger.kernel.org
X-Received: by 2002:a05:6122:421a:b0:5a0:2018:4dfa with SMTP id
 71dfb90a1353d-5ac4ea99b32mr12268519e0c.3.1781078020496; Wed, 10 Jun 2026
 00:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com>
 <CAMuHMdVEYciUYq6savTuOqDUQp6AqHGkeP30s6Z7PoZ3q-Pqvg@mail.gmail.com>
 <CAN4SLj0o+3Bjq0aBJUYbKU-YkXUeM9aPgRxiwmOHX_Fz-_Hq+A@mail.gmail.com>
 <CAMuHMdVX4ZJkXe1if=iHu5dt=Xtka=C9y8hxKYKc_7=bysycog@mail.gmail.com> <TYCPR01MB12093C33B2C33D80117F79D96C21D2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB12093C33B2C33D80117F79D96C21D2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jun 2026 09:53:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvY2iVM=sRq5+qFm1N4ksWsEMW3kFy1pLFeUbM6zsqsg@mail.gmail.com>
X-Gm-Features: AVVi8CfHcnn2EwKXXXh77rZddTm1dCYH0SlsSwxuoJCu4n_S71iEXmIEjnC1C8s
Message-ID: <CAMuHMdUvY2iVM=sRq5+qFm1N4ksWsEMW3kFy1pLFeUbM6zsqsg@mail.gmail.com>
Subject: Re: [PATCH] spi: rzv2h-rspi: fix incorrect readl() accessor for 8-bit
 RX path
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fabrizio,

On Tue, 9 Jun 2026 at 23:04, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Tue, 9 Jun 2026 at 16:14, Felix Gu <ustc.gu@gmail.com> wrote:
> >  On Mon, Jun 8, 2026 at 3:55=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > > On Fri, 5 Jun 2026 at 17:26, Felix Gu <ustc.gu@gmail.com> wrote:
> > > > >
> > > > > Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
> > > > > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > > >
> > > > According to Chapter 7.5 Serial Peripheral Interface (RSPI) Subsect=
ion
> > > > 7.5.2.1 List of Registers, the SPI Data Register supports access si=
zes
> > > > of 8, 16, and 32 bits.
> > > >
> > > > However, the "Access Size [bits]*1" column header has a foot note:
> > > >
> > > >     "Note 1.  The read access size is fixed at 32 bits."
> > > >
> > > > Hence that means the rzv2h_rspi_rx_u8() function as generated by th=
e
> > > > RZV2H_RSPI_RX() macro is correct, but rzv2h_rspi_rx_u16() is not?
>
> True, it looks like rzv2h_rspi_rx_u8() is correct but rzv2h_rspi_rx_u16()
> is not, and could use improving.
>
> > > >
> > > > Also, readw() in rzv2h_rx_irq_handler() is wrong, too?
>
> That looks correct to me. The access size for SPSR is 8 or 16 bit
> (as specified in the list of registers from section 7.5.2.1, and also
> repeated in section 7.5.2.2.18), and we are reading it with readw?

The confusion part is that the footnote in the column header of section
7.5.2.1 appears to apply to all registers, while apparently it does
not apply to e.g. SPSR (and e.g. SPDCR?).

BTW, e.g. SPDCR and SPDCR2 also support\ only access sizes of 8 and 16
bits, but 7.5.2.2.16 still states that read access size of SPDCR2 is
fixed at 32 bits. while 7.5.2.2.15 does not have such a note for SPDCR.
Those registers are aligned to 4-byte boundaries, though, unlike SPSR.

So there is room for improvement in the documentation.

> > > Thanks for the detailed explanation.
> > > I didn't check the reference, just thought it's a little weird here.
> > >
> > > Although the column header has a footnote to indicate the access
> > > size is fixed at 32bits.
> > > But in 7.5.2.2 register description, it specifies that for registers =
like
> > > SPDR, SPCR, SPSCR, SPCMD, SPDCR2, SPSSR, their access
> > > size are fixed at 32bits, but for SPSR, there is no footnote to speci=
fy
> > > the access size.
> >
> > True.
> >
> > > And SPSR is 0x52, readl on the register cause alignment issue?
> >
> > Good point. Let's wait for Fabrizio's response...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
