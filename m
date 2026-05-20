Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2EA23BCE3;
	Wed, 20 May 2026 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283750; cv=none; b=YmEdFcmj1fjLBD2A6xDHbsPsnMH7M7Gunt2ZiF2tLvcW46S9zlyodDj+42PHaZqtDiEUExWSdlSuIra45LpzE9W7JHtUEg/6UzQIHftdMIpHVqjbVnSqhVivtSNeS92hSTlN/KhNDm3Z/aOe2ZR3N6hNsfO86I42Bwymh0psoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283750; c=relaxed/simple;
	bh=iN5qSeTMg0N85U/XyWdu8GYTuA7U/tfdbqZzD/0w6gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7uSEmnSjg+O7oZue3T/ieZUx3ZCKmnuPi2QHyBGyRdM3UA3s2JHukLv5JLViS7+qmaHyHc6pba3EvgIxBep5vXGgQtK/t99CniHbbACPKLA2b5kyX7z4JDR5iOUsaToxX7kKbrHF2nSuRv6PUKJHMiTZh49E/DEvNU8X13JK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9Wj2oy8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9Wj2oy8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779283748; x=1810819748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iN5qSeTMg0N85U/XyWdu8GYTuA7U/tfdbqZzD/0w6gk=;
  b=B9Wj2oy8yAVwM6WvFmo7MIRFrtr7un3Yod5R5C6WeebnXEG+SodG/vWQ
   5+H14F0jSaMFBVCf3rffClzJU5RHm7YCkRRO4TbIPylpgOt0aNKS+6ROT
   ZSU2DfXDPb5qukSDvFHThZ2tyAcmJT3m5uq03JyHFh2XOQ5QFXYIUre7x
   HH78lt/IqXzFBWnmRzICGkSa81Zx3OCmfPfajXy5npG0n3y9G6m/FOCiP
   OrHjgqW6kjhBJwxQ2mKZbR0FfeLwkMCXyyGmOlm6ZpwK7eCZhihUlBQvZ
   vAVfDIjsN+RM8FSGh5h7LQUOL4fCxBoLcKmSF3Ag8jLLoOzecXAn1y5U2
   A==;
X-CSE-ConnectionGUID: LLWsD8pgRlmqxGtfkR6/fw==
X-CSE-MsgGUID: EixtNfYLSyiHaSw9IUTYIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80299602"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80299602"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:29:07 -0700
X-CSE-ConnectionGUID: VpIdgBobSkCG8LlaxTCMwA==
X-CSE-MsgGUID: AX7W7Z3NROS6yu1epC18Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="245178834"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.205])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:29:04 -0700
Date: Wed, 20 May 2026 16:29:01 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Mark Brown <broonie@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
Message-ID: <ag23HbvCqhmK0Ph1@intel.com>
References: <20260519102446.209723-1-peter@pcc.me.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519102446.209723-1-peter@pcc.me.uk>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Tue, May 19, 2026 at 03:24:46AM -0700, Peter Collingbourne wrote:
> A short polling delay, such as the delay of 5us
> (SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
> can become a 1/HZ (order of ms) delay caused by the usleep_range()
> call in read_poll_timeout(), significantly reducing SPI NAND access
> performance. Fix it by adjusting the read_poll_timeout() macro to use
> udelay() to delay until 1/10 of a timer tick after it is called, and
> only then sleep.
> 
> Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functions")
> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> ---
>  include/linux/iopoll.h | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> v2:
> * Fix it in read_poll_timeout() instead
> 
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 53edd69acb9b..2ee89b76f072 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -19,9 +19,11 @@
>   *
>   * @op: Operation
>   * @cond: Break condition
> - * @sleep_us: Maximum time to sleep between operations in us (0 tight-loops).
> - *            Please read usleep_range() function description for details and
> - *            limitations.
> + * @sleep_us: Maximum time to sleep or delay between operations in us
> + *            (0 tight-loops). Please read usleep_range() and udelay()
> + *            function descriptions for details and limitations.
> + *            This macro will delay until 1/10 of a timer tick after
> + *            it is called, and will then start sleeping.
>   * @timeout_us: Timeout in us, 0 means never timeout
>   * @sleep_before_op: if it is true, sleep @sleep_us before operation.
>   *
> @@ -35,11 +37,18 @@
>  ({ \
>  	u64 __timeout_us = (timeout_us); \
>  	unsigned long __sleep_us = (sleep_us); \
> -	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
> +	ktime_t __start_time = ktime_get(); \
> +	u64 __delay_timeout_us = 100000/HZ; \
> +	ktime_t __delay_timeout = ktime_add_us(__start_time, __delay_timeout_us); \
> +	ktime_t __timeout = ktime_add_us(__start_time, __timeout_us); \
>  	int ___ret; \
>  	might_sleep_if((__sleep_us) != 0); \
> -	if ((sleep_before_op) && __sleep_us) \
> -		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +	if ((sleep_before_op) && __sleep_us) { \
> +		if (__sleep_us <= __delay_timeout_us) \
> +			udelay(__sleep_us); \

If you want udelay() why not just use the atomic variant of the macro?

> +		else \
> +			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +	} \
>  	for (;;) { \
>  		bool __expired = __timeout_us && \
>  			ktime_compare(ktime_get(), __timeout) > 0; \
> @@ -54,8 +63,13 @@
>  			___ret = -ETIMEDOUT; \
>  			break; \
>  		} \
> -		if (__sleep_us) \
> -			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +		if (__sleep_us) { \
> +			if (__sleep_us <= __delay_timeout_us && \
> +			    ktime_compare(ktime_get(), __delay_timeout) < 0) \
> +				udelay(__sleep_us); \
> +			else \
> +				usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +		} \
>  		cpu_relax(); \
>  	} \
>  	___ret; \
> -- 
> 2.54.0

-- 
Ville Syrjälä
Intel
