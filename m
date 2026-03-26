Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB383FF883
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535326; cv=none; b=Ib7t7o3do0hbGzI9Wz5B4629ghF+lI2rhyvUTiUwt46mhTKljrVemZiN9mmOUfjLGGDVqyL5gqZap3GHdZnKwQOZfgTgC6aM5k4sD44ws9Ik/QZ/QtDFegvydmdTRZKdLV7qFuQbp7CoXyOJAjzX0Bs1h0erXUO2fIXLMXJD4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535326; c=relaxed/simple;
	bh=K6kz1YIg2Cx1fYJe70AD6r3Z3wt0vQ0W44s/a7Fmbc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2Sr+aLmXipoSiC6AjNWE24FZHKb6kl22eBfoiVXT6wHcQuWBiTmCWKiTaO/9H9U/cCKq21t/lZgirRfZ7fS1RkeWSmlbrmY/vvL1RsEwMhZJ5uYVQWGDFFwUd6HAUGCf4ENck3ACzXBbJcpjp8nLMIDKgTo6pvAYyL8I3TEAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso592662241.3
        for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 07:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535324; x=1775140124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kHn11aQstirwFpTzbetT2TMWUY8x1eBCRaGSrwNilg=;
        b=g4DfDShIs0MDhyrSGFPwilXkQ/55+L4ftku86WidINdcHQFQ+4T6jpN8moFYv3WY5c
         aIPxkL3m/vO7hr2bFdDjOiYBgdESqM5DiiOETp7SuWjWyzTEbE5oJhgtA9EUEv9eBUYn
         i17u8MqsyWPhI2mVNQnXyd2lr5huAvcK/RG/EtCyvxLuvofZy73WwTWThgK15moyRVMv
         chCVtUD+rQ+SJa2DG5j/294vFvQ54l9qkxaw3t7N321gnpm+8GlNnk/UWks0pxoDv45F
         NujVs4WvTo6EghtU5Btc3eFjynBMcqJNjq/8VZaKqVryQClqge3EiZ43kleZPPYNbuaY
         5fUg==
X-Forwarded-Encrypted: i=1; AJvYcCVmsm3S8lCyubNfZ8vAmREu0WKfspC3aMu+D7m4dwJcqjaTs86mNCCQbZm3AgdbZzCRv3tRAMRc+zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkBQF7Lkdfqfz2PURzkXNI8kYqCppTs9185M5UjdNDZ3Sx1iU
	qOtzuCei7+V89+likDJ64u0UDOr0iiqDFTuFUouyJOClxLlw4kbUZ3F/5K9UJ+TbHOc=
X-Gm-Gg: ATEYQzy/pLtqpZwnpWpSkX5gBjxPfyruAfIj0lX0xBlCL7OMwQf0oZRdnQV5WNUKyIz
	d0/rfQ7Ll5kCyss3P0XcdlbqU9r+PJc2gTQBrc+Kt+1vnLd6kXuIUEkyNLn2Wc5oHGRCKmIG/ps
	vslVoSMvdjnR6wgF/DAUn0YpQmK6xaDzEpBiLdFznhLM7TvuAO6LCpOyUlHxmD0sS4X081Bjtsd
	e6jDRb1toNmZy92I/QsFQqJJ3PsEdKat7OUHpD/o81gIQGAMwP3eqYA2muJYO6mVOiQ8Vla6SrD
	rZRZC8DHHbYyQw7jtdgQ/dmPQSzs1tFtSRPIHCwc7GdOC4xpXkJ2gPuxPOjQm/9Qv4pqxR7DxX3
	WY8NEer5ZxeBB9nKHVqkltAHW/asyJ2xiiLCFLBfqxlzB3pyoYY4J2Dy9/lNtUP3R7pA+ehmbeq
	RmSEHaHq3+Ek5MJQLsRwCVFKZU9/KOhdGbAe9RrYcp7kWPKfQs3ua+xvxNSHyA
X-Received: by 2002:a05:6102:4b1c:b0:602:789e:9df2 with SMTP id ada2fe7eead31-6039481ad90mr4178213137.33.1774535323849;
        Thu, 26 Mar 2026 07:28:43 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-604d50c928asm3267411137.5.2026.03.26.07.28.43
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:28:43 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so648061241.0
        for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 07:28:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8msPsv2e+g/TXLgNFEqUod43KTCuHusudN6easSpxrQKf6VxXzgYrZZtFrCYfEXUE9kjv2+7COM0=@vger.kernel.org
X-Received: by 2002:a05:6102:3f08:b0:602:6c8b:4b8 with SMTP id
 ada2fe7eead31-6037900e0d1mr4124976137.5.1774535322084; Thu, 26 Mar 2026
 07:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074907.9697-1-biju.das.jz@bp.renesas.com> <20260304074907.9697-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260304074907.9697-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Mar 2026 15:28:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX3THUiRMs=BgacxODUseTghD5MQ0QaZU9XENnKSaTkaw@mail.gmail.com>
X-Gm-Features: AQROBzBEchn4QJ4qz_JtpT4KXa5zrbIIxxx3S5ycozOPElDORQcj3XdPqrFveXM
Message-ID: <CAMuHMdX3THUiRMs=BgacxODUseTghD5MQ0QaZU9XENnKSaTkaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)
To: Biju <biju.das.au@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 08:49, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add support for RZ/G3L RSPI. The RZ/G3L variant requires only
> 2 clocks (pclk + tclk), unlike the RZ/V2H which needs 3.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
