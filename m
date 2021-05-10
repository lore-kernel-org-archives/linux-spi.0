Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B19AC433ED
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 09:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D2D61433
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 09:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEJJYA (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 10 May 2021 05:24:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55434 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJJX7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 05:23:59 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 189581F42076;
        Mon, 10 May 2021 10:22:54 +0100 (BST)
Date:   Mon, 10 May 2021 11:22:49 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v2 1/3] spi: spi-mem: add automatic poll status
 functions
Message-ID: <20210510112249.5613978e@collabora.com>
In-Reply-To: <542000b4-1a65-5090-72f9-441c75ee1098@foss.st.com>
References: <20210507131756.17028-1-patrice.chotard@foss.st.com>
        <20210507131756.17028-2-patrice.chotard@foss.st.com>
        <20210508095506.4d0d628a@collabora.com>
        <542000b4-1a65-5090-72f9-441c75ee1098@foss.st.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 10 May 2021 10:46:48 +0200
Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:

> >   
> >> +
> >> +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
> >> +		ret = spi_mem_access_start(mem);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		reinit_completion(&ctlr->xfer_completion);
> >> +
> >> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match,
> >> +						 timeout_ms);
> >> +
> >> +		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> >> +						 msecs_to_jiffies(timeout_ms));  
> > 
> > Why do you need to wait here? I'd expect the poll_status to take care
> > of this wait.  
> 
> It was a request from Mark Brown [1]. The idea is to implement
> similar mechanism already used in SPI framework.

Well, you have to choose, either you pass a timeout to ->poll_status()
and let the driver wait for the status change (and return -ETIMEDOUT if
it didn't happen in time), or you do it here and the driver only has to
signal the core completion object. I think it's preferable to let the
driver handle the timeout though, because you don't know how the
status check will be implemented, and it's not like the
reinit_completion()+wait_for_completion_timeout() done here would
greatly simplify the drivers wait logic anyway.
