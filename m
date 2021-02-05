Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C74C433DB
	for <linux-spi@archiver.kernel.org>; Fri,  5 Feb 2021 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AA964E07
	for <linux-spi@archiver.kernel.org>; Fri,  5 Feb 2021 09:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBEJq6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:46:58 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:34189 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBEJpE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 04:45:04 -0500
Received: from xps13 (aputeaux-654-1-105-144.w90-2.abo.wanadoo.fr [90.2.4.144])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E0A29100003;
        Fri,  5 Feb 2021 09:44:17 +0000 (UTC)
Date:   Fri, 5 Feb 2021 10:44:13 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhengxunli@mxic.com.tw>
Subject: Re: [PATCH 1/2] spi: spi-mem: add spi_mem_dtr_supports_op()
Message-ID: <20210205104413.5e873c0e@xps13>
In-Reply-To: <20210204141218.32229-1-p.yadav@ti.com>
References: <20210204141218.32229-1-p.yadav@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

Pratyush Yadav <p.yadav@ti.com> wrote on Thu, 4 Feb 2021 19:42:17 +0530:

> spi_mem_default_supports_op() rejects DTR ops by default to ensure that
> the controller drivers that haven't been updated with DTR support
> continue to reject them. It also makes sure that controllers that don't
> support DTR mode at all (which is most of them at the moment) also
> reject them.
> 
> This means that controller drivers that want to support DTR mode can't
> use spi_mem_default_supports_op(). Driver authors have to roll their own
> supports_op() function and mimic the buswidth checks. See
> spi-cadence-quadspi.c for example. Or even worse, driver authors might
> skip it completely or get it wrong.
> 
> Add spi_mem_dtr_supports_op(). It provides a basic sanity check for DTR
> ops and performs the buswidth requirement check. Move the logic for
> checking buswidth in spi_mem_default_supports_op() to a separate
> function so the logic is not repeated twice.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

I am not a SPI-NOR expert but for what I know this approach looks good
to me. Let's see what other maintainers think.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
