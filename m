Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F12848A0
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859914; cv=none; b=SSaMS8fzrKhDTPY0CGSc8/NI+pKkIeze9cIZUi5mbK9nHEINqYQOuxE82hPX/+Lw0lFw3MtVazqZ4uQAvIzQGn/XxfbG1NWHkS19lZjNNjJaQC3yp2yPEc8Wu1g2l5RMXWS6dX4RwMDI78Wi0wsJPoVXYNF9Od60bPEwIqMiv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859914; c=relaxed/simple;
	bh=edmK7IcuwX/yludeWLz7wQ4xZY9n/+AjLuFKIyQaVkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2Azb1oR8GQONlJKGed+8UxUHT1RGC+CXTDdQkknhWc8vGcULWkX3DU/KplIDqGr7TAqYfHuBFPdng4RwRRAhfprRP+697Eq/t7qL2KQeYFtcal6A1uic/ZG16ZAv3PeTW7/S5UQXtJhqNwfCxy4CGtXUhWcqbowe+JS4KMdEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqYJiSfm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqYJiSfm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362507f0bcso3166525f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 07:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771859911; x=1772464711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RuniNnNlGiTyYJotmFYj911sHoaLf3n2mQIYgujh2c=;
        b=JqYJiSfm1ZaYAfmKmHSAydSkXpUX5G7U/wHKFvW5oX0VNKa5A8EkrVNsxOahjfD12f
         kuHDny75+Abfili1V9IeRcS09FBCNeOcPC1GOCkx8gP2Xmt62G3Uw6lpPf22aU3b6ORB
         8ITWVHGbCBJTZ7uN4k8WMOEbcpveZ62CxZcmvmKpenBdYNUrHd1ZYMlixp0ZqCGOlJHE
         uUB2I7W7JrAyFloskVyKLs/XFIcyujIAuMG87LDhvYQc1dXS7IG04VK6ETcA7pueZhSm
         QRgjB/Dbg9kw+HneCwgsJE/Qo31hgm/WK73JWIkaGkWOlDgMM/kGLUIxAnQzZX1kx1xB
         Ximg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859911; x=1772464711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RuniNnNlGiTyYJotmFYj911sHoaLf3n2mQIYgujh2c=;
        b=SKmHalWXgkcH5N8LH6sZlHI8XwvsuvBd5UuhWaXQszNXanR5h5LFMsjQPDxSXwVKuA
         LMslf3R2v43VW+mC4DOUbEIhsAlDzGePhrsD+fRlqV5ofgMMOv4IDYdb/iI9qIjmpN/T
         Z9wiIOqObrytZQ6KiS5sLRcrH/23Bh2OynNdY4leIwPCQPpEuHR2K+DYgA6O+u1SZlNG
         LO3Qd3qzLjzA6yZDiFOpT8v8eyrEekoA8YrAozEPVieo9O+obyN6SYeVmCHzTzhm98O+
         XcPNLExSKBEHdv7m0r/WM0qstL7vib3WKoivmvX78pIj5PA0k0iGsK/U4Gaz0WmA9M0B
         AmSw==
X-Forwarded-Encrypted: i=1; AJvYcCXT9xpeBd5T4KK4qtCSP1Pf2kw8GabFq4zKSPdgiATHLvEHljnAc/6ptcApN32Js9u4adc80TWcYXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUtOakar+irwTM2iKUaD+bNyB1kfy38d7vg+fPU5oUU2RS9es
	XyztuGMzyQuYFBvi+vgofXC5Y9xH3lp8Xsgj0M5EtYMrhXFgl2dp5f3J
X-Gm-Gg: ATEYQzwsU57FjlIjHf+toHJ6blEmbMduP5+XoYowWywphjAd3KE8ZF6SK3vk1BXOnhg
	Rvi+OWvJf0WVAcBzBwJ5UQRw0x5Sjlre4pJQ4Lq18q8NCW8fKdrdCzczzdKGsrBiFAtZ8MB+fkM
	h5Elp5BgVnKWfHcPa2LvhjmN7j/9EFIiJ/B+3gwcj0JEgmlE9N+EXpD2kNa1SW0mDg5MiRDioUM
	kPo/s+KTf0s/o6ILqLtorw+Nu8ZkZivvqA0UxNsa5Jmay/Pu6jalVPHDk4gY2UYd9UU/uhc5wPD
	Xn/sYW21shWg2WytGUAOCa2LmzxgkWdOwn5Hhy8ydr/by4y3y7KeY+16FeT4z3CHzHeVYEGyTV/
	J+uyN+SsIm9p/kVedh8de9bVNXg2ZCNa3j2FWdGPsa8IvoDR6TG6//K2O4DcjiWLRsR5/piquGR
	hSAMgw8a0PFyP0mFVFUECTpVfNp9lcl31Qehf0gjTeTMEcB+ny9bNYYtO/a1s0/1bq
X-Received: by 2002:a5d:5f93:0:b0:430:2773:84d6 with SMTP id ffacd0b85a97d-4396ffde31fmr15606743f8f.24.1771859911308;
        Mon, 23 Feb 2026 07:18:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54a68sm21133203f8f.39.2026.02.23.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:18:30 -0800 (PST)
Date: Mon, 23 Feb 2026 15:18:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Haojian
 Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: use min() instead of min_t()
Message-ID: <20260223151829.6192b32d@pumpkin>
In-Reply-To: <20260223144437.2836369-1-andriy.shevchenko@linux.intel.com>
References: <20260223144437.2836369-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 15:44:37 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> min_t(int, a, b) casts an 'unsigned long' to 'int'. This might lead
> to the cases when big number is wrongly chosen. On the other hand,
> the SPI transfer speed rate is unsigned and driver uses signed type
> for an unknown reason. Change the type of the SPI transfer speed
> to be unsigned and convert to use min() instead of min_t().

I think you should use 'unsigned int' or 'u32' not 'unsigned long'.
There is no reason for these fields to have different sizes on 32 and 64bit.

Were spi to support 4GHz clocks (fat chance on a pcb track) you'd
need to use u64.

	David

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-pxa2xx.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7881a31e4cc..23e40f410814 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -796,7 +796,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
>   * The function calculates parameters for all cases and chooses the one closest
>   * to the asked baud rate.
>   */
> -static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
> +static unsigned int quark_x1000_get_clk_div(unsigned long rate, u32 *dds)
>  {
>  	unsigned long xtal = 200000000;
>  	unsigned long fref = xtal / 2;		/* mandatory division by 2,
> @@ -885,12 +885,12 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
>  	return q - 1;
>  }
>  
> -static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
> +static unsigned int ssp_get_clk_div(struct driver_data *drv_data, unsigned long rate)
>  {
>  	unsigned long ssp_clk = drv_data->controller->max_speed_hz;
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
> +static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data, unsigned long rate)
>  {
>  	struct chip_data *chip =
>  		spi_get_ctldata(drv_data->controller->cur_msg->spi);

