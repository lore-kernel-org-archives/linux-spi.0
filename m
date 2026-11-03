Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714486;
	b=3UVeYjyOmeZm36YmGemM2uuyyXanM2hvWX7fvnH9gmflJC7NqC8eY+B8hVngnot52ROu
	 lMB9I+TSt9w9+iiFF/0NgmN/b2fmW850hn0SxswbJm5imrMe7l3aiDpzmsuPpZwfGhPlZ
	 QfX0BVBbVUUrHb6ExnD5PQpC4yedql1vgLByY+5ld6gUrLBnkENtxgBAukKidRCvPkaBB
	 Y29KtXnwaddSYCQgCEV1BZd1fbzm09/sWt6CXukdzwhViK+Ovw33B1+blIAZLWRQ46DQH
	 GIQ6BUHg3qA1yG8ctCnz0GQ5OUO7naBspIqufuLxoVKpsZlULDdw5SMQ/NfVzXKgsYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=puVJrxN6Wl/F9qff//CZ3wktxOqBSw61zM0z8LPg36Y=;
	b=nR8CjQpIVKM78t9SMfPcKkrTL8phCZPTqpUYb1z5mGIWKtJmuyyY8KmfzUfwz66Kh8I4
	 jciWkToQKOPQjFJFLJDeHwLHRG2d3H+S0yzCpwZXfeedK/aIdmyItby7mzreBEdNLj/3m
	 Q6v0tTtU2cQZGPYnTiztimu9s1JrF8atVKyazzRnTY+u0Dmzu915eoFMUpLjEkwG/gCHk
	 HCODQ9sXpuZqzsXoqNLNdIwX4A9SOuwBXpIQsaGbBZcH0bJtWs3xTw2bqXDRnIsVFVTjS
	 mzLlwYQj6BhQRdzeaK/BYMrxeESoURlGYK7nSXtT/KswWrMKpZatIsbPiUkzSk3NycA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1+rZZqV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E100606EEBE
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 14:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E100606EEBE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1+rZZqV
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso650107166b.2
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 06:01:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793714483; cv=none;
        d=google.com; s=arc-20260327;
        b=ZxMW0HzfsWmio6IMDRrc+CFFFswH3fH5LTn6wp/d7KN8hzo7k5XC38g/1ohkKZaaYT
         uZTevBvXIVkX3ZIoJ0sc8Lk5DZnT6DkxGL92BXPdrHIPFKWnThlXXY77J6AFYGWovH+F
         V7VZ3EYDHYfsJl3H8/xHCIjVxuo+w6fcJUWNZ8xc5fFfqm0Dn3ao18tDs0moJN7oSQRn
         sX9vCuGxwzYjZaS7W3I5uUqPszL8TdNgzRgg5XsL6BJ5f4O7jMnhjwKD6MxQDEa8Pn41
         fRHlSn1YAPtwWpRaYe49YM658Y6pfbvSxW6DyXYTgxJ9YYr/NUxixQ1TLwddG1/+jQsY
         oSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=puVJrxN6Wl/F9qff//CZ3wktxOqBSw61zM0z8LPg36Y=;
        fh=u+AS6wnHRgRZLy661zdx/zGtf868SEjDWCLEqh7ACaY=;
        b=ckBCwYlnEKUrPOgW1Vg6bbI60yRKqN15kyqajDybpBfXoqdyz/6RBwbs9J/i2r9YK/
         muV3nsGZcxmOM4r3IL+ATeeh+0Et8MEOq/9bDkuBi+pvBmTgtbGarfmyvxWmrY2kWOVS
         K6WtnGHHcL+pXFK5CaxbNWILX30simB2AGmCl9rzjiTlS2lHk+EcqU5ozSAm/un412XJ
         2qb6WhT5dNptT/qvc6f90gV2ki8a7+HyUzIGYyfmhzIIuGzLg5lVQHpMlrb0eM3vSutK
         CZnh7pUfxMmKz6u90LPBlBN7Kj4nj1ClvqQmdeFaiZ8AeQfloUU9BINiHV5AO5fCizUc
         KLxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714483; x=1794319283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=puVJrxN6Wl/F9qff//CZ3wktxOqBSw61zM0z8LPg36Y=;
        b=l1+rZZqVDSW5VCQiKRAaCYdgHOoJmMTpdLuw5wbkn0ubihbmoaPezjfVxrZNWW02AW
         yrcnKlXDh0S2Gt7EFCjq++HlD+G7wfr/e4VLRJZ5OwaIZsLk6sV5fFw31oLC/cesJmVW
         86r8T22N4AsSe/NmnF+TzkbrQqKijz2s6DhYsGV2xHTI6jk+EFxKIbFHpdi+WlwNscmA
         h229aFTojNgIbNG1mmKZFnTUiQfXvfdDDNnc0nWUaOMtZ53QsWu552LCauRagDyuWlWT
         e3fjqceEZpYiMa7+oiykWJ/j+Bph/qkRJXjZOenV2nKD9netFH0bgYT7qpDSpNMsuX4b
         /Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714483; x=1794319283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puVJrxN6Wl/F9qff//CZ3wktxOqBSw61zM0z8LPg36Y=;
        b=GbeGF4ZqmvVeyVTQS28ytw59QZuaNQxytZOuhvsDbWQ2Sc54ILB6l15P6i9U6rtOwA
         PWdyZXeCGsui2OFkDKdR9Kc5oF88rHXwKmC9vjApXw46qLxU+cA2y7RNfNhqAssMZy58
         TeSMcjZZmJUFxFRpi9hN8omcldRuoy5vGL1NOlHclww4J/1PCM3J6Mz1tSTvwnrreSIW
         OE/axHl4Yq9RUUTP0h3a5r0LUIEXwZQH5pPtR8GlUSiUf5Pmn469XTk/Si4vKx6ZnXiM
         M12pRQA6P9Gj3cG9SSIeMgWkcFKPz/bSHhAj7t31M+6ivqPbb/O6XlBMnns2hsOMmGfr
         Q5tA==
