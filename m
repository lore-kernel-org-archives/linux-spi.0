Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7246C4A0;
	Fri, 14 Aug 2026 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710441; cv=none; b=Mqu+adNNmd4lwyQ11lurocmUHucsBzEJQnh7h+Nfav5bsF+05DVG864oTuFX73+LUAwqgCs1OA0expb/Wh/jy1D22q9tGAYCKbs7WtH0H/bczVEN6MigFNF2jfMFwbATq1haeyuIfPToO13Atc3IKDqM8IUzQUmv+7indJOn2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710441; c=relaxed/simple;
	bh=cJBeQsBTpEO0q01u4Rvs3Q9nETpXfjnhqjfsPHQH5gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzdtc8Wj3RIkvsKgQ2iIhqO3TfzRReeW86/FxaDWDPrL2yxheyRlGvGklDrwi0pBusrpSDp3C0OjNx8xOcKtr/I+G0vn71pxGkI+TLY8f2yUuXnNxyAMcUwxhc4qHMZWvARbeM5zjBTijiZK02Y+RKCQZ4xbKQgPAs8iTTx5Gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWz00XqC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWz00XqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786710439; x=1818246439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJBeQsBTpEO0q01u4Rvs3Q9nETpXfjnhqjfsPHQH5gU=;
  b=ZWz00XqCiTP9p0e+qA9SZDPoxDq3pGlz2t8NCC+E7f2OQWlw3Ztmke7q
   qsUJPvRVO+j14V8FMwWvOYmjZTtqm+OTQIhyef92Zr2CgIjSC5wM1SAXY
   y8IKxPqggsbe+lB6OJXLgytT9XoRGhIKW+lidKSLAUXKWxbZ36fBTSA0T
   EwZX8ncMYzE1EKHwNWp8ypMJNhX04hzk/zccB3/xtuZ4QxKxJN/TNySP4
   QNJgTuXP4UgPEmn9QqG5uK45/kEKMnw48ysRdJk86lW8SPbbtjhUorhBf
   t5IftL6CjvD5gB+72VdItDi+vYNJmMgm5YIQfCS5vWBmSTmw9t34nmJTb
   g==;
X-CSE-ConnectionGUID: RrVRdQjuSUaQOGYuuxfPnQ==
X-CSE-MsgGUID: WwbmJq2uT2S0mwqBmmQS+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97879274"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97879274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:27:18 -0700
X-CSE-ConnectionGUID: rBIv4H9LTguDKIyolg8kmg==
X-CSE-MsgGUID: 024IXkpHTJ+fr3WZ7Erwzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="287695205"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:27:15 -0700
Date: Fri, 14 Aug 2026 15:27:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Honghui Jiang <jiang_hh2019@163.com>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 4/4] spi: Add KUnit coverage for DMA mapping error
 paths
Message-ID: <an8JaNLIy4je-tiG@ashevche-desk.local>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
 <20260814031419.43378-5-jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814031419.43378-5-jiang_hh2019@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 11:14:18AM +0800, Honghui Jiang wrote:
> Add KUnit tests for the __spi_map_msg() error paths. The tests verify
> that a later TX or RX mapping failure clears the mapping state of
> earlier transfers and leaves cur_{tx,rx}_dma_dev identifying the
> current mapping device.
> 
> A zero-length transfer causes sg_alloc_table() to return -EINVAL,
> providing deterministic failure injection without test hooks.
> Additional cases cover successful map/unmap and a message which
> requires no mapping.
> 
> Build the DMA suite as a separate translation unit, exposing the two
> internal mapping helpers only for KUnit through the local internal
> header. Enable SPI in the default and all-tests KUnit configurations so
> the suite is exercised there.

...

> +++ b/tools/testing/kunit/configs/default.config
> @@ -1,3 +1,4 @@
>  CONFIG_KUNIT=y
>  CONFIG_KUNIT_EXAMPLE_TEST=y
>  CONFIG_KUNIT_ALL_TESTS=y
> +CONFIG_SPI=y

This is a stray change.

-- 
With Best Regards,
Andy Shevchenko


