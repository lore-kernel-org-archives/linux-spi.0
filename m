Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE03F824B;
	Sun,  4 Oct 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791101732; cv=none; b=d5b+dHfxpRBZr7sHVYYToRhQX85U5vByQ6CSkNxiOD2td1tytuttLv/YDs5tkpTBwSeJwY279qSZls9eNtPVxVpCOQsVpPo6uhU5sOJZT7TMlIo7CFsZQz83ZUN+A6sUmBGe623+nYf/dPTubnPxgy//xQW2vV2RUKa4uNv4n6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791101732; c=relaxed/simple;
	bh=l3X9H5L1fj1BmDzj5Rn/tNXmUhlIznfeIXte6hu8p/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKlfVCRdtp7f9YKgkfgGNsEL1sAck9IQvl17zjlTw1GkGsXXB3ensq85/F5j64lxUhVTQ9GYcLnmNzHxA/y9lLFQZj+0vZVzV4YJLcZ7y3aghsx10C6YBAFduBys9kkiby3GvOfE8BCxbGxzAKWp1N0/5Aow0H2IC4HAaUJr/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+fLambX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+fLambX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791101730; x=1822637730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l3X9H5L1fj1BmDzj5Rn/tNXmUhlIznfeIXte6hu8p/Y=;
  b=c+fLambXm3TWcPrQ/ItOcxz3yQzmi8E6t+dw/vuEpiRpuA4gvLtJSG2A
   yjIuWBxxX6V8FrRcWV6FeknJL8oGB+04TQzNUuuPLPmtKcboO5U/zYfmk
   ovBzybX+sW4vxE9+9mlRZaW2Cu3QXkIc0a0GagZLUKYQvtFBFtfkc/Xx7
   gFhu13WLPmJbcIzjcFq+A3Gc9UePeU9atG3fOB4HQGEuaYVINzWApHUn8
   2Mkss8Iq11wcr1LTHwwKAYQFs8ZLb0iTffTrfolSc7fLvp8I2unN0pXKV
   tXSuJysoRMzFqlaX6brBQ0/F3h4qSV+8HiJ9tvxN0XygMogj5sE4E8HE7
   Q==;
X-CSE-ConnectionGUID: xpv6oPNnT8umua0ip/BgGA==
X-CSE-MsgGUID: UXdZw47/Qoy00L0v54c0Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90833984"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="90833984"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:15:29 -0700
X-CSE-ConnectionGUID: CL6XgozSQiCcd/U3Xfp4Gg==
X-CSE-MsgGUID: npL6c5ofQv6XSbpjyGehyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="275216433"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:15:26 -0700
Date: Sun, 4 Oct 2026 11:15:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linusw@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Kim Phillips <kim.phillips@freescale.com>,
	jiale yao <19888972804@163.com>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: Re:RE: [PATCH] pinctrl: mcp23s08: reject devices without
 match data
Message-ID: <asILHNE0iDP2jVVR@ashevche-desk.local>
References: <20260925133804.2231004-1-yaojiale02@163.com>
 <TY3PR01MB11346E0C01A9337A3AF4D97DC868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <34472b57.1961.1a0dd3dff12.Coremail.19888972804@163.com>
 <TY3PR01MB113461CE3C9EB4A175879F5BD868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com>
 <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
 <ar9WM0ZtDJD2H5Ii@ashevche-desk.local>
 <CAD++jL=eGjhCM8Xa=T08rPSGpH4p5dsajZa569gsObJma3yZ6g@mail.gmail.com>
 <ar-FDqxMC3F-zkPB@ashevche-desk.local>
 <CAD++jLnia-GyvS57-q2NOTWrqXWC12-HDbU6qsUiWEqOgTPX_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnia-GyvS57-q2NOTWrqXWC12-HDbU6qsUiWEqOgTPX_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Danilo
(as you were involved in cleaning this up in the past and being co-maintainer
 of driver core)

On Sun, Oct 04, 2026 at 01:06:07AM +0200, Linus Walleij wrote:
> On Fri, Oct 2, 2026 at 12:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 02, 2026 at 11:52:41AM +0200, Linus Walleij wrote:
> > > On Fri, Oct 2, 2026 at 8:59 AM Andy Shevchenko

...

> > > The entire name of the thing feels like debugfs-footgun
> > > territory for example.
> >
> > Yeah, I can't find neither a thing on LWN.net nor in the in-tree documentation.
> > The only useful piece of information is (in kernel-doc of struct bus_type):
> >
> >   driver_override
> >     Set to true if this bus supports the driver_override mechanism, which
> >     allows userspace to force a specific driver to bind to a device via a sysfs
> >     attribute.
> 
> This whole thing is weird, but OK.
> 
> Since we have a ton of drivers depending on match data we either
> have to patch them all to bail out if match data is NULL (like this
> patch does) or, which is equivalent, opt out of driver_override
> that much is certain.
> 
> What I don't get is what this is intended for. What is the use case?
> The commit says this is for VFIO. Shouldn't it be opt-in and turned
> on only for VFIO then?
> 
> Kim Phillips is listed as contract for the platform bus driver_override
> so let's ask! Kim: what is this for?
> 
> All of the device tree drivers use the platform bus, what's yhe
> Unique Selling Point of this for our devices?

-- 
With Best Regards,
Andy Shevchenko


