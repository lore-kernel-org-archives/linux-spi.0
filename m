Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB143CAE79;
	Wed, 25 Mar 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438584; cv=none; b=aPcfH42vJ49P+DQ/XQ4laxwJ3ZmC662HH8Vgtz/R5CuJ14pTzLdqMe4VAaCOcqdHEpMOETAndJbijH3QdRgekg87V38DWgvtldiS6mBisNJP+y80MQYgo1G9UsPbdAlo04vV/bH1dJZsW4UAqpWfm2kGpqc/c115p23GpibH2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438584; c=relaxed/simple;
	bh=W7GQYjegagUPpxc46RFOInGcTdKwxFvusrp7kLvZjmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unlAKXRX+IgaTWCPhE7bx1jjTSes7d+6Zs5xAtekayrr8YPW4MJ0UyJUdLC+4c/AKtBOQDdUHKSi0WD8jOpAbXxD7go+ASIjuioexk8vcqgaMw3E4vNGYC4ongZSnLj/HA6TzW3a0Xs+zPAMGt9WaMKEyOOSlmW4I7BtLdNdDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbUd3qoQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbUd3qoQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774438583; x=1805974583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W7GQYjegagUPpxc46RFOInGcTdKwxFvusrp7kLvZjmw=;
  b=hbUd3qoQjY1XD+dOmNLD3ugV+GWO35gczt+FPA4ejaQYoHwnb/JzHo5H
   syQyCGI0MOFqV7+B7VZTGCeuhBs3btr+5/H1F6jRECgdvAlljd0sMoawN
   mpxP385wBDXACWk0eN1GUMxpqF2jnq1FrLy5FX7ZiPALrcRGqnOVF65AB
   YCCjg/wvwiauOayGv7D9xz9C/qIZ+bOgFnKE3Yfx91pEuQGke61cHP/vL
   eUQ6W2Rk68MmdkeHDqDgp0MSuI8M8OoQiPsR0fPnHjBkecd5/N7U6ZJsR
   ExyxV8aSoYIDbZiQd2AJusl0p6YRzaBTVY5sclFQ4tzvakIllzlZ8HXpX
   Q==;
X-CSE-ConnectionGUID: Ole70O3BTCmbjHSm4wUKjw==
X-CSE-MsgGUID: dsN00eSTSH6IvSoKW+VXlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="93049433"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="93049433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:36:23 -0700
X-CSE-ConnectionGUID: 8IDMUXWeQuCm8jpfRVRz1w==
X-CSE-MsgGUID: DydOfOulSsqHxDNj06O0zg==
X-ExtLoop1: 1
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:36:21 -0700
Date: Wed, 25 Mar 2026 13:36:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Message-ID: <acPIsrozxf5bAoHI@ashevche-desk.local>
References: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
 <20260324145548.139952-1-ustc.gu@gmail.com>
 <acOw2lGiQbPr-MGf@ashevche-desk.local>
 <CAN4SLj2ybx6Hici+KDbfQScxOcoVSxV56mTncCn7OVpKVRXEDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4SLj2ybx6Hici+KDbfQScxOcoVSxV56mTncCn7OVpKVRXEDQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 06:22:33PM +0800, Felix Gu wrote:
> On Wed, Mar 25, 2026 at 5:54 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > It seems has a potential corner case in this commit.
> > >
> > > The issue is that devm_add_action_or_reset() triggers its callback
> > > immediately if the internal devres allocation fails.
> >
> > Yes, it does.
> >
> > > This creates the following sequence:
> > > 1. spi_register_controller(ctlr) succeeds.
> > > 2. devm_add_action_or_reset() is called but fails.
> > > 3. The "reset" triggers devm_spi_unregister_controller(ctlr) immediately.
> > > 4. This calls spi_unregister_controller(ctlr).
> > > 5. For controllers allocated via spi_alloc_host() (where
> > >    ctlr->devm_allocated is false), spi_unregister_controller() calls
> > >    put_device(&ctlr->dev).
> > > 6. This drops the reference count to zero and frees the ctlr structure.
> >
> > I am not sure I see how the sequence is different from the say this
> >
> >         ret = spi_register_controller(...)
> >         if (ret)
> >                 goto err;
> >         // ...if success do something else...
> >         ret = foo();
> >         if (ret) {
> >                 spi_unregister_controller(...);
> >                 goto err;
> >         }
> >
> > So, each driver should be prepared for an error handling in which it should
> > release resources in the reversed order.
> >
> > > However, the driver still holds the ctlr pointer and will typically
> > > attempt its own cleanup, leading to a use-after-free or double-free.
> >
> > You mean buggy driver? Any real example of the use case?
> >
> > In the 5. you implied something like
> >
> >         ret = spi_alloc_host();
> >         ...
> >         ret = devm_spi_register_controller()
> >
> > ?
> >
> > But this is against the rule how devm must be used.
> >
> > > What are your thoughts on this? Does this analysis seem correct, or am
> > > I missing a detail in how the refcounting is handled here?
> >
> > Is this analysis AI assisted?
> 
> I got the thoughts from an AI review from sashiko and  verified it on my own.
> https://sashiko.dev/#/patchset/20260322-rockchip-v1-1-fac3f0c6dad8%40gmail.com

You must have said that in the first place. And have you found a real bug
when verified on your own? Or is it just theoretical possibility? If 'yes'
is the answer to the last question, then theoretically we have thousands
of ways in the kernel to shoot ourselves in the foot.

-- 
With Best Regards,
Andy Shevchenko


