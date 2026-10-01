Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B648595F;
	Thu,  1 Oct 2026 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838812; cv=none; b=qlJNG69tFMEd5/ivx05OT9LboIkOylbPFYssSFpl3s2ZdWhIHp3kdEAhTm8atEnsNebKGhvZH8Il5Ra7WQ4vVkexF/JHuZNOaU/415wZw3JdniTPLRX3etzZR2J2iQOJrm+mArGailup9NQq0FQG1Dul3zkL1v3avPgaalQRRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838812; c=relaxed/simple;
	bh=c9poQFe28/+6rOsU2BL302o2VdsLPOAG4h+Kc9pufzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGcBpFLObxrFnF1RXMJpEvnDUVz4dWK7Z9f7C+7+q9I2EH2JcT+nAPRy6xNcCdKosoDFdeoYkozaYkrqRGxJ6ltFsJvCJGaBsvFwFWbCluDxAtSIiQUlvaDUmBcVbQAyD5p0MgQqjh8bOYK3ZzOLCHvGquyr2DQzWPCkpxWXhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVy/ck2k; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVy/ck2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790838809; x=1822374809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c9poQFe28/+6rOsU2BL302o2VdsLPOAG4h+Kc9pufzk=;
  b=QVy/ck2kOLU2JwLX5olc8EC9CdgmuGPjwOELMNpEEB6xZau7cegmM2Pb
   lSGlcZ4QVO1NjJ5rp60YsXy8cme2Ts92wL4XqaY5TL4H6z+3k9bHXjQGL
   3nYkBd3Upc1NlEMqm50UowFAnH7lII494ZTvPi1NsSqqmyu5qlkzoF6Lx
   fxlgPODIZbXJEBP2U7fWGumoY2vSpKG5HVJt4q0H57rDlSdbZ3fp22R27
   /jOPwLti+1pIIRhV8VfWvtznbxX87eQSD5HAVi6RGlvF37JzYNoWUT6B5
   oTn576HUva6RPztvQVe1ELygY/FymWKCWN+JAhvTCZNxjIDXVWch0iEZC
   g==;
X-CSE-ConnectionGUID: nbNmtYQlQ3K87TKfJtxL4w==
X-CSE-MsgGUID: wX8+cuZtRzaIe+S+n0epzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91605757"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="91605757"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 00:13:24 -0700
X-CSE-ConnectionGUID: vyp43Y8wTKGApRQnopyDig==
X-CSE-MsgGUID: S16I1rjoT8Ga/duDXizAzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="305425762"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 00:13:20 -0700
Date: Thu, 1 Oct 2026 10:13:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v17 2/6] spi: pxa2xx: introduce clock enable and disable
 helper functions
Message-ID: <ar4IDfYyki7H1k5q@ashevche-desk.local>
References: <20260930160629.1822-1-fourdollars@debian.org>
 <20260930160629.1822-3-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930160629.1822-3-fourdollars@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 12:06:25AM +0800, Shih-Yuan Lee wrote:
> The driver enables and disables the SOC clock during probe, teardown,

The correct spelling of this acronym is SoC (System on Chip).

> and power management callbacks. Directly calling clk_disable_unprepare()
> when the clock is already disabled—such as when removing a device that
> is runtime-suspended—causes an unbalanced clock disable warning from the
> Common Clock Framework.
> 
> Introduce pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() helper
> functions that track the clock state with a 'clk_enabled' boolean flag
> protected by a 'clk_lock' mutex in struct driver_data. These helpers
> make clock toggling idempotent: repeated enable or disable invocations
> are safe no-ops serialized by clk_lock.
> 
> Convert probe, remove, suspend, resume, and runtime PM callbacks to use
> these helpers instead of direct clk_prepare_enable() and
> clk_disable_unprepare() calls.
> 
> Pack 'clk_enabled' immediately after 'n_bytes' into the existing
> padding hole in struct driver_data, avoiding additional alignment
> padding.
> 
> Assisted-by: Antigravity:gemini-3.8-flash sparse

Assisted-by: LLM

...

Yeah, as Mark asked this change is quite doubtful. Is this a hallucination of
LLM?

-- 
With Best Regards,
Andy Shevchenko


