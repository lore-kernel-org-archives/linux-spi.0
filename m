Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870620;
	b=pc2cdVenv88aQMhdlD+FT3XoQDOr6qyd/7ac6k109JHomOqLVw5fgkwA3A3w0IE41hxL
	 lJpr1kUFBbsZTKGAYJiMAivdj2D++5c1TVdMJ2xvEY30Cn6nA2VKHob5BgJ29bOCCg6w2
	 fk1pyXSBiIQ2im7KfErDvQULqKnU+Ph0FCp8Im7y9kMZAYG0ii+WY9LEKqpgfX6saEtbp
	 J5R6he7cUF2KUiLPCmMFm3pyVVxAyWcPSkdCBOO6My8rO8ILGSxkO5ad4GRBzfQD/RtfQ
	 f9w/LyDTXUzULORXT1ge8MaE0GDU1SBzvQdylprSTYnmOP5+bcUYMXRjsxBucvnZY5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870620;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=pdLSFARJtZZaOSy89wvFfnir+tkCHpND5r/hzAKJUn0=;
	b=uLmd/2q7xNLVqrG8qK5eqOpVgYLjZlPCfbv4MDEhjWGIDrVYV7EUAbEqFJlIoAt8MA7G
	 a1TbaO5JRGCOKjJ6WQ5iMepd1BwbGWPuUD/th72KgI2sDWnxRrRmkl7SsH91WSNXZSeuA
	 kmA9YPNPONAoRdxa9OQjkhoJpHRfNTHgk+aKBPbgKsrH1mL5Tao4/NQhaV0oX8cHOvq8H
	 bCpqzxH4UXulHVdSJdZt1zDOfcRu9KPF2tSqWx6VjG4BPnRFnAkeaNAAK0K/vqzJKABC3
	 kFaxOYwYWtoCNFURNPpAQhEWL34iS/gYRSJM1LJGDPthACtuuqHYmer9n/Klh2skDdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EA606A330
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 09:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184EA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1141648a12.3
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 01:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870619; x=1794475419;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pdLSFARJtZZaOSy89wvFfnir+tkCHpND5r/hzAKJUn0=;
        b=L70b8gVptsqgaw35N8BOU26SR8pcnoRHVIRviE0GmfzR4AaYWMDmkpQsJHXz69Vbq9
         cuEB7xOI7ID0/W+zP/rPAPfRXWviTaWYQL+n1rsFGKW+4UvGpx3m/guTrfUNWSD+EtXB
         CBMzfFLGDwrXBnOe1qw4rz6FDzbZxz5CO/vbjPREjEx8lZzYjAm8YLZOAIsWXdOzlPiN
         ocOY4aKw0Njg6CKU8hR+jXEXAlnMwGdtUJ0bfXD+PrwOins2/WPTfpPfvdSz7slqqr0B
         CBlzwJxG6IDTd76sJppKbWOIAMQkj/TZPKS062LiqV27+0y9Vn7r4pgX53tRrAScopcw
         r+og==
X-Forwarded-Encrypted: i=1; AKwUvBx3ubiToDRmq2IeVbrSP4UiTM9sRFiuE9SYKlQ0ibngysDJyTAa4dcyLkPDrfaAZz9oME85vlJiFMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wPSlD3jCBO9mh17srHMonfnWqXggZUxErby3sglEXEnl+35hS
	RtKxTEk+075bjlt87MTz1Zj+GI5cXYCHkAYy/qhteO4bBUDBeZaUrDQpYir9IcJF/ag=
X-Gm-Gg: AYBFou00lef2J859Y3glBoZc365tthS5uKqJ1+RCFfrLEU7EIuid4Q1wU2HpIBY4ef/
	nRNmpzUWSTn50kgMFpbXy0bCWAfUd61VTpaeEIq+x+CM97+F0tLDPH93sxElTGraXSYVFEmEPbc
	bjNIvLZ3ARSJxsbnoDKtUsAUIoRrZdvsleP2kBiYQLvfgQHpRCrOtaDBwIvcJfiZdDIMUqwIVwE
	dAS7isyXa/aZJAONJcudj0isOXnr40QRKfhgRJyBJ0QKr/4BwAbKXRrM6z2mME30DRTTjKz6A8m
	Wubm8GrJF7RnDCSzmYkpr7a09/WJ+VKM0XRzArGMhfHWUZ43GGWPqudZI8riAIrmtPmnclwyWp/
	m+WXYqwqcdIAUmgAJpbAx3DsRCCgWzB83ZnAAA1ciTWuVn1iBik1/vSNWwVRDTN5A3qKBXwFfA3
	cz+x934aniz0nShEpdmP7CUUycQhqn+GSNZozyv/cwZpCwfnTbMJEFU2laHDb50ksxeO9fuKy/y
	hP2x7G9gtgxvKFtzE6jshCc0uqajKTxEoriPzn4d9RsUr75loaxjLRx+LaBTWyLVYQMy0Y4I1UZ
	EsoDg4+EQxkv8k/Z6mc803qxN5je+jUdqtc1g+NEwzaGKinF0gLKnvmHMVXDJRwI
