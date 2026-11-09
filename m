Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247063;
	b=tiC/VFf3BUGk1Df55SC/rN/kMKp9FAzhO7WmP4W1cNs9sW44QHbVQCYD+D/YeSJIVVNV
	 hcmutZZJjiLYpCbRWGa7fjOXM/7afJ2+AU0mdq7KP1+mHvP+m8+smhxU/wyjA87r0v7UM
	 Z5p+G4Bw3kKlryjMVui/pfW/2P8chworSwAFnsncxTFff/vbKRdKnZhPKsVK2HVoYlaXb
	 /I8Q1bwUXmCJwxseFWxU6kdyo4BOFTJQs3o6sH8Xd/vghWzYCBp7w5kWpxboh5Ez2HdhR
	 3Evq5PRnBUOeAkLhw7/jzB86S5hCsIP4fA5kj2tnKjW1KZwQUBu96pbaerzw1plQJjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247063;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9Cc+2gtfN2/LHuRHGFLJjMnOZd72QDWhyPb9mjrBQIM=;
	b=X1gN/k2HEpg8EJv3s+0GEcEAn1pTutt/VrfFrUq9dy/1hdIPQh8U/10aEHTx1IllmHAe
	 y9OnyXL7W3RsjYg7DZjSMViSl6mnd63UMZxoxcGsTEmKB4iA3B/cgXW93W7sSNCqYuGcD
	 8ZH407KVCQuBCZ/rLIKzFp5kgdR62dbO3kSou51VkvDtUbrSUKMIf3rx55Q4V+4S+OuQB
	 EReEfAGQMKVoKRoZWkJpKl4dmgc/btiBxVq8PtJ3zIU1dgBPChbsqR5NbB1nDLWCaWY7d
	 Duujcv4bi8T+ISXs10jcFZEzm6UoMy6KtV4ck6TtFj5LvIjoaX46rSvbUhT/Xq/+q4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RYE80E4L;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DA606A330;
	Mon,  9 Nov 2026 17:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B6DA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RYE80E4L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794247062; x=1825783062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/GGAxNjyNSTAgb+4GsAIS07jSZ/uzkJHlCxb0K1tUUw=;
  b=RYE80E4L4jf+eo3yiNmYGvjkREiK14P7tpe2VTbck8ZSyfp/TeAWS5he
   Ydc1pMWVHQTvD6dqXwK2DCBMJREpZ2FA0BK5yRMiv3HT2aHyRUMQpt/ad
   0YsiSK6ITcQ6TMxMbD0ojpZZtMh8nej1ULGVuNc4NOQje0LVgQI7V9k1n
   RwbgmQ1f17yoZnD3BGGoXT+41rwyrOKWFwlc09/3aKQ3FWis09A6urYN1
   he6mfWqzIbpzf4W+kESQ1CHyspmUeLnmkAMmd5Dc/Eo9K51umHnm+CxzA
   Rrq7rC/Vq8QK2pdUWOp6cryd3vA2ccLYPwU43a/bRbqxyqnSiLqQvuerk
   Q==;
X-CSE-ConnectionGUID: FpfBUQ7BRR2TCnmIZkPejA==
X-CSE-MsgGUID: o+1uwiCcRj2issQ5Lq+qow==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2866556"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2866556"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:57:41 -0800
X-CSE-ConnectionGUID: wb2AMpMXSwWy17Y7mVRXlA==
X-CSE-MsgGUID: AJ9NiomKQuqzRxE8oUxCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7927416"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:57:29 -0800
Date: Mon, 9 Nov 2026 19:57:26 +0200
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
Message-ID: <avIJhv7p2v30U8H9@ashevche-desk.local>
References: <7f96599b-681d-4963-bdda-1274371ac84f@kernel.org>
 <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
 <autqC143h7Qf1R9H@ashevche-desk.local>
 <9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org>
 <auuYcS7-YqJKcUbE@ashevche-desk.local>
 <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
 <auxGom0XR-Hax9b3@ashevche-desk.local>
 <00390a20-7630-4066-9779-06c8f915a176@kernel.org>
 <auxNmE8yZVP-wL2e@ashevche-desk.local>
 <3dc7277e-2f6b-44a6-9085-2e33d989c1c9@kernel.org>
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
In-Reply-To: <3dc7277e-2f6b-44a6-9085-2e33d989c1c9@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 06, 2026 at 08:20:33AM +0100, Krzysztof Kozlowski wrote:
> On 05/11/2026 10:34, Andy Shevchenko wrote:
> > On Thu, Nov 05, 2026 at 10:07:30AM +0100, Krzysztof Kozlowski wrote:
> >> On 05/11/2026 10:04, Andy Shevchenko wrote:
> >>> On Wed, Nov 04, 2026 at 11:54:56PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 04/11/2026 21:41, Andy Shevchenko wrote:
> >>>>>>
> >>>>>> But sure, if we want to play such numbers game, I will be sending
> >>>>>> reviews for single lines.
> >>>>>
> >>>>> I'm not playing anything. The problem is that the patch unites the files that
> >>>>> have distinct maintainers and unrelated to each other code. That's why in the
> >>>>> subsystems I maintain, I almost always require to split on per-driver basis.
> >>>>> Yes, exceptions are possible, but has to be quite rare.
> >>>>
> >>>> That's independent problem. Patch could be split, but it was not. Since
> >>>> it was not, receiving end should act accordingly, e.g. when performing
> >>>> incomplete review of only part of the patch, do not call that entire
> >>>> patch was reviewed by giving the Rb tag, but give Ack tag.
> >>>
> >>> No, (partial) Rb != Ack.
> >>
> >> It is, because there is no partial Rb tag.
> >>
> >> There is partial review, but not partial Rb tag, please see exactly
> >> submitting patches. It repeats the same in three separate places:
> >>
> >> "Acked-by.... user may not have carried out a technical review of the
> >> patch,yet they may be satisfied ..."
> >>
> >> "Reviewed-by:, instead, indicates that the patch has been reviewed and
> >> found acceptable according to the Reviewer's Statement:"
> >>
> >> Above important: "THE PATCH"
> >>
> >> It is not "the patch or its parts"
> >>
> >> Further:
> >>
> >> "I state that:
> >> (a) I have carried out a technical review of *this* patch to evaluate
> >> its appropriateness and readiness for inclusion into  the mainline kernel."
> >>
> >> And further:
> >>
> >> "A Reviewed-by tag is a statement of opinion that *the patch* is an"
> >>
> >> In three places it is THIS or THE patch. Complete (exhaustive) list of
> >> options what can be reviewed to get the credit and give statement of
> >> oversight.
> >>
> >> Statement of oversight DOES NOT include "part of the patch".
> > 
> > So, it means I MUST from now on REQUIRE a split before reviewing.
> > Right?
> 
> Why "from now on"? The reviewer's statement of oversight is worded like
> that since beginning? Also nothing stops you from reviewing parts. We
> discuss the statement of oversight and its result: giving Rb tag. The Rb
> tag is not output of some review, but agreement with statement of
> oversight and performing what is stated there.
> 
> You can review parts, but you do not provide Rb tag.

No, I'm not going to review something that I may not put Rb tag on.
I can NAK or ignore (or Ack without viewing, but it equals to ignore to me).

-- 
With Best Regards,
Andy Shevchenko


