Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD7933ADA7
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015336; cv=none; b=Lb6XaJ9IJT0z3x3nXxM1QieijzTN7ZrYagI3QNg1aYVvZ9GJi4T+miquyytQKJi9hRZOT9XhFone3atjXmUAy5OnSIQd+ZfxfYmBb6E6eYIt0QnXQgYAXitWIrhHfRwu+hmvyNpdw7WnZHql1/SK3Tg9sMafOFkTnHgPoK9Jtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015336; c=relaxed/simple;
	bh=ogfDlnzBcc1OB6AZDDh1GpRPo9cWTVWur3OQA17OUCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSNWRwZeEctq7haMu0N7k4Hd9/KD50gO/WEj2YpjuIhwp0uvmN3rLdK/t70wAsVcR565ZpH3C8H8DJVtEpq/hwOzAWOftXybGRC7mjeJtxYZ2wQX15h9HmdEkPA7Tl8yKKoAs40vyoX/RlNSLI6mv2q+k55KHlU4z6iHGNMP2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ab0377d0b2so1603028e0c.3
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 07:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015334; x=1781620134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ip5sH1agdDU+wNC7wtZTrjXnWLeSyW0k20W5HgSy420=;
        b=qu2rRFZp6KbRVDKf4Lt1qdvB35cGj/zjZFwELQR3B6BDDDkpGwEWjIl7KLRJ1Z7E+x
         uvX9sW2nSQiEb1Q8KjFWdcMNxsW14J4PyOhtxFf93EbrD+24X3ASO2xCPZeIztjPEpT7
         VellY0i50+zCdKtx75dOugl0Wx0+svQyTFs/A6lRvyWlzZJyW1J0FicOtoMwhyj0GU2j
         G3GvKMadAUWrKMSctZJL/dtoHUsckG7kllyskzi+CQPJif+qRE1axPZOrWKODfUxXzyj
         kFGpWPwifBhq6mdIn47sTXMkGcUT/cijW3f3JznPDyQ9nziNpmQVMCcWNZGmJAuILCWl
         Zh/A==
X-Forwarded-Encrypted: i=1; AFNElJ+uHFm3E16ztPNzg0knlA10uRGbLidWUPQtKCJSC0uCGLEiwTa44H5PxiH+SLcIER3V5t7JScU0Qew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3n+Spz8Gu82ZA86PzkESUZIn6VYHatn9eWayTiC1JydrW+Fs8
	ecurHTIkLwtEDyuRJOR6J5vkDPXHKTUSL5vPu9G3CWYgO/9vNIBPwM2mhsNeJnrxm4Y=
X-Gm-Gg: Acq92OFr+5f48Hw4P6ZhunkZOxQAeCtKzPTHdJ2T0fFioDzOznTB9wRjYhmvMrUxsv+
	VqK4Ukxg4RI6eJHj4s/Zv5eEt6bSmEh0F61gvWleUeNLAGFyDidsKla8+ayaNNpCs04OawaAg8M
	OUpSuwA07eTjvOLovjWIj+HsIsWs6UpNIZdd7OwSasam4WzeTpvh0g2FAgW5tk7t0Htkh7iyTx0
	gfCXFnMt2yALe5uPNDy4yN2XekcOxlhxAeGNPgxOfDf3a5bH9LT57Yj8to4CXkX6njA7KqEwjP9
	F+5O+neiy/jrOS4Z1xnGmzJQSeOYJQNMUOxb1ZLAUN66oXkRTfgeUK0Xq/K/vbTGN1lVpEn6678
	MhOwO6Lcx+z8NHEimmToAruKtdkfaO7OVafzp5GMWVcd2SoARNjFflsqteoNhBHBurfwwB8dqZS
	yTfR4sNHLz0mgGhfFJcjPkyCASwFaWZS02gG7FESB/ONvEmqx+6zHFDj1IoPeRCiinPCB5Hfw=
X-Received: by 2002:a05:6122:6606:b0:5a3:5938:6935 with SMTP id 71dfb90a1353d-5ac4dcf10e2mr9072280e0c.6.1781015334299;
        Tue, 09 Jun 2026 07:28:54 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6413cc1sm17165016e0c.3.2026.06.09.07.28.53
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:28:53 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6c3099b11a9so2160862137.2
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 07:28:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8s6mWYq1l9aGD0oV92LrNXMPVFKDCBGyDiGK5VPHdwuSUWVJ1Q9desn9/w8h+Z6bufyb8m+oKx6SQ=@vger.kernel.org
X-Received: by 2002:a05:6102:4191:b0:634:a573:c097 with SMTP id
 ada2fe7eead31-6fef36392d5mr8870898137.13.1781015333253; Tue, 09 Jun 2026
 07:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com>
 <CAMuHMdVEYciUYq6savTuOqDUQp6AqHGkeP30s6Z7PoZ3q-Pqvg@mail.gmail.com> <CAN4SLj0o+3Bjq0aBJUYbKU-YkXUeM9aPgRxiwmOHX_Fz-_Hq+A@mail.gmail.com>
In-Reply-To: <CAN4SLj0o+3Bjq0aBJUYbKU-YkXUeM9aPgRxiwmOHX_Fz-_Hq+A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 16:28:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVX4ZJkXe1if=iHu5dt=Xtka=C9y8hxKYKc_7=bysycog@mail.gmail.com>
X-Gm-Features: AVVi8CfM28mVF7ANUyqKAdwxfMg6jnbRMy8l3EB3MFSG3wNg3msORlNrQsZGdzQ
Message-ID: <CAMuHMdVX4ZJkXe1if=iHu5dt=Xtka=C9y8hxKYKc_7=bysycog@mail.gmail.com>
Subject: Re: [PATCH] spi: rzv2h-rspi: fix incorrect readl() accessor for 8-bit
 RX path
To: Felix Gu <ustc.gu@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

On Tue, 9 Jun 2026 at 16:14, Felix Gu <ustc.gu@gmail.com> wrote:
 On Mon, Jun 8, 2026 at 3:55=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> > On Fri, 5 Jun 2026 at 17:26, Felix Gu <ustc.gu@gmail.com> wrote:
> > >
> > > Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
> > > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> >
> > According to Chapter 7.5 Serial Peripheral Interface (RSPI) Subsection
> > 7.5.2.1 List of Registers, the SPI Data Register supports access sizes
> > of 8, 16, and 32 bits.
> >
> > However, the "Access Size [bits]*1" column header has a foot note:
> >
> >     "Note 1.  The read access size is fixed at 32 bits."
> >
> > Hence that means the rzv2h_rspi_rx_u8() function as generated by the
> > RZV2H_RSPI_RX() macro is correct, but rzv2h_rspi_rx_u16() is not?
> >
> > Also, readw() in rzv2h_rx_irq_handler() is wrong, too?
> >
> Thanks for the detailed explanation.
> I didn't check the reference, just thought it's a little weird here.
>
> Although the column header has a footnote to indicate the access
> size is fixed at 32bits.
> But in 7.5.2.2 register description, it specifies that for registers like
> SPDR, SPCR, SPSCR, SPCMD, SPDCR2, SPSSR, their access
> size are fixed at 32bits, but for SPSR, there is no footnote to specify
> the access size.

True.

> And SPSR is 0x52, readl on the register cause alignment issue?

Good point. Let's wait for Fabrizio's response...

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
