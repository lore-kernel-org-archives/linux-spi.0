Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213211CA9;
	Mon, 20 Jul 2026 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575370; cv=none; b=NhfEIPx0M2uLRhfDIQQStDXYD2vzNpWXnIBhXRzl84Ue7rJUScxE+i5+m2psk32KHZAtHAdcc0D9OjqJoJghfKpuN+wzw0B4Gfe+727O7GXmh4vXS6Slc5QHoaEWoUcXiJKNvVjfoA8flQBmCjuLfkH+ZXZOfMGl26vtdQfdpEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575370; c=relaxed/simple;
	bh=JHcppqoikoS8e0wMZIde7eaA2lWQyyAwdPloNvfOIcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1Z2JjJqZ7qLNWuG8XcPCfGcTy06W+yphAi5Mx1QaOFN7sKIxHIkXCVL7QaiUKi/T2uj4J5Qlg7K72Vx4cUuQmOehxtRDwRyyNlGDqBPIu8Hp5c9ID6BhvjSGekjbTMNiLqarcl6io2l0HC617p5BANX1v7uzij77O2JenjOHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feoeOsEq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feoeOsEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784575369; x=1816111369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHcppqoikoS8e0wMZIde7eaA2lWQyyAwdPloNvfOIcs=;
  b=feoeOsEq1xyTYVQAyKzugT9Du8Gjywyclkd0Fi1YfL+qnWLagFdnGoGu
   a3mkPXcdDOfvwcb/eEWE+5TXUm0fbGgI7rBa1yLFvXWJuJHy+es8WCLgS
   HLZSxg3lCKu2O39wKunXamsI0EGOQQt3Lx/912HoDfeJZD3n3KireStVe
   eyv2FzWS+m1SOtxJJk9abK87vdOx0yiGJqqAuOJjlwyAe92FLunCKgUw9
   QAfx3tPX8oJE6YtF12+naMaTCYpfr5iVZ9svkmevKx+JAF14QHTB/h0tR
   2eTSrtuRCshSknDgok7MP4o8Bh0JLOJZ9jw1A0kblogVwLcp06dwzED1m
   g==;
X-CSE-ConnectionGUID: /itRfqBPSDWkvyzRVA+wCw==
X-CSE-MsgGUID: fB7HzX3mSqysBb31qF8P5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96299856"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96299856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:22:48 -0700
X-CSE-ConnectionGUID: LuL0t+6hQgex6EGAUYO66g==
X-CSE-MsgGUID: zUA/8s2zRDq/rrKDCG7NAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="258181719"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:22:46 -0700
Date: Mon, 20 Jul 2026 22:22:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 1/7] spi: pxa2xx: introduce clock enable and disable
 helper functions
Message-ID: <al51g77Zsdr3OyBS@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-2-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720162117.32304-2-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 12:21:10AM +0800, Shih-Yuan Lee wrote:
> The driver disables the clock during PM runtime suspend, PM system
> suspend, and device unbinding (remove). It also disables the clock
> on various error unwinding paths in pxa2xx_spi_probe().
> 
> However, if the clock is already disabled (for example, if the device is
> already runtime-suspended during driver unbinding), calling the common
> clock framework's clk_disable_unprepare() again leads to clock prepare/enable
> count underflows, generating kernel warnings.

Any real life example here?

> Introduce pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() helper
> functions that track the clock enable state using a new 'clk_enabled'
> boolean flag in struct driver_data.
> 
> This ensures clk_disable_unprepare() is called only when the clock is
> active, preventing clock underflows during suspend transitions and unbind.
> It also allows the probe function to safely unwind resource allocations
> without triggering clock underflows.

...

Same issue, I have no cover letter in my mailbox. Please, slow down and check
your email setup. Something is wrong.

...

> +static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
> +{
> +	int ret;
> +
> +	if (drv_data->clk_enabled)
> +		return 0;
> +
> +	ret = clk_prepare_enable(drv_data->ssp->clk);

> +	if (ret == 0)
> +		drv_data->clk_enabled = true;
> +
> +	return ret;

Use usual pattern

	if (ret)
		return ret;

	...
	return 0;

> +}

> +static void pxa2xx_spi_clk_disable(struct driver_data *drv_data)
> +{
> +	if (drv_data->clk_enabled) {

	if (!drv_data->clk_enabled)
		return;

> +		clk_disable_unprepare(drv_data->ssp->clk);
> +		drv_data->clk_enabled = false;
> +	}
> +}

...

> struct driver_data {

>  	void __iomem *lpss_base;
>  
> +	bool clk_enabled;

How is this protected against simultaneously called enable/disable on different
CPUs?

>  	/* Optional slave FIFO ready signal */
>  	struct gpio_desc *gpiod_ready;
>  };

Whenever you add the field, check with `pahole` that the layout is optimal.

-- 
With Best Regards,
Andy Shevchenko


