Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2D22425B;
	Tue, 27 Jan 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529718; cv=none; b=NRorQ/hHOSHv2F+ywqXdtMWv+xKv55g6SjpUhg4iJuO2HRcSlAKMUwYEWjdTrL17zXsNznaAQ14dR8rS1OJ9UTF19diQReP+Cn6GY8FK8JyF5sKXX/bYXXNHcCt9qWG8rH+TXB8fZCmj+w7RCepA+sJT98Gq8VOHRNUzL6Pr8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529718; c=relaxed/simple;
	bh=hNYWK9LXZ5vvecy7a9W+Vn+YofGNDK3NnbrGCkkzoas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfmMu/jjiuDfWcLRzSVM+w6ELtVX6+3g60dJz5wD/7rAi8uHKGeyvw7eNGKipZQnU8zvE32h9dXrvXr6JSzPKuCfRM/BP67/RdBM9XQt7jaRQ/lQUnQKwCQiyL/RmvkokX5uTXYoK9yCcruK3z0uV8bd/65npVqp/G4p3PpUoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqWl/Bhc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqWl/Bhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769529717; x=1801065717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hNYWK9LXZ5vvecy7a9W+Vn+YofGNDK3NnbrGCkkzoas=;
  b=WqWl/BhczMVRfh57XZPS97PEuQkATb0qCrnPfmm2UOniPisbsmicVQCC
   2ZBmi6ckIXmmA1v8uNKF0Dxke30QONDHQPHHm77VWn1GwjwexFUN5T865
   rrZJEnUj23ztSnxXJAfA8nV+v7lMTDj/JohZ0HeyEzaAhPu9E3tHXOBj+
   Ei9F1mglueaqnhMwZlOgGHFVoWTFDXkySwsn12wWmn3XTAsEMGUuKmwT1
   2Rbct60W7IxCS9az/lgaQyugZI6tOa6Lb9eou32bffa1c4Iyu7JcxIRgC
   3der6btIWeGB+CZmXmXOXtGKOyJlylCtfVy0aPrQ8JkZGbMGmxkbcV7t4
   g==;
X-CSE-ConnectionGUID: 483UKY3ZQnq3O87yTxL9ww==
X-CSE-MsgGUID: 2cA3N/mnQKeTaJ/Jz/ZAzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="88306626"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="88306626"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:01:56 -0800
X-CSE-ConnectionGUID: ECun5qIlSDS9aOsQ2PDy2g==
X-CSE-MsgGUID: KwRyYQfmTYyVmLnES9mlxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207909829"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jan 2026 08:01:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B2B1598; Tue, 27 Jan 2026 17:01:54 +0100 (CET)
Date: Tue, 27 Jan 2026 17:01:54 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw-mmio: support suspend/resume
Message-ID: <aXjhcijjig79ocks@black.igk.intel.com>
References: <20260122155046.12848-1-jszhang@kernel.org>
 <d0bd831a-08dd-4c2c-97e8-896f885cdbe8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0bd831a-08dd-4c2c-97e8-896f885cdbe8@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 22, 2026 at 05:57:42PM +0000, Mark Brown wrote:
> On Thu, Jan 22, 2026 at 11:50:46PM +0800, Jisheng Zhang wrote:

...

> > +	clk_disable_unprepare(dwsmmio->pclk);
> > +	clk_disable_unprepare(dwsmmio->clk);
> 
> These were allocated using devm_clk_get_prepare_enable() so we shouldn't
> really be fiddling with the state at runtime.  In practice this should
> always be fine I think but it's not really something we're supposed to
> be doing, in theory we could fail to resume and then end up doing a
> double disable on removal.  Probably the open coded version would have
> the same issue though so perhaps this is pedantic...

We clearly can call clk_disable(), but I'm not sure unprepare is the stage that
has no side-effects here.

-- 
With Best Regards,
Andy Shevchenko


