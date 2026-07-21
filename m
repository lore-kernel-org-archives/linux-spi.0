Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92853783D4;
	Tue, 21 Jul 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665718; cv=none; b=hsuzPfuoWomPRKnsXLg4AetZ9Bl7I5IPiq6GjDrP1Xlp8J2JFK+A28LLfak+OZxLHpxGO+wtVGWad2ZKjznlRSOJNvO59fm0+WRYgL7VTEEsqLpgzlnxVMHsZSChg0bL2qdMFm9dhzSw8DIcD4DEX0A2ZKgKQ2YfNgn5XNr4V/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665718; c=relaxed/simple;
	bh=i41F0VtbH8eej0JjA+9cjDBrSagBe6HmsLGLINWNq1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Som7gw23uEF2pgRn4ExxH8+8GQ+ArebcbT8ekowSAuPV/R1+vJxbuiyG359cIv/vL3vC41fdKsyB0cAGrX+rY+gUWseb1GhYsEPXmvI5blVfAoN27MUd5eRZu5MkzLYWPXLalwRi1ImCMP25LoubHtnmzLmSgnRLeD24wsph/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GU9EuFSc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GU9EuFSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784665716; x=1816201716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i41F0VtbH8eej0JjA+9cjDBrSagBe6HmsLGLINWNq1Y=;
  b=GU9EuFScNc9H4XchZCezxksZ7Y0Qd3O2Asz601MIAiA8EvEQcI0Lk+In
   dGkbVMcUAV292ynLN0Y5T75vaPiICPFGq42/qMLPuvKTYjuV6caL9vRl8
   Q+Niqsxwvt16BbtXS0DioEM2VFOa4NuSCE3KeA76MF4ofwMLdf5nciOSO
   jeU8cCNzV0op+kt4VXV5bgQ9h4LL4Fru7ESeSYvU98yczsB3cyDQwvAcv
   eTg/Even6kkp1+SOp4/ZmsDIT32kMUjN8TSf81QlR6g5UpTXWcGz7z+bH
   xolhoeoZxXeR2sXaoQb9+uBRV1ws2ZmEd5SjtuVAoq95YQ1kvmotzqz8s
   g==;
X-CSE-ConnectionGUID: Joq71UZrRd6Pv4Phhy4pEw==
X-CSE-MsgGUID: nBu6kCEIR6yuC91v6KK7rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85157319"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85157319"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:28:35 -0700
X-CSE-ConnectionGUID: rvQzQn6cTiy66MrPIUEa/A==
X-CSE-MsgGUID: H4YlEInCRuK03bLxzDbNyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="287898383"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 13:28:33 -0700
Date: Tue, 21 Jul 2026 23:28:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Mark Brown <broonie@debian.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <al_WbeyPMvtcmO32@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
 <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
 <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 11:26:27PM +0800, Shih-Yuan Lee (FourDollars) wrote:
> On Tue, Jul 21, 2026 at 11:05 PM Mark Brown <broonie@debian.org> wrote:

...

> Actually, I was just following Lukas's suggestion to modify
> drivers/dma/dw/pci.c to do a quick proof-of-concept test, and I used
> an AI assistant to help me write and deploy the driver quirk code.
> 
> I have previous experience with the Initrd ACPI Table Override
> mechanism, so I can definitely try that on my machine next to see if
> we can get DMA working properly by aligning the PCI routing and DMAR
> mapping correctly).
> output.

For old hardware (before Skylake) LPSS DMA interrupt line is defined in
two places: DSDT (and/or PCI) and CSRT. Changing in one might not help
as CSRT may have something different. Check drivers/dma/acpi-dma.c
acpi_dma_parse_resource_group().

-- 
With Best Regards,
Andy Shevchenko


