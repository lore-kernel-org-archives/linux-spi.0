Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7E30AD05;
	Wed, 25 Mar 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432480; cv=none; b=V2AzGAAgd5qFEmBg3NQGLbJw59vO3CBPJRzWdqPO+oHJB3/caRxpwzeJL/bPHiW+BXXH/fLAKmtb5aPk8Vr8lhMu23TybLs7IzQJgY+tZlZoBzuU6L1RCuXEJB/6v/Cv5XowrH5rZELFaqqymp8GoN0GBMFXvCsbcZVjxWoH8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432480; c=relaxed/simple;
	bh=7EiaRxmsVIzYa72CFW/2suQxXAhsJxx/5bUpYhqx88w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkDoKJ3YQViLvnkfYBV9l6xuPLiGgNzHdFVizXDL7iYkOJTGNXVEdRBzAttJ6HjMjJv/xBBzqTFSZxHVi70kWclCM20wQV/Hy51sT4e8JfAFlCg12FZlC9UR5+7XwRn/X+ml+DHzB98BHXqdEKAuBCuoallLqOhmfInwEEt9z04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ebcqzko2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ebcqzko2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774432479; x=1805968479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7EiaRxmsVIzYa72CFW/2suQxXAhsJxx/5bUpYhqx88w=;
  b=Ebcqzko2yl/LzAktYB9/u7XG6UasohYvCx9M6qupQQdA60HneiDChE5d
   GpHH2ZmbV1r5s+zdr2nMDdVs253sPsA9G6SuYxjhlH4faVhzNPCWoJGWd
   mno6KTxvx3VT+WfwmZJL8FuUtwg4FZkTHGeNPCutUF+SKN9j+9XrgkG8/
   3KGN5JmqtdFE6vBKnVFFfeLJ1W/wzJxe+MPrFW6hBS4aU9grEsaAJFT2c
   H/pykYP4+NuYxmETewjRK1vL+pedvLifHmpoqLRPx35KYYmeMNhcvOuL/
   /gcSljccZmcKLJCIXtkIZSyM9eA/MEsETXJkus2ksVN6xmjtm5nW3X+qc
   A==;
X-CSE-ConnectionGUID: t8UsG0yrRFGJdX3Cj24TfQ==
X-CSE-MsgGUID: feZy6lo+TOir7+Y9Uui84A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98085772"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="98085772"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:54:39 -0700
X-CSE-ConnectionGUID: /IZhftTwRFeN8RRbIFHKAQ==
X-CSE-MsgGUID: 5hkeYRO+TG2NXMhTecI1FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="226267337"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:54:37 -0700
Date: Wed, 25 Mar 2026 11:54:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Message-ID: <acOw2lGiQbPr-MGf@ashevche-desk.local>
References: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
 <20260324145548.139952-1-ustc.gu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324145548.139952-1-ustc.gu@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 10:55:48PM +0800, Felix Gu wrote:

...

> >  int devm_spi_register_controller(struct device *dev,
> >  				 struct spi_controller *ctlr)
> >  {
> > -	struct spi_controller **ptr;
> >  	int ret;
> >  
> > -	ptr = devres_alloc(devm_spi_unregister, sizeof(*ptr), GFP_KERNEL);
> > -	if (!ptr)
> > -		return -ENOMEM;
> > -
> >  	ret = spi_register_controller(ctlr);
> > -	if (!ret) {
> > -		*ptr = ctlr;
> > -		devres_add(dev, ptr);
> > -	} else {
> > -		devres_free(ptr);
> > -	}
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(dev, devm_spi_unregister_controller, ctlr);
> >  
> > -	return ret;
> >  }

> It seems has a potential corner case in this commit.
> 
> The issue is that devm_add_action_or_reset() triggers its callback 
> immediately if the internal devres allocation fails.

Yes, it does.

> This creates the following sequence:
> 1. spi_register_controller(ctlr) succeeds.
> 2. devm_add_action_or_reset() is called but fails.
> 3. The "reset" triggers devm_spi_unregister_controller(ctlr) immediately.
> 4. This calls spi_unregister_controller(ctlr).
> 5. For controllers allocated via spi_alloc_host() (where 
>    ctlr->devm_allocated is false), spi_unregister_controller() calls 
>    put_device(&ctlr->dev).
> 6. This drops the reference count to zero and frees the ctlr structure.

I am not sure I see how the sequence is different from the say this

	ret = spi_register_controller(...)
	if (ret)
		goto err;
	// ...if success do something else...
	ret = foo();
	if (ret) {
		spi_unregister_controller(...);
		goto err;
	}

So, each driver should be prepared for an error handling in which it should
release resources in the reversed order.

> However, the driver still holds the ctlr pointer and will typically 
> attempt its own cleanup, leading to a use-after-free or double-free.

You mean buggy driver? Any real example of the use case?

In the 5. you implied something like

	ret = spi_alloc_host();
	...
	ret = devm_spi_register_controller()

?

But this is against the rule how devm must be used.

> What are your thoughts on this? Does this analysis seem correct, or am
> I missing a detail in how the refcounting is handled here?

Is this analysis AI assisted?

-- 
With Best Regards,
Andy Shevchenko


