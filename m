Return-Path: <SRS0=FAtT=AK=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C4EC433E0
	for <linux-spi@archiver.kernel.org>; Mon, 29 Jun 2020 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4203C2065D
	for <linux-spi@archiver.kernel.org>; Mon, 29 Jun 2020 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgF2SzM (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:55:12 -0400
Received: from muru.com ([72.249.23.125]:59956 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbgF2SzK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 32DD08199;
        Mon, 29 Jun 2020 16:28:13 +0000 (UTC)
Date:   Mon, 29 Jun 2020 09:27:18 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        David Lechner <david@lechnology.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Convert to use GPIO descriptors
Message-ID: <20200629162718.GP53169@atomide.com>
References: <20200625231257.280615-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625231257.280615-1-linus.walleij@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [200625 23:13]:
> The OMAP2 MCSPI has some kind of half-baked GPIO CS support:
> it includes code like this:
> 
>   if (gpio_is_valid(spi->cs_gpio)) {
>         ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> 	(...)
> 
> But it doesn't parse the "cs-gpios" attribute in the device
> tree to count the number of GPIOs or pick out the GPIO numbers
> and put these in the SPI master's .cs_gpios property.
> 
> We complete the implementation of supporting CS GPIOs
> from the device tree and switch it over to use the SPI core
> for this.

Acked-by: Tony Lindgren <tony@atomide.com>