X-Forwarded-Encrypted: i=1; AKwUvBx6DHeEI6lEk6P+KgkgTYMQt1xULdY7VbC8TQazcuaLWhCM97B8KGLzSPWKs0FzHVvG8kiwjj+TbuQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aHY8NdMMsmulqbUjGEDM7nU/gWGy9sWleeNNmhV/zCqHpxCzS
	pmCMLUtMj41wACP3kQQpKFFe5ilZm4Hj1yYOEM9gsZw4ElEfZ7Y8/qufljeSAoiy1gZ00Ljgya7
	CYNkGPxGr4zibVx/8M/TJ+5uOdf1grAc=
X-Gm-Gg: AYBFou2IdQrkOoLMHUBRO+YGtlrzcBxh0+ILuLW9/okZ6yiM0yVUu5z2eAJE6ECQWk/
	G3L2qH9ZFGVibSxAawmqn9VMvLjnULlSiqUloHaQraJTQF2FQbmo5isMNv+fWMGxV9n2uIgiLia
	A0DlTWx5HHD2AvzurswQ9OIPg6i+dRxngUCLdvuWGNYIipaTrQhWd93ZNEpcVkGG0E0PbR4qECR
	EzPcNHBns2lV/uh0MV9QRF4DaCaurdp5X+MImLDWrw2ycmciSOWgI+br+SDLgbuoFtU1iQmkZ74
	jqXV2I5OTrZcloSl1wbR0JAE65fJGsI0IOEd1atP1kVocAbllfbGfkv5HwwF7qYktT+RSS3jke0
	qFZS4Oq08t3EnJOSThZyYWqketj28Ab+RQXwB3OKrZ48y1gkQAXWqw39oxYHZquBn3VnGN/wHsD
	pIh5Sn7IldctK38DF55keT3NCGIk3PcHWDSuB6oX++Sg==
X-Received: by 2002:a17:907:6e93:b0:c46:7ec3:fde7 with SMTP id
 a640c23a62f3a-c4ca7aac4e2mr1131212266b.31.1793714482177; Tue, 03 Nov 2026
 06:01:22 -0800 (PST)
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
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 3 Nov 2026 14:00:55 +0000
X-Gm-Features: AclHuK_xZ5jVEViNzHPZ3dWjLeRJR6DyKNbHfYq54kf-JupD2UbbX8_Lgl7fhAo
Message-ID: <CA+V-a8spupdMZ5xv4WgzwhiX8NfsAUUSowM2NZPK5XConNxLxQ@mail.gmail.com>
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
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 5:41=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
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
> ---
>  drivers/spi/atmel-quadspi.c       | 3 +--
>  drivers/spi/spi-at91-usart.c      | 3 +--
>  drivers/spi/spi-atcspi200.c       | 3 +--
>  drivers/spi/spi-atmel.c           | 3 +--
>  drivers/spi/spi-bcm2835.c         | 6 ++----
>  drivers/spi/spi-cadence-quadspi.c | 3 +--
>  drivers/spi/spi-davinci.c         | 6 ++----
>  drivers/spi/spi-dw-dma.c          | 6 ++----
>  drivers/spi/spi-ep93xx.c          | 3 +--
>  drivers/spi/spi-fsl-dspi.c        | 6 ++----
>  drivers/spi/spi-fsl-lpspi.c       | 6 ++----
>  drivers/spi/spi-geni-qcom.c       | 3 +--
>  drivers/spi/spi-img-spfi.c        | 6 ++----
>  drivers/spi/spi-imx.c             | 6 ++----
>  drivers/spi/spi-ingenic.c         | 3 +--
>  drivers/spi/spi-mxs.c             | 3 +--
>  drivers/spi/spi-nxp-xspi.c        | 3 +--
>  drivers/spi/spi-omap2-mcspi.c     | 6 ++----
>  drivers/spi/spi-pic32.c           | 3 +--
>  drivers/spi/spi-pl022.c           | 3 +--
>  drivers/spi/spi-pxa2xx-dma.c      | 3 +--
>  drivers/spi/spi-qup.c             | 3 +--
>  drivers/spi/spi-rockchip.c        | 6 ++----
>  drivers/spi/spi-rspi.c            | 6 ++----
>  drivers/spi/spi-rzv2h-rspi.c      | 3 +--
For the two files above,

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

