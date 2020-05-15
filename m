Return-Path: <SRS0=SRPJ=65=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43BEC433E0
	for <linux-spi@archiver.kernel.org>; Fri, 15 May 2020 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9587F20853
	for <linux-spi@archiver.kernel.org>; Fri, 15 May 2020 16:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgEOQoH (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 15 May 2020 12:44:07 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49149 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgEOQoH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 12:44:07 -0400
X-Greylist: delayed 735 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2020 12:44:06 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3B214100EEFEB;
        Fri, 15 May 2020 18:44:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AC152C8698; Fri, 15 May 2020 18:44:04 +0200 (CEST)
Date:   Fri, 15 May 2020 18:44:04 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] spi: bcm2835: Fix controller unregister order
Message-ID: <20200515164404.bev4zjzcmx4nwzhi@wunner.de>
References: <cover.1589557526.git.lukas@wunner.de>
 <2397dd70cdbe95e0bc4da2b9fca0f31cb94e5aed.1589557526.git.lukas@wunner.de>
 <20200515162903.GH5066@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515162903.GH5066@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 05:29:03PM +0100, Mark Brown wrote:
> On Fri, May 15, 2020 at 05:58:02PM +0200, Lukas Wunner wrote:
> > Fix by using the non-devm variant spi_register_controller().  Note that
> > the struct spi_controller as well as the driver-private data are not
> > freed until after bcm2835_spi_remove() has finished, so accessing them
> > is safe.
> 
> Why not use managed allocations of clocks and DMA channels?  This is a
> standard issue with the devm APIs, if you're using them you basically
> need to use them for *everything* up to the point where you start using
> them.

There is no devm version of clk_prepare_enable(), dma_request_chan()
and various other functions invoked on ->probe() by spi-bcm2835.c.
So tearing down DMA channels, disabling clocks etc needs to happen
in the ->remove() hook and consequently devm_spi_register_controller()
cannot be used.

So I respectfully submit that the patch is fine.

Thanks,

Lukas
