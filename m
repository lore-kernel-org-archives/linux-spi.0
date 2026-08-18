Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35933D6F9;
	Tue, 18 Aug 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036478; cv=none; b=iLYH7nAByyBcvRkfsGdgWzCVnj9Y6eLjO4ErrWksB+JVTJ0zcufN1rO7OfKoFwl3wqcvHj1BruWM1Oj7lFIf6qozGIVvSQ3dQJ3VYFSlm5EXXSgVysGnL0VBQIvgKWVfyEhK8MR1K1JfDLk1mSB83t9j22epHXjsljsWoruhUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036478; c=relaxed/simple;
	bh=PQBrvcoM7AsAs+OKfiNLOG/DrIZcv3l9znU7gnY5AR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwyK5Q9qoP6qoLAvO895C7MqsMy3URno8wgi+J1nI6Lo7cdrK2MRpZ/Q/c9ibHqUJYneTzNK8H+MeaAdSwFaWJpZYpZcZ8sTWJvJGis1ENjUeXM0QEDYtoP9usRCl85/kKWWNyJbtXnS0+R5TFPiCuQkulLpbj/kpHaFRcOSBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTgDByAb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTgDByAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787036477; x=1818572477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PQBrvcoM7AsAs+OKfiNLOG/DrIZcv3l9znU7gnY5AR8=;
  b=nTgDByAbwmO34jt4j7WoFrf6Y8iu7MWLj0C0baytZCU8/zkIYsky/gyo
   dXBIlDGRuzLhXSPV+teHx2kQenITJp0cWDPM9ZNPImT//lgh4NhEfOu/t
   sIGneb596+svDrOoXxRtZILCjI2cf84kpWSEGG/gCgewYJcTtCnDZFLc2
   sgH/m8T7kWwO9ko/mQQ9Sij6Upbyk637JRkbi8NXeyB+2Q03iKrB/VZDS
   Q5guNSd0F0I1y4kzq+s94gYTSl9VZXFdI3T4Vo3Wr5ev2fHKjrcRIBP7d
   L8QKPQdgbP12Nob/FogtA/N3yDqplg3ukIHq59ijCfkTeGAKLrsyi7Qut
   g==;
X-CSE-ConnectionGUID: SUD+eXS3SjawhwrCmhwtBQ==
X-CSE-MsgGUID: j0XTa+aMTaqa0u8iXKu6aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113062005"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="113062005"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:01:16 -0700
X-CSE-ConnectionGUID: aTc3McJJS2S2XshxqjC05A==
X-CSE-MsgGUID: vDJH+l5eTZeVBDsaD4kygQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="260923243"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:01:13 -0700
Date: Tue, 18 Aug 2026 10:01:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 5/6] spi: spi-engine-ex: Add support for multi-CS
 devices
Message-ID: <aoQDN3dUdzKBCb_Q@ashevche-desk.local>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <1e369b85711dc01d3494645d8bf60036cdad1134.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e369b85711dc01d3494645d8bf60036cdad1134.1786973376.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 08:33:26PM -0300, Jonathan Santos wrote:
> The SPI Engine controller only handled the first chip select when
> asserting CS lines and configuring CS polarity inversion, ignoring
> additional CS indices present in cs_index_mask.
> 
> Update spi_engine_gen_cs() to iterate over all set bits in
> cs_index_mask and toggle each corresponding CS line in the assert mask.
> Update spi_engine_setup() likewise so that SPI_CS_HIGH polarity is
> applied to every active CS index rather than only index 0.
> 
> Set SPI_CONTROLLER_MULTI_CS in the controller flags to reflect the
> capability to the SPI core.

...

> +		for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS)
> +			mask ^= BIT(spi_get_chipselect(spi, cs_bit));

> +	for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS) {
> +		if (device->mode & SPI_CS_HIGH)
> +			spi_engine->cs_inv |= BIT(spi_get_chipselect(device, cs_bit));
> +		else
> +			spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, cs_bit));
> +	}

Looking at these two I would rather see a helper

unsigned long spi_get_chipselect_bits(..., unsigned long index_mask)

With that the above becomes for-loop free.

		mask ^= spi_get_chipselect_bits(spi, cs_index_mask);

and

	if (device->mode & SPI_CS_HIGH)
		spi_engine->cs_inv |= spi_get_chipselect_bits(device, cs_index_mask));
	else
		spi_engine->cs_inv &= ~spi_get_chipselect_bits(device, cs_index_mask));

respectively.

-- 
With Best Regards,
Andy Shevchenko


