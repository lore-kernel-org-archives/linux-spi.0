Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793867;
	b=M5QEYxyqkm9+zzx0bBVWnQRx5n5X9PY57jghmZDCyR4RxDcCgthBVQcUqMX375fOogEl
	 a3nFD1B8EraLOZsqAXUxUyfxKcn0yXIN/v/R6HNEpVTx3uJ7HNOjqKxH3PCdQ5D+Hu2tp
	 pJv9twLB72HivGB+AS82KSC/hYdrqMeG1YSfits+Uhou97mT2HsBk8U3jfFt/gJlNdF+C
	 TA8syf61jScwdaQbMy+dsq0S8JmSCZdqYKfRxfmTY1T54G7HLRFRTYAQjgEcUnm0dAcRJ
	 jGep65MqKRPNnIf0DKWKXrz9Mqc1AutmJYvy/lAk78Dp5hsR6GZEQb8FZ0sPV7md11Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793867;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9yFi/GX6XbGdgj7giI9u2oIGi5Y7HHdeGnRwPsAUHHs=;
	b=yvD8y1inIkFPzt+oaluPn2KMnWQLrNl6/TNPCi17F8o42hV+/kqrk8g8ZvMwRyBLWNQb
	 M0RnQj9+ffBlwD+uJ3X/j2Onv48ZFrQg2C+bSuAkzjT4ga3OoHbcBsRb9MImTaflLf/qN
	 MI4/3aCIM8brHBgbUgBL8tY0i05Os+NYOO5SD7TPWszN++avus5g9eqftGZ5qkQ8/XZHx
	 IXMVb0jZdNC7XzfQ8k0jnuerK4GEm5UTzV1+VfYDS6QENiCYUX//juttZLkVB9HHaz5xn
	 tu9JgwsqQh3JPO0GHbXYvRlvDE/6CZ9FrEZS94HKPpMcFQQ1GOkVD0q4O1ydA9CLfrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JaKjSX6X;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EF606A332;
	Wed,  4 Nov 2026 12:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B5EF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JaKjSX6X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793793867; x=1825329867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODBzuH6RtEnF965vDKPdCAhbR7l9hy9L+HJc3UQCPr0=;
  b=JaKjSX6Xttd612h6p6t7IJ27T1rfMKntrJ6+51vkZ7MKL6OEVR0gQoPY
   rbNS3PQMAiPvPzWlzqTVw9/nX+pVKjlmplaNVIqThyE4on3Qs2zYlEu82
   A62EjNvJ7d/VxCJNeslrKtuWeqB/dHi5G9ZFS736SM0m2BOyA9jyQdZZv
   YFYCMPLbP7fGV8UYkqJcwr2q76HZI3MEcgkR0SPgU22QWm+JYU/y1Ex5x
   tEJA0ZEf+3M/RhEk6XcqWuteOcRvVn+4SA7MwJkr247HgQYcFajPdlMS9
   qEUjp+jyjqiBjnwtrFoCQMUmtQgdAYepSbaNJslDUVQoteiYgfRRMAQ0M
   Q==;
X-CSE-ConnectionGUID: 6WwDbO0HR3+bvxonlGto6Q==
X-CSE-MsgGUID: n1yu0FDXTT2Iwb/k3YW89A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2562537"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2562537"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:04:26 -0800
X-CSE-ConnectionGUID: e5RXcvV8RR2NRUD8xQaZDw==
X-CSE-MsgGUID: aHPluvORSJu7gIQFVL1ESA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7250227"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:04:24 -0800
Date: Wed, 4 Nov 2026 14:04:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: Convert to subsys_platform_driver()
Message-ID: <ausfRVIeQxghbMGE@ashevche-desk.local>
References: <20261104113405.1634275-1-peng.fan@oss.nxp.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104113405.1634275-1-peng.fan@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 07:34:05PM +0800, Peng Fan (OSS) wrote:

> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
> 
> The pxa2xx platform driver is renamed from "driver" to
> "pxa2xx_spi_driver" because subsys_platform_driver() generates
> "<name>_init", which would otherwise conflict with the core
> driver_init() declaration.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # pxa2xx

-- 
With Best Regards,
Andy Shevchenko


