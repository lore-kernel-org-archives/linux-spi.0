Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6930DEB0;
	Mon, 31 Aug 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181638; cv=none; b=YvBvSx9mXWIrb3Ign9RxdwhQ1NILznGZ/n0MHX4VrT4wKmYPQ/k2NUWomMwPVLz+EUkxGipv2HI6Za4yS/HqcAw76CAlNG7PUneb0ZfgoGYGYf/HHdRNAmw7hcU8Xc8XLzvNRgxHIrl6wC1mcqMfVCioI5QiG+7kkgdy4qtyv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181638; c=relaxed/simple;
	bh=6/vscZ84sW1fUTAC+I6IPslPZth5hZiW4QMeEDVqzFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICXMoEIH5gGGdm0mTzxMv453Qgf0cjqqVP7f9GeTwUEW36hqr+/ps6eIDAe+UfXCK1T/h1jT+rTPaWl0YIkzolhYrdtn23tE42cdFs2mLfhrK9hcnjlEJjyjmQFGkprLd/c05GvCxVy6cYf5Vjj5qLTm0W6H88FH7+dpnpH9lVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3xdzRrg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3xdzRrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788181637; x=1819717637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6/vscZ84sW1fUTAC+I6IPslPZth5hZiW4QMeEDVqzFc=;
  b=B3xdzRrgsEAWpXrHuJvXq5jJC3Y6hdafpHAItnXBJX4f/LKS7wBRNSN1
   6t0q8x9cRiQUhEbszbgIOawG7WWb3nf38PNcG+EQomJtJYLxZEVhzOU+T
   JRQXu+vQZOVvb+KIUl45yNvpRI6oBsFih4JbEG3Jr/xk1Xgkk5/UIzIT+
   GGXuo8DG8iOycOt1xMwYT8QOMyaxUnXWwUhyQhYGs41VQ2pSP23SmZFn3
   OjOTqBDhKJn5H/xfkotn+Gdq9GmF7FjaSlzgSN+Gb/BsWrI6W8rJ3GYdd
   1Wr7uG/b4tg2GL6YTUvYW/iSGsg7KWsWnNtUbYBaeE3ciXAtiba5r+mkK
   Q==;
X-CSE-ConnectionGUID: Jg8fKf7ESpWdU8qxqGVUmQ==
X-CSE-MsgGUID: r5jfKSMVSgaDnwrqLQs8EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88793647"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88793647"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:07:17 -0700
X-CSE-ConnectionGUID: b4TMZ87/SOWF/aw21zrwvw==
X-CSE-MsgGUID: qDMR9we+Szm2xt3XEdbShg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="272594617"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 31 Aug 2026 06:07:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id EBF1E99; Mon, 31 Aug 2026 15:07:12 +0200 (CEST)
Date: Mon, 31 Aug 2026 15:07:12 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Walle <mwalle@kernel.org>
Cc: tjakobsen84@protonmail.com, Pratyush Yadav <pratyush@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Report platform enforced SPI flash write
 protection
Message-ID: <20260831130712.GL124825@black.igk.intel.com>
References: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com>
 <DL34V3WU5UY1.3FYYB7UPWYY83@kernel.org>
 <20260831125526.GJ124825@black.igk.intel.com>
 <DL35CFJ3BXZ1.2RE00JYDZKXXU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DL35CFJ3BXZ1.2RE00JYDZKXXU@kernel.org>

On Mon, Aug 31, 2026 at 03:00:36PM +0200, Michael Walle wrote:
> Hi,
> 
> On Mon Aug 31, 2026 at 2:55 PM CEST, Mika Westerberg wrote:
> > Hi,
> >
> > On Mon, Aug 31, 2026 at 02:37:59PM +0200, Michael Walle wrote:
> >> Hi,
> >> 
> >> On Mon Aug 31, 2026 at 2:05 PM CEST, Tobias Jakobsen via B4 Relay wrote:
> >> > Patch 2 adds the only user, spi-intel, which already computes protected
> >> > range state at probe but has had no way to expose it since the SPI MEM
> >> > conversion removed its visibility of the MTD device.
> >> 
> >> Where was it removed, though?
> >
> > After the SPI MEM conversion the driver is a regular SPI driver so it can
> > only use spi_new_device() to add and configure the SPI-NOR chip (via
> > platform data, struct flash_platform_data). Prior this it was creating the
> > MTD device itself.
> 
> Yeah, but it never exposed the _is_locked() op, right?

Ah, yeah that's right :)
