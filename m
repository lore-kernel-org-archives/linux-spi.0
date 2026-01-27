Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835E35B63C;
	Tue, 27 Jan 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529671; cv=none; b=jbLo833DO8HIri12JwFR+XDhCPUOWpPZF3cmrqLFCRTrpDZq2FTQArkFt9kCVEXMGAMQS65X9oQupmoyliE9/ui/y39XyBvEXco35o6zoGxInvx0Aqjku18pck6tA66wevoeio5bV8/wZm/jLh8F66SjhzaHoAwyIc4S4dJe1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529671; c=relaxed/simple;
	bh=2g0eTNCjXzdN3etSNGWXA73wJbKBKuhuZIBhCohpH4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHIvrogbDXSLiR4vZzTh+Vg4ms5ENcmXRbmdN2a7UYwODg3O+tQTrQO4NOedtS9pd9hCp77S0mZxBoQ9vKLEI00jefrtg9oixVN88sLgpBrnFi+kdSd/C3qLAfle/zY2uJ3mzXSmtd7iJKSrowluHmI2QPOEm8j4x08yt4hAUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGa1+bDk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGa1+bDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769529668; x=1801065668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2g0eTNCjXzdN3etSNGWXA73wJbKBKuhuZIBhCohpH4I=;
  b=eGa1+bDkZNcXsTh+hg/WFmqLAtTeF3tJoOzK3DecxzgPmNuS0NF9WIHp
   jfSBTxkAg8eo+5VABkQmOdUUcYlX1nol2YkGk+WN0vYCkuSv9bbdPMjuT
   wijYlld8EGXYADMKYQcKRGVTUFs9PiDIfJWGr9thn0CQYTx4+doiC/m06
   xPK7vSnsSj9KeQblMEl1IyMIpBDWwfaJEvUCz8X0399Ox2gvMv63dpYAx
   /dhkTWCWJeIOBAWY3ITViiIKr/t1vZTjPKIo07jnWlSEAdgxmLaRtTMyy
   /grmolKsbK8+RnmbztD2FOQYoxoUTdH2HVUyHncESBlg9cqMb9CyLB2KP
   g==;
X-CSE-ConnectionGUID: PcoZBVPfSCeNVUF6W+qKpg==
X-CSE-MsgGUID: s5NbVazRTpaYDYQM+wG0pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69745860"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69745860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:01:06 -0800
X-CSE-ConnectionGUID: NOptSRkiS4eNYNH6EvyupQ==
X-CSE-MsgGUID: uhn5LrmYQ7qmoWoasvHBNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212475831"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 27 Jan 2026 08:01:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 066A098; Tue, 27 Jan 2026 17:01:04 +0100 (CET)
Date: Tue, 27 Jan 2026 17:01:04 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw-mmio: support suspend/resume
Message-ID: <aXjhQNaO6QnkdE3S@black.igk.intel.com>
References: <20260122155046.12848-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122155046.12848-1-jszhang@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 22, 2026 at 11:50:46PM +0800, Jisheng Zhang wrote:
> Add system wide suspend and resume support, the implementation is
> straightforward, just call spi_controller_suspend() then assert the
> reset and disable clks for suspend, enable clks and deassert reset
> then call spi_controller_resume() for resume.

...

> +static int dw_spi_mmio_resume(struct device *dev)
> +{
> +	struct dw_spi_mmio *dwsmmio = dev_get_drvdata(dev);

> +	clk_prepare_enable(dwsmmio->clk);
> +	clk_prepare_enable(dwsmmio->pclk);

You forgot to check for an error code from the above.

> +	reset_control_deassert(dwsmmio->rstc);
> +
> +	return dw_spi_resume_controller(&dwsmmio->dws);
> +}

-- 
With Best Regards,
Andy Shevchenko