>  drivers/spi/spi-s3c64xx.c         | 3 +--
>  drivers/spi/spi-sh-msiof.c        | 6 ++----
>  drivers/spi/spi-spacemit-k1.c     | 3 +--
>  drivers/spi/spi-stm32-ospi.c      | 3 +--
>  drivers/spi/spi-stm32-qspi.c      | 3 +--
>  drivers/spi/spi-stm32.c           | 9 +++------
>  drivers/spi/spi-sun6i.c           | 3 +--
>  drivers/spi/spi-tegra114.c        | 6 ++----
>  drivers/spi/spi-tegra20-slink.c   | 6 ++----
>  drivers/spi/spi-tegra210-quad.c   | 6 ++----
>  drivers/spi/spi-ti-qspi.c         | 3 +--
>  drivers/spi/spi-topcliff-pch.c    | 6 ++----
>  drivers/spi/spi-uniphier.c        | 6 ++----
>  38 files changed, 56 insertions(+), 112 deletions(-)
>
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 762a3fb0fca81..de205e04a8600 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -790,8 +790,7 @@ static int atmel_qspi_dma_xfer(struct atmel_qspi *aq,=
 struct dma_chan *chan,
>         }
>
>         reinit_completion(&aq->dma_completion);
> -       tx->callback =3D atmel_qspi_dma_callback;
> -       tx->callback_param =3D aq;
> +       dmaengine_desc_set_callback(tx, atmel_qspi_dma_callback, NULL, aq=
);
>         cookie =3D dmaengine_submit(tx);
>         ret =3D dma_submit_error(cookie);
>         if (ret) {
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index aadcdf734fb03..8b56ac1dcad8e 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -228,8 +228,7 @@ static int at91_usart_spi_dma_transfer(struct spi_con=
troller *ctlr,
>         if (!txdesc)
>                 goto at91_usart_spi_err_dma;
>
> -       rxdesc->callback =3D dma_callback;
> -       rxdesc->callback_param =3D ctlr;
> +       dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, ctlr);
>
>         cookie =3D dmaengine_submit(rxdesc);
>         if (dma_submit_error(cookie))
> diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
> index b532c58c0ab91..c807e730ca94c 100644
> --- a/drivers/spi/spi-atcspi200.c
> +++ b/drivers/spi/spi-atcspi200.c
> @@ -340,8 +340,7 @@ static int atcspi_dma_trans(struct atcspi_dev *spi,
>         }
>
>         reinit_completion(&spi->dma_completion);
> -       desc->callback =3D atcspi_dma_callback;
> -       desc->callback_param =3D &spi->dma_completion;
> +       dmaengine_desc_set_callback(desc, atcspi_dma_callback, NULL, &spi=
->dma_completion);
>         cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(cookie);
>         if (ret)
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index ffc896e4621ac..ffc1292b08c10 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -867,8 +867,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_=
controller *host,
>         spi_writel(as, IER, SPI_BIT(OVRES));
>
>         /* Put the callback on the RX transfer only, that should finish l=
ast */
> -       rxdesc->callback =3D dma_callback;
> -       rxdesc->callback_param =3D host;
> +       dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, host);
>
>         /* Submit and fire RX and TX with TX last so we're ready to read!=
 */
