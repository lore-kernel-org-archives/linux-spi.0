Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8CD3446CA;
	Thu, 26 Mar 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517757; cv=none; b=bS/pPAPx0X18zTGUY95nMqUvtAqg483IOsLDJQWf25xFq601dfaIdp1myXFqDUCDZljMC4ZV69w+cvAflDvFPOcv2o9PMpUdk1sigEUupgS1Xg0w3yLD9aVwJ8s9wifNl+Rzcq/1UKouZAyQhLnaLg3SdphR8ErN82zOqfb8Z7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517757; c=relaxed/simple;
	bh=AjqCvtb1rCf7v36P4Wjo7/tWvVH6j2pWo6Qh6B5tGFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPBs1RNZI4CSKu2SjSYYLL4xUj+cCmRXIwl3ryO02NLSBPZsy6tL72bPWTWcVe1U4C9okypmYG+5dZxw8wSwQdu+JHoXqiTSBSwJFPtbTuHzs4Sc5llYB6Xx/jwqlZidDu5dwYzp+CagbFbEZERliQC6W1OeSLkLC6k6OuyEhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmYueqHk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmYueqHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774517756; x=1806053756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AjqCvtb1rCf7v36P4Wjo7/tWvVH6j2pWo6Qh6B5tGFU=;
  b=fmYueqHk1LA7dDmiPyUZoh6wFRQLS7VdSC3UDf2j6eAM/EC3AnuYyuIq
   nWFNnh1BJ7RaPPjmpBBd3u38rc/ZUsEDcgKRPZ9OP1Gnk0c+03KTIIikf
   BwpXYcvbZ3Zg08TVSgGbzLSnyIlwcgkbWyHP3SqlCHyt6q9Qld5Eefbof
   Eve7UDwOs6+AYBr++heC+K1nc2egV0se+nQ8yamMSN04IryPz0+ZjM+dD
   jAaCka/T9UjfxWaonKqQG4uiDCSG1t5//gTA+OqjnfXIM46oYOzo8osHL
   8IPInGaaNvkdiA2GNKGyPq8tnltts7Tq2g1dQPuz0lVjzRdE2YyzJ3YKw
   Q==;
X-CSE-ConnectionGUID: 9ankxL3mQUuSv/knaLEBmA==
X-CSE-MsgGUID: 9AVsmMjgQquc8mcNv+lU1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="78166111"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="78166111"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:35:56 -0700
X-CSE-ConnectionGUID: GLe+KSppSVm5Mmxtm0GNPw==
X-CSE-MsgGUID: Wv/w0BZCQrqIvmeWeQt1Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="229721258"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:35:54 -0700
Date: Thu, 26 Mar 2026 11:35:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: fix use-after-free on managed registration failure
Message-ID: <acT9-MoL5zfss8Hp@ashevche-desk.local>
References: <20260325145319.1132072-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325145319.1132072-1-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 03:53:19PM +0100, Johan Hovold wrote:
> The SPI API is asymmetric and the controller is freed as part of
> deregistration (unless it has been allocated using
> devm_spi_alloc_host/target()).
> 
> A recent change converting the managed registration function to use
> devm_add_action_or_reset() inadvertently introduced a (mostly
> theoretical) regression where a non-devres managed controller could be
> freed as part of failed registration. This in turn would lead to
> use-after-free in controller driver error paths.
> 
> Fix this by taking another reference before calling
> devm_add_action_or_reset() and not releasing it on errors for
> non-devres allocated controllers.
> 
> An alternative would be a partial revert of the offending commit, but
> it is better to handle this explicitly until the API has been fixed
> (e.g. see 5e844cc37a5c ("spi: Introduce device-managed SPI controller
> allocation")).

Thank you!
This is good TODO list now.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


