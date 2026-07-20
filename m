Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5222A7F0;
	Mon, 20 Jul 2026 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577405; cv=none; b=SLY3WQDWdEj8MpK+kwDDMVChdvCR1u/SWnm51lS8ERffa6AKtw461K9oznZeWfvI98f6aPX8BHdez23QBfPS6JrRVq0Uc66uUCfsB72emmDpry/svMK3IXl3O3W6I9qlCWtoC7EZduUHNyYc15Mcn53nUoWrqteRuhkLK9lWuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577405; c=relaxed/simple;
	bh=xuBSAIf2BqyIqXPMitrv7lDaxfE+4gesNzdoI735OW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbyUAgIQ2tM6sM1BmVAcekXHCFc8kwTZapOPx2/9+q6P4mkCF7YF91x7p10jhepb+6nyKSg2bSD4Hjz3RVTuhWsrje6QAHfTP17GSbdnPoD+UO37Dw87nv7jafwRHKjFRvHjFAFf8OdaTJdDZ+3/ANWJ7zBhkUBk1nUkIduLExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU/GPmwE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU/GPmwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784577405; x=1816113405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xuBSAIf2BqyIqXPMitrv7lDaxfE+4gesNzdoI735OW0=;
  b=mU/GPmwEhQLBdYtxxdraePyGTwuW7ACjEGUvR/KiyyHQVHJ2BifE5mrN
   XoNKqzkJD2ZpZBHGramKpCLs9Hk1J8UIW7LVznXvboRiHrxPdIZHGlfao
   9bKYTCZeotF4jPBI9DCbBHcWt0t0JVEiCtmfXd3JlDe4VniUyJmzUersK
   ugv6NABW0iOVxWsrJa9E3jsNFIkKbohQN9ws3pIgSj7z9PHNMwym6FnxK
   3iKIhEeIjzPlfWn0vtkQ1c4YgkahaRUQg+ByOmhSnBtDyxcvxpgOF3E7e
   13cL8JmUIgM+xXV3hltE6o/7zTN+Vwab4fgC6JaJMwG6UMfHrNgHN8/8V
   w==;
X-CSE-ConnectionGUID: XPi/z/W6RY+67516lTVyhQ==
X-CSE-MsgGUID: KJCNJvlATpmRVmeT87IWRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89062618"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="89062618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:56:44 -0700
X-CSE-ConnectionGUID: fWcSVIL0QG2H/pMvF8+BQw==
X-CSE-MsgGUID: x2ZAM/duSk+2r3A3i5//Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="262498572"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:56:41 -0700
Date: Mon, 20 Jul 2026 22:56:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 7/7] spi: pxa2xx: rename local status variable to ret
Message-ID: <al59d-zgEV0KCPIp@ashevche-desk.local>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-8-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720162117.32304-8-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 12:21:16AM +0800, Shih-Yuan Lee wrote:
> Rename the return value variable name from 'status' to 'ret' in the
> pxa2xx_spi_probe(), pxa2xx_spi_suspend(), pxa2xx_spi_resume(), and
> pxa2xx_spi_runtime_resume() functions to conform to standard Linux kernel
> coding conventions.

It makes a ping-pong style of changes: Previous patches add more status uses
and moves, and so on. Instead, this patch should go before all that.

-- 
With Best Regards,
Andy Shevchenko


