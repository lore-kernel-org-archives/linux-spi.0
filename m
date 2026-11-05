Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871395;
	b=Japir2uKetNtfnm/QS6Llug69ZoaxTBBVVbL2Zxp8bdu9hwmVSsnuRBzQtVcJsvJT70t
	 xXPLbrsbIdVYAjxj4OC1IMIq1GKliQkSX+p5Qa3HUMKfzxHUp5luGpCWGi/FHJpZRFl8U
	 vJ5gihwiKIvN4mI0Oa19VnhzfAnliz+FVUdat+yU97ecnk2WpSyUNht24KFm8WWgvKZap
	 3ToMtEyT60Xrw5YG8DS8xFY0WdEfaLUwwPXY0Qc58k6JKiB4gtBARNcVWefF8tLqFT66/
	 Z78kCtUeB1Wn8TDmTClSdallGNkA2mzFijIsxMPGlO8IszKb1BZTfW6KUmn5BEmAN7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=amOrn2BM3j3WAFT6zEbS3mm8c/xDQuLIHsYgmvBaKeM=;
	b=OgBbk6OE47DuQLxpIEx9x0gdWqRdpe02uNC/1V8yxo7jz6VuFdP+nhGIL2/dCkBiT5uV
	 LSxnr5Q/Ogr+wSV2zvazAJlDR3+L0gCsOWaVTTITV82UD6/L8UCSUBC5RucIi3mJEY7d7
	 4R6B1V8TkSLWRHsbXiew8bi/S45dTUChA8WiBm0on5DbL8LzZdu93sNRNo94XtWOr4Zoh
	 rSmoTIcmwrKp7pNaUG8ocwE2OXCsE6oyjzpwAfisrjt0FyKOtH5OtyVU+s9ZeqxjltBnP
	 p7Gk17CIG1jDG0wIydOKUaqbUP81FBr/os2Q2Xjroqhn4CsrKJPPNUL3jY52HREFjrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kz93Il83;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC4606A337;
	Thu,  5 Nov 2026 09:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06EC4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kz93Il83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793871395; x=1825407395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XPy64qOWUbAHoiyLGCzNor5MK4R9RiDPJM0T594C8kU=;
  b=Kz93Il83Tv+ryM75PKs53ZyYw8+eSX/36mjsJNOzbzmWnD/BpEWdC/wA
   OVnculX7A7sV6ztBl1Od1D0Zou+u661GWC75eDR+dVqSLdOp7qwXGTQDf
   ypK2etKTira+bfcDEE6wK1nSopsEKGjzZBa3vMnyI+iCDm2FFVYUYJsBL
   wSVbczfgApVtbXIJYkuXBQo4t01dMkTX0aF7uowdKdSFVC/3PnJ3RI8aH
   cHadGxRyW470JHSfo1rwrONdtwtQuBag+hMrJWVq4eUWZ+STtuG1gz7TQ
   bIFNSVxVnV7T6OiYtSpbi5WY/WgXxJqJAW9xp5zIntAZqttYGbMJiQLfv
   w==;
X-CSE-ConnectionGUID: PwUg2k9NS6uPTEiQJpG9pw==
X-CSE-MsgGUID: x4M8oy/CRyKc/i87G8BviQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2745425"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2745425"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:36:34 -0800
X-CSE-ConnectionGUID: JeSjlIADSz2CkG3b626siA==
X-CSE-MsgGUID: q1LawZWwT3eXus4rDYzo+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7120392"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:36:22 -0800
Date: Thu, 5 Nov 2026 11:36:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Li@oss.nxp.com,
	Mark Brown <broonie@kernel.org>,
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
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <auxOFGTRAKb5bLXD@ashevche-desk.local>
References: <autj6pr_bPaul3w0@ashevche-desk.local>
 <7f96599b-681d-4963-bdda-1274371ac84f@kernel.org>
 <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
 <autqC143h7Qf1R9H@ashevche-desk.local>
 <9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org>
 <auuYcS7-YqJKcUbE@ashevche-desk.local>
 <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
 <auxGom0XR-Hax9b3@ashevche-desk.local>
 <00390a20-7630-4066-9779-06c8f915a176@kernel.org>
 <auxH_WzaOLsQ4-go@shikoro>
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
In-Reply-To: <auxH_WzaOLsQ4-go@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 11:10:21AM +0200, Wolfram Sang wrote:
> 
> > > No, (partial) Rb != Ack.
> > 
> > It is, because there is no partial Rb tag.
> 
> Heh, just what I wrote a minute ago in the workflows-thread. The clean
> solution is to introduce one. I'd vote for it.

Then I MUST started REQUIRING to split the patches in such cases to actually
review them?

-- 
With Best Regards,
Andy Shevchenko


