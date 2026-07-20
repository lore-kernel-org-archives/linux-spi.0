Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA33EB101;
	Mon, 20 Jul 2026 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545041; cv=none; b=DpXT7wUd94GMh0km+njhnrtiQ0E7dJgNO4Pv09309K/rQ1sPnDRLnhyu6BN7JRD1l8kKhuxtBB1U2W4G/HBOkAXbUM4Wjbnvt8BT0xKhruAKUNt3xKBUDhNNHd/bJ38ERiZglhRdeNFx+EIvSc07BjMlnLonFgpcd5gCccinMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545041; c=relaxed/simple;
	bh=NXLsN0NLLc10WDiTAYubEPEYUbp4CgElqUIeeqtCXh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8kyOyAi9rKncLbhrll5Tkv9m3EwLcDmT597GoPpPMvlwkWz1UWT+j49Nk6yFgVcu4V6fAvCeZrlePrOHi0dzKFvIsCOhhy/PNhyr1v4V50+A9tfj5eD8wCjEzt6kaPG460K3Mnav3zZZcll3ATrAzNDo9Z7Vy5WYrvrnqTY8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh1CY847; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh1CY847"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784545037; x=1816081037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NXLsN0NLLc10WDiTAYubEPEYUbp4CgElqUIeeqtCXh0=;
  b=Nh1CY847IEFeR6lpA9Nx6N4sPe8ATQph6tHMKFuLXbwXgdMUBhqJAyVA
   e+FqZfGC1nlQB/IS44FpD4QOxoNMHNBPgFlweL8rZa5skz2NPMOkrrWYJ
   ohFpN/h+Erle0N5BhIfaPy/yFLZkH5dJwKCC0wbOlx2pP8+BRtikoELWH
   3PKXk6vzcUTnNPQbVYbn0CM24l4aSWsaQfM2QicKscp9JG862wwUDJFU1
   HtibeHfPVPvqdgLJb0iZs7wO3fE56x4WNgF+YbHxp70SRexRnR/a6btbU
   lXwzL+/xCytYMMW1J/+VjoAzSmngZF8SVv+bpJFl8HeYPrr8gx4MK90ob
   g==;
X-CSE-ConnectionGUID: AclMNgs8SOOqyppU0r9Uiw==
X-CSE-MsgGUID: 0+IsWRrkSH6ryTcv0oVLKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84106230"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84106230"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:57:14 -0700
X-CSE-ConnectionGUID: FMYNt92OSyu/rpeMyKJZtg==
X-CSE-MsgGUID: fJhUkwZLQ8ScJBVAPNpQeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="254814597"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 03:57:12 -0700
Date: Mon, 20 Jul 2026 13:57:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/3] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and
 LPSS S3 resume state fixes
Message-ID: <al3_BbJGxtKDt4H4@ashevche-desk.local>
References: <20260718145209.6678-1-fourdollars@debian.org>
 <alyCbKAQh4jtZVDv@black.igk.intel.com>
 <CAAT15mN3B4=7eaQUO9nmdP3SCN21ffKyK7VD4Vxck6gbH3izuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAT15mN3B4=7eaQUO9nmdP3SCN21ffKyK7VD4Vxck6gbH3izuw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 19, 2026 at 07:41:16PM +0800, Shih-Yuan Lee (FourDollars) wrote:
> On Sun, Jul 19, 2026 at 3:53 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sat, Jul 18, 2026 at 10:52:06PM +0800, Shih-Yuan Lee wrote:

...

> > > Changes in v12:
> > >   - Addressed feedback from Sashiko review on the v11 patchset for Patch 2:
> > >   - Preserved the if (!pm_runtime_suspended(dev)) check prior to enabling/disabling
> > >     the clock in pxa2xx_spi_suspend() and pxa2xx_spi_resume(). On non-LPSS platforms,
> > >     if a device was runtime suspended prior to system sleep, unconditionally enabling
> > >     its hardware clock during system resume forced the clock ON while the PM core
> > >     retained RPM_SUSPENDED. Restoring this check prevents PM state desynchronization,
> > >     avoiding power leaks on non-LPSS platforms.
> >
> > What's going on here, please?
> >
> > It's v12 and you haven't even a thought to add the authors of the drivers, nor
> > any one from Intel whose SoCs are under the question here.a Besides that the patches
> > need more work.
> 
> Understood. I will add the required authors/Intel folks and address
> the remaining issues for the next version.
> 
> Could you please help provide the email addresses for the relevant
> Intel maintainers or authors I should include except the list below?
> 
> $ ./scripts/get_maintainer.pl drivers/spi/spi-pxa2xx-pci.c drivers/spi/spi-pxa2xx.c drivers/spi/spi-pxa2xx.h

Compare to

$ ./scripts/get_maintainer.pl drivers/spi/spi-pxa2xx*

And on top of that: Mika Westerberg <mika.westerberg@linux.intel.com>, Lukas Wunner <lukas@wunner.de>

-- 
With Best Regards,
Andy Shevchenko


