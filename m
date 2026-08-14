Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DD46C4BF;
	Fri, 14 Aug 2026 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710501; cv=none; b=P+ENYEI9FcFL/ekb9xUuzj7KQpB1SE7aPoRbXoR6+HUK7jxOftLl6z5aofLGXOCCDRGgAUluUsOsHgJ2qqOFKxJfsemV7z3VygZkmQHSEb8se/YMNoHj1Xqh8mUi6Uy+YVAr/2wTbwrIysbR6fBjANh66l6dKkjAX5Q2zZis+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710501; c=relaxed/simple;
	bh=zaYwCemc97M12XdlIHJ+Yc80JXgqWzCRgdOwCuqo6sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckBbSwhrRsvOCpDtNBY6Do/s/j94tFpKsKbbGJtbOcDfyfIqKzq96uSXAezKGHUiu/v3LN3Ql7I0iN2raNcPIpSNI1fVw8BfcGW4KEe+NwD2b6BwxSE1ZjGJPs1eFhx1Htujd25pSmSFTzJD72V1NlZSnyhtTnDTLX/DZSqc3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvOnmCma; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvOnmCma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786710501; x=1818246501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zaYwCemc97M12XdlIHJ+Yc80JXgqWzCRgdOwCuqo6sM=;
  b=XvOnmCmadg8IpwwRvxcTUlvCriEEVjfaQFvxgqg60+LgBDadH2pYTbCN
   82zPfuzSsTHonCkh7Ivsw5JBcIvqPa3Ag3Mp+MvtWD4hE1P6HxU9+NFcX
   1onKnD+1lxZQgDdTq4u5u1+y2/3UAL8hqpptcs6mqC/z8oJa0oKt8T9Lo
   9WCdcsCM7EhxFKjTV6zHUPnxW94bHz2xlX18wjjw0vYuPpN9XFTxj02yr
   /h27QkwL/wWjTfoJjgnvqX3D8XBQyCnfLzhBpw0C4w8bij0ehEGjFNp9Q
   oxzOWqLkyzhz9gSUft+1SA/sFX02l9C9rDDxB0mKC80mfzAcqK62tgmdw
   w==;
X-CSE-ConnectionGUID: BgvCAuJhQ4m8xAC9oWo1Yw==
X-CSE-MsgGUID: kuBy/1IURwWFKtrUfDpueg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87050919"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87050919"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:28:20 -0700
X-CSE-ConnectionGUID: WH6pY3rVTkyxAUTHqSoA1A==
X-CSE-MsgGUID: CZtnnpFiR26W6hAqIJSoOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260942097"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:28:17 -0700
Date: Fri, 14 Aug 2026 15:28:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Honghui Jiang <jiang_hh2019@163.com>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 0/4] spi: Fix DMA mapping ownership on partial map
 failure
Message-ID: <an8J33wZ102xcOro@ashevche-desk.local>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814031419.43378-1-jiang_hh2019@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 11:14:14AM +0800, Honghui Jiang wrote:
> A partial DMA mapping failure can leave per-transfer mapping flags set
> while cur_{tx,rx}_dma_dev are NULL or still refer to the devices used
> for an earlier message. The subsequent cleanup may then unmap a
> transfer with a NULL or stale device.
> 
> Before commit e289df82344f ("spi: Rework per message DMA mapped flag to
> be per transfer"), partial-failure handling was already incomplete, but
> __spi_unmap_msg() was gated by cur_msg_mapped, which was set only after
> the whole message mapped successfully. Earlier mappings could leak, but
> cleanup could not unmap them with an unpublished device. The
> per-transfer conversion removed that gate: mapping flags can now remain
> set while cur_{tx,rx}_dma_dev are still unpublished, turning the leak
> into a NULL- or stale-device unmap regression.
> 
> Patch 1 publishes the mapping devices before the loop and unwinds every
> failure through __spi_unmap_msg(). It keeps the forward declaration so
> it is independently buildable and straightforward to backport. Patch 2
> then removes the declaration by moving __spi_unmap_msg() above
> __spi_map_msg(). Patch 3 clears the current DMA device pointers once the
> message has been unmapped, while leaving them intact during partial-map
> unwind and DMA-to-PIO fallback. Patch 4 adds the DMA mapping KUnit suite
> as a separate translation unit.
> 
> Only patch 1 is a stable candidate; patches 2 through 4 are follow-up
> cleanup and test changes for mainline.
> 
> Testing:
> 
> - Patch 1 builds independently with the x86_64 reproducer configuration.
> - The spi_dma KUnit suite passes all four cases on x86_64 and UML.
>   Moving the DMA device assignments back after the mapping loop makes
>   both failure-path cases fail.
> - The default and all-tests KUnit configurations both select the suite.
> - All four reproducer cases complete without an oops when run as the
>   first message, and map/unmap counts are balanced after a successful
>   first message.
> - After message cleanup, cur_{tx,rx}_dma_dev are NULL.

Nice series!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
with a caveat that there is one stray change in the last patch.
Assumed that in v3 it will be dropped.

-- 
With Best Regards,
Andy Shevchenko


