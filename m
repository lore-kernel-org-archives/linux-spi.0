Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69843F090;
	Thu,  1 Oct 2026 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827993; cv=none; b=SgdwrmGoQ/4m5djPkONKqMDMosUy5wxu8RGceYlmSZQ68bqGwrKYZTVHNpsWdhP8XUoY/4GiFRxu5YRUcsSvum51kCimMjt9Ox8VkakfjGCUOWWWarnY84QCVWRTaeWvoG8HBoxjwpmW4+hJgnVRArsSM0JXDV5oREK2WlTJp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827993; c=relaxed/simple;
	bh=0gAxlKmIA6K1VhObkwtDYhb08ccS4/II8Y1SYR8k3+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd/z9j8iaNJ9DwdMZ+FVwn7by6HSxwOfH47uKnsnZR0xvzFN9O4+KnPAnmZ6ZD5MtVRp7cOcL1yxsVVBehujxojZB3+EzProJZOjqGLnQBbiTH8pVHQjRwoPAEPvhGN0sF7AYuh4gkeV0CI7KXNs1B7kZSjeV4s19Ib0ktxUUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0mhHuxK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0mhHuxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790827985; x=1822363985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0gAxlKmIA6K1VhObkwtDYhb08ccS4/II8Y1SYR8k3+s=;
  b=I0mhHuxKr8NjV//7+9ILkTwBjLwOlV6UOJUKXTzCwO5YBSzS0jzpX9PP
   LeMG/t4piXrpEsizyoNOrQfSIGP6yrGm2SU/HirOrg6XQ79txaFggOezT
   QCzutDPVcm0eecPxHP1ukdrD3BGkrGn0CeTKwmETZp9OU5OpbLyfPIhom
   MlA7tkZQFVWgjK713G0gCkBxic8tmyA7fsYWa60Gn85kdsvwFTZl9VUqB
   v2syl+IUhrysGT7ASnbpCv0+pYrkFSp66WXhpIxrq2LVE+xyLnszqH0uB
   qWRaV8naX1uLYkuAzxtc6ty1vfESE0eJdYYheMmiJ8ODMPCahQ4EV55To
   Q==;
X-CSE-ConnectionGUID: +TeTIIghRi2bscvQ6rMGtw==
X-CSE-MsgGUID: /5nBk55PS9ebXxwB8Kx93A==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90436460"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90436460"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 21:13:05 -0700
X-CSE-ConnectionGUID: 75Xo4f+JTciNDNdQJjJe1Q==
X-CSE-MsgGUID: tzhl8O0RTK+E2xq0gYHgsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="280629052"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2026 21:13:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 3C1A299; Thu, 01 Oct 2026 06:13:01 +0200 (CEST)
Date: Thu, 1 Oct 2026 06:13:01 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v17 5/6] spi: pxa2xx-pci: restore LPSS private register
 state across S3 resume
Message-ID: <20261001041301.GC176164@black.igk.intel.com>
References: <20260930160629.1822-1-fourdollars@debian.org>
 <20260930160629.1822-6-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930160629.1822-6-fourdollars@debian.org>

Hi,

On Thu, Oct 01, 2026 at 12:06:28AM +0800, Shih-Yuan Lee wrote:
> On platforms where Intel LPSS SPI is enumerated as a bare PCI device
> (such as the Apple MacBook8,1 on Lynxpoint-LP), the LPSS power island
> loses power during system sleep and powers up with the controller held
> in reset. Because the device lacks ACPI companion objects or MFD
> binding, neither drivers/acpi/x86/lpss.c nor drivers/mfd/intel-lpss.c
> restore the private register context across S3 resume.

Hmm, how is that possible? The LPSS is a single PCI device that only the
the LPSS MFD driver binds to. I don't think it is any different in Apple
platforms than any other regular PC platforms in that sense. What does
lspci -vv show on this system?
