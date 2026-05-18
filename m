Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692038655E;
	Mon, 18 May 2026 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079713; cv=none; b=sGT9jxQzNAuYnqBa2IO+MyYt5EvOQVf3JgdgK5xvmsenIdnKyA3miJeie9auhbcApkCuxyd2kGHIvC08BfHhb0uXidPe70wh6Gn7K+wOI6+aehhC1YBhBd0FNyOT62JZhJpTvb+EDkzzD568VVtyqjLeq4c3B5gzYBikJCpHWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079713; c=relaxed/simple;
	bh=rQIGvqhN0cRN44cMOmw13oWvVCFCMbrmr4Tvh2OChno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaGiTGACrYHjBc2E3gJMVgxP3qnN+BKcE04pMOQt0W3G9Lgdqcub0dIge26bqqefEUdyU7AStM1YNrE1Qc8g63+Tz7mCx1509RhiJFyE1IU7/wTo0wURqh/JIh0i8XEYQ47OffAOI8WXlQP328+888j4KLhtURLMk3+IUg1GBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itQkydhg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itQkydhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779079712; x=1810615712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQIGvqhN0cRN44cMOmw13oWvVCFCMbrmr4Tvh2OChno=;
  b=itQkydhgQBivvez8fHbfCwOxujr/YufVr9gNUP9xL6ZSjT6fkbPQR+NZ
   E7+EuUYEKNK7br1s3PlB7kB0YOEgmthTJ9chSc0muOHn2KxTtK5AAPs1p
   JazuhuIVHVSnBm6aFxKXLBTGoz6PNcE52Ov+NG6zZgJldFhXhM4rBBcGh
   ANM90DkH8qlhouGJYXuO396NRsev/sQmrJxr2Vnh2ljVdEvfAoywAoCCE
   IM4QxyNfE06nBRpVKBQiBZlg0tEJyE1nBx5H+Tpwi9BvadPECBu/PcjTR
   Y+5EUA/RJ56G+cj4gMnBJkv3HBq0uGt8zgNIkWOhafK+XG7xT/s9aj+je
   g==;
X-CSE-ConnectionGUID: EoKnJ84XQmuIg0mc3N13GQ==
X-CSE-MsgGUID: M493eJ3BTvGV72vj7oAqTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79896000"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79896000"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 21:48:31 -0700
X-CSE-ConnectionGUID: PBzfC4pdRYmutYXn6ZH9XA==
X-CSE-MsgGUID: gJgtL4uASjeSFufY/mk9/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="236282800"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 17 May 2026 21:48:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8E09995; Mon, 18 May 2026 06:48:25 +0200 (CEST)
Date: Mon, 18 May 2026 06:48:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Thomas Lin <thomas_lin@lecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, hoan@os.amperecomputing.com,
	linusw@kernel.org, brgl@kernel.org,
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com,
	andi.shyti@kernel.org, broonie@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org, lucas_hao@lecomputing.com,
	puntar_liu@lecomputing.com, jihua_tao@lecomputing.com,
	stan_xu@lecomputing.com, lumin_liu@lecomputing.com,
	notics_zhang@lecomputing.com, braden_zhang@lecomputing.com,
	harold_wu@lecomputing.com, will_zhang@lecomputing.com,
	aurora_jiang@lecomputing.com, ryen_lin@lecomputing.com,
	andy_jiang@lecomputing.com
Subject: Re: [PATCH v3 3/3] i2c: designware: Add ACPI ID LECA0003 for LECARC
 SoCs
Message-ID: <20260518044825.GM84797@black.igk.intel.com>
References: <20260514034319.3507315-1-thomas_lin@lecomputing.com>
 <20260518024937.453714-1-thomas_lin@lecomputing.com>
 <20260518024937.453714-4-thomas_lin@lecomputing.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518024937.453714-4-thomas_lin@lecomputing.com>

On Mon, May 18, 2026 at 10:49:36AM +0800, Thomas Lin wrote:
> Add ACPI ID "LECA0003" for LECARC SoCs that integrate
> the DesignWare I2C controller.
> Also add corresponding ACPI description in acpi_apd.c.
> 
> Signed-off-by: Thomas Lin <thomas_lin@lecomputing.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
