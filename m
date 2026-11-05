Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869318;
	b=cgD/iKS7kwv9nb8ixROHv22BN2BKWqbmbcUkviqPGbPYSTtLJXJgfIbGhcfKdhRItbob
	 hK964BYB28NgV8ekO328qk2ehmLkBDU2yypmurP7nBtUbKqPuS/SfuUkd0AKyOPpjZf/W
	 kur5BabWnJq1AhT/+1+OKCaYpYmYqwwPSo3i5/iyOMZyIAJ7NRy44so7sV4wUNh6/gL9W
	 F543W28PSG9R6C4VPEMqQWtp4BuALuqyBNyQXfPsZiY1NpTgNHg8U8xPpDo+BGcvlxcuu
	 zze59DqLkvAzyMY4SeE+ioYwOVmAE5/38r7kOgPRxR4Un1IAXiJ/blZorRWBLyYGI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869318;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=MOT/eVT47O4WVQDSlL8Tk9BW5VeaSSIH+swxSEeZrwY=;
	b=mqr2er90CUKQYDqi6nNIx2aH0+cURbVWO/f0rRd5yBPe6xox2mfA5oZIPutKvBiDd14w
	 APzbDT/WQqCQsm2TWjF77Xv6vPC6NzmVuhXOqGDVrm98AhgN1mBRjTKuXUqMafVBPAgID
	 uNMDh9d5QhSV7opDUMoJm+iua4DAUQcolI7wQ9uKXwpAuEbglxiBWQnlSS6C4ejvDbpkU
	 4jEIHzQ8JhEfnI2xCG0yt9YnivSlwLk+wuKdgMH6SsFnVsgqbHd8YJaernpd0Px8doa0W
	 NcY3AiqQrNIc+lnXy3+RsEgQ8OzgmKwPzD3SQ6zjgYnr+m4k7P1e2LEl6Sghyqjj3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dYbcBbgV;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AA606A31B;
	Thu,  5 Nov 2026 09:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 423AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dYbcBbgV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793869317; x=1825405317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsF2OB4+TAKcLaK6X2CbxWBe2H+bJw89o7MCcGnPEhE=;
  b=dYbcBbgVOlUSBxnyE/4Gn0ptbmxEULSOiQnRKhRdhR1dNwvkZEAGcBuW
   jMGs9M8e2KtibZ9mqnsLuDgF2TnXPMSyoYpOjhE5TQuw/Ph6XPqm7v/Un
   vW6ZLA1Qbxu4GLPOQProELEU9WMw/GIN9X7kmrpLHqk2swWjomMmvWaDn
   rBA39dBwuBWaFYeYb3YYXhvyjAtbelrh0EUophzQqLJGqvju6z1pp0XBU
   Ab+GSP2w84Khkqk1Kvv1wvK9D6JlP7+ZtdY3PdZcbHqya2uczXHsrgC09
   wsL95xS41h36OPsA44P9Kf6dj1AoU+znKlJjpx+6j+H/bBkcxqHTS+N45
   A==;
X-CSE-ConnectionGUID: mWzUxRhiQdWvO5I7z4uI2w==
X-CSE-MsgGUID: Iw37O7BMRHakcvb72FXWTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2547930"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2547930"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:01:56 -0800
X-CSE-ConnectionGUID: 73i/m+mbScKfalk02iBJcQ==
X-CSE-MsgGUID: 7N01rw1qQ3OIr7PEIb3JjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7121379"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:01:43 -0800
Date: Thu, 5 Nov 2026 11:01:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Konstantin Ryabitsev <mricon@kernel.org>
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
Message-ID: <auxF9RT5aljXkfh7@ashevche-desk.local>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
 <b656861c-a087-4087-952e-91fd15fadd52@kernel.org>
 <auuZHTvr5UI9Q9Q4@ashevche-desk.local>
 <fbcb650d-0f60-468d-b1cc-255ea8a93db3@kernel.org>
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
In-Reply-To: <fbcb650d-0f60-468d-b1cc-255ea8a93db3@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 12:02:21AM +0100, Krzysztof Kozlowski wrote:
> On 04/11/2026 21:44, Andy Shevchenko wrote:
> >> Andy,
> >> These three lines look correct.
> >>
> >> LGTM:
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > As
> > 
> >   Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org> # atmel-quadspi
> > 
> > Note, it's in your power to ask the author to split out what you maintain
> > to a separate change. So, it's your choice what to do, Ack the full patch,
> > give a partial Rb, ask for a split, ignore reviewing (often means silent
> > agreement when maintainer just applies that kind of a patch)
> 
> The "# note" after the tag solves the problem partially, if people were
> actually using it. Solves people looking at the Git commit and being
> mislead by partial review applying to entire commit. Does not solve
> credits, because Rb for three lines is not the same as for 100.
> 
> From v1 of this patch, four people (Alain, Lab, Troy, Kunihiko) did not
> use it even though reviewing only part. Only Wolfram, so 20% of partial
> reviews, used that syntax. Without that syntax, b4 will pick up Rb tag
> like it was for entire commit.
> 
> So I do repeat - if one does not want to use that syntax, then just Ack,
> instead of creating false impression of reviewing everything.

+Konstantin, then we need to teach `b4` not to break that or convert it to
something like

  [FirstName: reviewed only ...]
  Reviewed-by: FirstName LastName <...>

-- 
With Best Regards,
Andy Shevchenko


