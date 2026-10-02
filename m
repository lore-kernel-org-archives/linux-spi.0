Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E252346E7A;
	Fri,  2 Oct 2026 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936340; cv=none; b=ak7hLehDaGS3AzcO5QO3QuojdqNmO7T4E24FGvJF84XIUX+XRiYsFza8ZkkiN3QC7RLaVIlWSb9vUfo+sqp+wKi/gQ/xOzLNtAVdF4vK1NHhsLfOYJ6BuHSDKojKqNyrc8O/EdVK0QA6fcz3AWrPh8RrR5+HiydDaxa269FQwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936340; c=relaxed/simple;
	bh=TsMJ+4gNkWVqVswmgJ7yPSiNWVRV87vymlqaYEMCvlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7DLBSpNLPCzWMw2WoPieuk0Tm/6aCxwze1wl49fkPCm6g0OiHJNz5i8zbnlqQUUDZIWtN91uKOW3z6/iZMXHUA2P4Q87bAtQwNWZynQZn8vnMKwEn/n2vRHW7wJ3jIJp9grMnUH6Y1KNDNw2x74pKfAMuBTHES3CmaUyqQFAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/+yI66M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/+yI66M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790936339; x=1822472339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TsMJ+4gNkWVqVswmgJ7yPSiNWVRV87vymlqaYEMCvlg=;
  b=n/+yI66MM2aYcg6AZoYPUjgP+uZXsT70JXLMj/EhVJd4WsBeRGkLpvIg
   brppwZ78rGoPDfvupcY8BQN2hxaEfD8nqO6TNZSSXcie462rxPoak//eS
   CzoCUHxblw0XPBRB4cJJ5E+eabN9/61u636r82r0BHclWGVHn4I2+S/02
   UhFToO3L8hSj+yECKmwvhFtvmFUeOFQDv/L3kGHytj6JvaB8V9GPy3RLb
   O3pQGHs5muwvc7gQBsboBdQ/F8tYtXOE60Mw0yDq1u3ICTyhSo3JHcm7j
   VBtiNewNKI9F1KMub/k2zrDvugGTQYyCWh40CwuIOx/cnrNH1oqryYRZM
   w==;
X-CSE-ConnectionGUID: 6NwfLTv/TA2i30LiNmf/iQ==
X-CSE-MsgGUID: 4WcfP5WRQN2F5X31LYjzLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="109187567"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="109187567"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:18:58 -0700
X-CSE-ConnectionGUID: DWliCEhUSN6XooXqwkALjw==
X-CSE-MsgGUID: SND71xBDTUiQxFGjurcIhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275757817"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:18:56 -0700
Date: Fri, 2 Oct 2026 13:18:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: jiale yao <19888972804@163.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: Re:RE: [PATCH] pinctrl: mcp23s08: reject devices without
 match data
Message-ID: <ar-FDqxMC3F-zkPB@ashevche-desk.local>
References: <20260925133804.2231004-1-yaojiale02@163.com>
 <TY3PR01MB11346E0C01A9337A3AF4D97DC868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <34472b57.1961.1a0dd3dff12.Coremail.19888972804@163.com>
 <TY3PR01MB113461CE3C9EB4A175879F5BD868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com>
 <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
 <ar9WM0ZtDJD2H5Ii@ashevche-desk.local>
 <CAD++jL=eGjhCM8Xa=T08rPSGpH4p5dsajZa569gsObJma3yZ6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=eGjhCM8Xa=T08rPSGpH4p5dsajZa569gsObJma3yZ6g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 11:52:41AM +0200, Linus Walleij wrote:
> On Fri, Oct 2, 2026 at 8:59 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > I believe this is the whole design of driver_override like this...
> > There is an attempt to allow drivers to forbid that feature.
> 
> I guess I don't have the right background to understand
> the driver_override feature, it feels someone should explain
> its virtues to me because I feel I am getting really angry
> at it and it may not deserve that.
> 
> The entire name of the thing feels like debugfs-footgun
> territory for example.

Yeah, I can't find neither a thing on LWN.net nor in the in-tree documentation.
The only useful piece of information is (in kernel-doc of struct bus_type):

  driver_override
    Set to true if this bus supports the driver_override mechanism, which
    allows userspace to force a specific driver to bind to a device via a sysfs
    attribute.

-- 
With Best Regards,
Andy Shevchenko


