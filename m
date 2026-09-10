Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA03D6478;
	Thu, 10 Sep 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032833; cv=none; b=GfIr5IOnEG1Pjkkbbi7cpyOHGr007nW9C2cwB6YQLqCdHPSETfKTa6rSS54kU8iBNKqztLVchI4TG9ftPYWLSls6UXqzFWeiyprfa/Ei+3xrCflixL0nJd7uKcBx8gOqIHCiAPvJ0gClJQ1FT1D/7YswLzCQP7rNXvPeHqxs/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032833; c=relaxed/simple;
	bh=1em9aq9gzUl+zPgBvcxhxZd9TdbDXSqR40mgmMVYAMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIEMySnK2NO6H8AJPOgQyIboeyETjztgqK/deXX0jtgp9sRY0dCYel39wIOw4qRQfXJDODYEIRkChscxArDAai5qjGAA4lcc3IJWTc6+l2dJJc0h/h73rfWcJyIuVOKK4Wf2GbnAzbCtb8TDI+oDH3wC6hogBMCAImbNZs6xWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfBFHzg/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfBFHzg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789032831; x=1820568831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1em9aq9gzUl+zPgBvcxhxZd9TdbDXSqR40mgmMVYAMA=;
  b=VfBFHzg/D7PtAbUHv+DfTYsykiS8uGagGfOHi/MQ21XeH8VIaAJhdwdr
   twUCQDdByd9w5oO1a5/Cn9Kqzh0VWP8javlYncEJJ4X0E2rRgZp1do0Wk
   uaFKSZgxrfXp0FK5iRljEmLBX91RGX+PygVw2mHvPUNV7Vuy8mITRyo83
   xd0XhknWB2YuyU3Mr7y8/fWR1ZkGwUhrXci0z+7GMVYkeXXoQoM5BNS8t
   z9D5i84/Z8hu9LL4t+0t6NfjQjQZjgC2mfHdXyhCXk6wg/PWgieA828PH
   x0BRd8uGKfS1NkLOga6LukukfOpp4m1O70kA9UDsOdpAKHWhnizuMAkSy
   w==;
X-CSE-ConnectionGUID: UMXdb+sWRfGcQCeuEGqXeA==
X-CSE-MsgGUID: 4uTBVpa/SDykUYgYKJArwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="91992591"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="91992591"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:33:47 -0700
X-CSE-ConnectionGUID: FZK/4208RgGo59/IgLKZMw==
X-CSE-MsgGUID: T3eFll+kTeyXwnB5iRtisw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="275733812"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:33:44 -0700
Date: Thu, 10 Sep 2026 12:33:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@debian.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <aqJ5dqLKht5ezDw1@ashevche-desk.local>
References: <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
 <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
 <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
 <al_ZlTkEUHj-X1YS@ashevche-desk.local>
 <CAAT15mMaZWdkp9YRKvRDRw-WCA-4nWGGo8gge=D7oBKUr1yysw@mail.gmail.com>
 <amYya_hiHM6lrxTX@wunner.de>
 <ampdJY4LcP6Qc1de@wunner.de>
 <c05bb236-5aa2-4050-a030-8caed6d47a40@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05bb236-5aa2-4050-a030-8caed6d47a40@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 29, 2026 at 09:21:41PM +0100, Mark Brown wrote:
> On Wed, Jul 29, 2026 at 10:05:57PM +0200, Lukas Wunner wrote:
> > On Sun, Jul 26, 2026 at 06:14:35PM +0200, Lukas Wunner wrote:
> 
> > > I'm not sure why Apple chose to keep the DMA controller in reset,
> > > but have you explored enabling it on boot?
> 
> > Thinking about this some more and after taking a look at
> > drivers/input/keyboards/applespi.c, I realize messages exchanged via SPI
> > are always 256 bytes in size.  That's not a whole lot, and of course
> > messages are only exchanged when a key is pressed or the trackpad is
> > used.  So perhaps Apple determined that sending this in PIO mode is
> > ultimately more efficient than keeping a DMA engine powered on all the
> > time.  The CPU load saved through offloading the SPI transfer is offset
> > by having to program the DMA engine for each transfer.
> 
> > So perhaps usage of PIO mode was indeed an intentional choice by Apple
> > and need not be second-guessed.  I'm not sure.
> 
> DMA can also add extra latency with interrupt handling, it's possible
> someone decided to trade some CPU time for minimal latency (though you
> could probably arrange for shorter messages...).

Okay, so let's go with the disabled DMA approach, but this will need
a good commit message and a big comment in the code explaining all findings
and some kind of summary of this discussion(s).

-- 
With Best Regards,
Andy Shevchenko


