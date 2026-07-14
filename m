Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145203FA5EF
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020930; cv=none; b=jgDvqjVrV10Py+FVAUMJPZh25c6GcmErnRxva7M+RDog7lRLJv38lZc0RLQULQB6f8YIIHvfePSYHNOkQiQBd32lKFEzjfFerE+zbkF7G13eqx/Zrjpx5emJrp1UdKTM4pYyy6PhJIVogqNuSyeAD+cLCGeY+zmatmgbc3m91hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020930; c=relaxed/simple;
	bh=7PjaHS8Z7JC3iRkOgwQq3QmAz3flMbb/3aQx56GYFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfQLYmgpFh1cjBk84naNxSSSLly8QlLoLaE9ZIgytPQnuCAe+EzVaJydMoWvfGvyO6p4yUOhpE4QRB/R6/i8nnuSeEM0G1ShPk2G38+y+IJ5najHMhzYKuAhf4V9I1VhdbqasnyTqw8s+lTQbNJhOyUBkFBQrM1ibUArfwHkZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAUBTMxD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAUBTMxD"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d5468673so99303966b.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784020926; x=1784625726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jw59UYT+EI1+5hvOZpv0yqhdg9ddADwhfr99twQ85vI=;
        b=BAUBTMxD89Gf65I6WyHz26e3c99DY3vTTFXDR1akJFrWmAFDJOJ+41cTMll4vPPctr
         qJQmcGKT23yxSZnSOxEuWemZwQtsARR5M9cU7GlhawdCMGYdJ0HCyoQ7nvRO/gH0rsmy
         G6JpOFsLniigFugxrHhjQ0kVEaSOQbSn/FMNdBqQAcez6TiOt3Ak95plbX9edC2jTL35
         HoJvFWPt7POOlXGwxR0c2OYO91zEiujy37wxRbjtw+QoqyXhRJ3MrHI1gJxHBmJ+OI6Z
         b9/XX4AtwLMYj0/H4luoi/4Jck05Gmdx73b9IfEKk71D4wesfy8kAz/Eb/2dpXxMtksp
         QobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020926; x=1784625726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jw59UYT+EI1+5hvOZpv0yqhdg9ddADwhfr99twQ85vI=;
        b=bWg3GUN65oRZcs6hSIVaMqvCUc2wjnb7BYiXxoUpbe/RTzRY+F6i354Wvta1Ir6C5c
         cAm6iZGd1d6WGR8Mye2L7csxywRq7C5tjbaeaLH+5oZiXKRIP6qLHn67z2OB/9qvnqdI
         Y39rXpCW4AvwI+iLLDcy5v2f3NzDZpgstwHhmscGqrho8TBz1BNu7WcUfbC9Q7FE/cy1
         iPbCThNRf6Hebk8OSI4/FcnXpFOtxV81glCf62cCR3tlU2zv+hxj59r8ang8g+NphUCw
         lsiT+rBOtfWEQAdEEcklJzINIhouhJhiCqlPf53vCI7KOEbPjVE0hZufUIC0g7QWuB3e
         /PLg==
X-Gm-Message-State: AOJu0Yy8043ajYqLOWcagxpxKj/aKW06fC18Pi5zuPdh6KwMJFMxMV1I
	CO7k15lmL5QuGk0ce7NUyjX4sr/eCKKL0toS1AchmCv+XI/rJd9+C577
X-Gm-Gg: AfdE7clkpHKiZl35yi6k3oK5XhK57iVPrwDJ3qzTr2NbRg+O5A/03cOT27w+BJImJ+v
	D721KFP9qCQFSA/KDZDq5pU+ZnQH9U0QfuPWkb1laAPmvslVBD8pdXet/TWL8XOfP6IT1L/mTmK
	mja6Ks2ZBi/017qbvGQR9HPP+p+6l6MWFCBZJB4UEbn+dqFuW7O67VRQh3WJQE5SIL3elSa8CZk
	trlqOZYpP+GV6E/6qomyAxrN08mqY3GBtxJfczUZ1BaLj61pIfPW8FaGbvfBsniwKka5TJl9LKn
	JUNLBBYs+ylFFn6sMRnaQyU3F93N9GHMNVlpN94z4GMG2ejE321R/CyGx0eYAz7JznDu92iFuFF
	mbIvmQM7+fITLSNNvlfnjjkjdzr3Ul2/3OJwNsVyT3Aou4vSf6V1dl3wj8tAckEvdhVGAP5FxlY
	VGmEocZNhRaGhe74Q8epmLy8wAhE8=
X-Received: by 2002:a17:907:25c3:b0:c12:864a:bd37 with SMTP id a640c23a62f3a-c161f354603mr564500666b.34.1784020926185;
        Tue, 14 Jul 2026 02:22:06 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad84483csm1150626566b.17.2026.07.14.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:22:05 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:22:03 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, michael.hennerich@analog.com, 
	broonie@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, 
	andy@kernel.org
Subject: Re: [PATCH 5/6] spi: add rx and tx lane mask to spi_transfer struct
Message-ID: <qjuqqvdzedijivcqej7uxkctsgwyoo7ne6vbgaw4fo6zb3l6m6@yf3ler2x4xhe>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>

On Tue, Jul 14, 2026 at 02:56:46AM -0300, Jonathan Santos wrote:
> In SPI_MULTI_LANE_MODE_STRIPE mode, a transfer currently activates all
> available lanes, but some use cases require operating over a subset of
> lanes per transfer.
> 
> Enable dynamic lane selection for tx and rx by adding new fields to the
> spi_transfer struct. Controllers that support multi-lane selection must
> parse the transfer struct to update the rx and tx mask lane-wise.
> 
> Peripherals need to set values to the new fields only if multi_lane_mode
> is set to SPI_MULTI_LANE_MODE_STRIPE and they need to enable at least one
> lane, not necessary for enabling all lanes.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

Acked-by: Nuno Sá <nuno.sa@analog.com>

>  include/linux/spi/spi.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a9988db3fe2f..f4473d53b6b5 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -986,6 +986,12 @@ struct spi_res {
>   *      (SPI_NBITS_SINGLE) is used.
>   * @multi_lane_mode: How to serialize data on multiple lanes. One of the
>   *      SPI_MULTI_LANE_MODE_* values.
> + * @rx_lane_mask: Bitmask of lanes to use for receive in
> + *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
> + *      lane. If 0 all available lanes are used.
> + * @tx_lane_mask: Bitmask of lanes to use for transmit in
> + *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
> + *      lane. If 0 all available lanes are used.
>   * @len: size of rx and tx buffers (in bytes)
>   * @speed_hz: Select a speed other than the device default for this
>   *      transfer. If 0 the default (from @spi_device) is used.
> @@ -1131,6 +1137,8 @@ struct spi_transfer {
>  #define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
>  #define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
>  	unsigned	multi_lane_mode: 2;
> +	unsigned	rx_lane_mask: 8;
> +	unsigned	tx_lane_mask: 8;
>  
>  	unsigned	timestamped:1;
>  	bool		dtr_mode;
> -- 
> 2.34.1
> 