X-Received: by 2002:a17:90b:440d:b0:3ae:2969:9031 with SMTP id 98e67ed59e1d1-3ae8983eda2mr17448926a91.54.1793870619356;
        Thu, 05 Nov 2026 01:23:39 -0800 (PST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3280378sm2901775a91.12.2026.11.05.01.23.38
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:23:38 -0800 (PST)
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1931ff67a29so425602c88.1
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 01:23:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw9jUzgZj8FcFJAxO4IwtsSrjNF6Sy0oXL8nakHmOmr67BvmlVve8k/Ju2sZ9LUvgkk+9xtxy2vIC4=@vger.kernel.org
X-Received: by 2002:a05:6102:3711:b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7d072695e4emr7033715137.14.1793870187629; Thu, 05 Nov 2026
 01:16:27 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
 <b656861c-a087-4087-952e-91fd15fadd52@kernel.org> <auuZHTvr5UI9Q9Q4@ashevche-desk.local>
 <fbcb650d-0f60-468d-b1cc-255ea8a93db3@kernel.org> <auxF9RT5aljXkfh7@ashevche-desk.local>
 <auxGdYgJvjq9EBu6@ashevche-desk.local>
In-Reply-To: <auxGdYgJvjq9EBu6@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:16:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkzXMsv_4KHP20qidmH1B4Ew3=VuTJ8jqfqvx4_+pm4Q@mail.gmail.com>
X-Gm-Features: AclHuK9751j09IKd6_4EIkqyFvn0FA5bsvqOYkEgIDax6KzLeXviQYPveqzIsxk
Message-ID: <CAMuHMdUkzXMsv_4KHP20qidmH1B4Ew3=VuTJ8jqfqvx4_+pm4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konstantin Ryabitsev <mricon@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Frank.Li@oss.nxp.com, Mark Brown <broonie@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Radu Pirea <radu_nicolae.pirea@upb.ro>, CL Wang <cl634@andestech.com>, 
	Ryan Wanner <ryan.wanner@microchip.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Heiko Stuebner <heiko@sntech.de>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, 
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>, 
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	"open list:RENESAS RZ/V2H(P) RSPI DRIVER" <linux-renesas-soc@vger.kernel.org>, 
	"open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 10:04, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Nov 05, 2026 at 11:01:55AM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 05, 2026 at 12:02:21AM +0100, Krzysztof Kozlowski wrote:
> > > On 04/11/2026 21:44, Andy Shevchenko wrote:
> > > >> Andy,
> > > >> These three lines look correct.
> > > >>
> > > >> LGTM:
> > > >>
> > > >> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > >
> > > > As
> > > >
> > > >   Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org> # atmel-quadspi
> > > >
> > > > Note, it's in your power to ask the author to split out what you maintain
> > > > to a separate change. So, it's your choice what to do, Ack the full patch,
> > > > give a partial Rb, ask for a split, ignore reviewing (often means silent
> > > > agreement when maintainer just applies that kind of a patch)
> > >
> > > The "# note" after the tag solves the problem partially, if people were
> > > actually using it. Solves people looking at the Git commit and being
> > > mislead by partial review applying to entire commit. Does not solve
> > > credits, because Rb for three lines is not the same as for 100.
> > >
> > > From v1 of this patch, four people (Alain, Lab, Troy, Kunihiko) did not
> > > use it even though reviewing only part. Only Wolfram, so 20% of partial
> > > reviews, used that syntax. Without that syntax, b4 will pick up Rb tag
> > > like it was for entire commit.
> > >
> > > So I do repeat - if one does not want to use that syntax, then just Ack,
> > > instead of creating false impression of reviewing everything.
> >
> > +Konstantin, then we need to teach `b4` not to break that or convert it to
> > something like
> >
> >   [FirstName: reviewed only ...]
> >   Reviewed-by: FirstName LastName <...>
>
> And Ack is not the same as Rb, when I *reviewed* patch, I have *reviewed* it,
> even if it was partial one.

Exactly.

Ab means I won't take it through my tree, please take it through a
different tree.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
