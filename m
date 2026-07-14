Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E592DB7BD;
	Tue, 14 Jul 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021175; cv=none; b=ju1nXLDVHYmLuJFDnB86kheMXSeBK7DM/TcYOYmXfYdXG7wplH7d+v4e2AHb7mRq6H2o4vVZsSAr41DF4rhjp5knrGDZq2584muBnB5xUrQPRnFyzPHpy5IRrNyWnxbyJTNQKBd8bbVegoz2CTUY1BFUzjJihQNOO3ihO+sDEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021175; c=relaxed/simple;
	bh=zKUsK+NYkAtvMsH3CSzTahxWyYSgXSZQ5+GfD+Jzk34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It5cNbRT1CFZh6HsgK10KnMSUmtSOyf9CUje4z4ngOVwDFGWQk3gy4/mirb1zGqiO35YUW5zA3JvZTJxXniRp3A85IQrwK7XlC6cnbvspsIGGS88CY20phDyh0fshX1AHoR08bclZRnTQtYosLtDpdCimKqZIaOsLa5bkriVzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbscLYGa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbscLYGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784021173; x=1815557173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKUsK+NYkAtvMsH3CSzTahxWyYSgXSZQ5+GfD+Jzk34=;
  b=IbscLYGaNz7UNZBmUd2sgZveh/007PiktZwNp26ZLly8Xw3utnYadbE+
   Slt6YgK7p12BOJppWn2ABYe18lMzPhRYh6P0eUbmWKAlIUzimLHGTiQMh
   oxlBZO6NWmjGXLR9sxvTJASrv+x3MJtZ9T8FU/hdALilJ2caRDw3cv45S
   HddOq3PPdsKw1rUS8CvmaDESpZG53PpVx6H4fjT6NtJtapULAwu2IWngU
   zksWDVT5V0SBo/pUcESZlreZjrMhRd0dd4uc2RMHK1FsTAHtLDGheomKH
   +VCzeLRyCV/IKzPKPu5uS6+KGkEyXmpgxXRBnl63s6KIB9Jx+TIQS4mox
   w==;
X-CSE-ConnectionGUID: mLnIa/+tRdWuvAn1q5ONfw==
X-CSE-MsgGUID: p7EaNgwKROuDbvfGjaxCdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95285117"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95285117"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:26:12 -0700
X-CSE-ConnectionGUID: SbJF23I5TyKznSEmQlsEVw==
X-CSE-MsgGUID: Xgsxn7Q9T42czLLz1sdwXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254679905"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:26:10 -0700
Date: Tue, 14 Jul 2026 12:26:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 5/6] spi: add rx and tx lane mask to spi_transfer struct
Message-ID: <alYAr0Sih65lsZaQ@ashevche-desk.local>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 02:56:46AM -0300, Jonathan Santos wrote:
> In SPI_MULTI_LANE_MODE_STRIPE mode, a transfer currently activates all
> available lanes, but some use cases require operating over a subset of
> lanes per transfer.
> 
> Enable dynamic lane selection for tx and rx by adding new fields to the
> spi_transfer struct. Controllers that support multi-lane selection must
> parse the transfer struct to update the rx and tx mask lane-wise.
> 
> Peripherals need to set values to the new fields only if multi_lane_mode
> is set to SPI_MULTI_LANE_MODE_STRIPE and they need to enable at least one
> lane, not necessary for enabling all lanes.

Same comment as per previous patch, check very carefully the layout.
Run `pahole`, count the bits, think about BE architectures. This might
lead to unnecessary gaps or even more units to place all bits.

-- 
With Best Regards,
Andy Shevchenko


