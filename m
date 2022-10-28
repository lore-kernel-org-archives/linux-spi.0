Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683ACC38A02
	for <linux-spi@archiver.kernel.org>; Fri, 28 Oct 2022 07:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJ1Hx5 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 28 Oct 2022 03:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJ1Hxv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 03:53:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFFE1BFBA6
        for <linux-spi@vger.kernel.org>; Fri, 28 Oct 2022 00:53:50 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MzF80626pz67HLW;
        Fri, 28 Oct 2022 15:50:08 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 09:53:48 +0200
Received: from [10.48.144.136] (10.48.144.136) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 08:53:47 +0100
Message-ID: <fc70c4d9-1a48-0642-35c5-d9fd522ca208@huawei.com>
Date:   Fri, 28 Oct 2022 08:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon SFC Driver maintainer
To:     Jay Fang <f.fangjian@huawei.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>,
        <prime.zeng@hisilicon.com>
References: <20221028023739.4113998-1-f.fangjian@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221028023739.4113998-1-f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.144.136]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/10/2022 03:37, Jay Fang wrote:
> Add Jay Fang as the maintainer of the HiSilicon SFC Driver, replacing
> John Garry.
> 
> Signed-off-by: Jay Fang<f.fangjian@huawei.com>

thanks,

Acked-by: John Garry <john.garry@huawei.com>
