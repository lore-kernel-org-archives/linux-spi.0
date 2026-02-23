Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490D1C01;
	Mon, 23 Feb 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860250; cv=none; b=Jb2iULFc49ZOIRDeA+GfeX/vJ4NivFD9nYR62GaZRy75Ps1Wr16Bw9Ux8g50jruRrUeqVDEfp4/nMnqv4iQFdsNNAaGKqfIDB2VbmVovtuu5kLez/flI/Jk/nibixGp9dxAfsjj0fDlV4MoGQnZpZYxVq5TguHGtO59Mz3ZYtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860250; c=relaxed/simple;
	bh=LnPa/K8m1HXh91gH9byYDvVGpUurxv2UNobnzrueubY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVjdHDIQ/WGYhOX/LQiDblGqE4cVC2ZuWp7wiEioL1GncIeYTKe6H/jk933wCvxset7pqSqjU2tfvCt0ntuwNmbiM8UXnQeQH+C5XLz6/+Zs0BpMEbUUnMsstoblRM7lW6omV2mHDUUogAqHSFv1E0U9JE3Rh0qAXLjxAG7HFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+hZgcdZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+hZgcdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771860250; x=1803396250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LnPa/K8m1HXh91gH9byYDvVGpUurxv2UNobnzrueubY=;
  b=H+hZgcdZV7Jh5kFuqKpE2dJRrw6ETk31wmlbui19T5jlpAEWjskZ+UhJ
   61IjF5gMKRZOPg/6FK6Z1Y5IiKSVX8qYOW3FWZaFUq7PN/MMSCYdeKn+e
   WTDVZEYgzeGiv4IkyHxau0ikDx3s8V0PH+hIfhvvCmCHFj38OiHUrqL3g
   t8kbKAFS7ho28SW6TANTB5+cc9s8X2nD+HSfOQ588m2yVmnzx+p0WtQwH
   NdTInMY7aGbaZBGYrp6OwFPa11f5bu5TWA8dq/9jd/bNS88qTRGUtXGWf
   9F8Vk35/AJQA37EKTVfhT761tU6YfVnCLhFdia/CeEEwjpKujUqGQM1US
   A==;
X-CSE-ConnectionGUID: l/dEO1pGSQWsaeEO1qeuYw==
X-CSE-MsgGUID: ZGzvALPKRaO4Na6WD5/M4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76687249"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76687249"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:24:05 -0800
X-CSE-ConnectionGUID: mKp4bAVBTcSEf1n0pCSpog==
X-CSE-MsgGUID: x/KL/Q2CS++YospSC0JNRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="253315857"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:24:01 -0800
Date: Mon, 23 Feb 2026 17:23:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: use min() instead of min_t()
Message-ID: <aZxxDhoyuhNK0r7h@smile.fi.intel.com>
References: <20260223144437.2836369-1-andriy.shevchenko@linux.intel.com>
 <20260223151829.6192b32d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223151829.6192b32d@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:18:29PM +0000, David Laight wrote:
> On Mon, 23 Feb 2026 15:44:37 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > min_t(int, a, b) casts an 'unsigned long' to 'int'. This might lead
> > to the cases when big number is wrongly chosen. On the other hand,
> > the SPI transfer speed rate is unsigned and driver uses signed type
> > for an unknown reason. Change the type of the SPI transfer speed
> > to be unsigned and convert to use min() instead of min_t().
> 
> I think you should use 'unsigned int' or 'u32' not 'unsigned long'.
> There is no reason for these fields to have different sizes on 32 and 64bit.
> 
> Were spi to support 4GHz clocks (fat chance on a pcb track) you'd
> need to use u64.

Fair enough. I will correct in v2.
Thanks for review.

-- 
With Best Regards,
Andy Shevchenko


