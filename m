Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29C322DAF;
	Mon, 20 Jul 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577217; cv=none; b=h5wcFcYHyVt7st3c5LkS/N8WXV22lZPM3EC3bEsXq0Q9AvE2MnzfakKA6uwR9PehpNaSGUtArcB05b6z1MLEfNf4vAn9z5YGgCgnVaDmgQ/+jHoUkXgUMXivrnui9TevoVJYnx92A6xUnPEKuvpKK5YAHV8U9GNMyxDhA188s6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577217; c=relaxed/simple;
	bh=+454JAV+BxB9Vte1eAS5c/9Mxzjo1tSIngrpdtWKheE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul/12o2NglSkyXhPZn9fCXV8cLHCTcgalGv4o/bwYjixKhOE2chL3MKndV23IymZ3U6wR38Yo9cJ1LjWpjDEOEgP9I4ZB6gla28VyawCMrOOU9AodHqs05ktSAjEyR9huJGtyycItWhH+tWypMANSb1aWhJYKPCVOV2YjWK6Wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2+quASl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2+quASl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784577214; x=1816113214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+454JAV+BxB9Vte1eAS5c/9Mxzjo1tSIngrpdtWKheE=;
  b=n2+quASlbRTIAjho2ce73xKvBn8mPrG5lWobYak0f6XKzKZ7CBRrVnGr
   2SriZm6jxqNcPyOFxv8BJYmz0SiiFzPi49uwQaWt5fCyDUcjFkve9U8ZX
   W7jvfcA1G1G3D5tHmXrORgots7nctLNTwGkl1jqael31Z655QD0I5NH+q
   K/r1hTlBcXCY3esKG7iqAxKxAj5V9s7Zy2rxv+jRm+R0RNJM5isXRD9fd
   pdXArPjruLCDKsKa+i3cjrM62Rf62KS7261seFJ8xRZn2na7T2sJ8o5Oh
   aj7MQpiXlzhI4Zb0W/UlkJ2r5KrSN412hYj4DoR8J7ZrnkiWD/5GnScSL
   A==;
X-CSE-ConnectionGUID: IyQo7V7/QlODQzYGveP/sQ==
X-CSE-MsgGUID: cvMzzuyGQ+SBpsZ1ejFxZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96680181"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96680181"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:53:34 -0700
X-CSE-ConnectionGUID: P1jYgCOPQZmE6tA/345Qww==
X-CSE-MsgGUID: 8bDkAdW4R3ek/0OxhgkRiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="295760588"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:53:31 -0700
Date: Mon, 20 Jul 2026 22:53:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 3/7] spi: pxa2xx: overhaul teardown and suspend
 sequence using pxa2xx_spi_off
Message-ID: <al58ubdrmJpPtr0F@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-4-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720162117.32304-4-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 12:21:12AM +0800, Shih-Yuan Lee wrote:
> When removing the driver or suspending the device, the clock must not
> be disabled while shared interrupts are still active. Gating the clock
> before waiting for in-flight interrupt handlers to complete results
> in race conditions where the handler performs unclocked MMIO accesses,
> causing PCIe Completion Timeouts.
> 
> Overhaul the remove, suspend, and runtime_suspend paths to use a strict
> synchronized teardown order:
> 1. Disable hardware interrupt generation at the controller level.
> 2. Mark the device state as suspended (suspended = true) to prevent
>    subsequent interrupt handlers from attempting MMIO reads.
> 3. Call synchronize_irq() to wait for any active interrupt handlers
>    to drain completely.
> 4. Gate the clock via pxa2xx_spi_clk_disable().
> 
> Additionally, commit 29d7e05c5f75 ("spi: pxa2xx: Avoid touching
> SSCR0_SSE on MMP2") documented that disabling the hardware block via SSE on
> MMP2 SoC platforms corrupts the RX/TX FIFO. Instead of calling
> pxa_ssp_disable() directly, use the helper function pxa2xx_spi_off(),
> which respects the MMP2 platform quirk by bypassing SSE register writes.

...

> +	/* Wait for any pending interrupt handlers to complete */
> +	synchronize_irq(ssp->irq);

Unneeded. free_irq() implies that.

> +	/* Release IRQ */
> +	free_irq(ssp->irq, drv_data);

-- 
With Best Regards,
Andy Shevchenko


