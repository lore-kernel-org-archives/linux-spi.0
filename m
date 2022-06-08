Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B474C43334
	for <linux-spi@archiver.kernel.org>; Wed,  8 Jun 2022 11:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiFHLcw (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 8 Jun 2022 07:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiFHLcv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jun 2022 07:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D5414E976;
        Wed,  8 Jun 2022 04:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE90B82724;
        Wed,  8 Jun 2022 11:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BACC34116;
        Wed,  8 Jun 2022 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654687967;
        bh=1uftfzM/OH3g6hsphmAGcj+g53TBb2xEn+h7XD8wIXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzW80vMVeferu94vUepvuAucLkezHIfAfxN2yMrfCPBKV8HV2Y3ivQOJ1AREemXht
         04JlnpPqgpdkk3CqUpmmSHXyR07zaydqN9EoxOvhF1oQr1sQTpYtJU9jt3PTh7MHsd
         yMcgpoF9LRKxIcWn3fSA3ltUasCkel/vhPLt9Ge0=
Date:   Wed, 8 Jun 2022 13:32:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Introduce device_find_first_child()
 helper
Message-ID: <YqCI3N6+fRtoK66D@kroah.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 07, 2022 at 11:20:57PM +0300, Andy Shevchenko wrote:
> There are several places in the kernel where this kind of functionality is
> being used. Provide a generic helper for such cases.

This feels really wrong/broken.

There should not be any specific ordering of children in the tree.  What
subsystem relies on this such that they require this?

thanks,

greg k-h
