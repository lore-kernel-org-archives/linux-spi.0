Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AC3C10B5;
	Mon, 31 Aug 2026 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161130; cv=none; b=gogkmmdYY4H5J+JYUZuOHyh1WYSP7NMmj4opP9UB/2uLHz+LQQqr0D5iGEp4zNBsP/fLmkGIld5sGaWLO1Sz5+VKxePqJEk0aCNvh7awIu5CPUdCjMux7ewQ0CTRhup8iCY3wqYiXDSD0PoQO8D9t7oRCWcIpwGrK9GkmVq8Li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161130; c=relaxed/simple;
	bh=kEHjqXXuUEoJXmucqWdm1GsfAKRreBLBMjYuVV9iNCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmvrmCA0vkpWQttaSrugcqSQU93e8cLMgQsv2c3SY/F8XkseYnv6Bw0twbhgEpZrGVtMOevLs0GfHPd5dnewNw/3y17kBk5CqGbbKGLKrro03qa0SSi+i1LGfj1KDaM+qjZZg9W/c87/+4bv13uMTb3K1SSuN3MjsyY6kUA5Fn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnddLzQS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnddLzQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788161128; x=1819697128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kEHjqXXuUEoJXmucqWdm1GsfAKRreBLBMjYuVV9iNCY=;
  b=OnddLzQSkg2t75Tgln+0TV2kqxfyMg8Hyu9mNmRsE3uuA6Zfpoh+qn1Y
   gb2XEWot3w+uASdOsZeXEUkDWCHb2hj80cI+PJInk4r66sY5aOfNb1/Yf
   C8uMrgOKhgjb6PonCdiuLsNwRdJ3NftyQXf1AxD55+WDcOmoMNCBz7Apw
   kelUY6y8lQmNVE50T0nCCehMgQl5p2oonGeGzGcvw6AxWup4hGIED+YtO
   8Gic8j6vTfEAX6PhNvc5OVZ7+eyRXrn+wUx+VkcwH5AqpwoEqClikaa/F
   mlaxhsDoUJ/9zVElgZFQaNJQExZSN/UY7cuK4vT3cCWYoG6jUud+SyFhx
   A==;
X-CSE-ConnectionGUID: tToSHqJET4mS3LdTZR5xQg==
X-CSE-MsgGUID: +qmnGWHdQ72EsBsiQ6lwig==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99160103"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99160103"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:25:27 -0700
X-CSE-ConnectionGUID: iJ0aaLtrR9qmdUVlOOVs/w==
X-CSE-MsgGUID: dHqfOLPHTsShz3S/D2cxfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272236698"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 31 Aug 2026 00:25:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6108999; Mon, 31 Aug 2026 09:25:24 +0200 (CEST)
Date: Mon, 31 Aug 2026 09:25:24 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: tjakobsen84@protonmail.com
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: spi-intel: report controller enforced write
 protection
Message-ID: <20260831072524.GD124825@black.igk.intel.com>
References: <20260829-spi-nor-platform-lock-v1-0-cd362d4914e2@protonmail.com>
 <20260829-spi-nor-platform-lock-v1-2-cd362d4914e2@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260829-spi-nor-platform-lock-v1-2-cd362d4914e2@protonmail.com>

Hi,

On Sat, Aug 29, 2026 at 03:04:33AM +0200, Tobias Jakobsen via B4 Relay wrote:
> From: Tobias Jakobsen <tjakobsen84@protonmail.com>
> 
> On Intel PCH platforms write protection is enforced by the controller's
> protected range registers, not by the flash chip's block protection
> bits, which are typically left clear. The SPI MEM conversion left
> spi-intel without visibility of the MTD device, so it cannot supply MTD
> locking operations directly.
> 
> Pass a write protection query through struct flash_platform_data, which
> spi-intel already uses to hand the partition layout to spi-nor.
> 
> Note this asks the opposite question to intel_spi_is_protected(): rather
> than whether a flash region contains a protected range, it asks whether
> the queried range is itself entirely covered by one, which is what the
> MTD layer means by locked.
> 
> Tested on a Coffee Lake i5 with PR0 covering 0x860000-0xffffff and
> FLOCKDN set, querying MEMISLOCKED over four ranges:
> 
>                                PR0 range  whole chip  in PR0  below PR0
>   unpatched                       -95        -95       -95      -95
>   chip lock flags only              0          0         0        0
>   patched, no chip lock flags       1          0         1        0
>   patched + chip lock flags         1          0         1        0
> 
> The whole chip and below-PR0 columns stay unlocked because only
> 0x860000-0xffffff is covered by a protected range.

This looks pretty much that it got assistance by LLM, if this is the case
please add Assisted-by tag as well.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221927
> Signed-off-by: Tobias Jakobsen <tjakobsen84@protonmail.com>
> ---
>  drivers/spi/spi-intel.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
> index 7494b921a..667291979 100644
> --- a/drivers/spi/spi-intel.c
> +++ b/drivers/spi/spi-intel.c
> @@ -1223,6 +1223,46 @@ static bool intel_spi_is_protected(const struct intel_spi *ispi,
>  	return false;
>  }
>  
> +/*
> + * Unlike intel_spi_is_protected(), which asks whether a flash region contains
> + * any protected range, this asks the opposite: whether the given range is
> + * itself entirely covered by a write protected range. That is what the MTD
> + * layer means by "locked".
> + */
> +static bool intel_spi_is_range_protected(const struct intel_spi *ispi,
> +					 unsigned int base, unsigned int limit)
> +{
> +	int i;
> +
> +	for (i = 0; i < ispi->pr_num; i++) {
> +		u32 pr_base, pr_limit, pr_value;
> +
> +		pr_value = readl(ispi->pregs + PR(i));
> +		if (!(pr_value & PR_WPE))
> +			continue;
> +
> +		pr_limit = (pr_value & PR_LIMIT_MASK) >> PR_LIMIT_SHIFT;
> +		pr_base = pr_value & PR_BASE_MASK;
> +
> +		if (base >= pr_base && limit <= pr_limit)
> +			return true;
> +	}
> +
> +	return false;
> +}

Can you use intel_spi_is_protected() or at least make a helper that reduces
the code-duplication here?

> +
> +static int intel_spi_is_locked(struct spi_device *spi, loff_t ofs, u64 len)
> +{
> +	struct intel_spi *ispi = spi_controller_get_devdata(spi->controller);
> +
> +	if (!len)
> +		return 0;
> +
> +	/* Protected range registers work in 4k units */

This is not too useful comment, it should be obvious so I would drop this.

> +	return intel_spi_is_range_protected(ispi, ofs >> 12,
> +					    (ofs + len - 1) >> 12);
> +}
> +
>  /*
>   * There will be a single partition holding all enabled flash regions. We
>   * call this "BIOS".
> @@ -1395,6 +1435,12 @@ static int intel_spi_populate_chip(struct intel_spi *ispi)
>  
>  	intel_spi_fill_partition(ispi, pdata->parts);
>  
> +	/*
> +	 * The protected range registers address the first chip, so only it can
> +	 * be queried this way.
> +	 */
> +	pdata->is_locked = intel_spi_is_locked;
> +
>  	memset(&chip, 0, sizeof(chip));
>  	snprintf(chip.modalias, 8, "spi-nor");
>  	chip.platform_data = pdata;
> 
> -- 
> 2.53.0
> 
