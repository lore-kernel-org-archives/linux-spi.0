Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A7390C9C;
	Tue, 17 Mar 2026 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732871; cv=none; b=AT8U6GzwRrmL4oGkjVdeNcm+qZAvIiSPqIRwqbmN+TzKdkEzqwkTm3v1vpGJKIdpcafFHVyqhdKg/NEX3uwXOOmcIf6tW9HR3teeXXRIdXD3hBGCo5r5iY0DtatlF2VGi+Mauiu0K6B+KuGBwkpRoQVE6JBueylRTl2UOFDa8cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732871; c=relaxed/simple;
	bh=1OJtUNEamh5vO3iFIrEXYFak4q7SIt7T2aherzADZ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJin+WTo6SOAFIl4SwBBsbdIFKa9iBGCt2nHp6VhL5V85uqBwzYYvY/ihKKrjGztu0gUI4eZx6rsxeqTSqcC8jji5t+EPv5ZQYztB362MPiwAbgoKrqdmp291Q44HSfO4DPJwVu97EbvDCSvFtwFcA4D7Vy30c2u4KuWdplLKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M47DaaOu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M47DaaOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773732868; x=1805268868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1OJtUNEamh5vO3iFIrEXYFak4q7SIt7T2aherzADZ/g=;
  b=M47DaaOuSzsQO328WpCScWltYGD4pdgiPUxorGYboWTN4VdJ5bhV5HgK
   ycgZqRjShABovIRAl9mbB1rplIl4VcZupB+COiK3gbIxCgaUvmCnRiLDW
   14oPfBjsouJXU622gvO2BQcktn4jsCUgI8WY8nTWT5cqZTi+f8aJ2OIuu
   laCc4bSV3biqHi/7v+LEiaHEwyolHZvj23jbbfU5KQWTc9OpxHY//aR+G
   lg/1CmDhYBl0urV5JR+H+jn+fRM9jt7SZPoa74dmem/uDtsUDXX9ZPqP5
   GsoD2FLbVK4j3eSdEXvncyrXjHlj8mzrZGGe8l0511L8OqNoGdwFv64PQ
   A==;
X-CSE-ConnectionGUID: 7mzbjog+TL636KIKxK2VyA==
X-CSE-MsgGUID: RpLqQNvZTX2I+PG++Vj5oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74835520"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74835520"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:34:27 -0700
X-CSE-ConnectionGUID: l6i/QyKCQ2+Qh0zbsAMaDQ==
X-CSE-MsgGUID: E2hgBnOgTvOTItdc81+GLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226306582"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:34:20 -0700
Date: Tue, 17 Mar 2026 09:34:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	driver-core@lists.linux.dev, imx@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <abkD-VLprcbbEbB1@ashevche-desk.local>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkCPU3rxHI49N4_@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 17, 2026 at 08:26:53AM +0100, Wolfram Sang wrote:

...

> Thanks for tackling this issue! I agree it should be fixed, just
> wondered about one thing:
> 
> > While flags are often modified while under the "fwnode_link_lock",
> > this is not universally true.
> 
> Is it a possibility to use the lock in all code paths instead?
> Because...
> 
> >  	struct list_head consumers;
> > -	u8 flags;
> > +	unsigned long flags;
> 
> ... this change costs some memory on every system. Maybe it can be
> avoided?

How much memory does it cost? On most 64-bit architectures is +4 bytes,
rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
+0 bytes. I expect that 64-bit machines will cope with this bump.

-- 
With Best Regards,
Andy Shevchenko


