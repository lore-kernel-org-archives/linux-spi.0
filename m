Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21228C433F5
	for <linux-spi@archiver.kernel.org>; Thu, 24 Mar 2022 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbiCXJ0g (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 24 Mar 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCXJ0f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Mar 2022 05:26:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC76D4FD;
        Thu, 24 Mar 2022 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648113904; x=1679649904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6xswe2NDduqgra8KW8XqaVdTAYDUAbdLTGvm1CKnFGw=;
  b=GIhyhnXecC2QrlDWTI89tbKgRE5XjigDmn2mSs6SS6AeODGk3agRRVRl
   AuMHlkQNrdWd097EZsb0FR5zuWPYE5ZgtOZJCImYn3dDLBEr+OnS3cokd
   BXA2j6FZsJkf46QiJjlydNiFGHHWPowW5hSoBNiQikXWBcr4PHCwqjZeq
   CJHH8gAzUK+7vApsHUHHk9VXe6SjArCdzjxtsQXwJHfCYSiwc/og1iSoh
   51zD7M0iUnIJ90Wp8YDb8UZs4zlz6zFPe2cEdYiXc0rJWPKdxqAolYLl+
   12b/eQrl/OjTRURnbMrSr7/ljoqwUF5I9NjybPL1m4jPKgCromkQaS7KW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="283185382"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="283185382"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:25:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="519709826"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:25:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXJhi-005imM-Q3;
        Thu, 24 Mar 2022 11:24:26 +0200
Date:   Thu, 24 Mar 2022 11:24:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <Yjw4yjgordnSo+7M@smile.fi.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <YjtNJe4Pgp3WIwOa@sirena.org.uk>
 <YjtXbDyCWZxKnf4Y@smile.fi.intel.com>
 <YjtvsYs+x3LRaLVP@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjtvsYs+x3LRaLVP@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 23, 2022 at 07:06:25PM +0000, Mark Brown wrote:
> On Wed, Mar 23, 2022 at 07:22:52PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 23, 2022 at 04:39:01PM +0000, Mark Brown wrote:
> 
> > > There's no *need* but the __ looks suspicious...  what's the upside
> > > here?
> 
> > It's exactly what is written in the commit message
> 
> > __*_bit() are non-atomic
> > *_bit() are atomic
> 
> > Since they are wrapped by mutex, the atomic ones are not needed.
> 
> Yes, it's not needed but what meaningful harm does it do?

There are basically two points:

1) in one driver the additional lock may not be influential, but
   if many drivers will do the same, it will block CPUs for no
   purpose;

2) derived from the above, if one copies'n'pastes the code, esp.
   using spin locks, it may become an unneeded code and performance
   degradation.



-- 
With Best Regards,
Andy Shevchenko


