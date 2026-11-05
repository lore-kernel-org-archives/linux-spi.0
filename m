Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873191;
	b=EY5kUVRPzvi44jiBoZYoOjp5SKpS5Qj+4Kq2POf3P5knszuAtFcDa46RmYcElgYcbURk
	 YD+03e5ClBHV3vNzh/+BfEYZhUkfd5ix3Rmig+BTIB6v1J8ROqSq/OwrQUcAZGZFiFxio
	 9UK7TUpJ+2oygDlwvedyJV8fCWQCORKDO3N+nEG4Jw7rIZ8u1jmDufZzqhvTe0ux9RSH3
	 6ymTG90BQ6ImX845CUFuA5tPxnSNV1RqmJsxwUyiAjzydSMq4+FVOIuPRFfc1VUEBPUP6
	 xFndck9cOByg4QoZZ7vzY1gRPYYxeWnQXX/N8Y2E6P/pwdEv1shwyGgZqAOq4uqxpVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873191;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9eN0QkSa1ecIUgCfCf76DF+V7dyFmgHFBWvD0/9mpfY=;
	b=CtPwae2fLC6TQvCcaSYed9ohVu9I+mRbF46B1u2qUDDsPckI+tLJDj4XG87nP72Suv/S
	 WMUUgMSSLyz0LtY3KoMdsrCwT8hbgVJ1vGA/NOdzuqjzNeRo22wTPwLY9EI4WjTXePSA0
	 vt8ywNTTQpXwXn6wNH8U/miWb2k3F3Hs/u6CZf2BMhkPhIKyctF3SKuD88GUZxLD8QMjB
	 AU2Z2WfU1vHuL1xrxUbN4Ex9R1fYqkJYFYJMQ4ECqoyDoID+kIp359d+P+qbtOV1BXv+8
	 swq2Cm27tiFsI+hJUMuvTA61HLlyD59El/zv1Jf0PqS7NUIiF+/WRO6PtUIlPQo+euw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=feqhTnqA;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846360A3801;
	Thu,  5 Nov 2026 10:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4846360A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=feqhTnqA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793873191; x=1825409191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sHuju/foWw79h0Lx9lDW6+4gtj0ksiGlzl0r5P+LOfY=;
  b=feqhTnqAld3zblKxUXhQOyJueNaYdf1WbWXxLWEQGOanoNg86qs1ukYs
   h5GjyCPw3MuRrXcgEjmRHkP7yQfNij+nLQ3t2PR+DcklbFF2TsZco4oy7
   z7dPm79yevji8bqDhwZpilDPGgimjrTj4jc3IREBc0WATAo3CHtbHjWTc
   5D5NupCC73u7kMIEtzj0r5MeAxXmX+Nr/Mq9wngoDKgvPzY672sI4xeSV
   FfDVmGPq5+tRz12S6MuEi/ViALyJQZep9ZP2PG5znTC549WGo8NJzYcNz
   0xFW2ijjFlwqLz+ImwoOuDAPhnsO57UZ2+rZc5z/1vTbEtL+swQ58/NO0
   w==;
X-CSE-ConnectionGUID: 7Dy8RvAdT/yy9wfmNMmTkg==
X-CSE-MsgGUID: YJXwZCJGQeq9aI/X2X8PDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2687014"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2687014"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:06:29 -0800
X-CSE-ConnectionGUID: 96Aad4J6Td2JN0y4EunOKw==
X-CSE-MsgGUID: fNrhP6vdSb+xZdaYz36idw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8733180"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:06:17 -0800
Date: Thu, 5 Nov 2026 12:06:14 +0200
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
Message-ID: <auxVFt8_vZKzYniK@ashevche-desk.local>
References: <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
 <autqC143h7Qf1R9H@ashevche-desk.local>
 <9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org>
 <auuYcS7-YqJKcUbE@ashevche-desk.local>
 <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
 <auxGom0XR-Hax9b3@ashevche-desk.local>
 <00390a20-7630-4066-9779-06c8f915a176@kernel.org>
 <auxH_WzaOLsQ4-go@shikoro>
 <auxOFGTRAKb5bLXD@ashevche-desk.local>
 <auxQU_PU4bwLJUch@shikoro>
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
In-Reply-To: <auxQU_PU4bwLJUch@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 11:45:55AM +0200, Wolfram Sang wrote:
> 
> > Then I MUST started REQUIRING to split the patches in such cases to actually
> > review them?
> 
> Okay, this is a solution, too. Or requiring "# subparts"

TBH, I am flexible to both. Depending on the situation. I don't want to blame
the author or require additional work when it's not really required. But on
my side I still want to *review* the piece. So, "# subparts" is fine to me.

-- 
With Best Regards,
Andy Shevchenko


