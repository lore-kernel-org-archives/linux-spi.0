Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948BC47082
	for <linux-spi@archiver.kernel.org>; Wed, 26 May 2021 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDC9613D7
	for <linux-spi@archiver.kernel.org>; Wed, 26 May 2021 19:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhEZTcL (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 26 May 2021 15:32:11 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:37669 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhEZTcG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 May 2021 15:32:06 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9005010195553;
        Wed, 26 May 2021 21:30:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5D2BD40898F; Wed, 26 May 2021 21:30:32 +0200 (CEST)
Date:   Wed, 26 May 2021 21:30:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Phil Elwell <phil@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH for-5.14] spi: bcm2835: Allow arbitrary number of slaves
Message-ID: <20210526193032.GA12952@wunner.de>
References: <68febff3649a08d5bd0b5cd913d0f9128a634585.1621703200.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68febff3649a08d5bd0b5cd913d0f9128a634585.1621703200.git.lukas@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 22, 2021 at 09:29:42PM +0200, Lukas Wunner wrote:
> Since commit 571e31fa60b3 ("spi: bcm2835: Cache CS register value for
> ->prepare_message()"), the number of slaves has been limited by a
> compile-time constant.  This was necessitated by statically-sized
> arrays in the driver private data which contain per-slave register
> values.
> 
> As suggested by Mark, move those register values to a per-slave
> controller_state which is allocated on ->setup and freed on ->cleanup.
> The limitation on the number of slaves is thus lifted.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Joe Burmeister <joe.burmeister@devtank.co.uk>
> Cc: Phil Elwell <phil@raspberrypi.com>

This patch needs a rebase on commit c7299fea6769 ("spi: Fix spi device
unregister flow") which has just landed in Linus' tree.

So I'm withdrawing the patch and will send a v2 shortly.

Thanks,

Lukas
