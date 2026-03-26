Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010C19C553;
	Thu, 26 Mar 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552769; cv=none; b=u0fS/mmpPYasy8E4G/UbFXVue4JRJqUP86NNblJNrnw9o7UvSp/Acx0AMlHEVxHIOUZ3xg02AxsBiDa2TiCtSayqajcmhewP72YkwvC9I9hpdyT7Lf8SGe3RTllR7mkFGceL2gG6vV61TS1MPEbVKaXi49bsvdcOpOQBmMqG+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552769; c=relaxed/simple;
	bh=evYGLbkst/WtVeJKDrC7cfcwym1DFlnO7iz3reK55Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+cLH8S3p3Pg2O2jIohWRByjl/9cACm9fx9J1kMvD+Ma+DHmyOh8MzyuMSOfrkLdXGHMCAhuRB9pd+RDHg/t2IqNnYYhGmbxTH1Qpwu/sog6kgfe3zsA8hESjGx5I5XXVrerLoDE34T6QLfaSKFW6fbwzZzhlt3A1SmwAO09peY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVKnU9pk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVKnU9pk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774552769; x=1806088769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evYGLbkst/WtVeJKDrC7cfcwym1DFlnO7iz3reK55Ig=;
  b=bVKnU9pk0JKd6ojycP/fJlZ+cbp27TOw3L8kHGqnKLvt+CJ40OxdblEn
   c7LEtTlifN38y0vlqG78hZXWOPuwPd6UAeTVVon1cJ5gbEx8HT9dpelQz
   exdm7+cL9Mmcc8xiF8tandr3FwW8nM4ci5tmu+7+NXdd3uNCdF1rrCK44
   jLuQ3s0Vb4CqigMhEIUFoOUBpGUgfeYqKdlHwPma++f4VaKvB1teMLGqd
   JaioqKPwZd1YdFXu71usFu8vde6Gu7F9GIT7ykVm25VAXP0kvqp8ZTOnL
   9CFrtlwMEs2hbz0J2VH/QqWzIG4S76lPDfnysMPEq11SBGZfNh132Lvq/
   A==;
X-CSE-ConnectionGUID: kqlLnC3eRWyf8toF+plYxA==
X-CSE-MsgGUID: 5bacb2pSRYK/OTqEqNreYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="87096003"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="87096003"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:19:26 -0700
X-CSE-ConnectionGUID: 7kRMcYAzQOuMxU/lhDoWYA==
X-CSE-MsgGUID: MrNE2OlWTVOfCZSvPEd5Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="229163729"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:19:24 -0700
Date: Thu, 26 Mar 2026 21:19:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: fix use-after-free on managed registration failure
Message-ID: <acWGuheUdu4Bdb8S@ashevche-desk.local>
References: <20260325145319.1132072-1-johan@kernel.org>
 <acT9-MoL5zfss8Hp@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acT9-MoL5zfss8Hp@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 11:35:56AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 25, 2026 at 03:53:19PM +0100, Johan Hovold wrote:
> > The SPI API is asymmetric and the controller is freed as part of
> > deregistration (unless it has been allocated using
> > devm_spi_alloc_host/target()).
> > 
> > A recent change converting the managed registration function to use
> > devm_add_action_or_reset() inadvertently introduced a (mostly
> > theoretical) regression where a non-devres managed controller could be
> > freed as part of failed registration. This in turn would lead to
> > use-after-free in controller driver error paths.
> > 
> > Fix this by taking another reference before calling
> > devm_add_action_or_reset() and not releasing it on errors for
> > non-devres allocated controllers.
> > 
> > An alternative would be a partial revert of the offending commit, but
> > it is better to handle this explicitly until the API has been fixed
> > (e.g. see 5e844cc37a5c ("spi: Introduce device-managed SPI controller
> > allocation")).
> 
> Thank you!
> This is good TODO list now.
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Seems Mark dropped the original change, so this is not needed.

-- 
With Best Regards,
Andy Shevchenko


