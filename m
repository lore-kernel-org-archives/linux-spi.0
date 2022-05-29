Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD14C433EF
	for <linux-spi@archiver.kernel.org>; Sun, 29 May 2022 07:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiE2HRR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 29 May 2022 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiE2HRQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 May 2022 03:17:16 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3191B1A3B3
        for <linux-spi@vger.kernel.org>; Sun, 29 May 2022 00:17:14 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id vDAjnJygkOXCyvDAjnpj0X; Sun, 29 May 2022 09:17:12 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 29 May 2022 09:17:12 +0200
X-ME-IP: 90.11.191.102
Message-ID: <097dca7f-12ba-ddbc-7380-05f3278fe40b@wanadoo.fr>
Date:   Sun, 29 May 2022 09:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] spi: rockchip: Fix a resource that is put twice in
 rockchip_spi_remove()
Content-Language: fr
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        addy ke <addy.ke@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mark Brown <broonie@linaro.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <df2f4ae902474574ccdb0a8696ce51db39fbd239.1653808056.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <df2f4ae902474574ccdb0a8696ce51db39fbd239.1653808056.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Le 29/05/2022 à 09:07, Christophe JAILLET a écrit :
> spi_controller_put() is already called as part of
> spi_unregister_controller(). The latter is called automatically because
> the controller has been registered with the devm_ function.
> 
> Remove the duplicate call.
> 
> Fixes: 64e36824b32b ("spi/rockchip: add driver for Rockchip RK3xxx SoCs integrated SPI")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/spi/spi-rockchip.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index a08215eb9e14..70777731b20e 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -963,8 +963,6 @@ static int rockchip_spi_remove(struct platform_device *pdev)
>   	if (ctlr->dma_rx)
>   		dma_release_channel(ctlr->dma_rx);
>   
> -	spi_controller_put(ctlr);
> -
>   	return 0;
>   }
>   

NAK.

There is a spi_controller_get() call a few lines above, so this 
additional spi_controller_put() is needed.

CJ
