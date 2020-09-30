Return-Path: <SRS0=/X/+=DH=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21079C4727C
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 15:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C725D207C3
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 15:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgI3PDT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:03:19 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40940 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3PDR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 11:03:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C565D803086A;
        Wed, 30 Sep 2020 15:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nMbdrwTON2px; Wed, 30 Sep 2020 18:03:13 +0300 (MSK)
Date:   Wed, 30 Sep 2020 18:03:12 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/30] spi: dw: Add DWC SSI capability
Message-ID: <20200930150312.ipt724uihixblr3a@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-12-Sergey.Semin@baikalelectronics.ru>
 <20200929135233.GG4799@sirena.org.uk>
 <20200929221737.fiwjr4y3vhme4546@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929221737.fiwjr4y3vhme4546@mobilestation>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mark,
A concrete question is below of my previous comment.

On Wed, Sep 30, 2020 at 01:17:37AM +0300, Serge Semin wrote:
> On Tue, Sep 29, 2020 at 02:52:33PM +0100, Mark Brown wrote:
> > On Sun, Sep 20, 2020 at 02:28:55PM +0300, Serge Semin wrote:
> > 
> > > -	/*
> > > -	 * SPI mode (SCPOL|SCPH)
> > > -	 * CTRLR0[ 8] Serial Clock Phase
> > > -	 * CTRLR0[ 9] Serial Clock Polarity
> > > -	 */
> > > -	cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
> > > -	cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;
> > 
> 
> > > +		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
> > > +		cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
> > > +		cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DWC_SSI_CTRLR0_SCPH_OFFSET;
> > 
> > The new code seems less well commented than the old code here.
> 
> You are right. The comments are omitted. The thing is that they are absolutely
> redundant here, for the same reason they haven't been added to the standard
> update_cr0() method. Both the DWC SSI-capable and standard DW APB SSI-specific
> part of the code do the same thing: setup the CTRLR0 fields, which are described
> by the macro definitions. So there is no need to duplicate that information in
> the comments, moreover seeing it can be inferred from the code.
> 
> -Sergey

My response to your comment was that those in-code comments have been absolutely
redundant. So I just removed them, since I was touching that part of the driver
anyway. If you are agree with me having that done here, then please, accept the
patch the way it is. If you disagree, or have any other though, please give me
your answer, why.

-Sergey