>         cookie =3D dmaengine_submit(rxdesc);
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index cc57489732816..a71048a88c58a 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -706,11 +706,9 @@ static int bcm2835_spi_prepare_sg(struct spi_control=
ler *ctlr,
>          * RX-only transfers; else by the TX channel for TX-only transfer=
s.
>          */
>         if (!is_tx) {
> -               desc->callback =3D bcm2835_spi_dma_rx_done;
> -               desc->callback_param =3D ctlr;
> +               dmaengine_desc_set_callback(desc, bcm2835_spi_dma_rx_done=
, NULL, ctlr);
>         } else if (!tfr->rx_buf) {
> -               desc->callback =3D bcm2835_spi_dma_tx_done;
> -               desc->callback_param =3D ctlr;
> +               dmaengine_desc_set_callback(desc, bcm2835_spi_dma_tx_done=
, NULL, ctlr);
>                 bs->target =3D target;
>         }
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-=
quadspi.c
> index 73ea51c41f955..6e7c8b54e0377 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1395,8 +1395,7 @@ static int cqspi_direct_read_execute(struct cqspi_f=
lash_pdata *f_pdata,
>                 goto err_unmap;
>         }
>
> -       tx->callback =3D cqspi_rx_dma_callback;
> -       tx->callback_param =3D cqspi;
> +       dmaengine_desc_set_callback(tx, cqspi_rx_dma_callback, NULL, cqsp=
i);
>         cookie =3D dmaengine_submit(tx);
>         reinit_completion(&cqspi->rx_dma_complete);
>
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 087735ed9c80c..b115daf2c76f3 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -703,10 +703,8 @@ static int davinci_spi_bufs(struct spi_device *spi, =
struct spi_transfer *t)
>                 if (!txdesc)
>                         goto err_desc;
>
> -               rxdesc->callback =3D davinci_spi_dma_rx_callback;
> -               rxdesc->callback_param =3D (void *)dspi;
> -               txdesc->callback =3D davinci_spi_dma_tx_callback;
> -               txdesc->callback_param =3D (void *)dspi;
> +               dmaengine_desc_set_callback(rxdesc, davinci_spi_dma_rx_ca=
llback, NULL, (void *)dspi);
> +               dmaengine_desc_set_callback(txdesc, davinci_spi_dma_tx_ca=
llback, NULL, (void *)dspi);
>
>                 if (pdata->cshold_bug)
>                         iowrite16(spidat1 >> 16, dspi->base + SPIDAT1 + 2=
);
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index b706770334a61..94810f9dd5c5d 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -397,8 +397,7 @@ static int dw_spi_dma_submit_tx(struct dw_spi *dws, s=
truct scatterlist *sgl,
>         if (!txdesc)
>                 return -ENOMEM;
>
> -       txdesc->callback =3D dw_spi_dma_tx_done;
> -       txdesc->callback_param =3D dws;
> +       dmaengine_desc_set_callback(txdesc, dw_spi_dma_tx_done, NULL, dws=
);
>
>         cookie =3D dmaengine_submit(txdesc);
>         ret =3D dma_submit_error(cookie);
> @@ -498,8 +497,7 @@ static int dw_spi_dma_submit_rx(struct dw_spi *dws, s=
truct scatterlist *sgl,
>         if (!rxdesc)
>                 return -ENOMEM;
>
> -       rxdesc->callback =3D dw_spi_dma_rx_done;
> -       rxdesc->callback_param =3D dws;
> +       dmaengine_desc_set_callback(rxdesc, dw_spi_dma_rx_done, NULL, dws=
);
>
>         cookie =3D dmaengine_submit(rxdesc);
>         ret =3D dma_submit_error(cookie);
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index d8f4aa38685f5..6832869bc73bf 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -418,8 +418,7 @@ static int ep93xx_spi_dma_transfer(struct spi_control=
ler *host)
>         }
>
>         /* We are ready when RX is done */
> -       rxd->callback =3D ep93xx_spi_dma_callback;
> -       rxd->callback_param =3D host;
> +       dmaengine_desc_set_callback(rxd, ep93xx_spi_dma_callback, NULL, h=
ost);
>
>         /* Now submit both descriptors and start DMA */
>         dmaengine_submit(rxd);
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index f03488870d024..aee0393f9a832 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -581,8 +581,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi =
*dspi)
>                 return -EIO;
>         }
>
> -       dma->tx_desc->callback =3D dspi_tx_dma_callback;
> -       dma->tx_desc->callback_param =3D dspi;
> +       dmaengine_desc_set_callback(dma->tx_desc, dspi_tx_dma_callback, N=
ULL, dspi);
>         if (dma_submit_error(dmaengine_submit(dma->tx_desc))) {
>                 dev_err(dev, "DMA submit failed\n");
>                 return -EINVAL;
> @@ -600,8 +599,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi =
*dspi)
>                 return -EIO;
>         }
>
> -       dma->rx_desc->callback =3D dspi_rx_dma_callback;
> -       dma->rx_desc->callback_param =3D dspi;
> +       dmaengine_desc_set_callback(dma->rx_desc, dspi_rx_dma_callback, N=
ULL, dspi);
>         if (dma_submit_error(dmaengine_submit(dma->rx_desc))) {
>                 dev_err(dev, "DMA submit failed\n");
>                 return -EINVAL;
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index b25f94b2ef738..7798197d5b350 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -634,8 +634,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controll=
er *controller,
>         if (!desc_rx)
>                 return -EINVAL;
>
> -       desc_rx->callback =3D fsl_lpspi_dma_rx_callback;
> -       desc_rx->callback_param =3D (void *)fsl_lpspi;
> +       dmaengine_desc_set_callback(desc_rx, fsl_lpspi_dma_rx_callback, N=
ULL, (void *)fsl_lpspi);
>         dmaengine_submit(desc_rx);
>         reinit_completion(&fsl_lpspi->dma_rx_completion);
>         dma_async_issue_pending(controller->dma_rx);
> @@ -648,8 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controll=
er *controller,
>                 return -EINVAL;
>         }
>
> -       desc_tx->callback =3D fsl_lpspi_dma_tx_callback;
> -       desc_tx->callback_param =3D (void *)fsl_lpspi;
> +       dmaengine_desc_set_callback(desc_tx, fsl_lpspi_dma_tx_callback, N=
ULL, (void *)fsl_lpspi);
>         dmaengine_submit(desc_tx);
>         reinit_completion(&fsl_lpspi->dma_tx_completion);
>         dma_async_issue_pending(controller->dma_tx);
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 91e75e213f929..e239c4333055b 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -506,8 +506,7 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, =
struct spi_geni_master *mas
>                 return -EIO;
>         }
>
> -       tx_desc->callback_result =3D spi_gsi_callback_result;
> -       tx_desc->callback_param =3D spi;
> +       dmaengine_desc_set_callback(tx_desc, NULL, spi_gsi_callback_resul=
t, spi);
>
>         if (peripheral.cmd & SPI_RX)
>                 dmaengine_submit(rx_desc);
> diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
> index 76dcb283d1225..53370cff7e2cd 100644
> --- a/drivers/spi/spi-img-spfi.c
> +++ b/drivers/spi/spi-img-spfi.c
> @@ -334,8 +334,7 @@ static int img_spfi_start_dma(struct spi_controller *=
host,
>                 if (!rxdesc)
>                         goto stop_dma;
>
> -               rxdesc->callback =3D img_spfi_dma_rx_cb;
> -               rxdesc->callback_param =3D spfi;
> +               dmaengine_desc_set_callback(rxdesc, img_spfi_dma_rx_cb, N=
ULL, spfi);
>         }
>
>         if (xfer->tx_buf) {
> @@ -358,8 +357,7 @@ static int img_spfi_start_dma(struct spi_controller *=
host,
>                 if (!txdesc)
>                         goto stop_dma;
>
> -               txdesc->callback =3D img_spfi_dma_tx_cb;
> -               txdesc->callback_param =3D spfi;
> +               dmaengine_desc_set_callback(txdesc, img_spfi_dma_tx_cb, N=
ULL, spfi);
>         }
>
>         if (xfer->rx_buf) {
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index cadf0b93f4403..f8a3ac11f49d0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1738,8 +1738,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *=
spi_imx,
>                 return -EINVAL;
>         }
>
> -       desc_rx->callback =3D spi_imx_dma_rx_callback;
> -       desc_rx->callback_param =3D (void *)spi_imx;
> +       dmaengine_desc_set_callback(desc_rx, spi_imx_dma_rx_callback, NUL=
L, (void *)spi_imx);
>         cookie =3D dmaengine_submit(desc_rx);
>         if (dma_submit_error(cookie)) {
>                 dev_err(spi_imx->dev, "submitting DMA RX failed\n");
> @@ -1756,8 +1755,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *=
spi_imx,
>         if (!desc_tx)
>                 goto dmaengine_terminate_rx;
>
> -       desc_tx->callback =3D spi_imx_dma_tx_callback;
> -       desc_tx->callback_param =3D (void *)spi_imx;
> +       dmaengine_desc_set_callback(desc_tx, spi_imx_dma_tx_callback, NUL=
L, (void *)spi_imx);
>         cookie =3D dmaengine_submit(desc_tx);
>         if (dma_submit_error(cookie)) {
>                 dev_err(spi_imx->dev, "submitting DMA TX failed\n");
> diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
> index a0a047510611e..9567ddde06ef0 100644
> --- a/drivers/spi/spi-ingenic.c
> +++ b/drivers/spi/spi-ingenic.c
> @@ -157,8 +157,7 @@ spi_ingenic_prepare_dma(struct spi_controller *ctlr, =
struct dma_chan *chan,
>                 return ERR_PTR(-ENOMEM);
>
>         if (dir =3D=3D DMA_DEV_TO_MEM) {
> -               desc->callback =3D spi_ingenic_finalize_transfer;
> -               desc->callback_param =3D ctlr;
> +               dmaengine_desc_set_callback(desc, spi_ingenic_finalize_tr=
ansfer, NULL, ctlr);
>         }
>
>         cookie =3D dmaengine_submit(desc);
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index fda1d260b2966..eabea73a19fc7 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -267,8 +267,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
>          * The last descriptor must have this callback,
>          * to finish the DMA transaction.
>          */
> -       desc->callback =3D mxs_ssp_dma_irq_callback;
> -       desc->callback_param =3D spi;
> +       dmaengine_desc_set_callback(desc, mxs_ssp_dma_irq_callback, NULL,=
 spi);
>
>         /* Start the transfer. */
>         dmaengine_submit(desc);
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 38c8d6269aadd..e532b2da54835 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -872,8 +872,7 @@ static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xsp=
i,
>                 goto err_unmap_src;
>         }
>
> -       desc->callback =3D nxp_xspi_dma_rx_callback;
> -       desc->callback_param =3D xspi;
> +       dmaengine_desc_set_callback(desc, nxp_xspi_dma_rx_callback, NULL,=
 xspi);
>         reinit_completion(&xspi->dma_rx_c);
>         dmaengine_submit(desc);
>         dma_async_issue_pending(chan);
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.=
c
> index e46b1d9c8cd08..56fc8211a752f 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -436,8 +436,7 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
>         if (!tx)
>                 return -EIO;
>
> -       tx->callback =3D omap2_mcspi_tx_callback;
> -       tx->callback_param =3D spi;
> +       dmaengine_desc_set_callback(tx, omap2_mcspi_tx_callback, NULL, sp=
i);
>
>         return dma_submit_error(dmaengine_submit(tx));
>  }
> @@ -525,8 +524,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi=
_transfer *xfer,
>                 goto out_free_sg;
>         }
>
> -       tx->callback =3D omap2_mcspi_rx_callback;
> -       tx->callback_param =3D spi;
> +       dmaengine_desc_set_callback(tx, omap2_mcspi_rx_callback, NULL, sp=
i);
>         ret =3D dma_submit_error(dmaengine_submit(tx));
>         if (ret)
>                 goto out_free_sg;
> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
> index 8363bc873b03a..b6a6929cbb0c2 100644
> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -330,8 +330,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *p=
ic32s,
>         }
>
>         /* Put callback on the RX transfer, that should finish last */
> -       desc_rx->callback =3D pic32_spi_dma_rx_notify;
> -       desc_rx->callback_param =3D pic32s;
> +       dmaengine_desc_set_callback(desc_rx, pic32_spi_dma_rx_notify, NUL=
L, pic32s);
>
>         cookie =3D dmaengine_submit(desc_rx);
>         ret =3D dma_submit_error(cookie);
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 3ff30486b2892..9f98f95bb534c 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -956,8 +956,7 @@ static int configure_dma(struct pl022 *pl022)
>                 goto err_txdesc;
>
>         /* Put the callback on the RX transfer only, that should finish l=
ast */
> -       rxdesc->callback =3D dma_callback;
> -       rxdesc->callback_param =3D pl022;
> +       dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, pl022);
>
>         /* Submit and fire RX and TX with TX last so we're ready to read!=
 */
