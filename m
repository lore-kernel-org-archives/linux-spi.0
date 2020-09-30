Return-Path: <SRS0=/X/+=DH=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9088FC4727C
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 15:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483F62076B
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 15:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgI3PIC (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:08:02 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40982 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3PIB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 11:08:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 35906803071C;
        Wed, 30 Sep 2020 15:07:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sVk4b5xaWthO; Wed, 30 Sep 2020 18:07:57 +0300 (MSK)
Date:   Wed, 30 Sep 2020 18:07:57 +0300
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
Subject: Re: [PATCH 02/30] spi: dw: Use ternary op to init set_cs callback
Message-ID: <20200930150757.5uewiwkyey6soey7@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-3-Sergey.Semin@baikalelectronics.ru>
 <20200929131153.GD4799@sirena.org.uk>
 <20200929215553.xgst2v5ssweymlpw@mobilestation>
 <20200930145759.7djm5xijhg6mjtg3@mobilestation>
 <20200930150117.GK4974@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930150117.GK4974@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 30, 2020 at 04:01:17PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 05:57:59PM +0300, Serge Semin wrote:
> > On Wed, Sep 30, 2020 at 12:55:55AM +0300, Serge Semin wrote:
> 
> > > +	if (dws->set_cs)
> > > +		master->set_cs = dws->set_cs;
> > > +	else
> > > +		master->set_cs = dw_spi_set_cs;
> 

> > Judging by having your comment on this patch you obviously didn't like the
> > ternary operator used to assign a default value to the set_cs callback. So I
> > suggested a solution, which may suit you. What do you think about it? Agree,
> > disagree, insist on leaving this part of the code along, etc.
> 
> That looks fine.

Ok. I'll implement it in the next patchset version.

-Sergey
