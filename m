Return-Path: <SRS0=w6ou=B5=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D8AC433E1
	for <linux-spi@archiver.kernel.org>; Wed, 19 Aug 2020 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD80C2072D
	for <linux-spi@archiver.kernel.org>; Wed, 19 Aug 2020 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597841588;
	bh=nWrpfe/kyAkiTQ3w7qXLk+6ieFRCJLcRUUsxdd25wvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CoXy0k4ual+SuhPidF7rfKWSPPJKE/Mol/r7s04noy26w61aupu1ci680xUSxiPEQ
	 JyjATacHHt0IeG9b8Bavna5nHNW+6wOuHC2Q+IoW6yRYe8MO0lymclN0+AySteYB4L
	 cEoWgg3PjyJegk7dD/BgJi0U9YzenXMNUQYQS91c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHSMxI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:53:08 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:34864 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgHSMxG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:53:06 -0400
Received: by mail-ej1-f67.google.com with SMTP id a26so26160053ejc.2;
        Wed, 19 Aug 2020 05:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TSdYnGO6esUF6RULUMC6nEfsNIEpXpy1sXaM6lZVn9s=;
        b=R2mTPou0jZztqp3J+vpeYOvcK6tdOB6IufgwjRALCAtSp0jm7OXjOHJmepVs5rNGyL
         QK8SoD5YO4EgU2G0jX8oEZ5IryCHrHZh9WKFrToskbnFz9RmKDe4VE2O0DA2o6CjtGV3
         9v19iI5gqBEUNZJDxRs54up7SfhsPN2mRq61wBdQG4prN1dsrId1wL4X3dvDPH4dfY4S
         b4pu0vLaA+lwvMzVBTbBAYZpWEgX3myUcjLnHelN0C9SD1kBoxVBvlyuKAoNa21PeDPw
         RYKKpfGqSfrYZyv37XzU0aa70f6fj4kmDtx4v20wATAlLuNqI7c1dZ7hZ8KsFFbDF/2u
         Jv7Q==
X-Gm-Message-State: AOAM532TyyAhmhnR6ooEEd8Qqp25fZUQ8mBTKWd4xQXMlGvW4q5jadz3
        V+TDgi7z1p3AYzSB/ZnJRoU=
X-Google-Smtp-Source: ABdhPJyAmWAEyWvNsEvQcbK5E7xbLkVLc7d0XZRaRJ/bsM+RMk/OxzybTRBuL1IdCWNYkjK/RCKFNw==
X-Received: by 2002:a17:906:2c4a:: with SMTP id f10mr24823918ejh.352.1597841584378;
        Wed, 19 Aug 2020 05:53:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id b62sm17876759edf.61.2020.08.19.05.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:53:03 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:53:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 8/8] spi: spi-s3c64xx: Turn on interrupts upon resume
Message-ID: <20200819125301.GI18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123228eucas1p132d530d17256f887d93ed7792f5b9587@eucas1p1.samsung.com>
 <20200819123208.12337-9-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-9-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:08PM +0200, Łukasz Stelmach wrote:
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 27db1e0f6f32..5dcad43fb847 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1356,6 +1356,10 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
>  
>  	s3c64xx_spi_hwinit(sdd);
>  
> +	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
> +	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
> +	       sdd->regs + S3C64XX_SPI_INT_EN);
> +

Makes sense but you should explain in the commit msg what happens
without this (or why they are not enabled).

Best regards,
Krzysztof
