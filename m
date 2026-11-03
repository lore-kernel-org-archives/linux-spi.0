Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696666;
	b=RePEXMmwNAEbM4BID7fAZ5jOdrSiS01ZrU0GiotxJpQNFiJuNISeJwq9vZXcSquscaRJ
	 ihVF5wiXEFhsSy/kllPShA1XLbSuAOlX5yCDjRqWR2bWJFKRvQdWvf5T5FKhJqiaPIV9B
	 OWzy5ZafKgudb8CQZlHBGso044gUKP0ilIn28pyIt/UfEVgQ7DGX45PL77VJfV+jbhQvC
	 5ulgnElonq178tDFYHcakjn9+44FaHO/cc6p1oPMHwF4UoHvbGQiwKPVr23pT/OrUKLJU
	 Vq7EWQp9vZHTm3VXNoQN5gK30iYx7YkFOpCorFJdB+fFk/0qCBYHDFmziPSa3mzrAPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696666;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oqcwif+o3u40FPToGAPLvgMZ6cthmDqENUhGefULOww=;
	b=OzegxzfN9R+aIydve5m7AcixBkasLuzVVbCVxTvEriJgwkPhm1xjwPOcGIVu/TbeqoFQ
	 aHAt5KcrZe8GqGR8ILyK4E8UZ71C526E7x2yQD2T0U/ycjUjgLJ9wVqtBL/6c4oghc35C
	 yQIAoP37WVElkGw0uOnoI3TdFiUvB+MKiInl84L4a9yxmFkfrWtMww0SGmNGbpJR3UuDh
	 VF1FNGMtxqqSHWtkcblQDSlbYaRLl0kWwfSq2UNEcTUmguhNbl9xvIXX5ThuH12NW63J0
	 aK1e3Z5PnRWElRFQXSFgH4tvVdi2vUzJLR1aCdgVseJN8oka4r5lveZks/uMBaS+LMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1xKU2tT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0F606A332
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1xKU2tT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2BB1F00A15
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 09:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696665;
	bh=oqcwif+o3u40FPToGAPLvgMZ6cthmDqENUhGefULOww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h1xKU2tThc+PCjMmTSQl98ISc5OnxMMDKFMUPOC9vnlb9lQ4xXhBteZ2gpKXpRt7I
	 w9lfHpMOf3jD7ltyrds0TP7N7c/b/Jj6B+osimdzSS0PSO++Rw2BGlJCslQ8ZoGQrh
	 s035XhlTsRnNeYdvANd09qtbbDad5FtIteTxYMMEyv2lCo+HSmzUARhSS9QlY0zjzV
	 N4+Kg7jXHxMi3kiA9ATievIktcA60E+48pt0/InTqwfA0sOKN1kO3xUiAcccV8xDT+
	 +8Vutoj+WhzleMS5uiq6PG8imke4kD2NTobGiKFljbN6hq0teze7QLoDKWlRhqdiy5
	 celxtNibeT47g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab27e45e7cso31694421fa.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 01:04:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz/4iSLNIHW3PH2ocWOHeHT2uNIHqMvfZYkgvqjC8B4ldYWw5jf4EtzCCh0AkW5fhdINN5BpLm+d7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+c619aavMMxw0s1lXS39qEUFQrTAH2qpATAEyHAuHybiCBbrTS
	jWAeVZZF/qd+1yYXzXbeFKcC1gjLH+elpCcrSWLuuiS3sViMTcd7G3oJ008zwfVxKnO1PeEF9rZ
	pJGK/0UlxD/izXRh8jwpfmuku0abxGhs=
X-Received: by 2002:a05:651c:198e:b0:3ac:4da3:864f with SMTP id
 38308e7fff4ca-3acb7a9e0f3mr31016591fa.4.1793696664148; Tue, 03 Nov 2026
 01:04:24 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Nov 2026 10:04:10 +0100
X-Gmail-Original-Message-ID: <CAD++jLmoy=--GE4MScaTOa=x9+HAuvhHC7ixA_GYVme2vrcgZQ@mail.gmail.com>
X-Gm-Features: AclHuK8feuY0PnTZqOb4xpNbcV0UYLP8c4l3kas742sFixN6cKUvbMAmIcJa7DE
Message-ID: <CAD++jLmoy=--GE4MScaTOa=x9+HAuvhHC7ixA_GYVme2vrcgZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
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
	Haibo Chen <haibo.chen@nxp.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Heiko Stuebner <heiko@sntech.de>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
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
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:40=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:

> From: Frank Li <Frank.Li@nxp.com>
>
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across SPI bus drivers.
>
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Makes sense.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
