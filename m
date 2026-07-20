Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE411CA9;
	Mon, 20 Jul 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575642; cv=none; b=IC36lO/MZd4op0Fq5UJS85aIAc+iP8ZXsspbookzuUxChPLwbD5AoYfmmGQNMLbRHX7WmF7JAxYXjXMwpMA5qZDkfZNE+WjfuWTmvv9T2zU/VWqz7Q/cKs5y9TX/KLPFSK7KLBSUk17nVQhFZ6osB9gyJCLre2JuzVtgtsNbkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575642; c=relaxed/simple;
	bh=hWgaDkOb0LbmVmmiCxtUvfxEken1qhpQkfHaM7Fgk3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHzjQPaoPCeBBMavwV2x6IpTDv4O3Qb1gUF/1irSBA5Xyqu39UgmGfWJSLaywA1+fzhNW/3N7wrOybZGiqpJSKWyOZwwgOQPA/pVShpIhq9Adnsu9FGMUZoaQRkJO5Fm9qWKDKsbOSnF3ndlM8VULGI6p4Q+MfakuaDUxbQ0H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGF4aVqi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGF4aVqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784575640; x=1816111640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hWgaDkOb0LbmVmmiCxtUvfxEken1qhpQkfHaM7Fgk3A=;
  b=NGF4aVqiuLuwhnZpTpsvLDzmf/ADWEukC1zviQxA+iI5NOk7nv/fv2g2
   WTb2cfZVS/VcnkaBRPdnSn2krEWiyYdFihLXXwmHGUh2hnSQHQXc/F+x5
   x5Dm1igl8HUrq4cQPRcqavk546h8xIyy3loQNmWpI4fBjmhPUjqlt18T6
   rJvoawclYc3JiJeWzpYL9/uYDeI8QDfdu1KkhJmr2+Zdzwmeyz/OUn6fK
   f4MtEsJrMapjL2ZrsP22qJBXyYmq4yrPKt1msBQrlndmvnD+DWq+yUuAh
   ode1EqkxM1gedxhtAzSxpSKUTM41byGDJBpRaiW5GDoZu4MRAQzLBuZjr
   Q==;
X-CSE-ConnectionGUID: T07AAbhHTxmcaab2Xh6EoQ==
X-CSE-MsgGUID: AghHREAdSQCuUACU8nPpWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="88843557"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="88843557"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:27:19 -0700
X-CSE-ConnectionGUID: VEpARZS2TN6OfnH+jxlpNw==
X-CSE-MsgGUID: VCqD1pLAT0WCgKQ3SjF7uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257598201"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:27:16 -0700
Date: Mon, 20 Jul 2026 22:27:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <al52kpB1hklx5guG@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720162117.32304-6-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 12:21:14AM +0800, Shih-Yuan Lee wrote:
> On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
> 00:15.4 suffers from hardware DMA handshake failures and interrupt
> routing bugs, causing keyboard/touchpad transactions to fail when
> DMA is enabled.

Why? The thing like this I noticed on some other HW which required different
DMA settings. Have you tried to investigate the issue more?

> Move the forced PIO mode DMI quirk to spi-pxa2xx-pci.c (the LPSS host
> controller PCI glue driver) to avoid layering violations in client
> drivers (such as applespi).
> 
> Add an explicit DMI match table for MacBook8,1 and a module parameter
> spi_pxa2xx_force_pio to allow forcing PIO mode on demand.

This looks like a hack. Please, if you have a hardware, try to dump the errors,
collect the data corruption or timeouts and provide more information. DMA for
SPI on LPSS hardware never was a problem (unlike UART in some cases). I'm almost
100% sure the problem is in DMA configuration / setting bits.

...

>  #include <linux/dmaengine.h>
>  #include <linux/platform_data/dma-dw.h>
>   +#include <linux/dmi.h>

Keep list ordered.

>  #include "spi-pxa2xx.h"

...

> +static bool spi_pxa2xx_force_pio;
> +module_param_named(force_pio, spi_pxa2xx_force_pio, bool, 0444);
> +MODULE_PARM_DESC(force_pio, "Force PIO mode (disables DMA) for SPI transfers. ([0] = disabled, 1 = enabled)");

No. There is no room for module parameters like this.

-- 
With Best Regards,
Andy Shevchenko


