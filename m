Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFDC433B4
	for <linux-spi@archiver.kernel.org>; Fri,  9 Apr 2021 07:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7F461177
	for <linux-spi@archiver.kernel.org>; Fri,  9 Apr 2021 07:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDIHRX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 9 Apr 2021 03:17:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15993 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhDIHRW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Apr 2021 03:17:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGqC43DFmzvS40;
        Fri,  9 Apr 2021 15:14:56 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 15:17:01 +0800
Subject: Re: [PATCH 2/2] spi: hisi-sfv-v3xx: drop unnecessary ACPI_PTR and
 related ifendif protection
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <john.garry@huawei.com>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
References: <1617881505-51552-1-git-send-email-yangyicong@hisilicon.com>
 <1617881505-51552-3-git-send-email-yangyicong@hisilicon.com>
 <20210408135155.GG4516@sirena.org.uk>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <26fad983-9e06-333c-c1b9-332c6acfddfa@hisilicon.com>
Date:   Fri, 9 Apr 2021 15:17:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210408135155.GG4516@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/4/8 21:51, Mark Brown wrote:
> On Thu, Apr 08, 2021 at 07:31:45PM +0800, Yicong Yang wrote:
>> The ACPI_PTR() and related IS_ENABLED(CONFIG_ACPI) protection is
>> redundant, so drop them.
> 
> The driver supports building without ACPI so are you sure these are
> redundant?
> 

yes. we're not using any acpi function in this driver. What ifdef macro
and ACPI_PTR() protects is struct acpi_device_id, which is defined in
mod_devicetable.h rather than acpi.h. It can be built when ACPI=n.

some similiar cleanups can be found:
6c328c347ac3 ("platform/x86: i2c-multi-instantiate: Drop redundant ACPI_PTR()")
846afc1dbcbf ("iio: accel: bma220: Drop ACPI_PTR() and accompanying ifdeffery")
[...]

Thanks,
Yicong

