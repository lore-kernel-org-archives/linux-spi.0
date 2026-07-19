Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C7E573;
	Sun, 19 Jul 2026 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784447602; cv=none; b=GnFyA1SGp/sJzqt83VEOzYeHiCTMEZ2AIUc9wyTizQMKRdN8P0mFyNC9tikHlKaF0KQ0NVBxuUjbTOUWLVXz3rob8Am7zvLI+1E1T+qPg3m9kCZTVXOV43h7ho/uyMEs3w4C/VBmJA5+IKb9Z5bPUX8P/7XiTzOuGWYGry5wycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784447602; c=relaxed/simple;
	bh=sl2horV50lnhE84rW79Xs4WQ2NVNCmOai5zekMJVNgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcIOo/xNB+/E1PQBdwY9KTh6jfkrdfU7G0tncxW3MfR5rMYIv6xf7eN1xufDG++sOt/5/y+gsYTvKTgyXDby1flJPBZxh1bEnphFS3hg/dfVE8SvVUXmD13NUrl5T61tAI78aBiELA1/z3aC6aDFdDy2X4nikJJTFxoheo2BpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVMZMzGB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVMZMzGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784447599; x=1815983599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sl2horV50lnhE84rW79Xs4WQ2NVNCmOai5zekMJVNgw=;
  b=JVMZMzGB10ivUd/gL3j2h+bA2g6EjNTZULTYzhVi2I+7NZlKQX4oSycL
   U7qPgeqQFWeiu7CNpeEg9SKC7nfqmF1OwBgHBEaWW4UO8oSDcyn0ylLrK
   bPUPANYvkNZL2boRrtPjkX6Xd3Ad6ylYnp9A4toGpIhnch2LnOqKxM/pC
   KXn45YGtwTOCWlKTX/AlQvpoD3MQYMlWEj2EvY+DJOPhu1V3xHHY3DJ58
   LFpic87rysnM9NgkpFI+jz8biD11AjQoEQ7SroWpB4LyvqVhh+2bh9BOp
   uOpg6ep1KspUZcCHbjkuHYnTZSfKSLiBrX/xl71GhiyBmPDqYYffc6Gal
   A==;
X-CSE-ConnectionGUID: iv297JtTQdGJF+OwRJdL5g==
X-CSE-MsgGUID: JNhxAkYXT26MyWpWzy0uow==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="88881663"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="88881663"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 00:53:18 -0700
X-CSE-ConnectionGUID: zZbMTxriS5S9vrciAOLl+Q==
X-CSE-MsgGUID: FCfyWab2ToedBoRwHgmb/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="257813299"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 19 Jul 2026 00:53:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0EB9395; Sun, 19 Jul 2026 09:53:16 +0200 (CEST)
Date: Sun, 19 Jul 2026 09:53:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/3] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and
 LPSS S3 resume state fixes
Message-ID: <alyCbKAQh4jtZVDv@black.igk.intel.com>
References: <20260718145209.6678-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718145209.6678-1-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Jul 18, 2026 at 10:52:06PM +0800, Shih-Yuan Lee wrote:
> Hi Mark,
> 
> This 3-patch series resolves issues in the spi-pxa2xx host controller driver
> related to Intel LPSS SPI controllers and the Apple MacBook8,1.
> 
> Patch 1 moves the forced PIO mode quirk for the Apple MacBook8,1 LPSS SPI
> controller from the client driver (applespi) to the host controller PCI glue
> driver (spi-pxa2xx-pci) where it belongs.
> 
> Patch 2 fixes runtime PM and interrupt handling in PIO mode: when DMA is
> disabled, aggressive runtime clock gating causes PCIe Completion Timeouts on
> subsequent MMIO accesses. It scopes autosuspend lockout strictly to LPSS controllers,
> tracks clock state to avoid disable underflows, protects shared IRQ handling,
> preserves the if (!pm_runtime_suspended(dev)) check in suspend/resume to avoid
> PM state desynchronization on non-LPSS SoCs, and uses pm_runtime_put_sync() upon
> driver remove to correctly synchronize the PM state machine to RPM_SUSPENDED.
> 
> Patch 3 fixes S3 suspend/resume for Intel LPSS SPI controllers. The LPSS
> power domain is fully removed across S3, losing all private register state.
> Accessing MMIO on resume while the block is held in reset causes a PCIe Completion
> Timeout and a watchdog system reset. To fix this, we save the LPSS private
> registers in struct driver_data during suspend, de-assert resets first on
> resume, and restore the saved registers.

> Changes in v12:
>   - Addressed feedback from Sashiko review on the v11 patchset for Patch 2:
>   - Preserved the if (!pm_runtime_suspended(dev)) check prior to enabling/disabling
>     the clock in pxa2xx_spi_suspend() and pxa2xx_spi_resume(). On non-LPSS platforms,
>     if a device was runtime suspended prior to system sleep, unconditionally enabling
>     its hardware clock during system resume forced the clock ON while the PM core
>     retained RPM_SUSPENDED. Restoring this check prevents PM state desynchronization,
>     avoiding power leaks on non-LPSS platforms.

What's going on here, please?

It's v12 and you haven't even a thought to add the authors of the drivers, nor
any one from Intel whose SoCs are under the question here.a Besides that the patches
need more work.

-- 
With Best Regards,
Andy Shevchenko


