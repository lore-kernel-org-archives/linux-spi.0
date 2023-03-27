Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB55C7619A
	for <linux-spi@archiver.kernel.org>; Mon, 27 Mar 2023 06:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC0GqQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Mar 2023 02:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0GqP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 02:46:15 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE130CB;
        Sun, 26 Mar 2023 23:46:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VehiUOk_1679899569;
Received: from 30.97.48.73(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VehiUOk_1679899569)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 14:46:10 +0800
Message-ID: <60a08a27-f611-c64c-eec7-27703a08cfa0@linux.alibaba.com>
Date:   Mon, 27 Mar 2023 14:46:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 1/2] spi: sprd-adi: Use
 devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>, broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
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
>   drivers/spi/spi-sprd-adi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
> index 3b158124d79f..22e39c4c12c4 100644
> --- a/drivers/spi/spi-sprd-adi.c
> +++ b/drivers/spi/spi-sprd-adi.c
> @@ -541,8 +541,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
>   	dev_set_drvdata(&pdev->dev, ctlr);
>   	sadi = spi_controller_get_devdata(ctlr);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sadi->base = devm_ioremap_resource(&pdev->dev, res);
> +	sadi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(sadi->base)) {
>   		ret = PTR_ERR(sadi->base);
>   		goto put_ctlr;
