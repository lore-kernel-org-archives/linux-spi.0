Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A1C49EA7
	for <linux-spi@archiver.kernel.org>; Mon, 28 Jun 2021 07:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F261E61C2F
	for <linux-spi@archiver.kernel.org>; Mon, 28 Jun 2021 07:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhF1HIM (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:08:12 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:41531 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhF1HIL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Jun 2021 03:08:11 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 88652280161A7;
        Mon, 28 Jun 2021 09:05:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7C03138D650; Mon, 28 Jun 2021 09:05:42 +0200 (CEST)
Date:   Mon, 28 Jun 2021 09:05:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "William A . Kennington III" <wak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: <linux/spi/spi.h>: add missing struct kernel-doc
 entry
Message-ID: <20210628070542.GA5771@wunner.de>
References: <20210628004023.7371-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628004023.7371-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Jun 27, 2021 at 05:40:23PM -0700, Randy Dunlap wrote:
> --- linux-next-20210625.orig/include/linux/spi/spi.h
> +++ linux-next-20210625/include/linux/spi/spi.h
> @@ -339,6 +339,7 @@ extern struct spi_device *spi_new_ancill
>   * @max_speed_hz: Highest supported transfer speed
>   * @flags: other constraints relevant to this driver
>   * @slave: indicates that this is an SPI slave controller
> + * @devm_allocated: flag indicating this is a non-devres managed controller

Actually the flag indicates that the *allocation* of the controller *is*
devres-managed, so instead of the above I'd suggest something along the
lines of:

 * @devm_allocated: whether allocation of this struct is devres-managed

Thanks,

Lukas
