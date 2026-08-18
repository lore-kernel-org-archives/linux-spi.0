Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA24B04AB;
	Tue, 18 Aug 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035513; cv=none; b=VBarzmeUhB79fvAZFKvI2/4k1G1gjrT1ytszvLH25VgXPCE1KDDpsDA4SAH2LLiG2NFh9Fv6AsrPS2VfnkEW2wLdsXKWN1cjvJnmouUrRa8ehkRT2FuluQxTszSBlmCwml9VU8rRPQbVyL9x3IeoVER8PitZgt7Lrffuz7jNGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035513; c=relaxed/simple;
	bh=lrXgU4QXWqQK+kWTZ5cXOI7DwxXUEgPuBshEVuD/7lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv6YdXdXbRrIMSyuBSTC4Jfq8oV2Tj55kMD9kO01VQ6nva0dySBQNuGj1Wd3wkE/VBuZX1Dze95Ii5R/J6E4ggvMg4d1xe6nd/6echJmde/itz5thSztbLB9Ho/9MonUOqbfFrh39VdGk1QuG0Ba9JxkErXztvgBAT6NMSF0rco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pqge7fNz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pqge7fNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787035511; x=1818571511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lrXgU4QXWqQK+kWTZ5cXOI7DwxXUEgPuBshEVuD/7lQ=;
  b=Pqge7fNzl9vKEH3gY1/Y5ld2l6ZEXm55bCbNGdNZ9SjcDlo2loqaiGty
   uSq43gw+PwtNUsUK861i0SD7PBgf3O6Cug2FKrLkT2SUMBZ1fLKt6aRZh
   dQ+wnW9+Xz2FUfsLN7T9cuBH+nadI0PyNefFmtthTPIXXEXpcmaDNq+HA
   dKzSqeohaVon8I4VN2+PCNhIAaclT1f3VANkQJCQ+Jyell1iznt83gZPU
   21QbdGsmbu5Xkc1v2NiFSJsLUgw9jdm2A6aVgiSXkC8TcyZxTvMTpOhX1
   VTBaRsZs5lKacx0DAf+xVti/6MaYy3kNc1FIs0ZVtPOPxlJUx6rlQAcQC
   g==;
X-CSE-ConnectionGUID: gwlvThOZQu2XZaHIRbK4pA==
X-CSE-MsgGUID: hX7GtcT1ReS+/G+GyTxeTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91199975"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91199975"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:45:10 -0700
X-CSE-ConnectionGUID: Xe+Hb/V3RWSAGV4tcpgLkg==
X-CSE-MsgGUID: 9GsxlHI+QD6vHd0SsT+W8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="260920057"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:45:08 -0700
Date: Tue, 18 Aug 2026 09:45:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 3/6] spi: expand device name to include all CS lines
 for multi-CS devices
Message-ID: <aoP_cbcqHEA5L7iK@ashevche-desk.local>
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <5719698587a0a7658a3980168eef0731a5e7506a.1786973376.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5719698587a0a7658a3980168eef0731a5e7506a.1786973376.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 08:32:57PM -0300, Jonathan Santos wrote:
> The device name for SPI devices was formatted as <controller>.<cs0>,
> always using only the first chip-select index, ignoring the remaining CS
> lines.
> 
> Change the naming format to <controller>.<cs0>+<cs1>+... so that all
> active chip-selects are reflected in the device name. Single-CS devices
> are not affected since the loop only appends extra indices when
> num_chipselect is greater than one.

...

> -	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
> -		     spi_get_chipselect(spi, 0));
> +	cs_len = scnprintf(cs_str, sizeof(cs_str), "%u", spi_get_chipselect(spi, 0));
> +	for (unsigned int idx = 1; idx < spi->num_chipselect; idx++)
> +		cs_len += scnprintf(cs_str + cs_len, sizeof(cs_str) - cs_len,
> +				    "+%u", spi_get_chipselect(spi, idx));

So, if this won't support sparse CS list, I would just go with a standard range:

	dev_set_name(&spi->dev, "%s.%u-%u", dev_name(&spi->controller->dev),
		     spi_get_chipselect(spi, 0), spi_get_chipselect(spi, 0) + spi->num_chipselect - 1);

(yes, need a variation for num_chipselect == 1, but I leave the rest for you)

Note, I do not see that we are expecting to see the sparse CS list here. It
would make too complex logic to follow. So, range approach is KISS in my opinion.

-- 
With Best Regards,
Andy Shevchenko


