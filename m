Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811449;
	b=Kzno2SZtbazCqLnh0IHFItgIFlFqFLgkoSV4k94DEGDVKDfPptpwShZKsQp7ssIWXXt4
	 L+QJ7MIUzFWVkOv3aCFU/oYo9KIdQCWKkEoKJwdvORdmF3bCuVkTpkS0DdgsXWbHJjEXg
	 EnbuJCJtSa3fao/4TbmK/5/GHvGdFacR2D8EncbFNt7e4bQuQ7iS2HBckiytnA3FINrS8
	 StriIMBzq1ZZ/a80W2bsKczC1dNnnUY1v/qEEpPMSX7acckzPa9NU3fYnPZZxvgHRRxjy
	 /M+gom6dBx/h6+Wz90reQWr2NckrtYHO2THn2oVZ8R9jhnIMwL12GikbP4TaRzeDjfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811449;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8izICEiwnQYZgjlS2jA+WnZteNa4n7VbKpZ/O6pW3kg=;
	b=d9wDYtR/jjO3iBJ8RL2h8F5Qs+RwqIsL6OEdhsypZ59Ma8Nv9BX6C59WyU8NIBCSHuRH
	 9+kpr//B01lR+NG+euz92IkM7qQfpMJehYsnkSASHxte/M0Icb+Hxg+z53YgROR8bO9HE
	 /u+pShf9oELvOhUTUqzXAtq9TDUtc/An0KmEuJw7F/EMvE/to1u8BHAuUEG4mySNNySjo
	 SLxmilefWRAeCGVFt+5WADY5xlknhCgMKSaUzGIhFe+MIkBDA3ImePqlgOyKfsLsty8Gx
	 daYcQrKoKn16ynPiEpGhQWbg0zxjllpw7J2vDbeDrVe2khncsMtob93lsH9w4B41qgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFu+4Fcc;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF1606A332;
	Wed,  4 Nov 2026 16:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFF1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFu+4Fcc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793811450; x=1825347450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kA+R8pE/sj6tJF3qdsiBNT3subr7oV44Dq41fpFh520=;
  b=kFu+4FccF4mwUg+lujbS5S2z+QsSmjNhZ2VXE9pkRUGU5JFaHhAYGvqD
   2m2d8WwUUduzhkv25AeyGq18y54cB2L2uwYz+0iORYVvJTVVqTvdzFX//
   nY/LI7ZovPrR1J/Ai8kBe7wWWVYp/ULULxkbABr1DAiW55rj7hOf7G6gZ
   WmDtFd7z6TbAA9Sx7emazezcXk6wyGhs6R9EPg4judjPYKUoCeL8ToSJa
   3CitTzz5hVIteV4+ew2YrFRFmrpP9KOFL1SzmRjSdGs8owXQpa5mnZ86b
   oA3jcPhvKxK5Rvl0dLUipiF0DGa6BFYUhPbp38L1Oxg0Ubz/xy5n/6N/x
   g==;
X-CSE-ConnectionGUID: yAIgH109T4WDBp+q75bbnA==
X-CSE-MsgGUID: 13q1h3DKRZ+6UUAhKS5/xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2455735"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2455735"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 08:57:29 -0800
X-CSE-ConnectionGUID: i6LkdCHBS8aHv+axP23p/Q==
X-CSE-MsgGUID: bTVdwHnSQh2Pf9cSJkKNSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7158496"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 08:57:16 -0800
Date: Wed, 4 Nov 2026 18:57:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	CL Wang <cl634@andestech.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Heiko Stuebner <heiko@sntech.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <autj6pr_bPaul3w0@ashevche-desk.local>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 10:22:45AM -0500, Frank.Li@oss.nxp.com wrote:
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across SPI bus drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # dw, pxa2xx, topcliff-pch

(Note, you forgot to add the list of the drivers to the Rb trailers of other reviewers)

>  drivers/spi/spi-dw-dma.c          | 6 ++----
>  drivers/spi/spi-pxa2xx-dma.c      | 3 +--
>  drivers/spi/spi-topcliff-pch.c    | 6 ++----

> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -397,8 +397,7 @@ static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct scatterlist *sgl,
>  	if (!txdesc)
>  		return -ENOMEM;
>  
> -	txdesc->callback = dw_spi_dma_tx_done;
> -	txdesc->callback_param = dws;
> +	dmaengine_desc_set_callback(txdesc, dw_spi_dma_tx_done, NULL, dws);
>  
>  	cookie = dmaengine_submit(txdesc);
>  	ret = dma_submit_error(cookie);
> @@ -498,8 +497,7 @@ static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct scatterlist *sgl,
>  	if (!rxdesc)
>  		return -ENOMEM;
>  
> -	rxdesc->callback = dw_spi_dma_rx_done;
> -	rxdesc->callback_param = dws;
> +	dmaengine_desc_set_callback(rxdesc, dw_spi_dma_rx_done, NULL, dws);
>  
>  	cookie = dmaengine_submit(rxdesc);
>  	ret = dma_submit_error(cookie);

> --- a/drivers/spi/spi-pxa2xx-dma.c
> +++ b/drivers/spi/spi-pxa2xx-dma.c
> @@ -154,8 +154,7 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data,
>  	}
>  
>  	/* We are ready when RX completes */
> -	rx_desc->callback = pxa2xx_spi_dma_callback;
> -	rx_desc->callback_param = drv_data;
> +	dmaengine_desc_set_callback(rx_desc, pxa2xx_spi_dma_callback, NULL, drv_data);
>  
>  	dmaengine_submit(rx_desc);
>  	dmaengine_submit(tx_desc);

> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -1022,8 +1022,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
>  		return;
>  	}
>  	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_FROM_DEVICE);
> -	desc_rx->callback = pch_dma_rx_complete;
> -	desc_rx->callback_param = data;
> +	dmaengine_desc_set_callback(desc_rx, pch_dma_rx_complete, NULL, data);
>  	dma->nent = num;
>  	dma->desc_rx = desc_rx;
>  
> @@ -1084,8 +1083,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
>  		return;
>  	}
>  	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_TO_DEVICE);
> -	desc_tx->callback = NULL;
> -	desc_tx->callback_param = data;
> +	dmaengine_desc_set_callback(desc_tx, NULL, NULL, data);

Yeah, data can be replaced by NULL as has been already mentioned.

>  	dma->nent = num;
>  	dma->desc_tx = desc_tx;
>  

-- 
With Best Regards,
Andy Shevchenko


