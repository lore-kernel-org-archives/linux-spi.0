Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA73CE0B4;
	Fri, 11 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110035; cv=none; b=Q7CX9a1Fvur4rlv/LvUne80RIiLI2Etbo1lLvD13cE8wgWKJ8om+Og6SD6sEOD/N8myjAzvKz5a7Cc9dmcc5+79DxmcycaGPBDp7gRRjABPIgiIfPFuNcE6WfJPKtz0aXtJ8Gzj5ZXuXpOURYXHli0sj5QhCfOvyUFmy+P2ryqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110035; c=relaxed/simple;
	bh=3wJnBVZnRSVS61O1rzRNLjsLtjOPLoDsXkgihDJ0Z8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYBv2dXZEuRqbzu1y5YwzI4M9JP/90sx898iOiCk19FDIFISB0FKWHSgesvrJZkX3j0nlWbwOKXSRnzMJKrkFZqut01clKckFBRgxjC8PtEowotuweWVBOi5othcxRHwthLr3q+NOas9TseCjYHUYpvjsLAejHj+1wvrmuC1LeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkEzsZ72; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkEzsZ72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789110020; x=1820646020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wJnBVZnRSVS61O1rzRNLjsLtjOPLoDsXkgihDJ0Z8o=;
  b=jkEzsZ7277NF1UBbRkYC8TBqWrXjihTWZz9lsE+KbZV0bWGZlmHjkimU
   p2nYe7Sf4mQD8jHVull+U80uQdrLRno5kuET8ZA9NYhAHaida2Yt6tfJR
   oy9Xqd5mlFvNatzUiid4GZjlyRMfPPchUVpXjZPIqmTFNGMgeuR2dS6PF
   fn7hpV5pgx69J70bFHKMPAZe5uqugzzRb6iHK0dKaKc2HjHBHV0usjZHR
   BwchTs1uVmsShOzW7pZmiahVUYVyPLg+5mXGAyjfjbjcyQ1dmEa5iXQbM
   nY0zb8oV42WWbo23qxP9NDHK27fENdRFfagfI5BYiVOWnvmJERc6cvJ9b
   w==;
X-CSE-ConnectionGUID: Emfuk04RSV2Y+4Cw8H1T+g==
X-CSE-MsgGUID: wZoMEPoDQOyW4eTHZZgl4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="79603"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="79603"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 00:00:12 -0700
X-CSE-ConnectionGUID: Yys6om9OQ/2vz/kZHaPlzA==
X-CSE-MsgGUID: V/ZyARINT+WnUWGoghQXeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="310100166"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 00:00:11 -0700
Date: Fri, 11 Sep 2026 10:00:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Mark Brown <broonie@kernel.org>, falemi@asu.edu,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dln2: validate chip select count reported by the
 device
Message-ID: <aqOm-NtZiNeTOgSk@ashevche-desk.local>
References: <CA+0ovCivEREvoy=Z-D5TSddgTfFknhFrCBPON3a7QD2Kne=MTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovCivEREvoy=Z-D5TSddgTfFknhFrCBPON3a7QD2Kne=MTA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 09:43:38PM +0000, Farhad Alemi wrote:
> dln2_spi_get_cs_num() stores the chip select count reported by the device
> straight into host->num_chipselect, and dln2_spi_cs_enable_all() then
> evaluates GENMASK(num_chipselect - 1, 0), whose shift exponent is out of
> bounds whenever that count is zero or larger than BITS_PER_LONG. The
> resulting mask is handed back to the device in a u8 field, so any count
> outside 1..8 is invalid regardless. Reject such counts with -EPROTO in
> dln2_spi_get_cs_num(), where the value is first read.

You need to check with the datasheet. It says that only 4 SS lines can be
programmed. The reserved bits must be held in 1. So, all in all, the _MAX_CS
should be 4.

> Closes: https://lore.kernel.org/all/CA+0ovCioY634b646jDcs2cFmg_1q2UMN4wuTQ1V26Gy+Dm_c+A@mail.gmail.com/
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> ---

Datasheet: https://diolan.com/media/wysiwyg/downloads/dln-api-manual.pdf

-- 
With Best Regards,
Andy Shevchenko


