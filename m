Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEB25F988;
	Tue, 18 Aug 2026 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035182; cv=none; b=W8CjeOvaZ9WmKXQBLN/JeuaVj4RyS3aabUx5JxBBBJo788WrbT6TiyRpEuSM8BCi59qn+SooXCNo94kpTGjO30Vr3NZeiHiJaD8OXlAYpR3O3mzv7Y1a9BoF8eJQLlWMfKIMfx6PCeD4ijGhpQgEeEk8/XkbVwkpKDK7+ioUUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035182; c=relaxed/simple;
	bh=dwoa7Pkf7toKPG9zKyI+upibeEWgZvDkUzQFz4JD5+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBBVhCZ2GWyQvMTo+1ipc4+Jokbwspf3f2VmgYWub+TE2UZV79+qa+7/weFRYqzkvuXgWqU0G5TTaDXSznVurIpLSxTkGdUiQrc/QWJvSvofJV6CkrJiE2HP1tlg5xukGnpCptIgZMUrB3N5KoSx6Z/EzUojZBIg7NqFcKgOVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9faRYoN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9faRYoN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787035181; x=1818571181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwoa7Pkf7toKPG9zKyI+upibeEWgZvDkUzQFz4JD5+M=;
  b=h9faRYoNvD0nXgE7jFASfmky75oR4BTRhfMH+cvI/HhPxjYipBfZD/LG
   yCUmVgMkqBbzMLPhrArsc0ZAZ1JIhmaN8qTHe6h9mjx1rL2Th8FqewrHE
   FQcAqdLF5KJ+2XUxfKc2c2aKnsRzUkXI5s7lWfqPKa89PrlJTmtv0DgY5
   DpBSLWs1c0iUYBKXTDCEoXhN9bCf8NJT0HWwauS8PLm+J0KabV5rU93rq
   3JphmNzfmvMH82kIHiBcUNfg6LI+SIECMUWSNPAcbUkFQB/HvtUk9n+vL
   aveaFz0CFiC2pMfaeTYLSMi/YWj6ffbL3j+K6OkPAYyKyPTCj2zKs69Jt
   Q==;
X-CSE-ConnectionGUID: K+MqDHIbT1+O5XZfL8KBSg==
X-CSE-MsgGUID: VqzfIBYHTGCjqdVgH2QK6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98183969"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98183969"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:39:38 -0700
X-CSE-ConnectionGUID: tQafyydnTCGKjC/5oQTeIA==
X-CSE-MsgGUID: R/xYP4L2Tme6RQLkUVsLuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="258926859"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:39:36 -0700
Date: Tue, 18 Aug 2026 09:39:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 2/6] spi: support simultaneous assertion of multiple CS
Message-ID: <aoP-Jo6vqj5ks7YY@ashevche-desk.local>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <e8870b405f29cc89439701d1fcc7e88781aaab22.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8870b405f29cc89439701d1fcc7e88781aaab22.1786973376.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 08:32:43PM -0300, Jonathan Santos wrote:
> Some SPI controllers allow multiple CS lines to be toggled at the same
> time. The existing code always used CS index 0 when tracking the last
> active CS in spi_set_cs(), and unconditionally set cs_index_mask to
> BIT(0) when parsing DT, both forcing the single CS usage.
> 
> Modify spi_set_cs() to iterate last_cs[] using each logical CS index
> instead of always reading index 0. Modify of_spi_parse_dt() to build
> cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
> so the controller correctly identifies which CS lines belong to a device
> when asserting them simultaneously.
> 
> Board info, ACPI, and ancillary device paths are not updated here.
> Board info would require an API change to accept an array of CS values
> and is left for a follow-up when we have a use case for this. Ancillary
> devices are by design single-CS, so multi-CS is not a current use case for
> them. ACPI represents the CS as a 64-bit integer with no established
> convention for encoding multiple CS indices yet, so any extension there
> would require a separate specification effort.

...

>  	/*
> -	 * By default spi->chip_select[0] will hold the physical CS number,
> -	 * so set bit 0 in spi->cs_index_mask.
> +	 * Set cs_index_mask to indicate which logical CS indices are active.
> +	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
>  	 */
> -	spi->cs_index_mask = BIT(0);
> +	for (idx = 0; idx < rc; idx++)
> +		spi->cs_index_mask |= BIT(idx);

Maybe I'm missing something, but isn't it a simple mask, and for-loop is not
required?

	spi->cs_index_mask = BIT(rc + 1) - 1;

OR

	spi->cs_index_mask = GENMASK(rc, 0); // This is better as it supports rc to be 32 or 64


-- 
With Best Regards,
Andy Shevchenko


