Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6054BB5CF;
	Thu,  3 Sep 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446021; cv=none; b=HzTdTJwDVefV1kHIgC0AxZN4bjGE1gbZJirCR5akd7lLnop0tpNEE97r3UMElLh82zOUftKsaHGRgKguN4eDbKSzxHHscP8FpWxIE+KhlQWSWXaYGv0IdlEP/kYBwvaCkfOlZfuP8Z1PNNon9HLNmdCDO1A0N7ETQPCHUXBzQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446021; c=relaxed/simple;
	bh=HsPxWnRGaVGv62xWxf4ggzWQrusBWON46ZH6Z0Dw1Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxih5boPX6nPIV3itFYTF0ni7YJKKcAGSKkF4Ie99N2BN+MyefRmZtuiS2tv7VqqXdbjnmbW3NC5YMU9T7Xa6XtubfKhorndAaLZJW1Hu5fKleo/02RGdPsvlHs33KkSRjDQ9AQHFdMXxedJkyIOzPxcIkdhylcCSks5Qz1oe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diCP/1CC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diCP/1CC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788446016; x=1819982016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsPxWnRGaVGv62xWxf4ggzWQrusBWON46ZH6Z0Dw1Bs=;
  b=diCP/1CCnooHIY+sFGu51gbtxWOseJSaTgxBKjiK8LUsRzbJhkXa6i+U
   jA2nGAnw7s1G+Ds4V0CZDgCeRt6jjNe2NXz5A+svyYJowkUUdDZ0d0fuK
   4Rfjuu7DPP8amt4cIsrDphaEUMKkyUV2E02n5BuC5t8RIOnY6QvwwbRsu
   UVnIhq0H2a/jVCaPh4bt7sWfsvCJ0e8wzVDYj8+Q0tZX7E58YD/Khnig/
   N1tFpNZFbPXhQrxs+2ukvxPZzby8jYN4i6s4QpioEMHv8eIerf+SouDyR
   wQbcQKRz+IlIcOG9etIUFZU2THHEYXXLUkp7ilrPMHzbQCDgipNTvvxJ+
   g==;
X-CSE-ConnectionGUID: aqGWb+QRS6+z0XfW7iQyVw==
X-CSE-MsgGUID: 5DNAh4qNQbK3zKfYs/XjvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92750788"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92750788"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 07:33:33 -0700
X-CSE-ConnectionGUID: g96UcXgRStWn97Pbm7pDKw==
X-CSE-MsgGUID: Lm//J9dJSny2c4zXUc1w8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269737522"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 07:33:30 -0700
Date: Thu, 3 Sep 2026 17:33:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	dlechner@baylibre.com, broonie@kernel.org, nuno.sa@analog.com,
	michael.hennerich@analog.com, jonath4nns@gmail.com,
	Dennis Heinzel <dennis.heinzel@irs.systems>
Subject: Re: [PATCH] spi: axi-spi-engine: fix stale SYNC IRQ pending
Message-ID: <apmFOKpncNJtrTF4@ashevche-desk.local>
References: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 10:49:22AM -0300, Jonathan Santos wrote:
> spi_engine_setup() sends a SYNC(1) command and polls SYNC_ID to confirm
> it was parsed by the FPGA, but never clears the corresponding interrupt
> pending bit (INT_PENDING[SYNC]). When the first real SPI transfer starts
> and INT_SYNC is enabled, that stale pending bit fires immediately, causing
> the IRQ handler to see the leftover SYNC_ID from setup, match it against
> the current transfer's ID, and prematurely signal completion before the
> hardware finishes.
> 
> This race manifests at low SPI clock frequencies (~2-3 MHz), where the
> FPGA takes long enough to execute the transfer that handler is parsed
> before it finishes. At higher SCLK rates the transfer completes fast
> enough that the issue is masked.
> 
> Fix this by clearing INT_PENDING[SYNC] after the polled SYNC, ensuring no
> stale interrupt is left pending.
> 
> Reported-by: Dennis Heinzel <dennis.heinzel@irs.systems>
> Link: https://ez.analog.com/linux-software-drivers/f/q-a/604145/axi-spi-engine-stale-sync-pending-can-complete-first-transfer-early-at-low-spi-clock-2-3-mhz

We have a Closes tag.

> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

...

> +	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
> +					 reg, reg == 1, 1, 1000);

While at it I would replace 1000 with 1 * USEC_PER_MSEC

> +	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
> +	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);

In both cases? Error (timeout) and not?

> +	return ret;

-- 
With Best Regards,
Andy Shevchenko


