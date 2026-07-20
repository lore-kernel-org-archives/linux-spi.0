Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB23F44CB;
	Mon, 20 Jul 2026 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545936; cv=none; b=j22FNYCOM6ITjPlSSAnIZH5V6Zm2HS68mjIUFNNGmz1+zJfVfwQHekUCAVrORLLThKyeMwkwIpuZCvqmu+9/GaQs8vknoF4TdrOZbWioaMqr/+6oqZOdHvAXIQrdN3/3sQm8c9vKqrNcUzkBD1iiGAJCtteh1ivuefcu6J+PPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545936; c=relaxed/simple;
	bh=8Tu1sNIjvh0qe7418eMkiZjWGhY5PHNA0ccDcGQxbH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gERFcGh/XSnotmHAWMwgxlhyDVU9MtLgii2c6X8IrC+ExGA4l/k8fy7uy3RCkRT2KLsdp7KShnX3+1JS8LA2Ii/d8pK6i/1dbfArUsXr+rgVvN7Kj2uvrQ6zbklnoOSats9zdmSch8W9Tqy4bWGWBJA40wglqMpdCTunlF3Fw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5WRy5jc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5WRy5jc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784545934; x=1816081934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Tu1sNIjvh0qe7418eMkiZjWGhY5PHNA0ccDcGQxbH8=;
  b=i5WRy5jcz1RLQXO/pRliYmGtvoZTZzG/7SvMJVHyYiOZ+A0f7shEa3ZT
   CLLf6WiVIgbsGtyR5mrmfXEmA94FIAiAhnC/vvon3JlCrm6agds+xBupP
   S9zn8/gh4eD77+5OZmLqGK4QS9oDJbn6bqa2Ml4BdrobNVwHTiM4rfV0C
   xzkD5oEX+IhWXkcCRbsvDsdoFatkDDpNeoeY803qV58Q3wqgk7kDVFnMr
   WinZ0Qg4HLWHyDQ9Q4E4LPQ3mjd9n93doJUFNqW9fmReeJhtaSqHEngU/
   xCCYsXT+zPT1NarY1kCorujZILrZqEBTT+cE1GeMe0L5QheSFfosxh++p
   Q==;
X-CSE-ConnectionGUID: D6PTQotXR/2yCCfC9WvvCA==
X-CSE-MsgGUID: C+/JTX0MSduczWsnS4pRoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="95776378"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="95776378"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:12:13 -0700
X-CSE-ConnectionGUID: 0IEGxcEkSyqqW1z1IDaPng==
X-CSE-MsgGUID: TrEMbgEwR5myB/DSP6nxvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="256852429"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:12:12 -0700
Date: Mon, 20 Jul 2026 14:12:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 1/7] spi: pxa2xx: introduce clock enable and disable
 helper functions
Message-ID: <al4CiYmT10s8mrZ_@ashevche-desk.local>
References: <20260720104029.13740-1-fourdollars@debian.org>
 <20260720104029.13740-2-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720104029.13740-2-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 06:40:23PM +0800, Shih-Yuan Lee wrote:
> The driver disables the clock during PM runtime suspend, PM system
> suspend, and device unbinding (remove). It also disables the clock
> on various error unwinding paths in pxa2xx_spi_probe().

You forgot to add cover letter (or forgot to Cc me). On top of that you haven't
waited for at least 24h (and for this series even more) as stated in the
Documentation. Last but not least, I only today answered with the people who
will be interested (in my opinion) to glance on this.

So, thanks for the effort.

-- 
With Best Regards,
Andy Shevchenko


