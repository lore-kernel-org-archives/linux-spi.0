Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869490;
	b=zB+U34QigPH8QO3MPpwfKfSoI5Pt8QSRJUoBQFplVUBqNxROkcuNYP+WY3+nGPs1IYSs
	 3QNrcW0xaIunpQpJJYKf1F2TSjiS9liMsKti5QBr+xGe+qQ/YtMHEWCXEEThrnpy7Iw7V
	 GzjkMiwrPKk2FnXNDNAb3IU1zjRvmpVJP5nBPE09IpJNTKcmW9Y9gsiHP7VLgCnOKRiq4
	 RLKC3ljc2MSy3fRsua1W/l/HGdWjmZ2j5RuiN50lhVz298/JbHkMpDouuBYrMIuv1VdCL
	 ZOZorK0ML1xsLueBpy0p/Zb3loJGElpt3Xo+FC77G1dM+NwLhdATXog+EWVEzWSHlNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869490;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Y7soNQkoJL0Hf12qOxG9iJhIaujgxOHIpYViOEz9LeQ=;
	b=IE3mLQj/998reBRDmaFoV8zfe6IszppjjfZjWpFZ5fabF6rQQT5vmLueD77cO1WDq+Qh
	 B28snP6aOJ5quRGPu4Q9A9MN9kmJ3sIotIxyuXzO1MsVuTIoAKrEqW6Gx1L1U03aU2upf
	 Jf9Hd7e2pxU3doJW2mLSoD6/jpwia2/FvWhLxhalaOxtrTWYoS4OQylcf6Xc7SryZtaCl
	 xxBGKReiKdJ1DzIWp3MtMuxAhPB2cSN6PsM/fuhexTl3zUbQrOm7EzqCX1W/Yqx83ULDH
	 ioEXyX6CUUb5pyhNE0+fg4nAkJBRuZFkD2Bx0SXNF/IzLQCWJ5vufbLnzsVrlRLeaQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="h1O/1r2s";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3006606A32D;
	Thu,  5 Nov 2026 09:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3006606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h1O/1r2s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793869490; x=1825405490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LECBwyHoq/Gb/ca6fZikFPfxANCrjI25ogdvAt/TfI0=;
  b=h1O/1r2sN3gY9P/pMrrzAiNgeD9e83BGDfUBPWAhhEa6T9XJei35lKKO
   2OP/gXoIttBNTiUBSpFWQ1njFQoOm/7ASX9q8v5Piw0HP//5b+/YMHgdT
   qoh3BGLysUBWuL9CdS5LZU8+AUnm9VgP3vWtIurqN0v3vFa8WVXLU6SVI
   8HG1yti14JfGUizUNUZ/MtwYojNpEjM41jzvKzqZ6DRjN3X0s+IqmJeQn
   lh7nL/a/7FC4K6zOsr6zOfrRFmTLCpjoNlLll3BFujXewOb8YOMy+nz5I
   q0zUah24uXrBukFBlta/XCiHBuukRP6vwz9qfAx6bHqRvkt97pQCXfU4m
   w==;
X-CSE-ConnectionGUID: UUfeBzAtSPulGWd2oNjrzA==
X-CSE-MsgGUID: i9w/j+0xRLGjtsgvmIyoIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2523312"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2523312"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:04:49 -0800
X-CSE-ConnectionGUID: iP5CMRdrQXSK1/i0FAHKxQ==
X-CSE-MsgGUID: x5ccBZCwRCiV8KzewVnjww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6789320"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:04:36 -0800
Date: Thu, 5 Nov 2026 11:04:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank.Li@oss.nxp.com, Mark Brown <broonie@kernel.org>,
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <auxGom0XR-Hax9b3@ashevche-desk.local>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
 <autj6pr_bPaul3w0@ashevche-desk.local>
 <7f96599b-681d-4963-bdda-1274371ac84f@kernel.org>
 <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
 <autqC143h7Qf1R9H@ashevche-desk.local>
 <9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org>
 <auuYcS7-YqJKcUbE@ashevche-desk.local>
 <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
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
In-Reply-To: <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 11:54:56PM +0100, Krzysztof Kozlowski wrote:
> On 04/11/2026 21:41, Andy Shevchenko wrote:
> >>
> >> But sure, if we want to play such numbers game, I will be sending
> >> reviews for single lines.
> > 
> > I'm not playing anything. The problem is that the patch unites the files that
> > have distinct maintainers and unrelated to each other code. That's why in the
> > subsystems I maintain, I almost always require to split on per-driver basis.
> > Yes, exceptions are possible, but has to be quite rare.
> 
> That's independent problem. Patch could be split, but it was not. Since
> it was not, receiving end should act accordingly, e.g. when performing
> incomplete review of only part of the patch, do not call that entire
> patch was reviewed by giving the Rb tag, but give Ack tag.

No, (partial) Rb != Ack.

-- 
With Best Regards,
Andy Shevchenko


