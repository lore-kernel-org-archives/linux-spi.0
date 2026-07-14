Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61347D957;
	Tue, 14 Jul 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039228; cv=none; b=OxltIIYG4D4UP/77f4llBOMCgW9WMqpYd0tcnJXRjOKd8lUkI4rQRGHnXDLKmfRzbfmtLKb3OZZ2tpZb+WAWSyC6ygAKbwaY5U78egQJ2WwqHDDwgilaqsALQo/YZ7SpLDvtXZP7DOFBn5AGYyi8LVejsgO12XAIJwUBDSLLVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039228; c=relaxed/simple;
	bh=eMNJXhEw+kkIM2CkatG2LL0hKuQZV6d1eHjd4UYLl0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We6RWWz5Pz1XgUWGsCYOkh+EXB6qh60PpGZtHeLJjwQkGK7DgW4oMZdHd5difEA5L6if1njR6G1dXCAZ9A/cSdzEl49shokU9wR1SJHUOzxv1BvVgGN2lr0TNnTgm2LF8rydG3AjzTx0BceQqOHaFqOHclnboVMSVXIafbqX1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAK4oXz8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAK4oXz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784039225; x=1815575225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMNJXhEw+kkIM2CkatG2LL0hKuQZV6d1eHjd4UYLl0E=;
  b=LAK4oXz8nD5staGrPWfFJu85Db+z1/cTJINay6+FDRF2GBBi4ex/GvI/
   h6Oet1gjQcfwCQGMwehpqJSKkr3HKrfdYw5gc9utixeFObjxbV0E1zSM7
   cYFuSOGn0emtDopvcfWsIi9wCn+HUVVxeJdx8JYhXhRbahOYcQfhsvMPv
   ssA58uL25VRinBXVBb5nOOi1/aMri8RWmgbw4i4+LENhwM3hRlf3RZr38
   T9pv+lRVLmaFh18+mh+K4B33CmXw3ctwmMZAggT6vKkaEoF7UZRjGY+m2
   W9ymBpwOnkr06YFRepidvhq2TaHtZmjOykCfsMDs1Ev0sjRmn8caitjEl
   g==;
X-CSE-ConnectionGUID: 0/ghssn6SWS33jOSMwOMNw==
X-CSE-MsgGUID: A4Z27n8vR3mJNjQmy9Za+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="83647314"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="83647314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:27:04 -0700
X-CSE-ConnectionGUID: MFaS+7HYS9+A/HTHDGicng==
X-CSE-MsgGUID: nvYpw2V3TfyHOXhpB1IUfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="249518332"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:27:02 -0700
Date: Tue, 14 Jul 2026 17:26:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
Message-ID: <alZHM1UJ2JnAdikw@ashevche-desk.local>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <alX58XKU2iD3x9y1@ashevche-desk.local>
 <6cf508ec-c139-4969-9342-d5b6717bde21@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf508ec-c139-4969-9342-d5b6717bde21@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 09:09:02AM -0500, David Lechner wrote:
> On 7/14/26 3:57 AM, Andy Shevchenko wrote:
> > On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
> >> This series introduces two SPI subsystem features: per-transfer chipselect
> >> masks and multi-CS device support. Together they address the multi-device
> >> setup described in [1] and the limitation noted in [2], where no SPI
> >> controller completely handles logical chip selects beyond the first one.
> >>
> >> The first part of the set addresses multi-CS support. Some SPI controllers
> >> can assert multiple chip selects simultaneously, but the existing code
> >> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
> >> preventing this from working.
> >>
> >> The second part addresses dynamic lane selection for STRIPE mode. In
> >> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
> >> active. Some peripherals need to select a different subset of rx/tx lanes
> >> per transfer. New fields are added to the spi_transfer struct to allow
> >> drivers to specify which lanes to use for each transfer. The documentation
> >> is also updated to describe this new behavior.
> > 
> >> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
> >> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/
> > 
> > Mark usually "merges" a series like this and cover letter goes as merge commit
> > message. With that in mind, can we use Link tags for the above? Like
> > 
> > Link: ... [1]
> > Link: ... [2]

> Beware, that would cause b4 to add the links to every patch in the series.

Even in `b4 shazam` case? I thought it adds only a single Link per patch,
and leaves the original Links as is. No?

Also this can be done with the blank line before real tags, would it make
it behave differently?

-- 
With Best Regards,
Andy Shevchenko


