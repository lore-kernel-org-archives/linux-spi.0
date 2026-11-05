Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875087;
	b=ZJDq1HRefb8fV0S07iyL2n098fUnCBqagm0nMshFub3zMae5kvgXQ4htzQMauGKQ2wAt
	 WoWhowP4GMv4Ur0/GkaRmxL49qLq7RFTAbXEZS76pMseUrXQ8a29lRodiLiqIKegFA6Hb
	 wr7triD3vlZCMG/U4DBTytsnmztThK4u0al6Rsap1Om2ED48Yi6SDoHuT/0OXmbPkShox
	 ZDSDwK6qrNqO4sDp/+KsWrDZpjZjgdtHswIOS7bqyiDwX9qlmfcMXcfTirNDQzObDW3FT
	 Y99z7gu4JVV9TcNzh8E1xvZ/lIz8u7WmrxIixYIlWCPzLbdeXNKg2DMeSVfuuWTWrZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875087;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=Kb0CzJzsHsZ+UWHQAp2uA/S+bpBIx9myNk0nvO3EvbQ=;
	b=SiziMTp/xXZFAqLWyYjoKVeKiLPBcOc1RgBmDqxqUJMmt+wFXQ4ENiFUc8xV2AA5p/hV
	 5ZbuqVeHlNM+Fz9p2f89OvJ3QyNXxsdPhyjLUKyEYZQNhkCb2mWrsFYblx+DNJBTkBtwv
	 aGUVK3LeScZ1gQGgB9KuTmO+4cb2M6kuvua9zp5kxJQ+RgvoV/wP4m0YC+M/OIT0P8LEa
	 /EEUSqS5fCImEtjObR+0eg/7sLOPDFxTNJbs2GC1tweqcnzjPgsYiSGQ229YWvrxhDsbc
	 qeA/1zwJ5CyyzACFK4XsunPvvfTfqJcXjZYZOStgNibJ9OENk/KLygvVG2OoNnDOvxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4rKjlRB;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B4606A326;
	Thu,  5 Nov 2026 10:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4rKjlRB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793875087; x=1825411087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eqO4A+ClsqjEqfXPQ0TFlIOZ+1UsCC9oIYRbbnK4e7s=;
  b=A4rKjlRBVFVKIEQC4EavgCR17/xSyjTrOEB2Tb84HNkL6B9y4XJRT1QM
   iUwkaAxPJL3QUyzkBOA2luwvYVxfQEtYxAZEW+GgljOK2viemRDECySII
   WP7y3aEe+2a85svsfCglP2dbIrcCrEpO3+UJsHfe9yqiygMRa6YlwWPEW
   SH/E8Be2sTsitocPTdbj6RjtMQXjuD7nznitbEIfRXlPNJPABOF93RqS8
   OPhcFvq5cMM3UjilmzE5ltY/OlPLJqNBytdS6Dli+9Pk356d8cgqYZwW5
   whsC1IhkOREAn7phf37f1DlJwQbvCLs1O+8Yiwt+HbJIKiDSNPAN1i8lB
   g==;
X-CSE-ConnectionGUID: B8xcpbARSGSwQZmhBQ2uSA==
X-CSE-MsgGUID: WkGLZSL4SyOFx13P6djZZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2560338"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2560338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:38:06 -0800
X-CSE-ConnectionGUID: xIegnpX+Sr+k5gjNuD4pbQ==
X-CSE-MsgGUID: Wcy7neyfQa2lUKLW6Cyinw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7281977"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:37:54 -0800
Date: Thu, 5 Nov 2026 12:37:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
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
	Frank.Li@oss.nxp.com, vkoul@kernel.org
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <auxcf206A1yMnHkX@ashevche-desk.local>
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
 <2154003.0S5aU1g85B@diego>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2154003.0S5aU1g85B@diego>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 10:52:38AM +0100, Heiko Stübner wrote:
> Am Montag, 2. November 2026, 18:39:58 Mitteleuropäische Normalzeit schrieb Frank.Li@oss.nxp.com:
> > 
> > Replace open-coded assignments to callback and callback_param fields
> > of struct dma_async_tx_descriptor with calls to the
> > dmaengine_desc_set_callback() helper across SPI bus drivers.
> > 
> > No functional change intended. Prepare make to struct
> > dma_async_tx_descriptor private to the DMA engine.

[...]

> > diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> > index 1a81fd94b4396..f8d6cea2f3dad 100644
> > --- a/drivers/spi/spi-rockchip.c
> > +++ b/drivers/spi/spi-rockchip.c
> > @@ -475,8 +475,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
> >  		if (!rxdesc)
> >  			return -EINVAL;
> >  
> > -		rxdesc->callback = rockchip_spi_dma_rxcb;
> > -		rxdesc->callback_param = ctlr;
> > +		dmaengine_desc_set_callback(rxdesc, rockchip_spi_dma_rxcb, NULL, ctlr);
> >  	}
> >  
> >  	txdesc = NULL;
> > @@ -500,8 +499,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
> >  			return -EINVAL;
> >  		}
> >  
> > -		txdesc->callback = rockchip_spi_dma_txcb;
> > -		txdesc->callback_param = ctlr;
> > +		dmaengine_desc_set_callback(txdesc, rockchip_spi_dma_txcb, NULL, ctlr);
> >  	}
> >  
> >  	/* rx must be started before tx due to spi instinct */
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Please, use "# subpart(s)" syntax with this tag

   Reviewed-by: Heiko Stuebner <heiko@sntech.de> # rockchip

-- 
With Best Regards,
Andy Shevchenko


