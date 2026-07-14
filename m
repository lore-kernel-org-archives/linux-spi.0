Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DF2D47FF;
	Tue, 14 Jul 2026 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020676; cv=none; b=da9+IDhU0xgWz8qxDVyuFiiaHF6KB7f6/HbnNHm6DkZsiheopv6+bnJi3KnxyVSherCgInsMrkoGo+xx+Q9ollEZpjE+iL7KVYHyYPC28g7cK16H1q+mvqKa6dVsJk+wPzOZZviogH2n9F15m8GST9DXXL9YS+23VVGRbs44VRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020676; c=relaxed/simple;
	bh=vjbRzLr7dPV4H5yqyoWjYSmyfFTBeP+ER6B0jxcsmT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvu5E9BLfSDFaJ6C9ok+v/IclTYlyhmQ9T4oaS6IvtXBtnxrVBE8BXJ5wdOhYnXba+QRghErAieaFOY+g4Ae7/N/UD8SCRJeYinj1UBQQwm3dS5+n7UyZ6ZHuzZqgivdtTYPNtjRBEu0nRNGE8oJQoyNIWaVyYALZEc5PLhVpig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fF7Gn5VX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fF7Gn5VX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784020674; x=1815556674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vjbRzLr7dPV4H5yqyoWjYSmyfFTBeP+ER6B0jxcsmT4=;
  b=fF7Gn5VXCQug+w3yvqs/Ly+hRFMGFW4yuFBzCl0V/SB9U/WL6L+L0hls
   RcD7nc/TPz22ctJ54sOdELlWHl6EnrOcQ+5grXMUouIDYqkCwlijv0wBb
   1qhBAjuv9Q2Z8iI+/HbGrAbsNemv/DI7A05WXhfNcWKFa3Nly2uQBTFEk
   LLyiYxkAuKeSLVorKTUeKG4PYAGGjUSc65ovavED1br3gL6MuFQSANj1i
   8N7EeG7J+GNMVGwpu+Wcxv7X9I78PVOHX9CsVW+9C1PWu0IiOaqTRZZcr
   bSAKg3A7Vr5FSJNIfmOylTfvz4j5ippMSv29WhlKQCnYaXrIp8XRrPGok
   A==;
X-CSE-ConnectionGUID: ecC9mw1oS/29jZUJMIuIkg==
X-CSE-MsgGUID: E0CzaGs5RsGZaLSAYLU9QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="110185560"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="110185560"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:17:53 -0700
X-CSE-ConnectionGUID: x/GGvwDOQy2a64QIj+PLpg==
X-CSE-MsgGUID: S74e9s1ST0aVtfKvcpShTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255306597"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:17:51 -0700
Date: Tue, 14 Jul 2026 12:17:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 3/6] spi: spi-engine-ex: Add support for multi-CS devices
Message-ID: <alX-vH_ICf-ocBSG@ashevche-desk.local>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <844bb5dbe3a4f40f12575bc50b4e65875fa33d3c.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844bb5dbe3a4f40f12575bc50b4e65875fa33d3c.1783729282.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 02:56:16AM -0300, Jonathan Santos wrote:
> The AXI SPI Engine controller hardcoded CS index 0 when generating
> assert commands, so only the first chip select was being toggled even
> when a device declared multiple CS lines in the device tree.
> 
> Modify spi_engine_gen_cs() to accept a cs_select_mask argument and
> iterate all bits set in the effective mask (the intersection of
> xfer->cs_select_mask with spi->cs_index_mask, falling back to
> spi->cs_index_mask when the transfer mask is 0). Update
> spi_engine_compile_message() to pass each transfer's cs_select_mask
> at every CS transition, including cs_change and cs_select_mask
> change boundaries between consecutive transfers.
> 
> Likewise, modify spi_engine_setup() replacing the single-index CS
> assert with a for_each_set_bit() loop over cs_index_mask.
> 
> Set SPI_CONTROLLER_MULTI_CS flag in the probe path so the core
> multi-CS path in spi_set_cs() is activated for this controller.

...

>  static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
> -		struct spi_device *spi, bool assert)
> +		struct spi_device *spi, bool assert, unsigned long xfer_cs_mask)
>  {
> +	unsigned long cs_index_mask = !xfer_cs_mask
> +		? spi->cs_index_mask
> +		: spi->cs_index_mask & xfer_cs_mask;

This is an interesting style. Also, why negative conditional? It's harder
to parse. First, split the assignment and the definition...

	unsigned long cs_index_mask;

>  	unsigned int mask = 0xff;
> +	unsigned int cs_bit;

...and then, for example,

	cs_index_mask = xfer_cs_mask ? spi->cs_index_mask & xfer_cs_mask :
				       spi->cs_index_mask;

>  	if (assert)
> -		mask ^= BIT(spi_get_chipselect(spi, 0));
> +		for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS)
> +			mask ^= BIT(spi_get_chipselect(spi, cs_bit));

This requires {} now.

>  
>  	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(0, mask));
>  }

...

> static void spi_engine_compile_message(struct spi_message *msg, bool dry,

>  		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
>  				     inst_ns, xfer->effective_speed_hz);
>  
> +		struct spi_transfer *next_xfer = list_next_entry(xfer, transfer_list);

Define the variable at the top of the scope.

>  		if (xfer->cs_change) {
>  			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
>  				keep_cs = true;
>  			} else {
>  				if (!xfer->cs_off)
> -					spi_engine_gen_cs(p, dry, spi, false);
> +					spi_engine_gen_cs(p, dry, spi, false, xfer->cs_select_mask);
>  
>  				spi_engine_gen_sleep(p, dry, spi_delay_to_ns(
>  					&xfer->cs_change_delay, xfer), inst_ns,
>  					xfer->effective_speed_hz);
>  
> -				if (!list_next_entry(xfer, transfer_list)->cs_off)
> -					spi_engine_gen_cs(p, dry, spi, true);
> +				if (!next_xfer->cs_off)
> +					spi_engine_gen_cs(p, dry, spi, true,
> +							  next_xfer->cs_select_mask);
>  			}
>  		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
> -			   xfer->cs_off != list_next_entry(xfer, transfer_list)->cs_off) {
> -			spi_engine_gen_cs(p, dry, spi, xfer->cs_off);
> +			   xfer->cs_off != next_xfer->cs_off) {
> +			spi_engine_gen_cs(p, dry, spi, xfer->cs_off, xfer->cs_select_mask);
> +		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
> +			   xfer->cs_select_mask != next_xfer->cs_select_mask) {
> +			spi_engine_gen_cs(p, dry, spi, true, next_xfer->cs_select_mask);
>  		}
>  	}

...

> static int spi_engine_setup(struct spi_device *device)
>  {
>  	struct spi_controller *host = device->controller;
>  	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
> +	unsigned long cs_index_mask = device->cs_index_mask;
>  	unsigned int reg;
> +	u32 cs_bit;
>  
> -	if (device->mode & SPI_CS_HIGH)
> -		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
> -	else
> -		spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, 0));
> +	for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS) {
> +		if (device->mode & SPI_CS_HIGH)
> +			spi_engine->cs_inv |= BIT(spi_get_chipselect(device,
> +								     cs_bit));

It will be easier to follow when a single line.

> +		else
> +			spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device,
> +								      cs_bit));

Ditto.

> +	}

-- 
With Best Regards,
Andy Shevchenko


