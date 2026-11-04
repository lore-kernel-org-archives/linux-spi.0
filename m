Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813155;
	b=GOZ0WjJ/m5NfWm6KqVy3URE/rFqGtKso0A+FF6tiXPLNWIdFIvA+W3PO2KDGRbwDdHYd
	 OeJ96L+/8AmfmPinIeFmOXakGUnOFmNufmr4ORzCMmW/G0jbV18fgbLd+N/KQD8ytt0Gl
	 HOplemdP4U/BqsxcVgFX1dtxH7AymZeIfXTBHfsrepQBUh4vs2Mlx/R0b/zpa3ZE2RNwy
	 006N6EFBzM5vbkCWRCJ5YYozwnGHsmZXm3eZW/vvnXUxmYchE+SdYELQhl9i6qq+0ZVpB
	 NQ5ywS7CajOXAheIC8hDpp3TD0YuNaop7tc0/JReCarcyVIEq7uxZho+h+sBuis7sGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813155;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jUACR3WdNvp+1mq8YkWwlDzJHU0/aXZ2xaR7a5aW9T4=;
	b=xoAI7sMWyLsz4hK/I3HcKLOf6M1MOSJiF+z+BHZKYNkmPZGI5xC45pIjmCHzBh5WFAUc
	 0eWT7y1+VHlCSaC5OHLHeBABQsPUyEZkb8iSGdI3Jz1LXwH3qV3vwDl3IabqE9C7LjoeZ
	 rbg3Hn2t7aDm/A9vwCvZK9d+bEJVREht9oOuARQUQMkt2U+ZzhLKQKiGxBdlm6snZ1BCG
	 47ajGqQL8zuXF80JY0F1KbgbFscvWT8j/ch4X+nm4N2nygZIZj8HR95ulNVHgykGeDOwm
	 QkUUyNB05unEbJohI3dmfQNbdYro2a8rMCGtdh37oN1lP6h+jPnDxgAlCTgr6M3MfBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfAzDDAp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A70606A328;
	Wed,  4 Nov 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfAzDDAp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9981F0093A;
	Wed,  4 Nov 2026 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813154;
	bh=jUACR3WdNvp+1mq8YkWwlDzJHU0/aXZ2xaR7a5aW9T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DfAzDDApnZkst84u7igt5Tzo7p4bRP0TTyZOpD01uW9oDYaPqSC4UwI5YnnoJr0sL
	 4ST/bkJo4aKiNSk3I0lRgaJOcFJLtsdyGWg65cQQgNA1oi5jxGTkpEzsjutDWwevEx
	 yAFw0fwRhfwtEX8uaY8A85xDppxBOCrlg7wuQsk8m5Xz6nwM09YNMO3+eBvmSCpSsP
	 cOc2yJg3Ut1tMjuZ4UfR2K8YEfsaeKcjH9LemW6vRrRWpfg2EJj7swGN17IQ1WZ5hX
	 Sevn9M5IVKfYR8JxofvDqRGg7w58C2sVKXpEPQNvbvrQ7z6MNIk+msfVAQNFAoXFSP
	 Qeqahu2f8xWmA==
Message-ID: <b656861c-a087-4087-952e-91fd15fadd52@kernel.org>
Date: Wed, 4 Nov 2026 18:25:32 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com, Mark Brown <broonie@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Radu Pirea <radu_nicolae.pirea@upb.ro>, CL Wang <cl634@andestech.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vladimir Oltean
 <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Heiko Stuebner <heiko@sntech.de>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Andi Shyti <andi.shyti@kernel.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Laxman Dewangan
 <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>,
 "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 "open list:RENESAS RZ/V2H(P) RSPI DRIVER"
 <linux-renesas-soc@vger.kernel.org>,
 "open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Thierry Reding <treding@nvidia.com>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 16:22, Frank.Li@oss.nxp.com wrote:
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
>  drivers/spi/spi-rspi.c            | 8 +++-----
>  drivers/spi/spi-rzv2h-rspi.c      | 3 +--
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
>  38 files changed, 57 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 762a3fb0fca81..de205e04a8600 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -790,8 +790,7 @@ static int atmel_qspi_dma_xfer(struct atmel_qspi *aq, struct dma_chan *chan,
>  	}
>  
>  	reinit_completion(&aq->dma_completion);
> -	tx->callback = atmel_qspi_dma_callback;
> -	tx->callback_param = aq;
> +	dmaengine_desc_set_callback(tx, atmel_qspi_dma_callback, NULL, aq);

Andy,
These three lines look correct.

LGTM:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
