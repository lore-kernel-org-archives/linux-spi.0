Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAAFC7619A
	for <linux-spi@archiver.kernel.org>; Mon, 27 Mar 2023 06:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjC0Gqd (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Mar 2023 02:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjC0Gqc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 02:46:32 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E949D6;
        Sun, 26 Mar 2023 23:46:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vej261H_1679899585;
Received: from 30.97.48.73(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vej261H_1679899585)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 14:46:26 +0800
Message-ID: <c97461f6-8139-cdf0-b65e-d796fc0f3c29@linux.alibaba.com>
Date:   Mon, 27 Mar 2023 14:46:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 2/2] spi: sprd: Use
 devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>, broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
 <20230327060516.93509-2-yang.lee@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230327060516.93509-2-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/27/2023 2:05 PM, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/spi/spi-sprd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
> index 702acaeebab2..518c7eaca84e 100644
> --- a/drivers/spi/spi-sprd.c
> +++ b/drivers/spi/spi-sprd.c
> @@ -929,8 +929,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	ss = spi_controller_get_devdata(sctlr);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ss->base = devm_ioremap_resource(&pdev->dev, res);
> +	ss->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(ss->base)) {
>   		ret = PTR_ERR(ss->base);
>   		goto free_controller;
