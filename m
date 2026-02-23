Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09D190462;
	Mon, 23 Feb 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868139; cv=none; b=lvwO/L79+syIvQGZx0LXBSRHjRC/7EZnNhR6DckhTzXuNm4OIeueaqXs01REDMxiSzVedogeM/GVxYU0vck+eakD4QxKaAsv8njV6CeNFU3OmyCgzlUtTlZ7P/+9y+WVb/CfcSlSvzyy2VlMNAF0UA9oVRjFTgYhRqYlUPzPWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868139; c=relaxed/simple;
	bh=U5zxDmwawz4WruJGR4RkxkWHRP6haiZsXdq6zgOTCaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NldhROFJpd62WKS4u1dUs2MeNg8Mrta7GPGW5xP+2BdUy1I5ofX3mtCw1ZYW80PZo3TPyPV/+ZNzS5/9HJigBHW1y7gB02/sO4dJbl3boMWWppqx5o85C6L45tcWIJvgVnnREyyEbNFqZQlMuzoxaiyaFc7nzOfpvD1YDOet/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2tcFfKG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2tcFfKG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771868137; x=1803404137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5zxDmwawz4WruJGR4RkxkWHRP6haiZsXdq6zgOTCaU=;
  b=H2tcFfKG26evmhAg9LSKkdlHKfy333lWYaeS5HOnJ58CxT66mb5vJf/X
   3N1xZUum1TDDP+afsOC5DCrE1GCI2Iwy7xnVx3kp9yKvXF5NAEw7zH5m0
   PJL6BwcIQ9IzNpCiE59aGJGZ312xodwDUDI/+2QQW6o/9+9XmUsiRr5Vo
   JBXTq+4fvibyWoGgvNaGRBMYu00UW3ha31F4pl/3eztoM6tXe2fqanMmI
   vTmaWQ+wkzBmqmwyxIOKhjRJNnt+8vUlq79DyavonK0qC24rbbscUgqnY
   ecFMgVOVDlIxtMqEUEXi8RND8yR4JjAgo8nTdTSULwaPDXuHguaPxhtYU
   w==;
X-CSE-ConnectionGUID: iipST+eESxe3kSrqFWczow==
X-CSE-MsgGUID: NTvdYz++R+CMLhUjOl6fXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73049921"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="73049921"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:35:37 -0800
X-CSE-ConnectionGUID: AKo+otEIRKW/YmGTs8gUNQ==
X-CSE-MsgGUID: kYLwZzcFSD+fzetIaWYUuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213544542"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:35:35 -0800
Date: Mon, 23 Feb 2026 19:35:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: use min() instead of min_t()
Message-ID: <aZyP5NdXWikG6E_C@smile.fi.intel.com>
References: <20260223153117.2838840-1-andriy.shevchenko@linux.intel.com>
 <20260223170903.5f3379b4@pumpkin>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223170903.5f3379b4@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 05:09:03PM +0000, David Laight wrote:
> On Mon, 23 Feb 2026 16:30:54 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > min_t(int, a, b) casts an 'u32' to 'int'. This might lead to
> > the cases when big number is wrongly chosen. On the other hand,
> > the SPI transfer speed rate is unsigned and driver uses signed type
> > for an unknown reason. Change the type of the SPI transfer speed
> > to be unsigned and convert to use min() instead of min_t().
> 
> Reviewed-by: David Laight <david.laight.linux@gmail.com>

Thanks!

...

> > -static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
> > +static unsigned int quark_x1000_get_clk_div(u32 rate, u32 *dds)

> I've looked at the file...
> I think all the 'long' in that function can be 32bit.
> Especially if the code actually works on 32bit.
> There is also the stunning:
> 	do_div(fssp, 1 << 24);
> in the only bit that that does need u64.

I know, but it's unrelated to this patch aim.

-- 
With Best Regards,
Andy Shevchenko


