Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46F3C3BEB;
	Fri, 27 Mar 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596019; cv=none; b=q+V6aqAx+bUfLaEpkun/+t2QI2sxt9ZpLwk4vImBpNBzBdMVR2t+SRkjhHP4gn/fh3zITI4Ptid7gc8uyilvv1z9QTV0kw0FfNOWBr13TZePGrmIaB5uMWXzvho6yDmnMmshGPExGJfq1yHIR+kq7Ex3OIoR7YEOxk4VKdRIYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596019; c=relaxed/simple;
	bh=7Q2xrf/zmOZu+aG0pdnFP4ISWJUMYatAYhqZmBO/ehM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmQXkX6bsmTrU5WClMQKiax5MjzXAkXd2xKnK3fYqYoCUQ9EuK4TxNZ0dSqDg6y6BjbQe9ryqgHN6OFMrJLYHWFjooRDd/I25QYkxgvCdAPEbNjDCSJYzctHxM+rzgHbqIeG/T1muFRVKa4lB0+DS8JySz08u+au2VikwCKlK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rqptxv+u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rqptxv+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596013; x=1806132013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Q2xrf/zmOZu+aG0pdnFP4ISWJUMYatAYhqZmBO/ehM=;
  b=Rqptxv+ut4WHKsAojN83L1Bq4HXYKeIvQ/GpRoyXuy/s5zuw+4bq/ghL
   8vCMhdktfb7fu/WhdkHXx14FYTKLE4LFBJoqiGbiiQqD1BBL9rlGaNenC
   NhdtpKtsp7KY3PHYCK3jdeud9Q5mV3ApFheHG/rj1ubNi4OEC9IlEcgyz
   BEkuK0u/51u0kpIn7CmcTSdgQzRMPnS0KKYvcBFY4MQIGuI6yFIxRBXav
   I8yfvnq594ViUSj4MUXgyqq+G3HVFWS+2y75z0V/Lun7oYmJ9tNh94VCs
   AhJhW+xMkyd3XtFlX+ygfKGIic1gMr5jMPf3BZ8t+rQENOhaP0ZsclkTp
   A==;
X-CSE-ConnectionGUID: HOnN7w9aQ6CQjBLx5RU4QA==
X-CSE-MsgGUID: YqkYVndQRTOdhA23l1eD2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79523925"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79523925"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:20:12 -0700
X-CSE-ConnectionGUID: v51ttp9/R+uESe1sJ/KP6g==
X-CSE-MsgGUID: Rl6sbizKQLuwMk48ivKcsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="225164915"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:20:12 -0700
Date: Fri, 27 Mar 2026 09:20:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: fix use-after-free on managed registration failure
Message-ID: <acYvqDTmQljmzXcg@ashevche-desk.local>
References: <20260325145319.1132072-1-johan@kernel.org>
 <acT9-MoL5zfss8Hp@ashevche-desk.local>
 <acWGuheUdu4Bdb8S@ashevche-desk.local>
 <e8588793-02ad-4339-bca7-fe55db697e89@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8588793-02ad-4339-bca7-fe55db697e89@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 07:25:14PM +0000, Mark Brown wrote:
> On Thu, Mar 26, 2026 at 09:19:22PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 26, 2026 at 11:35:56AM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 25, 2026 at 03:53:19PM +0100, Johan Hovold wrote:

...

> > > > An alternative would be a partial revert of the offending commit, but
> > > > it is better to handle this explicitly until the API has been fixed
> > > > (e.g. see 5e844cc37a5c ("spi: Introduce device-managed SPI controller
> > > > allocation")).
> 
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Seems Mark dropped the original change, so this is not needed.
> 
> Not intentionally?

I don't know, but it allows to start from fixing the users to avoid regressions.
I'm fine with the current state of affairs.

-- 
With Best Regards,
Andy Shevchenko


