Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FEEC6FD1C
	for <linux-spi@archiver.kernel.org>; Tue, 14 Mar 2023 08:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCNIDv (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 14 Mar 2023 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCNIDt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Mar 2023 04:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA96F199E6;
        Tue, 14 Mar 2023 01:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6569BB818A1;
        Tue, 14 Mar 2023 08:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ECEC433D2;
        Tue, 14 Mar 2023 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678781025;
        bh=HMA4luAOJ/JpqUqTMoMg4ekpqnwd90vDR6GH0nvHhn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2FoqGbcWqIE8LWSD3s+tB4+oR4bv2S/9QBykbMB0He3oekVDLFBKfaZAh9QUPRSx
         v6hQSdzc/LVM8yJ8WWFKlcuq6WvRBSfzTEiUzeN2owwQVtkKb+ODArA48Ue6KmXu/Z
         oaoLvY2t21fdc4FuYlk2zGbf8CJZzuUVcpyxm00s=
Date:   Tue, 14 Mar 2023 09:03:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: docs: adjust summary to CONFIG_SYSFS_DEPRECATED
 removal
Message-ID: <ZBAqXXGnqJmySgkM@kroah.com>
References: <20230314075609.5232-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314075609.5232-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 14, 2023 at 08:56:09AM +0100, Lukas Bulwahn wrote:
> With commit 721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED and
> CONFIG_SYSFS_DEPRECATED_V2"), ./scripts/checkkconfigsymbols.py indicated
> an unresolved reference to the config SYSFS_DEPRECATED in the SPI summary
> documentation.
> 
> Simply, delete the sentence referring to the removed config there. Also
> update the documentation, as these sys/class entries should always be
> symlinks, as the commit message of the commit above suggests.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mark, Greg, Jens, please confirm that these sys/class entries now always
> are symlinks. That is simply my guess after reading a bit on sysfs_deprecated
> also changed compared to the normal setup, but I am not the expert here.

They have been symlinks for years, the only subsystem that the
CONFIG_SYSFS_DEPRECATED logic still modified was for the block
subsystem.  So your change looks good to me, thanks for doing this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

