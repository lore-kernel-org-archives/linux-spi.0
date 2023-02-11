Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E772C61DA4
	for <linux-spi@archiver.kernel.org>; Sat, 11 Feb 2023 14:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBKOrY (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 11 Feb 2023 09:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBKOrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 11 Feb 2023 09:47:23 -0500
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE88CDFD
        for <linux-spi@vger.kernel.org>; Sat, 11 Feb 2023 06:46:51 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Qr95pNL9rOJaFQr95pI1Nk; Sat, 11 Feb 2023 15:46:32 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Feb 2023 15:46:32 +0100
X-ME-IP: 86.243.2.178
Message-ID: <e8ce6ab5-5db0-305b-f025-a4cef95fde58@wanadoo.fr>
Date:   Sat, 11 Feb 2023 15:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: Remove extra/duplicate constant from expression
To:     drv@mailo.com
Cc:     broonie@kernel.org, kumarpraveen@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        ssengar@microsoft.com
References: <Y+dnFKut9qiQUxjW@ubun2204.myguest.virtualbox.org>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y+dnFKut9qiQUxjW@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Le 11/02/2023 à 10:59, Deepak R Varma a écrit :
> Constant SPI_TX_OCTAL is included twice while building the controller
> mode bits. Remove the extra constant.
> Issue identified using doublebitand.cocci Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv-asAA5fHt7EIAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/spi/spi-sn-f-ospi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
> index 348c6e1edd38..19284d6914fc 100644
> --- a/drivers/spi/spi-sn-f-ospi.c
> +++ b/drivers/spi/spi-sn-f-ospi.c
> @@ -611,7 +611,7 @@ static int f_ospi_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	ctlr->mode_bits = SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL
> -		| SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL
> +		| SPI_RX_DUAL | SPI_RX_QUAD

Or maybe s/SPI_TX_OCTAL/SPI_RX_OCTAL/ ?

CJ

>   		| SPI_MODE_0 | SPI_MODE_1 | SPI_LSB_FIRST;
>   	ctlr->mem_ops = &f_ospi_mem_ops;
>   	ctlr->bus_num = -1;

