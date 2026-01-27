Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC5199949;
	Tue, 27 Jan 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547113; cv=none; b=AemGCqO6TSxDaeivA5HAiFbGLDO+1dbOUCAfVNEC1RoNuHJcU92aNheL0HGuVe4eHqe3KinKHWGAd/bYFcOC/zuOT/f2ayADrU7QRR/FK9GN/l9Lu9voarJ/uzJ/TTM9jfBBVzPGNNLdRzIalRwJ0QrlRfWjaIKuHbFu99nAy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547113; c=relaxed/simple;
	bh=BeD41On0XbCqOtG9Q1FksHjbZMmUdhkI7VHvrxtXqFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbufVNViLy2L8rZkyAPlAER3iuM4DPGDWfxAq85IkC09G6IeIxeBsKbIHWLQ8jcz2WCoJJIHOIqdhKIZcrqW5TiaG56PRS1bSwFspFDNcqwQiNbcv7DUw0tIHe0nPTIhMeY+r50egREe/XaW/CcJcg5982lwxxb0RNIhHOJvtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTIsAVY8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTIsAVY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769547110; x=1801083110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BeD41On0XbCqOtG9Q1FksHjbZMmUdhkI7VHvrxtXqFs=;
  b=MTIsAVY8hJL+S27jy+brHQYA4tjyi/7gb6Ze1IlkiGDhJV99nFEazo6r
   X5s7rxbPXFk6n9cM/lf9cirdH4CZdF19VJlOYG8rl0urSMym1oMItN3X7
   ll5S16S0y4orJz5ne5BxJqbrDok82m3V7red5KIgj33564ZEe73Z0lb7G
   I9fLjqNv0M1qtH4r5oS1slllmNL31QOyctR5mjTMwEFUhUI4GIFt2PTR5
   R/QNVpGbiPQGKzlwPuC3EJE+6v+uOrVjHoC1QmVvOXRabMMfNA9ckLJMy
   cLgXnPMgQgjL5T0OPnwEeoeaphrKh/1K7p6pW8BP37zwA9i0ZOZX43NlN
   g==;
X-CSE-ConnectionGUID: be96VwIWQ8e3gGSMr0iwzQ==
X-CSE-MsgGUID: rhZmP0U/RWGUsKelib8Utw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93411920"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93411920"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:51:50 -0800
X-CSE-ConnectionGUID: q1HVHVo6Rr+nwFaG0l2fUg==
X-CSE-MsgGUID: SmgLpx2JQt63Re/KpvpdPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212624708"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:51:49 -0800
Date: Tue, 27 Jan 2026 22:51:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw-mmio: support suspend/resume
Message-ID: <aXklYtTg-pqrT5sw@smile.fi.intel.com>
References: <20260122155046.12848-1-jszhang@kernel.org>
 <d0bd831a-08dd-4c2c-97e8-896f885cdbe8@sirena.org.uk>
 <aXjhcijjig79ocks@black.igk.intel.com>
 <6b89afd5-9e6c-45ed-835d-6e0d1906aa14@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b89afd5-9e6c-45ed-835d-6e0d1906aa14@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 04:07:11PM +0000, Mark Brown wrote:
> On Tue, Jan 27, 2026 at 05:01:54PM +0100, Andy Shevchenko wrote:
> > On Thu, Jan 22, 2026 at 05:57:42PM +0000, Mark Brown wrote:
> 
> > > These were allocated using devm_clk_get_prepare_enable() so we shouldn't
> > > really be fiddling with the state at runtime.  In practice this should
> > > always be fine I think but it's not really something we're supposed to
> > > be doing, in theory we could fail to resume and then end up doing a
> > > double disable on removal.  Probably the open coded version would have
> > > the same issue though so perhaps this is pedantic...
> 
> > We clearly can call clk_disable(), but I'm not sure unprepare is the stage that
> > has no side-effects here.
> 
> What makes you say that disable is OK?

It's (assumed to be) paired with clk_enable() in the resume.
I was talking from CLK usage perspective. However, after looking
at the resume implementation in drivers/base/power/main.c I think
the failed resume of one device doesn't prevent it's removal or
anything. It just collects statistics and records an error, but
no other actions are taken. Which means anything that needs to
be paired between suspend/resume and not checked at remove or
shutdown is prone to the same problem.

-- 
With Best Regards,
Andy Shevchenko


