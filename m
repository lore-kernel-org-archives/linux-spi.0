Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E73F3F2109;
	Tue, 14 Jul 2026 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020020; cv=none; b=lpafQi6Voi1a/1urpgYs6KwiNzHE8B0dEf9rdNZ/umz8KyT+TJJZSLTH42rderpC05OGawSfGZNS+NcuZZPqcqNdlGX8Y5BpnwtRr+5ybISr5gXFIX5jqaOvIg9nAKaxk8WcQiW7eJpGUyWq2D9T4Sv7DEIWZajlzpsZDUKtwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020020; c=relaxed/simple;
	bh=/nMZLkbDak9sUSV8Zu8Lj24BshrHYSiFCMo0Qh1V/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0c7xnrwfdm7Q3xtb7R8MdSjPOtVTuysTPCATMABMG0ipXq5pM7FxhKZEaIBYZDyINuLR1lPIX+94E1MHYt/oJkAQEbBP3pzhwgrqJ7z8kwM335XF5X+e1pAW4LR+1aNuPpt+Sp9cjbiKgNDtsQV+wcaXllCqeixiJGmW6VRpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfeU4cA1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfeU4cA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784020020; x=1815556020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nMZLkbDak9sUSV8Zu8Lj24BshrHYSiFCMo0Qh1V/K8=;
  b=mfeU4cA1XoKJfcP82P2EpYVtP0K4N+l6WWcazHcTHoXvIYZauZ1zMX4k
   3W7fOLfDlvHgjASCg8S6xpnm5uIYQVtPPGq/nP3WTLWRSpDFoynzQOzj9
   L8+yrd0+baRtNRnPjtaBIZPx3UuXTT9c3qBXAPlsHX4q4stNfFOFBNENl
   Q3846P3fRsYkS7smXzjtJ+tgMzr3y4mIhzTJA+2ttaszES7wOF6Au5eEF
   myFD9B+MxdlJONFwV4lkHfTk1jUeVq4pPP9xAK+VN/uM9rP16QH0XupJf
   mP8dFwIglU4nearhLqL/AMbA27V7TSUHISq2yshWb0oDhyqW61gmJYb4i
   Q==;
X-CSE-ConnectionGUID: liscFI1NS0Se//gj6iMA/g==
X-CSE-MsgGUID: ao4vAzFRRq2kZVbK8a48MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88536698"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88536698"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:06:59 -0700
X-CSE-ConnectionGUID: MR4BEgstTQGGjWictE6iUQ==
X-CSE-MsgGUID: 9BP071V7RSGs3qftVKdu9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="259374037"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:06:56 -0700
Date: Tue, 14 Jul 2026 12:06:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	michael.hennerich@analog.com, broonie@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 1/6] spi: support simultaneous assertion of multiple CS
Message-ID: <alX8LfOvZYuWNeXa@ashevche-desk.local>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <4a18b2d08916aebb3f8ac01d3c57679caf0e8caf.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a18b2d08916aebb3f8ac01d3c57679caf0e8caf.1783729282.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 02:55:48AM -0300, Jonathan Santos wrote:
> Some SPI controllers allow multiple CS lines to be toggled at the same
> time. The existing code always used CS index 0 when tracking the last
> active CS in spi_set_cs(),

> and unconditionally set cs_index_mask to BIT(0) when parsing DT,

What about other cases (board info, ACPI and ancillary)?

So, the board info in case we need it, should be modified to take an array of
CSs. The ancillary seems by design a single-CS stuff, not sure if we ever would
need multi-CS. And for ACPI it is a gray area since the CS is 64-bit integer
there and theoretically we may interpret some higher bytes as amount of CS or
so, but this has to be specified.

TL;DR: Please, add a summary like the above to the commit message to explain
why those were not taken into account.

> both forcing the single CS usage.

> Modify spi_set_cs() to iterate last_cs[] using each logical CS index
> instead of always reading index 0. Modify of_spi_parse_dt() to build
> cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
> so the controller correctly identifies which CS lines belong to a device
> when asserting them simultaneously.

-- 
With Best Regards,
Andy Shevchenko


