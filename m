Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0F408630;
	Mon, 31 Aug 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180932; cv=none; b=KjHrmZjwofxEPLDCM+B+obpBMpNWSz5zTm+uzTTW0Sqxg3f635PdGgL7cxnDiAmG8eCVIyH/1NqFs8BX3JtWWsj+hkI1Iomxyn2mAOfCwr7lfZgEBU53Uz2v664csKzZA/ZCjcUuX0/RkLz5GpY3F1xv2MSvZ5Fpk6QDPG8gFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180932; c=relaxed/simple;
	bh=sif5+hNzJedR/vts6gsrtZ73av+XEooXAd9niZui1ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL2Jng2pLeuc+ThDTXgTJeCSr1HdBtD0SFzpu+vHbWvHB2s1R32KrqbD2xT+nEHEhS4q+JmW/9KkcpvHG04yv9bb1ppu9a0gA/C6Dmask2kP3IUnCmIVtWhuI2IIz1r6+kkEtxYKus7++4/rpqLhBshchXKlQU9lppM29BqlDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9PQDxOQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9PQDxOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788180931; x=1819716931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sif5+hNzJedR/vts6gsrtZ73av+XEooXAd9niZui1ZY=;
  b=h9PQDxOQGWZF17TloLI43CCD4JSP/JNWJ3KNEoP4ta3ccGAhPbV8Pav1
   4bvYiKq5jDyhU9lYr0fDG6FUa1kCn2gN7HRiJ0stVjZEuv5RyJdR2h0EK
   v7CypmRHgr5PPXLmxCjjLQDqpKhXzDWDruwudTlz+8pM8Az7VqRV93dzC
   fMipXHV0uBr7c5jFyQT3UwtVZwptQHOPf/RXPK6z9Pvyw+YTE5vmXhPMB
   R0VzWoXN4riSqSe6E3L5aaIEQCIoDcHAylQaWrewzGOuoncKxlJra2SfA
   lTiP4p8hKosTNuFd7EMm9wBZFwbfvPrwX1KEOq/kD4oS0STLF2n5h8rjg
   Q==;
X-CSE-ConnectionGUID: tlpD/T2PTomk9yrY+xyidQ==
X-CSE-MsgGUID: 3QLShdv2TU2x/XdTjjaD7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="100099936"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="100099936"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 05:55:30 -0700
X-CSE-ConnectionGUID: e5CI7kEYTRGeapYb6Y21NA==
X-CSE-MsgGUID: ARJQiCOHTfC/50iF0RwawQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="272980107"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 05:55:28 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8584799; Mon, 31 Aug 2026 14:55:26 +0200 (CEST)
Date: Mon, 31 Aug 2026 14:55:26 +0200
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
Message-ID: <20260831125526.GJ124825@black.igk.intel.com>
References: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com>
 <DL34V3WU5UY1.3FYYB7UPWYY83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DL34V3WU5UY1.3FYYB7UPWYY83@kernel.org>

Hi,

On Mon, Aug 31, 2026 at 02:37:59PM +0200, Michael Walle wrote:
> Hi,
> 
> On Mon Aug 31, 2026 at 2:05 PM CEST, Tobias Jakobsen via B4 Relay wrote:
> > Patch 2 adds the only user, spi-intel, which already computes protected
> > range state at probe but has had no way to expose it since the SPI MEM
> > conversion removed its visibility of the MTD device.
> 
> Where was it removed, though?

After the SPI MEM conversion the driver is a regular SPI driver so it can
only use spi_new_device() to add and configure the SPI-NOR chip (via
platform data, struct flash_platform_data). Prior this it was creating the
MTD device itself.
