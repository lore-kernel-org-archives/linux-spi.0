Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303243B493;
	Tue, 14 Jul 2026 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019448; cv=none; b=Cklv3zf+v+sCg+2mEDzMG/Ay7op47bSaErzOLOPIouaIAMb9zq9BOlwf7SbPEQcxu4I/zFqnC+pwakZVcK7PJaf7pfNSlFLXJHCrL/K0Dl0lLiuffXORDD5LhnElq1yK0yUW66PjFhqf6essr3nbdV2Huw/44dhT3im6wOf5p0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019448; c=relaxed/simple;
	bh=D+MdZEXzWIAcSkhe+rQ7cr9DUx8C6mCZzR9OXkvribs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjQpsT4NdkS3wirJiRCleSBMu8CbOzu65hWpXbVpc2hdhGlupGfJ/dMayp/VK5UFZ8DD3Boo45YWjJyCLkIx2Q8JGRmCbqIo8DT31ikqCWHHfDFVfNT0fu17892Tz3Pl4+j/YLNao/z4f/NB0y1LdytMwNbHHRugKaTc0CZ+Ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtBBjdxq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtBBjdxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784019447; x=1815555447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D+MdZEXzWIAcSkhe+rQ7cr9DUx8C6mCZzR9OXkvribs=;
  b=OtBBjdxqYebBZ1CSL7DHRoTSFZA++Gc1H7cZNlJu9C1Sq90GIpA4dxpO
   kXUGlnMD/KFqhWiJm66cgUspkjK0awrQ1oxQqDx7c5NYKasxfLdWMWcek
   uijkHkBdP8LmeaoGRx1Q/CPyepkDie/9dqX8/jozILTTrNJNQ8CPSZY41
   fKF3RjbtWyAv5Yc3PBL0damqkGrvjFWwpfEF8RbuFjrgJnIwtLR3I55p7
   ueU4on0OJsDu8BbNaRG6EpJdSC4WvHmaIENlygUNdbKKpE7zvCRfuGD/X
   jtR27cTcMAFhEjJEtCCvwky9rt+0RoCYjMfERlyl6i5HdsnfEe6MucI5R
   w==;
X-CSE-ConnectionGUID: oM6gORVlTA2B98Q+Mqtyhg==
X-CSE-MsgGUID: +OaxTg77Q2uZmrMu/S44+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95784566"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95784566"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:57:27 -0700
X-CSE-ConnectionGUID: ymxRF5hATEC5SzdY6MACfQ==
X-CSE-MsgGUID: rKer9SIrR8WFnbqFkPmcZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255855209"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:57:24 -0700
Date: Tue, 14 Jul 2026 11:57:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
Message-ID: <alX58XKU2iD3x9y1@ashevche-desk.local>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783729282.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
> This series introduces two SPI subsystem features: per-transfer chipselect
> masks and multi-CS device support. Together they address the multi-device
> setup described in [1] and the limitation noted in [2], where no SPI
> controller completely handles logical chip selects beyond the first one.
> 
> The first part of the set addresses multi-CS support. Some SPI controllers
> can assert multiple chip selects simultaneously, but the existing code
> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
> preventing this from working.
> 
> The second part addresses dynamic lane selection for STRIPE mode. In
> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
> active. Some peripherals need to select a different subset of rx/tx lanes
> per transfer. New fields are added to the spi_transfer struct to allow
> drivers to specify which lanes to use for each transfer. The documentation
> is also updated to describe this new behavior.

> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/

Mark usually "merges" a series like this and cover letter goes as merge commit
message. With that in mind, can we use Link tags for the above? Like

Link: ... [1]
Link: ... [2]

-- 
With Best Regards,
Andy Shevchenko


