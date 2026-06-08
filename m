Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0838F922
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905358; cv=none; b=ung+CdOPKlEJ6398j2ZO5WnbahoFnHoTC6qZTrL5P7Z6novXt9YhlmM/Q/CI9/HezPcYCc8+Obpm8CzDpIRHzj/fkoYRMVl0zIfUigct4eGCTOVGO+c9Xt8YWGGDLnqJBYhaVHJdmUQ5q0aBQ5oII9Y+QWkNMdKMdG2zeyAuuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905358; c=relaxed/simple;
	bh=EZ6O3f1jsPsrFY5TdW32+0NSqE5O+fh0ngad37h91dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqJHO7z2pNIpZ1NLflgIyzqwum69k4nOh8PbbJDA3VbfO6kVf/5NUIAWAVAMkas9A2Uza93FyBpv2bfwFxbNUwgnW2e5sFv9/M82As7cQDFAZkXMHBkTzWJGw7AZLmUOB2cXkRY/1gV5DYzLBCp/Skoo2lvz+8ZlZgmaKzdyr7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59cfbfe64baso1227763e0c.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 00:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905356; x=1781510156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Cmn669Tthf2NAdP9bTtgq4iWIUzugLFW7aAuo6G0Ww=;
        b=fUiGlTm8+pNgTfxEZ8P4a/6EzCU6PEq6jMc8YFyjjrraA++JeZis7j4JspbOBw5Ok+
         NR9fKDac8OifYSOzQpFuIixc6NGA7S5kgdLZF9sf12bybxhrjU2ck/EApvHkYSWpXjLN
         73CDOq08BsPoRiNNIG8OoXY2W5lB9e8tAQwQeA1zWqxYH3oIJ2DKBEU02bYrivWETmdk
         XRoNWELnbpSRVWExKEBDyfHheM/gqzF2jo7P94NlpaA3/V+m+B1HHRefy9j2zeZHuW0C
         E+nd7brFRQS8tSqfns8BkhJxk6U/80LeA9cC+gcijMxp81HpPxJjf3BPrXbHiXlW5EKi
         V1WA==
X-Forwarded-Encrypted: i=1; AFNElJ/HByqi+Zq6UNPLxSrKCwW23Ql4qBrB6iYwqgtZv8j+Durfv4Mcx9KtJGTFNuFwoZ6Rb3qOP0VqvQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzn6WzKhNCm13JG/C4ku6rxMvqgLLq80/bJNtl/qyiboQYJgGf
	YNvYtkkZfJRHTDg2EM+k4IDfRshnYiaPRK/mgCtvfqGrOETfqvm6kXGbKZjiXwXr
X-Gm-Gg: Acq92OF4CXJ1hJPZqWVTypZUi0VisnpKveQxPDop7b+ma9OGXs8rm3RDNWOqQoOZj6n
	oGC9NYxOffdPJX6j5QNQ6DnzIeQGF7VscwagixwHk/ViyjqySE738MlPmuDNY4cvVUrIH7zM2pa
	YT+QaUvUaEeWFttxciMj+k3aPAXNa6P1FGs1GJsVlzGEXKAPjnfhJhUhVYd5mwwUXfKM5IidX1D
	gHWzNZeVvWFV/MtC2D+nzl29x6yGFMU64VGry5NxshI2Y9DsSNDYIkrOk/4RpaIKjR2pB7aZA1U
	v4ATCxBvy0B89vfVZskIPUKKLIKDBrx9tgdAZ5h9wiELYtCQiWbq4k6OhnR/sR85E20nB7dLWU5
	h2fK/yT42++BZem5NLOCauhMOcCiLNc7I72Np1m6v3/QyHhp392AkhXs+9dx6pFenDJBzIV9m+W
	JJPtvnwVe3i5QgPWkCVyRtG4HLXCajB2SzrYxEOXcKYkq5UgWOL5w2R/eiOwOiq0Q5H69Kau1T9
	GQ=
X-Received: by 2002:a05:6122:7c6:b0:5a4:c20a:ba4d with SMTP id 71dfb90a1353d-5ac4ee91209mr6435740e0c.4.1780905355637;
        Mon, 08 Jun 2026 00:55:55 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d777996csm13452706e0c.7.2026.06.08.00.55.55
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 00:55:55 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59ebf30a91dso1223958e0c.1
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 00:55:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8XGeKHvYw6uMf+V8WmHcwO65pMTfNqLFXZRr8Cd3UzxHpb1gDplKuuEANSA1r4x2wFDmUbdP5Cc0g=@vger.kernel.org
X-Received: by 2002:a05:6122:4692:b0:5a6:7838:d679 with SMTP id
 71dfb90a1353d-5ac52c09f1amr6196587e0c.13.1780905355135; Mon, 08 Jun 2026
 00:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com>
In-Reply-To: <20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jun 2026 09:55:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEYciUYq6savTuOqDUQp6AqHGkeP30s6Z7PoZ3q-Pqvg@mail.gmail.com>
X-Gm-Features: AVVi8CcmuQ7XmWIeu3kjbwGuTATRPoxdKm42xnuPXVpABMXaapDScD6SCIjYH5M
Message-ID: <CAMuHMdVEYciUYq6savTuOqDUQp6AqHGkeP30s6Z7PoZ3q-Pqvg@mail.gmail.com>
Subject: Re: [PATCH] spi: rzv2h-rspi: fix incorrect readl() accessor for 8-bit
 RX path
To: Felix Gu <ustc.gu@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Felix,

On Fri, 5 Jun 2026 at 17:26, Felix Gu <ustc.gu@gmail.com> wrote:
> The RZV2H_RSPI_RX macro instantiation for u8 data incorrectly uses
> readl(). It performs a 32-bit read which can consume excess data and
> cause corruption.
>
> Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Thanks for your patch!

> --- a/drivers/spi/spi-rzv2h-rspi.c
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> @@ -137,7 +137,7 @@ RZV2H_RSPI_TX(writew, u16)
>  RZV2H_RSPI_TX(writeb, u8)
>  RZV2H_RSPI_RX(readl, u32)
>  RZV2H_RSPI_RX(readw, u16)
> -RZV2H_RSPI_RX(readl, u8)
> +RZV2H_RSPI_RX(readb, u8)
>
>  static void rzv2h_rspi_reg_rmw(const struct rzv2h_rspi_priv *rspi,
>                                 int reg_offs, u32 bit_mask, u32 value)
>

According to Chapter 7.5 Serial Peripheral Interface (RSPI) Subsection
7.5.2.1 List of Registers, the SPI Data Register supports access sizes
of 8, 16, and 32 bits.

However, the "Access Size [bits]*1" column header has a foot note:

    "Note 1.  The read access size is fixed at 32 bits."

Hence that means the rzv2h_rspi_rx_u8() function as generated by the
RZV2H_RSPI_RX() macro is correct, but rzv2h_rspi_rx_u16() is not?

Also, readw() in rzv2h_rx_irq_handler() is wrong, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
