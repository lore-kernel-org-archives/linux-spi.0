Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94267C4332F
	for <linux-spi@archiver.kernel.org>; Mon, 17 Oct 2022 21:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJQVMO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 17 Oct 2022 17:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJQVMM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Oct 2022 17:12:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE079EDD
        for <linux-spi@vger.kernel.org>; Mon, 17 Oct 2022 14:12:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s3so8564541qtn.12
        for <linux-spi@vger.kernel.org>; Mon, 17 Oct 2022 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvpgY9xWF9UUUAa08RkU7xR5FRUQJoMROK6ckPWKWdQ=;
        b=dpRypmD23u/BW2x1IKuGNtetMezvoXi85oQnLAGjRyMLxwV9ZgUlXG5daNpVNkDdW1
         xhHjhdjyw71Dymp29y6jEYR2KsiRGfyOaIjx+fRFO00XLXY2eGQHxE/3E2JpdyJ936jc
         7tvlCBezPdfIkIiTEdXvfGigpHj0AefD85F33nuYe5aikUnn6NGRkf5AbcUtQAzAz+sQ
         kH3JgrFkIC/dKBTsBOGcdyAStR7kLUWOaywA8IOUF+NRrSgOWh3alF9IQBFEZ1cM4r3a
         jFcUUJvywHgWqwH+c5/537ih1rPTHz3SM9CZYBSHYQ2JjmpVab0d/Hl0kv7MhCIGR4T3
         MI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvpgY9xWF9UUUAa08RkU7xR5FRUQJoMROK6ckPWKWdQ=;
        b=xIbW3HLyKju8kGEvM/7gqNB2GuSTYUzK9JyfziSuKeLSLnTtjsMe2At4PIlBCIGMPs
         uz706NgIgq43CLEYRwvQeri2LhPxXRHy6iO8epyXzIkr5zb6HrNgjhWRVrVYoxomROCB
         ecZRLHnXesvtefGiNMGE8FPTilBNzt1iBhC836jkYLQjF/oQFKijl+Gvx3URzIFU+MIH
         CLm0IAXY+UHUwC1ErJ4eqXZy2U+9GnzXWr95vEwKAsS1wpm6KRViHxtDIHktaerbNgg0
         KWxnZstu94N2q/lAFCrysqhAX6eiAaxKBZGSniZBzaCYRn90a5a5eF6+SYbxol57Y74v
         fk3Q==
X-Gm-Message-State: ACrzQf1D29U6VCEfpvnU00HvJ2QKx6ifQeCKiqqC74So63SgE3tz3pYm
        DJW1COP0eh+H1kCLMPM0zzY=
X-Google-Smtp-Source: AMsMyM4nYeiG0WEw+P0T66yZceFKu0g2JG8MenE9O+FW3vCW2d/s+s+Om7aD4tLphXxdxaumBHrQpg==
X-Received: by 2002:a05:622a:43:b0:39c:eb15:c2ee with SMTP id y3-20020a05622a004300b0039ceb15c2eemr5666594qtw.331.1666041130257;
        Mon, 17 Oct 2022 14:12:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n6-20020a05620a294600b006cfc7f9eea0sm687179qkp.122.2022.10.17.14.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:12:09 -0700 (PDT)
Message-ID: <78aea830-72d8-33a1-56b9-8b01142b98ca@gmail.com>
Date:   Mon, 17 Oct 2022 14:12:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: bcm-qspi: Make bcm_qspi_remove() return void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20221017200143.1426528-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221017200143.1426528-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/17/22 13:01, Uwe Kleine-König wrote:
> The function bcm_qspi_remove() returns zero unconditionally. Make it
> return void.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
