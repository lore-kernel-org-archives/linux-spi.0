Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D03A5425
	for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005852; cv=none; b=TX72hyf7KdyPZkdGiB482bkhnu2+/q6lJWdeyKdiPHD8FDhp5bEbASKMXj+8zn0vqX1nvIfLd92vXw8ruMy/z7aHTSUGI2a4WBt0W/wb5iH6qWIuNUNMN1V7oUy3ErCB5ydk0orKNfQheGIBb7pjoE86ufmveYrGvpo+jUFTPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005852; c=relaxed/simple;
	bh=9ovGQYlOjYxK3plbHA0lDCx38GOv5tYaaRGjIx9Ah74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBTB0cpGBLkqxjST9s2l9YS2GJ4Hh8IB+vd9IfjIS4wq8w+ZKFkkKuGAmYmxumz8aQiMo/f3GePlgrHZAYuYhA7481Roo4Vv1du21gBwgpmxmMJlhP/LOX2GmGH2hvPjJFO8WuJbg+XT4YKzVYIK5sUx7+hWv3OXpUMGiHdrfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6027ef7e068so1291633137.1
        for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 04:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005848; x=1774610648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS48mKiSSOgr/13p71hpFJpaqE1/Y7kt2W9Pgmdu1rI=;
        b=adIcQo0kX7D9tvMvSOMzsq+BMtEkcgZXp7p3qsp6N7Ecy9hZsmf98isB3NbV9gZeq6
         Bi0oXzy6DXJaSG7FLbN6nGwwodH0flEq4m+xzM1980QsNUbYqOEskAViUe4ysrUkemmn
         8kXSXXYAEhJYZH43MY9tlg3La8G9pIiCxCk2+VyZRAsxxt2x7nkg4OBUqIup6bQZ0jTK
         VK3CbXqJKgNeQD4h8rIzuSp7tMBM9AIFW6OPtTLjv/dPqPH2bOFQq9jA3vMotWBssnCT
         MLHl5W1KS/haLuF84vp7KBk80m5rQ16J+jeDTfGk8F/zShtWhUGFjGV4YTCsVTcJbX20
         abhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4z/xxw2nmGz6VxyCrzBMqp7bvhgxJSfdBy9jeP9Szqc3P5izjaXW/iSnI50ho9iF31McxB+sWtVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1pA1Iy6CNL6RRdORAsHVx0u7QE8gB/tWDHFaMBaqntqG+L9C
	CSvU0MO/UfHd3WU5oNeJpfCx7PgHFH13kOn2S7aa0K1CpQ9Vqtescy5tkGbeYnp5o4s=
X-Gm-Gg: ATEYQzzpT+MBuFBQMNpGIYTnyOKZBEZoPTjGxB4WxrWUtq7TiHHDySC53P9J9odH/m2
	+Xg+K/LFAfAwTndYrvwsVynErkcf1BCV9hUBOgK9pkcbVI+sVn+Vw8npEjwRJq7MEEQEPtdBAlt
	OAM/ZWJhH6BoMD70x+nDBp2Kdp/FJzBG73oqFJpH4ZqCYWScwqXidDN8MFr+376oyX5ivtS1LhE
	6jwNG/iKvcXVq2lxY4Nn3mEe9ZqfSdgejvPmuNmAwJBCeTS2xD1vyHQwK9ec/uraI5dLnh9Vyzt
	x78YRwW+aZpby0ryLbtvA4NcbU8S5mBYyHXlVn4njUhHBgytTNzSM16AbtBQPEU67rpW8esizfQ
	1gLb9RLzOCwiReDeYZ3FmDBVgj5UKptN/44vMOyzUJ7J0GA+/+/q5Bf9NP5W5hJGbvLnmfZ/Y8g
	qDnTw0MkA2CJYfmV/Uov/go9xDclYxJaWc2+5HcvPTCwtHS6xJg3kjJgR9yNAp
X-Received: by 2002:a05:6102:38cd:b0:5fd:ff75:f437 with SMTP id ada2fe7eead31-602aed93dbfmr1386503137.33.1774005847873;
        Fri, 20 Mar 2026 04:24:07 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136971ff1sm836453241.0.2026.03.20.04.24.07
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 04:24:07 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6027a750ad0so899302137.3
        for <linux-spi@vger.kernel.org>; Fri, 20 Mar 2026 04:24:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwXjWVqaETM19QzzU3UbQYHzcuUejLO7pq6dO7GTz+k6Urr4gHYgsDAaGDVRhISx5QeILSnuq0T04=@vger.kernel.org
X-Received: by 2002:a05:6102:a46:b0:5ff:b8d8:b40b with SMTP id
 ada2fe7eead31-602aeb16725mr1396805137.11.1774005421334; Fri, 20 Mar 2026
 04:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com> <b634c10e632fed07b5652c11de060deca27ead90.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <b634c10e632fed07b5652c11de060deca27ead90.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 12:16:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxUzTbABO4LXMKV3EVxYhBhFRnM4haxkhryypmaCL6xg@mail.gmail.com>
X-Gm-Features: AaiRm51HNwZDCeJmEpbXlgoq873Qn3LQLzzhwtaltybEWlaMXE_ceM8X-KrNbxY
Message-ID: <CAMuHMdXxUzTbABO4LXMKV3EVxYhBhFRnM4haxkhryypmaCL6xg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tommaso,

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

On Tue, 17 Feb 2026 at 17:25, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Enable RSPI0 on RZ/G3E SMARC EVK.

which is available on the PMOD0 connector.

> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> --- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> @@ -167,6 +167,13 @@ rsci9_pins: rsci9 {
>                 bias-pull-up;
>         };
>
> +       rspi0_pins: rspi0 {
> +               pinmux = <RZG3E_PORT_PINMUX(M, 4, 2)>, /* MISOA */
> +                        <RZG3E_PORT_PINMUX(M, 5, 2)>, /* MOSIA */
> +                        <RZG3E_PORT_PINMUX(M, 7, 2)>, /* SSLA0 */
> +                        <RZG3E_PORT_PINMUX(M, 6, 2)>; /* RSPCKA */

I will exchange the last two lines while applying because of sort order.

> +       };
> +
>         scif_pins: scif {
>                 pins = "SCIF_TXD", "SCIF_RXD";
>                 renesas,output-impedance = <1>;

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
