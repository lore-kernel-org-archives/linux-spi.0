Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DFEEB64DA
	for <linux-spi@archiver.kernel.org>; Wed,  5 Jul 2023 10:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGEKTJ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 5 Jul 2023 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGEKTF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 06:19:05 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338CE63
        for <linux-spi@vger.kernel.org>; Wed,  5 Jul 2023 03:18:56 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 57fcbf88-1b1d-11ee-b3cf-005056bd6ce9;
        Wed, 05 Jul 2023 13:18:54 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 5 Jul 2023 13:18:53 +0300
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1 2/2] spi: amlogic-spifc-a1: add support for
 max_speed_hz
Message-ID: <ZKVDjTCFAcJxO_Ci@surfacebook>
References: <20230703094518.53755-1-mmkurbanov@sberdevices.ru>
 <20230703094518.53755-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703094518.53755-3-mmkurbanov@sberdevices.ru>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mon, Jul 03, 2023 at 12:45:18PM +0300, Martin Kurbanov kirjoitti:
> This patch sets the clock rate (spi_transfer->max_speed_hz) from the
> amlogic_spifc_a1_exec_op().

...

> +static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32 freq)
> +{
> +	int ret;
> +
> +	if (freq == spifc->curr_speed_hz)
> +		return 0;
> +
> +	ret = clk_set_rate(spifc->clk, freq);
> +	if (!ret)
> +		spifc->curr_speed_hz = freq;
> +
> +	return ret;

The form 

	ret = clk_set_rate(spifc->clk, freq);
	if (ret)
		return ret;

	spifc->curr_speed_hz = freq;
	return 0;

less error prone in case some code is squeezed in between.

> +}

-- 
With Best Regards,
Andy Shevchenko


