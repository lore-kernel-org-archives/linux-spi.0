Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D5382362
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655040; cv=none; b=TYNc1Fvs72K9s9QMOVKP7PEYI1GGxtLF5oniqcvyJbm25MU3V/81dLh29in6NgJnuzv/B0oC+iR3H01+PeEyjMGKs0sCb4kcrVxHiVERirhlYF2FTnLxblVmak+o7xkZ0nquhVF02lSX5Alha2NkPyAq0RO67ZomeserWrtZPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655040; c=relaxed/simple;
	bh=7brzX4WOi+5jYVLMoJofPutcuzGjrekvjwI7c1OWTA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJNZHBoTjL3CEJC9YzXSKJZysEbr3KGVf0VMMdceGZ/3UJG4jbQWWdj7T2QjZ6fIQLSiEydWfVmRD8edYTluWxKey01FBcS98IovVCbrHXBKiYSAeJxa148frnYuSoDZF0sE4NG+xw7edX+YWG2zf8pxGcZ0hjTkgBKoBszrdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKt49IQt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKt49IQt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b43f5990dso460934f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773655037; x=1774259837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORR2k9D3W/c7ahH5HJ1Wm+dpUNHSI19Jin/n96XvaOU=;
        b=mKt49IQtq7Up/4AfWeOx4yqmt3a+xXbMUHoXhGGY3rkDnFvYAJDpQlstGhf/VeFaGI
         9QxFzB/oqSB8PsfFg0lfCey8n2S+SgkzP2xN693zkzneYEL2OWJ7GE/b8ef081LXEUmc
         DcmaXKVsDIuskaUyQlTxeUvZBr9b48CKUs3gbJKazxdoBhhvLDkcDRV1ZfYbXeX0jK9q
         Augyd4uRZm5I+DdKcFaJJLASix/SLJ3BeQ3i9p8puYkonNHi9q2usA4iUNomwt6R2TqD
         jwzq8ZadqoLthQNAZKg5iA0WVVpOt80Ju0/wwrjpwZflJFaDCgYv/FoKzkvLcSPrm4Ys
         YHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655037; x=1774259837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORR2k9D3W/c7ahH5HJ1Wm+dpUNHSI19Jin/n96XvaOU=;
        b=stiAOHO/M7rrV7SpTcyCaQPQztNf/LnU393q5/ztmV05mJ4ohnZLi9OHcMFRLtwIBI
         BsR02GCM19y+E7BtgE1wZftxryUtZ5h0Hw0GDCoLoyfBSR9VQfWJyuDLbMUp0VfnGDFA
         4z6EhfkkAoZ1ktqH2nUyiOAtwUJVUyAiA4zdYD1RpVTdgh+7vnljwpombqgumjvy8fyX
         VApE+Nd8kNZNyuwdebpLlrqJ+pMiwfC6SmAzY9l+fsJi4pCtsuzwAq5q0rT19CiG6LNc
         Xatep4xAkmaLxR1RU4MMEMcmUg3Z+NIjNK2au9wLwt8zxvcXQf4dhdTQKJDXULftY26Q
         KSaQ==
X-Gm-Message-State: AOJu0YwWO0RvzXzW4s0yWtYmBMv3s3WPlRIvm3cfDSEi5zUYxqwIzG90
	rsXVv/emS3XbX89Yw66WFYvFflXMtfhOaiyGnJP85ntN5J9rfC5Q+O6HWtTcOWlNRCU=
X-Gm-Gg: ATEYQzyw+28Xg1A7fQTNJ6Nx3a9c9T8ppHS+NylyncDV2pVll748qw8ht0unqm1D1Tq
	JDoYYlELMdD/CNNcqwph0TqRKa9jOIjqCdhKKjrCV/wKEWIc4iAwFeZTuLkE7vb+FRpLb1v0qPp
	IVSed0Dq3lXLGTiOfQecG4dJs0Uiwk/mEXqI2HKuc/9wZ289C93sU4I97+IsGZY73eSPshhUEK7
	u9HnxqTr6snXQw6mbmlwsqFo+p8me/16H2GIvZAEgous32mUUqaDvRxDdSwhNzAD6RoQ1DLaFtF
	ZzYhldo6/serc8Z+Nwb3TqjaDGpWKbYnCrCPfrgGTY1bihQUs8BL5ikr8M5tQPNnMqJJFQi+yZK
	JQfH5wVTBL6H+ykXolrEjUHplLQuwe5mly/a6egIVCfSVJErDbrt/xXjyTUsY8sExGeKUUgckfL
	1vK92Yyc3ztRyMAfyM0omR5BYLXdfo
