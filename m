Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0F4C433E0
	for <linux-spi@archiver.kernel.org>; Tue, 30 Mar 2021 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FDF619C5
	for <linux-spi@archiver.kernel.org>; Tue, 30 Mar 2021 12:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhC3Mx5 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 30 Mar 2021 08:53:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15107 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhC3Mxf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:53:35 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8q7z2rryz19GkZ;
        Tue, 30 Mar 2021 20:51:27 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 20:53:23 +0800
Subject: Re: [PATCH v2] spi: davinci: Use of_device_get_match_data() helper
To:     Fabio Estevam <festevam@gmail.com>
CC:     Tian Tao <tiantao6@hisilicon.com>, Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <1617107474-46079-1-git-send-email-tiantao6@hisilicon.com>
 <CAOMZO5A8r8LuV_GOvi3=rdABFgWuC3ho=h2B4FwWB_Y-WCXUTg@mail.gmail.com>
 <37cc380a-4df3-44b9-9d93-903a80617f77@huawei.com>
 <CAOMZO5C8BinwMDPSxL93UAMtXdw0VAFmpngGa6LhTZ3D44_r1Q@mail.gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <b47a2dbe-dd36-5eba-53ec-94822069f8bd@huawei.com>
Date:   Tue, 30 Mar 2021 20:53:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5C8BinwMDPSxL93UAMtXdw0VAFmpngGa6LhTZ3D44_r1Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


在 2021/3/30 20:49, Fabio Estevam 写道:
> On Tue, Mar 30, 2021 at 9:48 AM tiantao (H) <tiantao6@huawei.com> wrote:
>
>> What about doing it like this?
> Yes, this is what I suggested before :-)
> .

thank you，I will send a new patch for this.

can I add Signed-off-by: Fabio Estevam <festevam@gmail.com>


