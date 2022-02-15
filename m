Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB69FC433EF
	for <linux-spi@archiver.kernel.org>; Tue, 15 Feb 2022 14:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbiBOO5r (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:57:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiBOO5n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Feb 2022 09:57:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14D21BE;
        Tue, 15 Feb 2022 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644937053; x=1676473053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLv+uJ8dQfa1J7XDE+qzodTlFt0zYhUwkV8f4XbLUbc=;
  b=bmYHhRMW3KlSzukYN+Pj6+LL7PHiwtrzK/grhNtx3dWusTyZNYr3HnfX
   NfSUqDKCn8c12v/Bh1RpYGaQVdUrXRHqw0KcpHh2bBtrriF4Ckz976Tfc
   dxPDocZIu1IU1aCnaykG5mLVZhDW+MAsBLaAAEky7Ig/DEs5uIe3yratd
   Nvd/OcTHGt24oiKwTbKb6dqi56zE3lS98xdSnVu3ffPcrWL4WhSYyEl8A
   FfQxPBLRyYZgbklZQgQtYuII5q9LH3Jrht2WU+i9gGk4mvkmx9E4Qh55w
   IeWcKxhdeVxbTjqmH7N/QYVpekapZMTd4UhC636j4D9zRFirVAOxmnJxM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313641081"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313641081"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:57:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="570859624"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:57:30 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 15 Feb 2022 16:57:28 +0200
Date:   Tue, 15 Feb 2022 16:57:28 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] spi: intel-pci: Add support for Intel Ice Lake-N
 SPI serial flash
Message-ID: <Ygu/WNwGfc8JVgO7@lahna>
References: <20220215135139.4328-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215135139.4328-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 15, 2022 at 03:51:39PM +0200, Andy Shevchenko wrote:
> Intel Ice Lake-N has the same SPI serial flash controller as Ice Lake-LP.
> Add Ice Lake-N PCI ID to the driver list of supported devices.
> 
> The device can be found on MacBookPro16,2 [1].
> 
> [1]: https://linux-hardware.org/?probe=f1c5cf0c43
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
