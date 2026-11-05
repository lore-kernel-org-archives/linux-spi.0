Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871272;
	b=jDO0mXDjoQib1sMgBPfHH9KoQkEH3ooedTxioSG9X3aNrrkk6+tr2HpXTFdB5LyUI+GX
	 DBe6ALQ4CtAXfQRhSiJIvj9QP9iEfaZonWbZ8aNNSNCQS2fbj5utvv5kklLaFUfIOEDKr
	 CDsX9f2lYqCDhjKRbnWUVjJEnO0HszYSgnOHEiErHhb3vjvcchbGV3GK01yYahiQ03qct
	 niFPvAmFXPLxQmMFtY78aJfHIwKX3XcuUJMhPt79PWLKWgQJVERASUZ9fR2FhbnOMBdE/
	 SjYQhOHRIZcIs7GI+zPjDn/JIZ1k0A80PKYo25f6HLu5PhEA2QQRkc5A6cktntaceig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871272;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FHZJ9UZXx1w1S9lh8ts36Xc7WZ/XCgLmeoJLBVEnO0Q=;
	b=Yk5dRevc1JvbY1u6ictg0TvvBH9X91dC7PSBv44naPgjYKdhSVBTomwg0YWfOU5npOVS
	 P97naAe6AvzStke+hvgRoxwfJmsowF1tblQUY7OL8LXw+PsknEq5SInpwkbQdzARqYp/7
	 F+gB6v3DVRLzcFS+J0BNqAwm1j9bFAjFhCqKNqpnZw4wE4djTy2m03k5y4yLRa9DkAUpQ
	 3XT9FwAerCrd3FwbrO4bAPT6TTxyTlysSEX16zhIcVE7TiIKAw40SZ/piWKO/JCyTgtRw
	 HMl4yxK47NwzXqZgXPv72OmyueEvF965+1jOI29WhxPHq8ACfAi+m/k1H8CHSzBzVVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="G/LAUnN7";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09AE606A329;
	Thu,  5 Nov 2026 09:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F09AE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G/LAUnN7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793871272; x=1825407272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4LUR2vLgdtbMkV4yJV6wiaAwpAfjeOibn9D0PFxVDWA=;
  b=G/LAUnN7uJFb4Hw9zdpTNgm87wYSbL4U1h5+3oEgVEfVl87F4KgFyKsq
   cbcIlGJ41lQyowDIbdu1ddXwRZOJ59miMMGXZ9i42vc13wP6Yuw9Izjhh
   lgkkSQFrOGnSRW555FjJ0qaXBuzJPtwVAqIH/c6CceDC5FdyBK3yoIKRU
   6IMLdKShGWpQYIZeh+Nl5Swx/WIewH9PnJFklFHRHjOqabEyX7QeIn8bV
   gfMIHGFgAEwm2K3gpqJVO2JPZOKYIaDTrWM1hbTKJQ9qeNqVQNaOVTn/R
   pIRExOWdBFa87Yxo6U1pQWI8BhI7znuZGU+w/7LqMuHvLDajmyeMhc6BN
   Q==;
X-CSE-ConnectionGUID: f62k/7XOQJmedKqJWrv5Vg==
X-CSE-MsgGUID: wn0gviFXQFeo+rCPwiwgKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2558357"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2558357"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:34:30 -0800
X-CSE-ConnectionGUID: nlTZtjm4QSWKV5TFLHXZjw==
X-CSE-MsgGUID: 6+CUyE26TrGO0R2loVaiPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6795038"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:34:19 -0800
Date: Thu, 5 Nov 2026 11:34:16 +0200
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
Message-ID: <auxNmE8yZVP-wL2e@ashevche-desk.local>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
 <autj6pr_bPaul3w0@ashevche-desk.local>
 <7f96599b-681d-4963-bdda-1274371ac84f@kernel.org>
 <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
 <autqC143h7Qf1R9H@ashevche-desk.local>
 <9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org>
 <auuYcS7-YqJKcUbE@ashevche-desk.local>
 <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
 <auxGom0XR-Hax9b3@ashevche-desk.local>
 <00390a20-7630-4066-9779-06c8f915a176@kernel.org>
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
In-Reply-To: <00390a20-7630-4066-9779-06c8f915a176@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 10:07:30AM +0100, Krzysztof Kozlowski wrote:
> On 05/11/2026 10:04, Andy Shevchenko wrote:
> > On Wed, Nov 04, 2026 at 11:54:56PM +0100, Krzysztof Kozlowski wrote:
> >> On 04/11/2026 21:41, Andy Shevchenko wrote:
> >>>>
> >>>> But sure, if we want to play such numbers game, I will be sending
> >>>> reviews for single lines.
> >>>
> >>> I'm not playing anything. The problem is that the patch unites the files that
> >>> have distinct maintainers and unrelated to each other code. That's why in the
> >>> subsystems I maintain, I almost always require to split on per-driver basis.
> >>> Yes, exceptions are possible, but has to be quite rare.
> >>
> >> That's independent problem. Patch could be split, but it was not. Since
> >> it was not, receiving end should act accordingly, e.g. when performing
> >> incomplete review of only part of the patch, do not call that entire
> >> patch was reviewed by giving the Rb tag, but give Ack tag.
> > 
> > No, (partial) Rb != Ack.
> 
> It is, because there is no partial Rb tag.
> 
> There is partial review, but not partial Rb tag, please see exactly
> submitting patches. It repeats the same in three separate places:
> 
> "Acked-by.... user may not have carried out a technical review of the
> patch,yet they may be satisfied ..."
> 
> "Reviewed-by:, instead, indicates that the patch has been reviewed and
> found acceptable according to the Reviewer's Statement:"
> 
> Above important: "THE PATCH"
> 
> It is not "the patch or its parts"
> 
> Further:
> 
> "I state that:
> (a) I have carried out a technical review of *this* patch to evaluate
> its appropriateness and readiness for inclusion into  the mainline kernel."
> 
> And further:
> 
> "A Reviewed-by tag is a statement of opinion that *the patch* is an"
> 
> In three places it is THIS or THE patch. Complete (exhaustive) list of
> options what can be reviewed to get the credit and give statement of
> oversight.
> 
> Statement of oversight DOES NOT include "part of the patch".

So, it means I MUST from now on REQUIRE a split before reviewing.
Right?

-- 
With Best Regards,
Andy Shevchenko


