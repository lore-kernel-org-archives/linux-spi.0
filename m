Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F653AEF58;
	Mon, 20 Jul 2026 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577584; cv=none; b=k1jkppi0K1nHNWEh3PK2IKWWrRMngcbzYqrkVfyPU9+cpc3LHLdZrBlLn3bUjjMFgFqwqSNsaVT66hbBC9wSacblcg8jk5Rsrtzd/u9xeucYO+shBy7+/EBnv0zVU9v/DObXzZ8Z4p7iEgEW3mMbG/MmMSU5t48OYxUG3v4ldDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577584; c=relaxed/simple;
	bh=5nBWDPcmFe0n+me7Aphp9FEdrZbw0OAsproebJUVPfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCSfNJrERR5NLM8HtKZzD0nFz0Kggxg/x3G9Rhmc2hHOYkjoPtDR0UjdFXlajSvJah8iTBYWPy5JM/quNC3a17cC/FkPpkinxnzUHMNlocQpbTO5VI+U6ld46UHvOsDVd34YBT/C2a4L8ih7LFZ57se4V97Af+CfUZAgKU60VI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxfFiq1w; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxfFiq1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784577580; x=1816113580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5nBWDPcmFe0n+me7Aphp9FEdrZbw0OAsproebJUVPfo=;
  b=WxfFiq1w3vluIKcUCoGfEelQpakTFsgHYNr9uOHXpbEt9ZC52glWhVW2
   c+DUhrnxBwb/gVtbR9wMxOUdavmUQUrszCuOrCWVnJSwuC/DWW9L6enPg
   55eGYIf0lx5mhd8b5MsLxRDNf+tUg4USql2PUOPtsqpKa5OLJc5pzfLnB
   HdGrfYqOZ5JEQkhhKjEECNxvpqcGA9j3JnWgpruy2vMrmWJ5d63/AJ1Gs
   OAqqAsM7FLk1DRym1W99W3tjdY6Q+nR8KXCFLfjXVWIGBrbeQr+6PoUMk
   alG9wCmY3DKrzNv5GIaZzBCHhwVwE79bKKAZ7stPqHMK1n9+JyuyYj8xZ
   Q==;
X-CSE-ConnectionGUID: xLjKDjnJS/G3sucn9RWeXQ==
X-CSE-MsgGUID: cVSr7uXLROe6lQ5sKYldCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96680605"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96680605"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:59:39 -0700
X-CSE-ConnectionGUID: eIrH41XgSc6mjV9zSfN6lw==
X-CSE-MsgGUID: fSuRV11BSymJPi12DM5ZSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="295761514"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:59:36 -0700
Date: Mon, 20 Jul 2026 22:59:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 6/7] spi: pxa2xx: restore LPSS private register state
 on S3 resume
Message-ID: <al5-JasTYF5r8A-j@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-7-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720162117.32304-7-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 12:21:15AM +0800, Shih-Yuan Lee wrote:

Is this series AI-assisted?

> Intel LPSS SPI controllers lose all private register state across S3
> suspend because the LPSS power domain is fully removed. On resume the
> driver only re-enables the SSP clock, leaving the LPSS private registers
> in their power-on-reset state, which causes two problems:
> 
> 1. LPSS_PRIV_RESETS (offset 0x04 within the LPSS private space) stays
>    zero, keeping the functional block in reset. Any MMIO access while
>    the block is held in reset causes a PCIe Completion Timeout and a
>    watchdog-triggered system reset. LPSS_PRIV_RESETS_FUNC and
>    LPSS_PRIV_RESETS_IDMA must be de-asserted before any other register
>    access on resume.
> 
> 2. The LPSS software chip-select control register must not be blindly
>    restored from its suspend-time snapshot: if CS was asserted at the
>    moment of suspend, restoring that state corrupts the first
>    post-resume SPI transaction. Instead, call lpss_ssp_setup() which
>    unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
>    the state established at probe time.
> 
> To resolve these issues safely:
> - Wrap S3 suspend/resume with pm_runtime_resume_and_get() and
>   pm_runtime_put_noidle() to guarantee active clocks during MMIO
>   access and preserve PM reference counting.
> - Restrict LPSS private register save/restore to LPT, BYT, and BSW

^^^^ (1)

>   platforms via pxa2xx_spi_need_lpss_restore() (newer platforms are
>   handled by intel-lpss.c).
> - Save only the first 6 LPSS private registers (offsets 0x00..0x14) in
>   drv_data during suspend, avoiding reserved offsets beyond 0x14.
> - On resume, de-assert resets first, restore saved registers, call
>   lpss_ssp_setup(), and clear drv_data->suspended to prevent unclocked
>   IRQ access.
> - Add error recovery paths for spi_controller_suspend/resume failures.
> - On the resume error path, call pm_runtime_set_suspended() before
>   pm_runtime_put_noidle() to align the PM runtime state with the
>   already-disabled hardware clock, preventing pxa2xx_spi_runtime_suspend()
>   from attempting unclocked MMIO via pxa2xx_spi_off().

This is an ugly hack.

Saving context is done in drivers/acpi/x86/lpss.c (see #1 why this file).
If something wrong in the flow it has to be fixed there, not here.

-- 
With Best Regards,
Andy Shevchenko


