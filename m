Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385EC433B4
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25DD61288
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhEJNcD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 10 May 2021 09:32:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:62648 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348133AbhEJMkQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 08:40:16 -0400
IronPort-SDR: /F+7haN7w14ep2tcd6GrwJ4ObO1r0XvmEHJuEQAt/Lm6cPAwEdvcvnPsdsodpdr5MERlIlWhYR
 JwvLzMI3BvLA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="186630435"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="186630435"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:39:11 -0700
IronPort-SDR: qr+vKfhFFOxuAriRn/h1VWiMb0tXm1Qu5IZa5twkTj1uqIaFfwLl8EDw5CS3NBEwX2Poquub4Y
 Pgla+J4ZgJjA==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="470782756"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:39:00 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lg5BY-00BAPk-PH; Mon, 10 May 2021 15:38:56 +0300
Date:   Mon, 10 May 2021 15:38:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2 07/14] spi: pxa2xx: Introduce int_stop_and_reset()
 helper
Message-ID: <YJkpYDfoUg04UEMy@smile.fi.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
 <20210510120953.GA15173@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510120953.GA15173@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 10, 2021 at 01:09:53PM +0100, Mark Brown wrote:
> On Fri, Apr 23, 2021 at 09:24:34PM +0300, Andy Shevchenko wrote:
> > Currently we have three times the same few lines repeated in the code.
> > Deduplicate them by newly introduced int_stop_and_reset() helper.
> 
> This doesn't apply against current code, please check and resend.

Hmm...

Can you, please, point out, what branch should I use?
It seems good against v5.13-rc1 and spi/for-5.14.

Okay, I will resend against spi/for-5.14, but I don't see the issue here.


-- 
With Best Regards,
Andy Shevchenko