X-Received: by 2002:a5d:5d86:0:b0:439:b3a3:7239 with SMTP id ffacd0b85a97d-43a04d78189mr21771898f8f.5.1773655037253;
        Mon, 16 Mar 2026 02:57:17 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3b0e9b99sm18531007f8f.18.2026.03.16.02.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:57:16 -0700 (PDT)
Message-ID: <dbdd4655-1c6a-42b0-a6fe-8d14db1043f0@linaro.org>
Date: Mon, 16 Mar 2026 09:57:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH spi-next 11/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a
 special case
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-11-1b695607702d@pengutronix.de>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-11-1b695607702d@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/03/2026 8:39 am, Marc Kleine-Budde wrote:
> The i.MX93 is affected by erratum ERR051608, the maximum prescaler value is
> 1 not 7 as in the original datasheet.
> 
> On unaffected SoC the maximum prescaler is 7. Commit 783bf5d09f86 ("spi:
> spi-fsl-lpspi: limit PRESCALE bit in TCR register") added struct
> fsl_lpspi_devtype_data to hold the system dependent prescale_max value.
> 
> Commit 9bbfb1ec959c ("spi: spi-fsl-lpspi: Treat prescale_max == 0 as no
> erratum") introduced the special value 0 to signal the default and
> corresponding run-time check with a conditional operator.
> 
> To simplify the code, set the prescale_max of imx7ulp_lpspi_devtype_data

The whole point of the original change was to not repeat the normal 
value for every device in the config just because one device has an 
errata. This new change is exactly the opposite of simplification IMO.

> and s32g_lpspi_devtype_data to 7 and in fsl_lpspi_set_bitrate() directly
> use the fsl_lpspi->devtype_data->prescale_max.
> 
> On ARM64 this leads to a reduction of the code of 52 bytes:
> 
> | add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-52 (-52)
> | Function                                     old     new   delta
> | fsl_lpspi_setup_transfer.isra                956     936     -20
> | $x                                          7144    7112     -32

On clang 15 this change makes it bigger by 220 bytes rather than 
smaller. I checked because I was suspicious that removing a single 
ternary could save 52 bytes, but it looks like the outcome after all the 
optimisations is just unpredictable so there isn't much point in making 
changes like this.

You also didn't say _why_ we need to save 50 bytes, or what the 
performance impact is.

> | Total: Before=19675, After=19623, chg -0.26%
> 
> This partly reverts commit 9bbfb1ec959ce95f91cfab544f705e5257be3be1.
> 
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/spi/spi-fsl-lpspi.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 3a0e9726fa71..f2c7bb3bc4cc 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -96,7 +96,7 @@
>   #define SR_CLEAR_MASK	GENMASK(13, 8)
>   
>   struct fsl_lpspi_devtype_data {
> -	u8 prescale_max : 3; /* 0 == no limit */
> +	u8 prescale_max : 3;
>   	bool query_hw_for_num_cs : 1;
>   };
>   
> @@ -143,8 +143,10 @@ struct fsl_lpspi_data {
>   };
>   
>   /*
> - * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise there is
> - * no prescale limit: https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
> + * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise use
> + * the register limit of 7.
> + *
> + * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>    */
>   static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>   	.prescale_max = 1,
> @@ -152,10 +154,11 @@ static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>   };
>   
>   static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
> -	/* All defaults */
> +	.prescale_max = 7,
>   };
>   
>   static const struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
> +	.prescale_max = 7,
>   	.query_hw_for_num_cs = true,
>   };
>   
> @@ -348,7 +351,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
>   	int scldiv;
>   
>   	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
> -	prescale_max = fsl_lpspi->devtype_data->prescale_max ?: 7;
> +	prescale_max = fsl_lpspi->devtype_data->prescale_max;
>   
>   	if (!config.speed_hz) {
>   		dev_err(fsl_lpspi->dev,
> 

