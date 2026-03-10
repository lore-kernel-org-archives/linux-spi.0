Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB737E308
	for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140216; cv=none; b=d9NsiL6dnVctCGCBd11weQizlHG7qx88LyxHUN0uNEz4rPsix3852pqTbC9vcsVn3DbblPJ3f3yRovGtKDSdrNm04EvdwVFfdhEYZceQBZl+4bBMmK18N5UbHvIrKHK4OjsFi48GicOaQQaHuj679DHG4BgMKinmo6euywy6Tj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140216; c=relaxed/simple;
	bh=wBZpPm4FYL+nkwBThAO7ls7WJgnd3ewyWAQhJxEFD0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtK4ae72usq3AVtfIa77NAiUDlGBLr2gFGRsNnR96D3RdFkvcsL35C3Q3g+tqd7IS61jXiA/bkKa0G7DAc5Fx+dS7yRnBEnrHv194rrS/WAE0Jg23hfT2/ileHe6RLQvvlHhPR3/m5aeMaN5y3x9qlVtb82o2s0p8Ibq4WG/a7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDhbYJvc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDhbYJvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773140215; x=1804676215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wBZpPm4FYL+nkwBThAO7ls7WJgnd3ewyWAQhJxEFD0M=;
  b=bDhbYJvc3xTpk++Ol3Phz5FU1oifZa6Vx+pdxlcF6u/xVPy+3mrBLeYb
   8WJHmVMh3rEoQ3ChIP6EUUMdy3hPZUNfMbGiRLOLQZF3eb9F0T4+fWx4Y
   OYXTdGDP0t7d1P2shViESukcqdI5KrsWnPof4sN3L7Cf6WYwaZX9T1RAO
   Amm9mA9Zh4/w6maRfehaze6L2xQW5o2KD83a5iPZLCp/NZe3daZW33MGz
   ZoJAsUrccKejCXjTlbrXMU0azIuKIAwtV0SRvD3GOuhyo6Xk9s/P2BN9X
   yPxUyVA58H8yOuisgM8IbGkPfQBOD+rVbY3FC3eXp2lVLPRbLM+SLk9Ru
   g==;
X-CSE-ConnectionGUID: QvhtXjbBT8GfSSK+ZE2VtQ==
X-CSE-MsgGUID: nxnTHlAORuSFyV6vzWVOAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="78037448"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="78037448"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 03:56:54 -0700
X-CSE-ConnectionGUID: 8EGlpKjMRA6QG7kqfMicKg==
X-CSE-MsgGUID: chDfZFTzSTO5DAJ85HFJrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220115580"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 03:56:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A110495; Tue, 10 Mar 2026 11:56:51 +0100 (CET)
Date: Tue, 10 Mar 2026 11:56:51 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: intel-pci: Add support for Nova Lake mobile SPI
 flash
Message-ID: <20260310105651.GT2275908@black.igk.intel.com>
References: <20260309153703.74282-1-alan.borzeszkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309153703.74282-1-alan.borzeszkowski@linux.intel.com>

On Mon, Mar 09, 2026 at 04:37:03PM +0100, Alan Borzeszkowski wrote:
> Add Intel Nova Lake PCD-H SPI serial flash PCI ID to the list of
> supported devices.
> 
> Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
