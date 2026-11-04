Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813021;
	b=kKyTo+ihnWmEr8SWXLJogZdQUoLu4tw3muQ7+GyHm4yFmbHdfUjxtiVQ1qJbtOjNKsYr
	 Zq6ckuZzNlpXMz5WfB41kdlRHcX+r8l2IweDTxuSSHbRslKhGK2Ux3CqvUHWODIXpZ0n2
	 J+1RsgBP2p45MMC+737Ll67SCgk0KEjzzNwJa4r5oIMROklqbRAG0mSBZypL89b6F+/eU
	 fCiVTRJ9nf8Q7oBQwx6lmS1tcVuwq6zy+PdakZPzYvthuKp4hClF2RL7PJsUZDTJXeYP4
	 GYMc+QbxgiEnwpflqr6yH0VnRUfsyT4EFWvshdkFTfJv81Zs8W8MjhebilWJEEV5rAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813021;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=a/wU2sebGcyCrU5AkFG1h4tK5hyQV0ZGzccPwppRbHs=;
	b=atG9KNym1wl656ZaFyciJvIgqasKGigrloAlgbVHKew64Nv3KPg+H5eT9fP2c3LGFY3E
	 XvTOzh+6NI2yCjn2WqDlX30Z7VbXEbY1x2/pOSZ5QK/4VgyiteAuWbWSiUrT7Pna7XQOv
	 SNwmkHIUfr5OtnHUzvE6kV44MdS48nu+97dAWMMrvXZ8dMa4hkZRa+Z94VDl4ql43lu+E
	 6AcBeVGKy1xuGLqocnw01VDKzHpZHg+P7XNJtO1+lE7D+zgFRcH0OyJZEdS+urXcTtm+d
	 Q/1f7VXBgqDZxzxGC//Fg4JYQJkXO2TRoQxCLMIEnbsZv4M82pg4Vxaamt1j0tGlU7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G3orpvqD;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97950606A31B;
	Wed,  4 Nov 2026 17:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97950606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G3orpvqD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793813020; x=1825349020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gbqiUDxqr5yVr2qcIwH7+q0Qj3ZwEXSUQhnZ+MqKmos=;
  b=G3orpvqDX2j4nvLrfBANf4TzqNZjO1EmlxQ3RIG0uAm1Jan28N7SEWYi
   RBufX9ZNUE4f+rRJSmyJvkQ4zXF8iPS6WtyRwmxsdbUsOEAc7MRsZmMwU
   OvAEfEMfk4QlZtwXBAYtl0rsaHklhwwGUCRMvLHbbOafhq+tkrbPrKHGT
   XAlnnCCrDqFtEbSgvIrbcgj4o7S17APq7+PP7llkarkqg87/17LdL869v
   jl1BXVjtOu3HM4d2wKvdx6q5jVERPcJRjBUadIjk/1ul5mcxS17MsGAi5
   sGvEFLjjVDgqRN53Fy0GRpYKQW+8NdMQaiOvXMZuDHab+HlbHF6K3NHz4
   A==;
X-CSE-ConnectionGUID: 121Ee1kTQxyGDmo5x6AXPA==
X-CSE-MsgGUID: w0H6nGn5Sl+rgCY5CKSVzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2584699"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2584699"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 09:23:37 -0800
X-CSE-ConnectionGUID: ZJ4okITuTL+k/7bbeLtfXg==
X-CSE-MsgGUID: Yy2sU1htRK+8Eg46G0DWpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6642051"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 09:23:25 -0800
Date: Wed, 4 Nov 2026 19:23:23 +0200
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
Message-ID: <autqC143h7Qf1R9H@ashevche-desk.local>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
 <autj6pr_bPaul3w0@ashevche-desk.local>
 <7f96599b-681d-4963-bdda-1274371ac84f@kernel.org>
 <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
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
In-Reply-To: <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 06:08:39PM +0100, Krzysztof Kozlowski wrote:
> On 04/11/2026 18:02, Krzysztof Kozlowski wrote:
> > On 04/11/2026 17:57, Andy Shevchenko wrote:
> >> On Wed, Nov 04, 2026 at 10:22:45AM -0500, Frank.Li@oss.nxp.com wrote:
> >>>
> >>> Replace open-coded assignments to callback and callback_param fields
> >>> of struct dma_async_tx_descriptor with calls to the
> >>> dmaengine_desc_set_callback() helper across SPI bus drivers.
> >>>
> >>> No functional change intended. Prepare make to struct
> >>> dma_async_tx_descriptor private to the DMA engine.
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # dw, pxa2xx, topcliff-pch
> >>
> >> (Note, you forgot to add the list of the drivers to the Rb trailers of other reviewers)
> > 
> > These should be acks. RB creates false impression entire commit was
> > reviewed. Our docs also clearly state entire commit:
> > 
> > "Reviewed-by:, instead, indicates that the patch has been reviewed and
> > found acceptable according to the Reviewer's Statemen"
> > 
> > (not patch or part of patch)
> > 
> > "By offering my Reviewed-by: tag, I state that
> > I have carried out a technical review of this patch to
> > "
> > 
> > (not patch or part of patch)
> > 
> > When you accept only part of this code, you basically Ack. I really
> > dislike these half-done reviews, which later appear in logs and tell you
> > nothing. You could have clear security bug here, but 10 review tags. How
> > useful tags...
> 
> And let me even bring a better example. Imagine a patch, doing massive
> refactoring of core SPI stuff, 1000 lines of code, complex locking and
> also simultaneously updates drivers to new API changed in this core.
> 
> Reviewing that 1000 lines of code in core SPI with complex locking takes
> someone 30 minutes. He gives Rb tag, gets credit.
> 
> Now you come, look at SINGLE line in a driver and give Rb tag. For 10
> seconds job of looking at one changed call in one driver.
> 
> You just Acked, you did not review "the patch" (quoting submitting patches).

Your example is doubtful because the patch is combined from independent pieces.
The Rb fits very well the listed drivers. The problem is that some of the
people combine changes into a bundle (and not proper per-driver series).

-- 
With Best Regards,
Andy Shevchenko


