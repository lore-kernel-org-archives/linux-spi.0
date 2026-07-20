Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B30449B22;
	Mon, 20 Jul 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577333; cv=none; b=X2nNZf7ozBc09omGRh9LRkaTI2hO2zjV5eeZUKXkY5mSwGScStQ7IjJuhaaPdN7p8XRo2ATyf5dQ+tk3Qd/7+C9HiSp0ixnywoeD41jEDy0El7svvqhnDAVjZwNKPPPT/rQO0nxMIQRO7iNpFqr24OQsr5HHvE4wA8BYCad87DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577333; c=relaxed/simple;
	bh=Y2jNi5/edQtJsWbYoQEOskTGNBe48nPyiAMLKqrHdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYth9QLXoYKD3qfO2iQ2L/oL+lDDxDW12lToha44LJTd/EGuSA2TKKpFucRR0JaLKL9U0zxATKE4yDv6xkIY0eEpINCXCndJFNQXNh5Icwn3LX65AXPD8bZ+q/FI2pikGy4siSr5s1fmT0vy0hbzXTv5noWLHMJnSjxXI/85AbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DH42jXhp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH42jXhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784577332; x=1816113332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y2jNi5/edQtJsWbYoQEOskTGNBe48nPyiAMLKqrHdqQ=;
  b=DH42jXhp/8rX3hsSLfvHgPf74vHn8mRq22sP0RpiKG0Oo08I9IkqSyQv
   9AJdCOlRfxuv9rQhu3SP+y1Eibtgpy2DquWBzRGH6XxInO3W7qUWwnqFm
   u9ZFCsmRJSxDGmo6ivZA94jg+rvXpd27RHGpfHW6k0MIrA4DrFzU6l8dX
   g5QBPmkrarR7zO6ixLPp5ooS5yDrVCXxzEcq9udhMQiMT9CeZf5jb+iBB
   2hYvgDEkSCqiuBqCWDhvEgJ0uKLLg6mbNf9C1UkOvCXpBji2M+Scd14Ql
   QL1P8F8yVknoAF2Pnwgh8Yhvj7uWG5iXXdQg/wwIAElVGPBaIf92T19Gy
   Q==;
X-CSE-ConnectionGUID: fgEyRY7RR8O+2gF2LMMlBg==
X-CSE-MsgGUID: 9HR2202XQQGmyvdB0coK2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89062549"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="89062549"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:55:31 -0700
X-CSE-ConnectionGUID: bW4DzkLbQP2DiVio1b4+2g==
X-CSE-MsgGUID: tLBOvaQAT2Ob2/o6gq5SnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="262498510"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:55:28 -0700
Date: Mon, 20 Jul 2026 22:55:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 4/7] spi: pxa2xx: lock out runtime autosuspend for
 Intel LPSS SPI in PIO mode
Message-ID: <al59LnVJQhiZq9yR@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-5-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720162117.32304-5-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 12:21:13AM +0800, Shih-Yuan Lee wrote:
> When operating in PIO mode on Intel LPSS SPI controllers, runtime PM
> autosuspend clock-gates the hardware block when idle. On subsequent
> transfers, MMIO accesses to trigger resume are performed before the runtime
> PM state machine can wake the controller, causing PCIe Completion Timeouts.
> This issue does not affect DMA mode, where the DMA engine holds the required
> resources, nor does it affect non-LPSS controllers.
> 
> Lock out runtime PM autosuspend for LPSS SPI controllers specifically
> when operating in PIO mode.
> 
> Acquire a runtime PM reference via pm_runtime_get_noresume() in
> pxa2xx_spi_probe() after registration, and release it via
> pm_runtime_put_noidle() in pxa2xx_spi_remove() before hardware teardown to
> ensure the runtime PM reference held in probe is released without invoking
> runtime_suspend on already-unclocked hardware.

.runtime_suspend()

// this is how we refer to the callbacks.


...

> +	/* Release the PM reference held in probe for LPSS PIO mode before
> +	 * hardware teardown so the PM core does not invoke runtime_suspend
> +	 * on already-unclocked hardware.
> +	 */

/*
 * Keep the comment style as per SPI and many other subsystems
 * and as in this example.
 */

-- 
With Best Regards,
Andy Shevchenko


