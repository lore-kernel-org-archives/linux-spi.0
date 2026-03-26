Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CA23EABA;
	Thu, 26 Mar 2026 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517392; cv=none; b=UPz2iOmLkdgs23X3JIrXh1qvLdVomzaKLmJlAQhpWj+HZrb/9DB2R5ouJSJ4WCRlPI8qrpXCfPX5zTZDd4YCrMidfNFniaWr2cyfgTTNFV4ybgMaRHkS2BVGrCkYkG/jt5VopHURVmJ1NiChUduVvnW9griq8wDZmjA2GPSv8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517392; c=relaxed/simple;
	bh=gFSHtDzLUvWzklpfenFzaXBp3qo4cR0W75zxcVPWhbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdzQyxqWhiWDh35qnaGPYnGpwbyEhUijcbPrLtJG9jt6y9+s6Fgj4gPvNUfLsLhywPI8/WaDrHf1QdRgFzHOdjj77fGEuyNpcnlSmCm88lQla71E3sxzvYuTuUnjqgnZiGGPWiqR8CvzNeJnI44IzKlWntuAYvzEjYwDFEOq9Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzuHTgwa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzuHTgwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774517390; x=1806053390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gFSHtDzLUvWzklpfenFzaXBp3qo4cR0W75zxcVPWhbw=;
  b=BzuHTgwaEjvzeTAY/8a/BcewjqbW6lKwDrhW+2HIfEXcafyMDqgRduLt
   SkcdTyl705QiRqFi6q2+UPtuwnWmBXTiY6VEXPsFAv1OsEGl5wiU2v7Wd
   KdpBCIfU8j/MjV3o6+Rl8s9Vkef3FCx7QjiXd3dC3v6rH3auhgHTFThCE
   MK/b1Vd3eiP51k0QphtPheKlJhEJ3/hkiuaItSmGZACpWc/HCkwJ9pgqn
   xaE+O+IUspW/l1bydM8T9yWWF0r3Y5N82B6o6TTolK7slus+8v3CkZwXt
   nG7Huvv585WcznsJUws2S4ntpWr4/LbOtW6WSFo/kGb8SKV7VoRUgZmgm
   w==;
X-CSE-ConnectionGUID: cKqMfuqTT3u8jVUNrW+DfQ==
X-CSE-MsgGUID: /BKuM0pkRXmRBkO6bKV/mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="101023297"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="101023297"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:29:50 -0700
X-CSE-ConnectionGUID: GI+r1oluSQauWLTOPlnm1A==
X-CSE-MsgGUID: zEM+TkWMTgWOclhqfz5OWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224013963"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:29:48 -0700
Date: Thu, 26 Mar 2026 11:29:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Felix Gu <ustc.gu@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Message-ID: <acT8iPKXzSCtM7d5@ashevche-desk.local>
References: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
 <20260324145548.139952-1-ustc.gu@gmail.com>
 <acOw2lGiQbPr-MGf@ashevche-desk.local>
 <acP5T-pwlOfPdlQ0@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acP5T-pwlOfPdlQ0@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 04:03:43PM +0100, Johan Hovold wrote:
> On Wed, Mar 25, 2026 at 11:54:34AM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 24, 2026 at 10:55:48PM +0800, Felix Gu wrote:
> 
> > You mean buggy driver? Any real example of the use case?
> > 
> > In the 5. you implied something like
> > 
> > 	ret = spi_alloc_host();
> > 	...
> > 	ret = devm_spi_register_controller()
> > 
> > ?
> 
> We have some 50 spi driver using a non-managed controller allocation
> with managed registration.

Ouch!

> This was the only way to use these interfaces before managed allocation was
> added much later.
> 
> > But this is against the rule how devm must be used.
> 
> SPI is "special"... But yeah, we should eventually fix the API to avoid
> inconsistencies like this.

I see, yeah, it's better to do so.

-- 
With Best Regards,
Andy Shevchenko


