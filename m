Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E23C433E6
	for <linux-spi@archiver.kernel.org>; Mon,  8 Mar 2021 17:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D1E65232
	for <linux-spi@archiver.kernel.org>; Mon,  8 Mar 2021 17:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhCHRHu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:07:50 -0500
Received: from www381.your-server.de ([78.46.137.84]:56058 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHRHZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Mar 2021 12:07:25 -0500
X-Greylist: delayed 1515 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 12:07:24 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=TzaqzNZ5/Fp8lTYyeKtH9GBmnc2sIncwn71iQvdnlBA=; b=fQ5ZX63LM3J4j/xr/WKkGBW97u
        pLCR+JdYGE5oAFeNLpqhzoYZmzEKLwmerJmarikSJ/sHl9o8wvZ/OUOLPnFqLa/cuV/+wxylNSzb9
        wnb1a7viLJ4fXVqTqDEixl3P4vzVN/a0CT71oj3R1+4sMNkkZDHKM6yNyRSGN+uey08bF2pURA5pC
        guXumxSvr4e2ALghBd4BLRxe+WEW6wgx+atUQHIZu09Jp6F+x5o9a8QZ1hXwqqKh1eQXcYxrfUtzn
        SxC76aTOTVL0RbTfdN1Cis0i0MP87mmnfPGihVQuiPDfKroXcsrM68S9pqDeYVpGVi+VbgAomQ+Oq
        uFrjkRwQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lJIxL-0007HI-1U; Mon, 08 Mar 2021 17:42:07 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lJIxK-000WTg-OM; Mon, 08 Mar 2021 17:42:06 +0100
Subject: Re: [PATCH 01/10] spi: spi-axi-spi-engine: remove usage of
 delay_usecs
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com
References: <20210308145502.1075689-1-aardelean@deviqon.com>
 <20210308145502.1075689-2-aardelean@deviqon.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8a6ec9a1-71f8-ce1d-600a-66eba9244a54@metafoo.de>
Date:   Mon, 8 Mar 2021 17:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308145502.1075689-2-aardelean@deviqon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26102/Mon Mar  8 13:03:13 2021)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/8/21 3:54 PM, Alexandru Ardelean wrote:
> The 'delay_usecs' field was handled for backwards compatibility in case
> there were some users that still configured SPI delay transfers with
> this field.
>
> They should all be removed by now.
>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>   drivers/spi/spi-axi-spi-engine.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index af86e6d6e16b..80c3e38f5c1b 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -170,14 +170,10 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
>   	unsigned int t;
>   	int delay;
>   
> -	if (xfer->delay_usecs) {
> -		delay = xfer->delay_usecs;
> -	} else {
> -		delay = spi_delay_to_ns(&xfer->delay, xfer);
> -		if (delay < 0)
> -			return;
> -		delay /= 1000;
> -	}
> +	delay = spi_delay_to_ns(&xfer->delay, xfer);
> +	if (delay < 0)
> +		return;

Bit of a nit, but this could be `delay <= 0` and then drop the check for 
`delay == 0` below.

> +	delay /= 1000;
>   
>   	if (delay == 0)
>   		return;


