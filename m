Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264090;
	b=qJa3bGwUYZuG3TXwXCZT4j59xWjLYLVkVMFpvYGDu6zXDlsXjKFRz5+fiH0CZg9noXQJ
	 h/WS8CDUr/vZjZV3XjDaoUo/N+gJBQkcTJlx0FE8/rqukoL5UfxR+semgxCYQoGc59/5d
	 W1EcFaagYiRAU4Wuxc1hPsXIqCrTFI2itvGTY3hO/VIry/Ae62JG6sC67zuxqzXJVLR+y
	 ZFTkotngGyxdYTnAmZ7h7Q11rjghWC9Uz0h5lJRKS3hLCb+PjvoT2+tixuuRdkjtyR964
	 ZT8UTdeCmWQ+2Ty0SIg9GKnmC+c9WqqKFU9c+pPVVIPaIkd/lDlr7NIoKlF4siZMrEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264090;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vbe6nTsdDhg8Mlze/ClcUGDvjt9uDhFUXXWTuvVdSok=;
	b=yuaDMYqFb8I/t2z+WxVzoKgqM57N+6r3kNFiWpZtfAxyfnyGKx9Qqvzo88dUXvD31jhU
	 5ftV1/1BOx3Ja7LonVLgd1H2WJk9YnK5TL1PrgJlkNMWhn1S7PK4AkBenTh6zLMz9BSq+
	 DLT+j7YO710s0JVuNBg+oymkw3aKRNmC2e+lfzTksIFvRfvigUHA34MvNpu96QTI7oBsc
	 8zVPRFSikoIsHCiTv6biRiYNctKK/I/n/P94kHcj6DT6NIGcyaKa9FLsrv5q2JDKFwIfl
	 wbZax3Z5QiRnZTr4eiT3HUhiSvnxQx+FsyH3k/cG3OIVTmp+w5Htu+iZwopwhDJHphQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rj0Rk2FE;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090C606A31C;
	Mon,  9 Nov 2026 22:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6090C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rj0Rk2FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794264090; x=1825800090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=loGujMBTdlkfiQk5hWwMHTl07E+9259CEaRMomFVuEY=;
  b=Rj0Rk2FE7T+NWrkWn326px4ZqLreSM+p93yD36ZR3CaYVpaLxPXFeour
   y2eiuRXazbcjyLCun02quor2RULbeLyZ1aeraTrdb6K/nT1RvjJjrkC3I
   duTukWNPQaksAkNBeXaPWF982oD19GHKymcaNdEjDoUxbhyu5hhB9f1E9
   jjjjre5ptP8tSkT1LaqhXgTrhCafOs0RBQT715zqTlOnhqgwwbFBRoSpA
   e9Gnc01Pnc16N1fuodfR1ZBduswE1Le0GrSxHj+N2MNaNyMlj6BGzjgUP
   qIN9HRgizNypPLvyWtT+FNsSegTRYv4zT25jK/xJqzvP4xj5QC3Fb9Lux
   A==;
X-CSE-ConnectionGUID: LPR5BJtyTLOO201ZhtgoJg==
X-CSE-MsgGUID: TrInIqIIR5qc74GJ54Z7oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3012356"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3012356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:41:29 -0800
X-CSE-ConnectionGUID: WiiU066RQsK4uk0B5ylzZQ==
X-CSE-MsgGUID: 0Xjwhd9LQHC9A95XLjHjGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8169672"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:41:16 -0800
Date: Tue, 10 Nov 2026 00:41:14 +0200
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
Message-ID: <avJMCrlbmV6uq9NK@ashevche-desk.local>
References: <autqC143h7Qf1R9H@ashevche-desk.local>
 <9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org>
 <auuYcS7-YqJKcUbE@ashevche-desk.local>
 <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
 <auxGom0XR-Hax9b3@ashevche-desk.local>
 <00390a20-7630-4066-9779-06c8f915a176@kernel.org>
 <auxNmE8yZVP-wL2e@ashevche-desk.local>
 <3dc7277e-2f6b-44a6-9085-2e33d989c1c9@kernel.org>
 <avIJhv7p2v30U8H9@ashevche-desk.local>
 <78833267-f204-4387-9f8c-c7e0d5df59a5@kernel.org>
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
In-Reply-To: <78833267-f204-4387-9f8c-c7e0d5df59a5@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 11:10:38PM +0100, Krzysztof Kozlowski wrote:
> On 09/11/2026 18:57, Andy Shevchenko wrote:
> > On Fri, Nov 06, 2026 at 08:20:33AM +0100, Krzysztof Kozlowski wrote:
> >>>>
> >>>> Statement of oversight DOES NOT include "part of the patch".
> >>>
> >>> So, it means I MUST from now on REQUIRE a split before reviewing.
> >>> Right?
> >>
> >> Why "from now on"? The reviewer's statement of oversight is worded like
> >> that since beginning? Also nothing stops you from reviewing parts. We
> >> discuss the statement of oversight and its result: giving Rb tag. The Rb
> >> tag is not output of some review, but agreement with statement of
> >> oversight and performing what is stated there.
> >>
> >> You can review parts, but you do not provide Rb tag.
> > 
> > No, I'm not going to review something that I may not put Rb tag on.
> > I can NAK or ignore (or Ack without viewing, but it equals to ignore to me).
> 
> That's your call, but you put it on yourself, so do not blame us for "I
> MUST from now on REQUIRE"...

No, I don't blame you. It's purely documentation and terminology issue in my
opinion.

-- 
With Best Regards,
Andy Shevchenko


