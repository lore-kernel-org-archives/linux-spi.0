Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60A386C1C;
	Tue, 21 Jul 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665893; cv=none; b=QGLposBphdBHIh1ucmaiUmwUENX9QYN41964aQGtk4rhwKAu+D7towK+VN24iPhWe9nKJBuBP7V+xf+JJnCX1ULkkHaAL2EAYkNK2kv0dSe06Yr44q4zxvGPQmVeExOIiRUt2xMxgc3/v5qAmfmrIEGuv/tOGlPbrEVMr27Oc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665893; c=relaxed/simple;
	bh=mELpT8EvpAt86dh+Sl+XOiKX3cuLi6TaXGjWeybKb3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl6sE6g+jVo11XrZhU8nkaALJxio0TwIABbvlHDzJfPUJvkjVzTWKr0ZvVj88Sf3fnXWZlPIfD0OPIH9POR8CzDAoMzhiwbrgqfNHU7bPFy0nz9/7T5KfEUAAQh/RkboYpjjrv8fSh2o1w8dcD01//23R4tE3Xrse36NRzvETRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iP4XN+Ig; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iP4XN+Ig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784665891; x=1816201891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mELpT8EvpAt86dh+Sl+XOiKX3cuLi6TaXGjWeybKb3c=;
  b=iP4XN+Igw1puPa+uAtQgahHWgeJPBRGQPWOVSS2PPn1dSLvTZC6fZfoL
   +VY0PY6Ihacw+Llux7Kd8Lf7vG9M8kCm1ZJL3FflZHzyJo3A746TjC7g/
   VIOpWjyv2ANzhqHWTA36h/2evu0J30PjPJDGYeDpyat2kOUk+6Gw/pnjZ
   SMrbkNmpBOMWRD1AI0dli7BCWk5HgkRxIxpc/R81tmXVKKruBug10WezN
   j0fqcrGg3FWEdHO9gKxQlv13P61Z/hJizMUy9cclJUFbzlOv2nlPkkXJO
   5pyJVSiLE7cQJ1mI5lPMXQ7i2a7/bGN5jNrzz+vV4nZHXzVGfrEaQj1gf
   w==;
X-CSE-ConnectionGUID: f6WpGwgeQ4uHKJFu5usYyw==
X-CSE-MsgGUID: 1QvZ1EMhRmC4yUiomeA2KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85046553"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85046553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:31:30 -0700
X-CSE-ConnectionGUID: iT9pIwoOSTusznNhX95K7g==
X-CSE-MsgGUID: 1l8sK7okT1O+xBqBdpftvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="257940865"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:31:27 -0700
Date: Tue, 21 Jul 2026 23:31:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <al_XHWJktSD_MWHe@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
 <al52kpB1hklx5guG@ashevche-desk.local>
 <CAAT15mOxrJxb+jRf1P=yu=vXgDj9kRhrdSLkB8v4tEbhHOZ+Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAT15mOxrJxb+jRf1P=yu=vXgDj9kRhrdSLkB8v4tEbhHOZ+Pw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 10:49:17PM +0800, Shih-Yuan Lee (FourDollars) wrote:
> On Tue, Jul 21, 2026 at 3:27 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jul 21, 2026 at 12:21:14AM +0800, Shih-Yuan Lee wrote:

...

> Thank you for the review and feedback.
> 
> Regarding your question about why DMA fails on this hardware, I have
> just sent a detailed reply to Lukas in this thread outlining our
> physical verification findings. In short, I confirmed that the
> DMA controller's physical interrupt line is not functioning on this
> motherboard,

It might be wrongly described in ACPI tables, but in HW it works.

> and macOS and Windows 10 also completely bypass the DMA
> controller. Please refer to that email for the DMAR/IOMMU and
> cross-OS analysis details.
> 
> Regarding your other comments:

> 2. The force_pio Module Parameter:
> The original spi-pxa2xx driver is designed to hardcode DMA usage if
> DMA channels are available. I introduced the force_pio module
> parameter for two reasons:
>   • It serves as a diagnostic tool for users on similar hardware to
> easily test and verify if their issues are related to DMA.
>   • It allows developers to easily test and debug the PIO code path on
> DMA-capable LPSS hardware to prevent regressions.
> 
> That being said, if module parameters of this type are strictly not
> preferred, I am completely fine with removing force_pio and keeping
> only the DMI-based quirk for the MacBook8,1. Please let me know your
> preference.

Neither is preferred until we will fully understand what's going on there.
Yes, DMI quirk is a last resort, but to come to that we need to try better
options. See my other reply about the DMA case.

-- 
With Best Regards,
Andy Shevchenko


