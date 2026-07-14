Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2443D50E;
	Tue, 14 Jul 2026 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021045; cv=none; b=IQlhDPPzxlxP9DcRAWeTzKdOpWO4QJgKr60d/FcBJ/djzlR+EyMyXW0e8YX3SI07pVVrrq2OMAciWo/UDE5F99UAJV8EvGCDS4J31L95t4zewaKQDhF+fDLvaMPGePqPa6jmLueVZcL44+4+y3hpiIXf5rs0FwbQFu89FwB3RTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021045; c=relaxed/simple;
	bh=5ZYTbEsM0CzwOpABOL1t0HJuK4VZVIO9Kc3UUPOYhvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpAvtKnSLRbZSwGuqVgEydkHaIDVVfrbHprgvoL/XARZuzcxXiradcV8xblCli1CoK3RdDTHuIq5mh8r5cKwhFZ1xllpvOwFtayPZhQICQmK+d6F2/a4nsq0B9z/VJkCdswXLQlhAe2Qufgx9ruYDxGApQRTm8LpN20mhRPSCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNVCoT/t; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNVCoT/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784021043; x=1815557043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ZYTbEsM0CzwOpABOL1t0HJuK4VZVIO9Kc3UUPOYhvI=;
  b=DNVCoT/tIOgltTe6cNlsiHCWT2dcFN7YjRJduY0+z+UEjUg8r/dkWCbQ
   BMUlpsR5AlwUHF4nZ3p+W0ZnIO0R4HLdeMmZ3clMztqyySjvIkYRydCvw
   PSolH/hbR0i8B+PZveAuH8rClcjJhGgCJf5rUEDe+lYkPIlaq+AHKnF5H
   c5sB337SAOTZF0sFvfu2XenLlysSAeC///U0Dw/KHMoZLbpxalgtlGipa
   zHsDjqjb3XabCjxjmuLmJv2+J8kmESwQRaYnpGs6qKHYQKm4aqHXC35wU
   HSMl0neRKMOLRcfk2Cf0y7a66sPUFFVZiM7Ba29l3DFkforPQ79Nw6Msv
   g==;
X-CSE-ConnectionGUID: 4/AniTk9R+a1IBDSPlZDCw==
X-CSE-MsgGUID: g3ZtaPhaQ9CLIatlMrH0Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95284978"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95284978"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:24:02 -0700
X-CSE-ConnectionGUID: d+QqfCY0Q+KGzU8gCDokqw==
X-CSE-MsgGUID: qzYI9dYPTU+A+jmtO2zqsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254679626"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:24:00 -0700
Date: Tue, 14 Jul 2026 12:23:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 2/6] spi: add per-transfer CS mask
Message-ID: <alYALGJjjP24Yxhb@ashevche-desk.local>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <3b38df61feee9a0c7e08bd03e624be12b5812cda.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b38df61feee9a0c7e08bd03e624be12b5812cda.1783729282.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 02:56:02AM -0300, Jonathan Santos wrote:
> Multi-CS devices assert all their chip selects simultaneously by default
> via cs_index_mask. Some use cases require selecting a subset of those CS
> lines per transfer (e.g. routing data to one of several subdevices sharing
> the bus).
> 
> Add a cs_select_mask field to spi_transfer. When the mask is set and the
> controller has SPI_CONTROLLER_MULTI_CS, spi_set_cs() builds a temporary
> spi_device whose chip_select[] and cs_gpiod[] arrays contain only the lines
> indicated by the mask, then delegates to the renamed _spi_set_cs().
> When cs_select_mask is 0 or the controller does not support multi-CS,
> the device default (cs_index_mask) is used unchanged.
> 
> Update spi_transfer_one_message() to pass the relevant spi_transfer to
> every spi_set_cs() call so CS transitions between transfers with
> different masks are handled correctly.

...

> +	/*
> +	 * Handle multi-CS controller path.
> +	 * For multi-CS controllers, we need to create a temporary spi_device
> +	 * structure that reflects the transfer's CS selection

Missing period at the end. Always follow English grammar and punctuation in
multi-line comments.

> +	 */

...

> +		struct spi_transfer *next_xfer = list_next_entry(xfer, transfer_list);

Define it in the top of the respective scope.

...

> +	if (ret != 0 || !keep_cs) {
> +		/* Use the last transfer's CS configuration for proper cleanup */
> +		struct spi_transfer *last_xfer = list_last_entry(&msg->transfers,
> +								 struct spi_transfer,
> +								 transfer_list);

This style is hard to follow, just split assignment and definition.

		struct spi_transfer *last_xfer;

		last_xfer = list_last_entry(&msg->transfers, struct spi_transfer, transfer_list);

> +		spi_set_cs(msg->spi, last_xfer, false, false);
> +	}

...

>  	unsigned	dummy_data:1;
>  	unsigned	cs_off:1;
>  	unsigned	cs_change:1;
> +	unsigned	cs_select_mask:8;
>  	unsigned	tx_nbits:4;
>  	unsigned	rx_nbits:4;

Be careful with these. Have you run `pahole` to check if there is no boundaries
break that makes some unneeded gaps?

-- 
With Best Regards,
Andy Shevchenko


