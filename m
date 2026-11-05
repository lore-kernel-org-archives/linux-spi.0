Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870829;
	b=4Wgpzm0dTrEusfi823ALsaY6KSMC4Xp4jZQVXaDZDghUg4WsrNQu1HwbV1C/nHwHJNDu
	 +Q/GrAP03aT2pHl+6kDMhxFFBk1bOaHDdwSuLHbXo4cK2n9/6wdqR37qVnkbjeFnqvr1f
	 RBZeSlior0dB98aCw/keEavQfTqO0Un5qIqR7t6AKMi4oY/EqUuCtRPmn+ZgbPnxRWHov
	 Ph+mF04thvAQkjAl+6AAAnT+lTrt2JDiryQrQ7dKxZOV1senHnRq1E+f+2un35hYnlZPJ
	 nw3CdI9VqNqtQ7aLOsSEeKVNhmXhlWOO9ZeDaF6Mj7N0zKQbxdb8A22d+vrXnFZ8n7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870829;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=9pg1eAqFe+iTfmNTfa/GRPtY3M6bs2CHPsTRd5ndQTA=;
	b=lAqXvMUmHYjXHf/7dToDrMgbn/5tn/cLmsJLDa9TlugWpqPT5aaSBzMuYV+PKzjtZkM2
	 oa/d61BpxMg2hnCHcnBR/pdNAMaSU7YxS5tvc/28yRPSyLL2fJG+IPxO+sQ3EoSp7UyOV
	 4qLc8TUH028aqLur0tLyjfLv67iFttihssciaVM2SXEhqPAmTitN3pZcJkk5wyLAWKWOA
	 jdIDsCQcCZuAlcMf6u3+A/1IQMhWgi8oAGVco/G1g9wTcDMN1ANjMuKH9bBIByB7UwgEQ
	 m7XyulwXGGCSjtttT6i4fbeFugNvvMUDHXgJX0wY2Ubk08DnOM/f23mCwgXlyxzgT+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FFD606A32D
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 09:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88FFD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-930c0f9c1b1so175415385a.1
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 01:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870828; x=1794475628;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9pg1eAqFe+iTfmNTfa/GRPtY3M6bs2CHPsTRd5ndQTA=;
        b=02UGukusNWeVA0geVwJFrS5JYslYCcV1CYHp/lNYDo+C0j6+ENtqI6ywjt0xr4MKZN
         Cn3R/gS3zTs57MB2VuXsE5FOcj9z6skjkt0IaOosVQprlRUJQqK+6RCRp3yoDewK0as1
         BisWinyZW9ulO0dNO29fVTnjYDEHUZKYWh/ambrI3lYD3DAA6OUhnU7SNS4gDWuAGGG/
         /33nuvgH3dTnaTaL3hVdU9JHWsTxTsujywyo0WP+QYD+ms2G7pGZfne1EDoDQiGDylGR
         0kl6i7ThPM9cJU/FJpkMbwXK0aVOgf4PLE6xBuHdLQq5WpGMizVIp13fbzCM7gvVCp4l
         Cf3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwJwWdNGEDmRy8xmHAqFd2hJadptEoCtyfXpyVRUFuxY6KwYsRJuL3HJPi35ClzfZ8Qy3oj2Kw4UAo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WUmPjJGvp4IefQ8nUrDUmVWFxUbfUqHQn26XXiX7F+XjxVg/k
	KeJYesgrej8egzAT5lC4ZvV6MeNayLWSUai0jZnFwePCEEyC+z5LSx0B9hPj4/Sqzxc=
X-Gm-Gg: AYBFou3ZwFMNLBTKqqYf5SzJAigLmBVlF5K+P/fdoXuBm6XkARvryFB9BjouaeJ4F1Y
	5t1cWQZcuKu4ur2OEcJVYut3232X+yr2oKO3BzLp/12gGdFYetOsudIb9yD8B/Hm7iWaQEOOrS4
	vfqN8uE+Rzhym/wnxwpZiavyrsuyQjfbGYSuRTFjLWAAkOSGGhO25mkYd1fLdoAAGdRA4dUvcHJ
	ckhDbdq+LvkRksf+3CnEALtwYbmZ6VtnwpP/3bUJipu9ROpmsc9QGdi0O6Rr6VYcgV+JDFDvRDq
	VIhOQ6U0imDX3i6sv9o/pdbebVBPuYi5G+is7Je/xGZBlugG/Yr4E2HLfKC3t00cqo2QoSY8aH0
	bdvoPJsIgpDiTlJy6IH9yzUJQRep5tRG04jynsou26/4WTKXSrLf6Z78ZJGMKUMsioxKyBLvkhR
	rG4XsKtVqYYSJkXQKOibbZrK9q5MageJbpWsaFXTxDwj2nLvhG5y9s8WMkk/73NeF4LOmFnFHxz
	9gAFd/kMrrJGZtw1NzzSitF6UNdYyeoKAn79zfUIhXGjDQh3IfEEJJPuaOGSa14CSkToqJbaCbG
	8SbD8jEGz7x7TOSADB5XVSI8SDNNsy0hHFXFGRz/L5Fp+9KI6t3SZvDQWyIDw5FCdBoGyw==
X-Received: by 2002:a05:620a:2b47:b0:93e:592d:f5a2 with SMTP id af79cd13be357-944214cb918mr3107709685a.11.1793870828423;
        Thu, 05 Nov 2026 01:27:08 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945e99be936sm30793585a.2.2026.11.05.01.27.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:27:08 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53644ab1f7bso14086471cf.3
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 01:27:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBykTxokIYJIfaa6AlTr2chEogoDR1arxtrAf1TtRkrsBengPR56T/+pNa8RAFizHuZbl8z5qod3nIo=@vger.kernel.org
X-Received: by 2002:a05:6102:e0b:b0:7cc:1045:610 with SMTP id
 ada2fe7eead31-7d072cc4a42mr6604019137.27.1793870415083; Thu, 05 Nov 2026
 01:20:15 -0800 (PST)
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
In-Reply-To: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:20:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUfYZmbf6ADFFoKSod6yhu7jQVt5CBNuQpmRUUWR3OZGw@mail.gmail.com>
X-Gm-Features: AclHuK-9tAw2bAtaZucYUxK8rDds9GR808jJtyoj1R1Fxu-dNuDK-M2tP9yoLrk
Message-ID: <CAMuHMdUfYZmbf6ADFFoKSod6yhu7jQVt5CBNuQpmRUUWR3OZGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com
Cc: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Radu Pirea <radu_nicolae.pirea@upb.ro>, CL Wang <cl634@andestech.com>, 
	Ryan Wanner <ryan.wanner@microchip.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Heiko Stuebner <heiko@sntech.de>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
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

Hi Frank,

On Wed, 4 Nov 2026 at 16:30, <Frank.Li@oss.nxp.com> wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across SPI bus drivers.
>
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add missed set_callback in rspi_dma_transfer() (sashiko
> - collect review by tags
> - drop void *

You have lost the "# Renesas related drivers" part from Wolfram's
review?
https://lore.kernel.org/all/auoQiuIm9FxdOrYl@shikoro/



Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
