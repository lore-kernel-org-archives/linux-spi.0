Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931532EC09B
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866549; cv=none; b=dm9gjCBBVuUsCTURbUWevi1StC+oLOiYvQ38AVJy9U21IkjQ0Khn+U1SLXLURuxwVplup/x4fMWTrIID4jq70Xu8H8JAcsDS/0RpFi+yQLTqPDIg1bs9nAiLSjV7A8fo27v2C2TAsL4Es+Ytl2igE66dEQerqk4Zk7aVORUUQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866549; c=relaxed/simple;
	bh=HOE1BWvTdGm81sVi4uOGNfO5U+qY0bIwnNqnBLA/63s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XF13XrDEifBNSIV9ffmPQstusXhxGqXZ5suJWCaLt2UncocKNVMkvXnXRThtvTFU0nKxjbbdQblWldCRsC0C2+tO56wtaPHWD2mCaPs8gwZvm8FQES2QbpCj3IxnKiWWiLP3dcvvoTTZNwjNtT7+InQOa8IplFN5dgxZfNwGqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CilFVtTu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CilFVtTu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so47522525e9.3
        for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 09:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771866545; x=1772471345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSoWMk7UM/e+NtDYxH8dhGcwAl8yWcJJT9+skqKp56I=;
        b=CilFVtTu9JhMh3nuePDuylRFaDulTSnXzR4rXmfSh5DzSDuqNKW0VUmvvHAu+XqdQs
         addqIcDICFac6v0N2ImJ6ITCRQVgL7jWUJGVcPehSTk1QwKDI3QeitCHrrZV1gl8erRy
         JdMFuOaXdAFH2MIpGRZxqL7e6bGTroOyY6WsduyUyN7w1JMWHOLSQEOp/I3Ty8bid3+M
         JFi2lWC99B7eFI5uWeqthTlTX5yd0CoTiPdFFqTOErSOMTcmaVmZc2eGzBecuTYVAulJ
         UQDUxkb5ECLxhOy/wv+IwIczB/4isQjdD1iZYt+670kenTiPxqMxnuKfzYz900r8agKJ
         ELiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771866545; x=1772471345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PSoWMk7UM/e+NtDYxH8dhGcwAl8yWcJJT9+skqKp56I=;
        b=sKsdWw0OZSu/T6YDNMDH0XdUFm0PWKUmV97v3kvX7Pf7QpggOoZ63qt7Kf+grXhvz6
         SD3pS107l4njzdF4tVBOxZv2fYVf/V37zm8OxZ/2PG/aZnguyIhyXEd+HceN2/fWiAUh
         2Jnhq3JEorx8PjR2/kqEc87K4k0MhAjIzfW4EpUjUd45C1n9y1kO+ihcWO5Jx/JhxX3+
         z6OWVaJ07XxC8UJUUiylYpG4KuJLsLOkv9/BM44v833gnFGd/A0pZdSjmkri9DkOf+TB
         iJK8sxBAJVqyARbBevXnvxJf0m1+Qb9U5+RuHhNmALdYZHgxnihQppugSGPYUXPiSVeC
         cfJw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/s80UKdzvvl8LM82Va4lKZ7UTG6q77VrfVgUoLxFZZAOjUZ2i+57nn2DGC4J7n6TEff0UrqQlvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8SN7ZQG3a4lIAUmAbPbiwlEGQ/tgE/fYq4QTD+rlcmQ5/zlL
	SncAnPe/+jAAr6IYIHwLlHM+WfNujAuxsL8rJjsz5dXXuxJ5a+D9JvIL
X-Gm-Gg: AZuq6aLYJLB4Ns6zv0Fcf93ct3ha5z96gwjO0hc9qruDk4BGVU9B4qEISKyuokIIFT8
	OA5l1o88EkvaumBttAZkaHG7nATV6UB29N/iKFXKcnGKK5sdETYkpgu+qmdy45mlR0MDHDmGZO+
	yEvFJwYshqPyaotCoQOyr7pVWuTI6bDuQoX/19/MHtpeV089r+BUNkBA1KozDddXozQRtLgOxbO
	ufL87aDtjA1UktiVtndTBXLOt2YlIwp2I2wNsBG2kGbK/6U2Ph++eiLxX0V9tbriVLNTa9jw9i9
	o4/jR2zFyrP7Bny2x+EJaSpJpTO5KR5q4GsR8jByMXJCNr+O4VMNHPBRhk1Ncd7VYWDC75GIWOF
	McS84VSDnxlKVbnPh1ZE3AxgFainYmpih5b5qwUz5G9d0S/lRELgNVaAf71oKSlG+ekrD99L5EJ
	9QCwJ71/3U6GOPvFbZre9HzV8P72tZ9Op4JqLf8CKx6AZknuZ/88WgXJ4twad+JB+wteAt6yVsV
	NA=
X-Received: by 2002:a05:600c:8716:b0:471:1717:411 with SMTP id 5b1f17b1804b1-483a95e9a7fmr160559565e9.24.1771866544616;
        Mon, 23 Feb 2026 09:09:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b75e51sm207415805e9.5.2026.02.23.09.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:09:04 -0800 (PST)
Date: Mon, 23 Feb 2026 17:09:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Haojian
 Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: use min() instead of min_t()
Message-ID: <20260223170903.5f3379b4@pumpkin>
In-Reply-To: <20260223153117.2838840-1-andriy.shevchenko@linux.intel.com>
References: <20260223153117.2838840-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 16:30:54 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> min_t(int, a, b) casts an 'u32' to 'int'. This might lead to
> the cases when big number is wrongly chosen. On the other hand,
> the SPI transfer speed rate is unsigned and driver uses signed type
> for an unknown reason. Change the type of the SPI transfer speed
> to be unsigned and convert to use min() instead of min_t().
> 

Reviewed-by: David Laight <david.laight.linux@gmail.com>
(but see below...)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: used u32 instead of unsigned long (David)
> 
>  drivers/spi/spi-pxa2xx.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7881a31e4cc..6291d7c2e06f 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -796,7 +796,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
>   * The function calculates parameters for all cases and chooses the one closest
>   * to the asked baud rate.
>   */
> -static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
> +static unsigned int quark_x1000_get_clk_div(u32 rate, u32 *dds)
>  {
>  	unsigned long xtal = 200000000;
>  	unsigned long fref = xtal / 2;		/* mandatory division by 2,

I've looked at the file...
I think all the 'long' in that function can be 32bit.
Especially if the code actually works on 32bit.
There is also the stunning:
	do_div(fssp, 1 << 24);
in the only bit that that does need u64.

	David


> @@ -885,12 +885,12 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
>  	return q - 1;
>  }
>  
> -static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
> +static unsigned int ssp_get_clk_div(struct driver_data *drv_data, u32 rate)
>  {
> -	unsigned long ssp_clk = drv_data->controller->max_speed_hz;
> +	u32 ssp_clk = drv_data->controller->max_speed_hz;
>  	const struct ssp_device *ssp = drv_data->ssp;
>  
> -	rate = min_t(int, ssp_clk, rate);
> +	rate = min(ssp_clk, rate);
>  
>  	/*
>  	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
> @@ -902,8 +902,7 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
>  		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
>  }
>  
> -static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
> -					   int rate)
> +static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data, u32 rate)
>  {
>  	struct chip_data *chip =
>  		spi_get_ctldata(drv_data->controller->cur_msg->spi);