>         dmaengine_submit(rxdesc);
> diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
> index c94d1d192e743..0e7ad7fb48eb2 100644
> --- a/drivers/spi/spi-pxa2xx-dma.c
> +++ b/drivers/spi/spi-pxa2xx-dma.c
> @@ -154,8 +154,7 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_da=
ta,
>         }
>
>         /* We are ready when RX completes */
> -       rx_desc->callback =3D pxa2xx_spi_dma_callback;
> -       rx_desc->callback_param =3D drv_data;
> +       dmaengine_desc_set_callback(rx_desc, pxa2xx_spi_dma_callback, NUL=
L, drv_data);
>
>         dmaengine_submit(rx_desc);
>         dmaengine_submit(tx_desc);
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index e8b076b1622d3..6be0b942d7c4e 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -429,8 +429,7 @@ static int spi_qup_prep_sg(struct spi_controller *hos=
t, struct scatterlist *sgl,
>         if (IS_ERR_OR_NULL(desc))
>                 return desc ? PTR_ERR(desc) : -EINVAL;
>
> -       desc->callback =3D callback;
> -       desc->callback_param =3D qup;
> +       dmaengine_desc_set_callback(desc, callback, NULL, qup);
>
>         cookie =3D dmaengine_submit(desc);
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 1a81fd94b4396..f8d6cea2f3dad 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -475,8 +475,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_s=
pi *rs,
>                 if (!rxdesc)
>                         return -EINVAL;
>
> -               rxdesc->callback =3D rockchip_spi_dma_rxcb;
> -               rxdesc->callback_param =3D ctlr;
> +               dmaengine_desc_set_callback(rxdesc, rockchip_spi_dma_rxcb=
, NULL, ctlr);
>         }
>
>         txdesc =3D NULL;
> @@ -500,8 +499,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_s=
pi *rs,
>                         return -EINVAL;
>                 }
>
> -               txdesc->callback =3D rockchip_spi_dma_txcb;
> -               txdesc->callback_param =3D ctlr;
> +               dmaengine_desc_set_callback(txdesc, rockchip_spi_dma_txcb=
, NULL, ctlr);
>         }
>
>         /* rx must be started before tx due to spi instinct */
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index c61edd1c1353b..5e03a186e9e79 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -553,8 +553,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, =
struct sg_table *tx,
>                         goto no_dma_rx;
>                 }
>
> -               desc_rx->callback =3D rspi_dma_complete;
> -               desc_rx->callback_param =3D rspi;
> +               dmaengine_desc_set_callback(desc_rx, rspi_dma_complete, N=
ULL, rspi);
>                 cookie =3D dmaengine_submit(desc_rx);
>                 if (dma_submit_error(cookie)) {
>                         ret =3D cookie;
> @@ -577,8 +576,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, =
struct sg_table *tx,
>                         /* No callback */
>                         desc_tx->callback =3D NULL;
>                 } else {
> -                       desc_tx->callback =3D rspi_dma_complete;
> -                       desc_tx->callback_param =3D rspi;
> +                       dmaengine_desc_set_callback(desc_tx, rspi_dma_com=
plete, NULL, rspi);
>                 }
>                 cookie =3D dmaengine_submit(desc_tx);
>                 if (dma_submit_error(cookie)) {
> diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
> index daa4239b0fe04..f17b6d3da5de7 100644
> --- a/drivers/spi/spi-rzv2h-rspi.c
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> @@ -295,8 +295,7 @@ rzv2h_rspi_setup_dma_channel(struct rzv2h_rspi_priv *=
rspi,
>                 return ERR_PTR(-EAGAIN);
>
>         if (direction =3D=3D DMA_DEV_TO_MEM) {
> -               desc->callback =3D rzv2h_rspi_dma_complete;
> -               desc->callback_param =3D rspi;
> +               dmaengine_desc_set_callback(desc, rzv2h_rspi_dma_complete=
, NULL, rspi);
>         }
>
>         return desc;
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 58e306cc730fc..d24b95212ecd8 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -338,8 +338,7 @@ static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma=
_data *dma,
>                 return -ENOMEM;
>         }
>
> -       desc->callback =3D s3c64xx_spi_dmacb;
> -       desc->callback_param =3D dma;
> +       dmaengine_desc_set_callback(desc, s3c64xx_spi_dmacb, NULL, dma);
>
>         dma->cookie =3D dmaengine_submit(desc);
>         ret =3D dma_submit_error(dma->cookie);
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 89fbdde46cfe9..557c645fcebc6 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -665,8 +665,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv=
 *p, const void *tx,
>                 if (!desc_rx)
>                         return -EAGAIN;
>
> -               desc_rx->callback =3D sh_msiof_dma_complete;
> -               desc_rx->callback_param =3D &p->done;
> +               dmaengine_desc_set_callback(desc_rx, sh_msiof_dma_complet=
e, NULL, &p->done);
>                 cookie =3D dmaengine_submit(desc_rx);
>                 if (dma_submit_error(cookie))
>                         return cookie;
> @@ -684,8 +683,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv=
 *p, const void *tx,
>                         goto no_dma_tx;
>                 }
>
> -               desc_tx->callback =3D sh_msiof_dma_complete;
> -               desc_tx->callback_param =3D &p->done_txdma;
> +               dmaengine_desc_set_callback(desc_tx, sh_msiof_dma_complet=
e, NULL, &p->done_txdma);
>                 cookie =3D dmaengine_submit(desc_tx);
>                 if (dma_submit_error(cookie)) {
>                         ret =3D cookie;
> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.=
c
> index d03a93d149ecc..c9bf925ee3521 100644
> --- a/drivers/spi/spi-spacemit-k1.c
> +++ b/drivers/spi/spi-spacemit-k1.c
> @@ -294,8 +294,7 @@ static int k1_spi_dma_one(struct spi_controller *host=
, struct spi_device *spi,
>         }
>
>         /* When RX is complete we also know TX has completed */
> -       rxdesc->callback =3D k1_spi_dma_callback;
> -       rxdesc->callback_param =3D drv_data;
> +       dmaengine_desc_set_callback(rxdesc, k1_spi_dma_callback, NULL, dr=
v_data);
>
>         dmaengine_submit(txdesc);
>         dmaengine_submit(rxdesc);
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index fa0e8e83cb1be..4e202d74c9926 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -374,8 +374,7 @@ static int stm32_ospi_tx_dma(struct stm32_ospi *ospi,
>         cr =3D readl_relaxed(regs_base + OSPI_CR);
>
>         reinit_completion(&ospi->dma_completion);
> -       desc->callback =3D stm32_ospi_dma_callback;
> -       desc->callback_param =3D &ospi->dma_completion;
> +       dmaengine_desc_set_callback(desc, stm32_ospi_dma_callback, NULL, =
&ospi->dma_completion);
>         cookie =3D dmaengine_submit(desc);
>         err =3D dma_submit_error(cookie);
>         if (err)
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index b77daba6db83a..f9865720c6dd3 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -265,8 +265,7 @@ static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
>         cr =3D readl_relaxed(qspi->io_base + QSPI_CR);
>
>         reinit_completion(&qspi->dma_completion);
> -       desc->callback =3D stm32_qspi_dma_callback;
> -       desc->callback_param =3D &qspi->dma_completion;
> +       dmaengine_desc_set_callback(desc, stm32_qspi_dma_callback, NULL, =
&qspi->dma_completion);
>         cookie =3D dmaengine_submit(desc);
>         err =3D dma_submit_error(cookie);
>         if (err)
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 4c3ae546afc05..66932400cf570 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1690,11 +1690,9 @@ static int stm32_spi_transfer_one_dma(struct stm32=
_spi *spi,
>
>         if (rx_dma_desc) {
>                 if (rx_mdma_desc) {
> -                       rx_mdma_desc->callback =3D spi->cfg->dma_rx_cb;
> -                       rx_mdma_desc->callback_param =3D spi;
> +                       dmaengine_desc_set_callback(rx_mdma_desc, spi->cf=
g->dma_rx_cb, NULL, spi);
>                 } else {
> -                       rx_dma_desc->callback =3D spi->cfg->dma_rx_cb;
> -                       rx_dma_desc->callback_param =3D spi;
> +                       dmaengine_desc_set_callback(rx_dma_desc, spi->cfg=
->dma_rx_cb, NULL, spi);
>                 }
>
>                 /* Enable Rx DMA request */
> @@ -1719,8 +1717,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_=
spi *spi,
>         if (tx_dma_desc) {
>                 if (spi->cur_comm =3D=3D SPI_SIMPLEX_TX ||
>                     spi->cur_comm =3D=3D SPI_3WIRE_TX) {
> -                       tx_dma_desc->callback =3D spi->cfg->dma_tx_cb;
> -                       tx_dma_desc->callback_param =3D spi;
> +                       dmaengine_desc_set_callback(tx_dma_desc, spi->cfg=
->dma_tx_cb, NULL, spi);
>                 }
>
>                 if (dma_submit_error(dmaengine_submit(tx_dma_desc))) {
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 6b7a05dd0de8a..e9fce8618299a 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -232,8 +232,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *ss=
pi,
>                                                  DMA_PREP_INTERRUPT);
>                 if (!rxdesc)
>                         return -EINVAL;
> -               rxdesc->callback_param =3D sspi;
> -               rxdesc->callback =3D sun6i_spi_dma_rx_cb;
> +               dmaengine_desc_set_callback(rxdesc, sun6i_spi_dma_rx_cb, =
NULL, sspi);
>         }
>
>         txdesc =3D NULL;
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index f43f2df478b45..ffe547d1e3af3 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -480,8 +480,7 @@ static int tegra_spi_start_tx_dma(struct tegra_spi_da=
ta *tspi, int len)
>                 return -EIO;
>         }
>
> -       tspi->tx_dma_desc->callback =3D tegra_spi_dma_complete;
> -       tspi->tx_dma_desc->callback_param =3D &tspi->tx_dma_complete;
> +       dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_spi_dma_comp=
lete, NULL, &tspi->tx_dma_complete);
>
>         dmaengine_submit(tspi->tx_dma_desc);
>         dma_async_issue_pending(tspi->tx_dma_chan);
> @@ -499,8 +498,7 @@ static int tegra_spi_start_rx_dma(struct tegra_spi_da=
ta *tspi, int len)
>                 return -EIO;
>         }
>
> -       tspi->rx_dma_desc->callback =3D tegra_spi_dma_complete;
> -       tspi->rx_dma_desc->callback_param =3D &tspi->rx_dma_complete;
> +       dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_spi_dma_comp=
lete, NULL, &tspi->rx_dma_complete);
>
>         dmaengine_submit(tspi->rx_dma_desc);
>         dma_async_issue_pending(tspi->rx_dma_chan);
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-sl=
ink.c
> index ed1fcf57dd30d..5aca26549e730 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -440,8 +440,7 @@ static int tegra_slink_start_tx_dma(struct tegra_slin=
k_data *tspi, int len)
>                 return -EIO;
>         }
>
> -       tspi->tx_dma_desc->callback =3D tegra_slink_dma_complete;
> -       tspi->tx_dma_desc->callback_param =3D &tspi->tx_dma_complete;
> +       dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_slink_dma_co=
mplete, NULL, &tspi->tx_dma_complete);
>
>         dmaengine_submit(tspi->tx_dma_desc);
>         dma_async_issue_pending(tspi->tx_dma_chan);
> @@ -459,8 +458,7 @@ static int tegra_slink_start_rx_dma(struct tegra_slin=
k_data *tspi, int len)
>                 return -EIO;
>         }
>
> -       tspi->rx_dma_desc->callback =3D tegra_slink_dma_complete;
> -       tspi->rx_dma_desc->callback_param =3D &tspi->rx_dma_complete;
> +       dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_slink_dma_co=
mplete, NULL, &tspi->rx_dma_complete);
>
>         dmaengine_submit(tspi->rx_dma_desc);
>         dma_async_issue_pending(tspi->rx_dma_chan);
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-q=
uad.c
> index d8cca3aa276b2..95132d8be9dd6 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -522,8 +522,7 @@ static int tegra_qspi_start_tx_dma(struct tegra_qspi =
*tqspi, struct spi_transfer
>                 return -EIO;
>         }
>
> -       tqspi->tx_dma_desc->callback =3D tegra_qspi_dma_complete;
> -       tqspi->tx_dma_desc->callback_param =3D &tqspi->tx_dma_complete;
> +       dmaengine_desc_set_callback(tqspi->tx_dma_desc, tegra_qspi_dma_co=
mplete, NULL, &tqspi->tx_dma_complete);
>         dmaengine_submit(tqspi->tx_dma_desc);
>         dma_async_issue_pending(tqspi->tx_dma_chan);
>
> @@ -550,8 +549,7 @@ static int tegra_qspi_start_rx_dma(struct tegra_qspi =
*tqspi, struct spi_transfer
>                 return -EIO;
>         }
>
> -       tqspi->rx_dma_desc->callback =3D tegra_qspi_dma_complete;
> -       tqspi->rx_dma_desc->callback_param =3D &tqspi->rx_dma_complete;
> +       dmaengine_desc_set_callback(tqspi->rx_dma_desc, tegra_qspi_dma_co=
mplete, NULL, &tqspi->rx_dma_complete);
>         dmaengine_submit(tqspi->rx_dma_desc);
>         dma_async_issue_pending(tqspi->rx_dma_chan);
>
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 091a8b8842f58..0083160c15fea 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -452,8 +452,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma=
_addr_t dma_dst,
>                 return -EIO;
>         }
>
> -       tx->callback =3D ti_qspi_dma_callback;
> -       tx->callback_param =3D qspi;
> +       dmaengine_desc_set_callback(tx, ti_qspi_dma_callback, NULL, qspi)=
;
>         cookie =3D dmaengine_submit(tx);
>         reinit_completion(&qspi->transfer_complete);
>
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pc=
h.c
> index eb3485149e75a..fdda26eb311fb 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -1021,8 +1021,7 @@ static void pch_spi_handle_dma(struct pch_spi_data =
*data, int *bpw)
>                 return;
>         }
>         dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_FROM_DEVICE=
);
> -       desc_rx->callback =3D pch_dma_rx_complete;
> -       desc_rx->callback_param =3D data;
> +       dmaengine_desc_set_callback(desc_rx, pch_dma_rx_complete, NULL, d=
ata);
>         dma->nent =3D num;
>         dma->desc_rx =3D desc_rx;
>
> @@ -1083,8 +1082,7 @@ static void pch_spi_handle_dma(struct pch_spi_data =
*data, int *bpw)
>                 return;
>         }
>         dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_TO_DEVICE);
> -       desc_tx->callback =3D NULL;
> -       desc_tx->callback_param =3D data;
> +       dmaengine_desc_set_callback(desc_tx, NULL, NULL, data);
>         dma->nent =3D num;
>         dma->desc_tx =3D desc_tx;
>
> diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
> index 86fce9a571dab..e8344a66e4361 100644
> --- a/drivers/spi/spi-uniphier.c
> +++ b/drivers/spi/spi-uniphier.c
> @@ -418,8 +418,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_c=
ontroller *host,
>                 if (!rxdesc)
>                         goto out_err_prep;
>
> -               rxdesc->callback =3D uniphier_spi_dma_rxcb;
> -               rxdesc->callback_param =3D host;
> +               dmaengine_desc_set_callback(rxdesc, uniphier_spi_dma_rxcb=
, NULL, host);
>
>                 uniphier_spi_irq_enable(priv, SSI_IE_RXRE);
>                 atomic_or(SSI_DMA_RX_BUSY, &priv->dma_busy);
> @@ -445,8 +444,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_c=
ontroller *host,
>                 if (!txdesc)
>                         goto out_err_prep;
>
> -               txdesc->callback =3D uniphier_spi_dma_txcb;
> -               txdesc->callback_param =3D host;
> +               dmaengine_desc_set_callback(txdesc, uniphier_spi_dma_txcb=
, NULL, host);
>
>                 uniphier_spi_irq_enable(priv, SSI_IE_TXRE);
>                 atomic_or(SSI_DMA_TX_BUSY, &priv->dma_busy);
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
