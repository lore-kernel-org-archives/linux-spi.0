Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF84B0487;
	Tue,  8 Sep 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860928; cv=none; b=e+2OXQLvyMwwyXoFlrR9gvao5eB2L0C6YNMAU1jQUTYaZFXuUrl10J4aExiicJD/0KsQs4bcX8/l8ktvE0bTZDcNtGhrgqm7mqi8UqH97qyRUwYnbund+e/WF+EFeJIj26sifihy3M76ALjRmPMuhfCTYaeZE3ggCUwnlAVuQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860928; c=relaxed/simple;
	bh=si+pQMS2orFm2KYIwbM662sl0NYGSij8sMghKY+BowE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2d0YcNjDp99WZKu8UPfcS/0vBhp5k7o2AU8SNybMX5AnFrhV8gMP6AAOgyRVIuBP+p8ogL295mHGral2XsWFEF6kw3IGKhmSlceaFUslMwC5qNzQIOZsBKnvCag4IMAjAE04Ugxg5z8vdF4Q0NoqT5uurRSFWECGf+zrNGxYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxXJdg+t; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxXJdg+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788860926; x=1820396926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=si+pQMS2orFm2KYIwbM662sl0NYGSij8sMghKY+BowE=;
  b=YxXJdg+tHrNSnnX3X36e74OftG1vSqaaNmLySOqa72qBb91bQaCB5kjQ
   /v8FzW0PHQMy8FTg96scaHxBAtMMJE9238XtUh8PKvoKvacyVG+9Qz9aR
   gWGgDOSqQ7pr5BycSzRGx4cXr8wpV3lLmWzqC1M2/iQApoz7ujllMOwxo
   3uJdav7rc6afxsK2A1UPDIG7KsrKNPAOr/Qo5CpUnEvVn7Dl9aiwjrA3T
   UdsqwzM7y3WTpVRa+9PIWCQKQ/WyUXQ+HMK0nq/LTPe2++629qHeMVllC
   gtzJuYJEFq4hxV5w0/Sq+1UN1qfhgBPUu731ph3Pl3y27ylPBJ0T+mMpa
   w==;
X-CSE-ConnectionGUID: jlN197COSHiuTWDlPg9pDg==
X-CSE-MsgGUID: uHRKhUpFSeyY4JAnK42NSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89301145"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89301145"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:48:45 -0700
X-CSE-ConnectionGUID: yiLn9v7XQR6NiVWkIyNgqw==
X-CSE-MsgGUID: fgg/IIrsQAy1UtuZOE0jPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="272879880"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 08 Sep 2026 02:48:41 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A666B99; Tue, 08 Sep 2026 11:48:39 +0200 (CEST)
Date: Tue, 8 Sep 2026 11:48:39 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: wangjia@ultrarisc.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: i2c: dw: Add compatible for
 UltraRISC DP1000 SoC
Message-ID: <20260908094839.GF106095@black.igk.intel.com>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
 <20260907-ultrarisc-dts-v2-6-5eb4c97477c5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260907-ultrarisc-dts-v2-6-5eb4c97477c5@ultrarisc.com>

On Mon, Sep 07, 2026 at 05:54:45PM +0800, Jia Wang via B4 Relay wrote:
> From: Jia Wang <wangjia@ultrarisc.com>
> 
> The DP1000 integrates four DesignWare APB I2C controllers. I2C1 supports
> SMBus, while I2C0, I2C2, and I2C3 support standard I2C transfers. Each
> controller has one register range and uses separate reference and APB
> interface clocks.
> 
> Add the DP1000-specific compatible string with the generic one as a
> fallback.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
