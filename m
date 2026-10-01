Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C583C345D;
	Thu,  1 Oct 2026 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838656; cv=none; b=P/Uhk2X/JFcNC9jF75C0lRmCdq3NNzW9qzQeUdysR8Sr4rx8ySQER+xfsb9reYJ+NEyq2Pvop1zhO/rTJP7cTncIzB0JV9hvsz5xQ88HrNpWWIjrljC+m3mCA3ewAIlj5PQYKXG6r/oXxJajKcJcIobIk7NrsGsiUmctHc0ugsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838656; c=relaxed/simple;
	bh=2BkzFXAjmTTbybLib9uPTvSgVl9rmz7HuMDD/0WeqNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwJcb6AGElBFEbN4GsVgrL2ln7V+eruFuMIi+yqfWpgSCUE/I07N04JUSVouaO5213xm5I8+OadSRBImHtk7eFNT+kerNfBj0msPuV1VFXTGJdGcqeF+ZEnTCbwsk7rULusFUgg0IVH/zFDG5mC7gwEGYMxelCFXiSkApH4267U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXtWdp57; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXtWdp57"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790838651; x=1822374651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BkzFXAjmTTbybLib9uPTvSgVl9rmz7HuMDD/0WeqNM=;
  b=YXtWdp579ktVGVyHN0w97wub7qAFBQcxYfaxcTpJIvRhUeLFi2ZoDoLg
   P9Xf2sOsdXHcvtuFfHa1ELtOo8hmn3hZmbHZrg6wi9Hs9VUpgO+PImZo9
   OFeEN71wo1ORX6fhc7dlYezrDdHeGhV2jHLiTIReKpRZ72Qt/T0voRh4b
   YbuqDTYFSim2MgcYFwqbxi8YxG7Pdnmba2olFrbBhvKIm6+sc7s3espcl
   DXc3CTCJIkqqkovgQQb8eCjeMlKp+qkGWlsj9DZFPHVZyJVHndMbwu8sM
   fDz/NW9Ibif/YeVKUd0HOgh4mCI4H4S3P7KywfQoVluR3CamHE63kc+9l
   A==;
X-CSE-ConnectionGUID: jdzltQH4QoqA3KK5glCY7g==
X-CSE-MsgGUID: JEN2OOwmQES0JV83IktVtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102162293"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="102162293"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 00:10:45 -0700
X-CSE-ConnectionGUID: T/b2vH+UQxyCUoaIA7lPDw==
X-CSE-MsgGUID: qLKlflxmSwSBWcep8u/o+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="275032205"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 00:10:42 -0700
Date: Thu, 1 Oct 2026 10:10:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v17 1/6] spi: pxa2xx: rename local status variable to ret
Message-ID: <ar4HcFk_IW7IBAgk@ashevche-desk.local>
References: <20260930160629.1822-1-fourdollars@debian.org>
 <20260930160629.1822-2-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930160629.1822-2-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 12:06:24AM +0800, Shih-Yuan Lee wrote:
> Rename the return value variable name from 'status' to 'ret' in the
> pxa2xx_spi_probe(), pxa2xx_spi_suspend(), and pxa2xx_spi_resume()
> functions to conform to standard Linux kernel coding conventions.
> 
> Assisted-by: Antigravity:gemini-3.8-flash sparse

Assisted-by: LLM

...

> -	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
> +	ret = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
>  			drv_data);

Also fix the indentation of the second line. Actually just join them to become
a single line.

> -	if (status < 0)
> -		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot get IRQ %d\n", ssp->irq);

...

>  		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
>  						"ready", GPIOD_OUT_LOW);
>  		if (IS_ERR(drv_data->gpiod_ready)) {
> -			status = PTR_ERR(drv_data->gpiod_ready);
> +			ret = PTR_ERR(drv_data->gpiod_ready);
>  			goto out_error_clock_enabled;
>  		}

Actually this can be redone as

		ret = PTR_ERR_OR_ZERO(drv_data->gpiod_ready);
		if (ret)
			goto out_error_clock_enabled;

-- 
With Best Regards,
Andy Shevchenko


