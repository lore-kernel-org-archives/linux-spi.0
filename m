Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF793563E1
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722458; cv=none; b=kC8j0UDFOv32/eTA23zfeJtiIjRxdo4MdZ6AGx/4n1h9PEnow9WCm/r+IFfDmI/mKvTF9A+aam4N4xg9LDexvRnjzIf9YUvwCXzC7WuWn5K4zS7VRM89iYEav6/HLGZ3ivAvfbutHqyiy5z/e1tiGbT9q9gyWArgZFvD5Zzhmtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722458; c=relaxed/simple;
	bh=BNDSL0Nv+QnTOb/BpUOkxBNpTRpd3JVzXhV1IfBtomY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQ0KtmZYxDIFkudjVDHxU3xEc3jsm+HmJcgMzUZ+2WbbVEyat3zzQU9nV3r420zQ9aai8PoVoGwpXqIIruO5RLOTJGssq30/FQSQ9PfvnoDfpBNsuq8eam24c9LMunuaHwd8OHnZW1jsMFTNV0Sliw02wx6pmUwlNKpe0WGCOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=tp4SmWK1; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="tp4SmWK1"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2808dbc3so88131501cf.1
        for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784722455; x=1785327255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGQC9a0lDQVYs2rzJjXKUgf6ViPQ8mWczj4aICyEJF0=;
        b=tp4SmWK19Oa3tWYBp7HalYrg5Fs4nkt/5MMcckst5gx2M8t7r1DL1b0erjjDzOa4xv
         TnJFaUQvT5y4YbS1u2t3KlbnIDFG3n0/lYsQIJMFYVZBOiCxlJ7EUMf9YbC5PftHGvAF
         V1PvZKV9bbaFrQ2mIgUa1+z2eoy4DUJSJTMbvToVWzqOaRxDAjjmv4QL4/jD8fIoInDX
         VKwaWRPzmcZcgEMrmpeUjF5fYmkpiWpxijkH8YuwTEEoqqzT/m8jT9HNrpGkuuUtn1l9
         /ayGnePNW1GOB7sSMq5RwlpJwc1tgNol2LG2V8QhgxxMXftKnEAVVIxJ0e7hht4YtHl8
         yYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722455; x=1785327255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGQC9a0lDQVYs2rzJjXKUgf6ViPQ8mWczj4aICyEJF0=;
        b=IImGm3pQUCd6Pz1bVMj1dlhvOxO4jxLNcLNwjMWin0wRSgjS2LwM6WYYUOp3jaq2T7
         KCENPJ+AgHD2CKbOwO7zAImNFlmGfYOXKraciBhlzYBV8sXVHUl44qhtR5B9JS6wbNiv
         BzlM4GDEinCpIDy+T5e3lZLSulIwENmvZQ3ChD9sEqupvKQVPxIiA6M2B8EwmL+pLEWQ
         MuwiwWSZPOduQyDGtDnDzmnQpZTtg7genk19xl6cMYHgSNBrm4B/j/GxYh5qqlxbzuzQ
         cyTz2PQSC25YeffB3AhAiO6D5P/+qPHbtS7h+RVf6hlcReVgwos0zdTjIOld69rY3n4A
         F8hw==
X-Forwarded-Encrypted: i=1; AHgh+RpLEG+x6x0OgO84fd92WlfcO5UVunedscjhxaIYRkJXMKJ8lsHUkj5D8yXEvDJn52HNwGhN5LBQnlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQobtr2H9c7PvUiA+C2hdeq547wrzmLP06yY2h4BHdVopJGLnO
	wLYLk0O0GQUfCRDOw26nzlRL3VJQjG3KubEduLIHwmz5EOtA4G3868mkMqgpNV3T1kw=
X-Gm-Gg: AR+sD13fCRZcApVb79w+9+Kh9BS7t3tzPXDyB/ldHiAdH18rixBnHeKowtugCflxyER
	sdfTjhW1JooIIRowyqm+YiL6uDEp8KCcqR904fp8x1mIzCm1IiDVLQ3S0+zbn9vtBIWdxBoax8f
	67HZCdIcZgsP0+m9RGked46J4vGN++179j4KhGts8DFBAAEdcjF9aFienKaD8szJn69PWLHSIkH
	hPN7f6ebStpeSLE9kgGgaNWt+vypp/QZy4tk0Q8RsnxXDdNhmYhBpUvff8Mkf9J9ou37lf4CqYu
	/Zq/hdkn652qRtSIbzksfoB/+qvjFNrl2nBS7vAgfWh692GMuGRyQXITVXYEfmB7a+6ApCdjkgO
	ZA+ChAcMKyM3yV7W7D41bTB//IOktkiPNMYDoZ4JArc9wEy/Jt+ZgzttF/XOWlw4PHfYzNYMOL5
	Q9TQ==
X-Received: by 2002:a05:622a:58cb:b0:51c:19af:6341 with SMTP id d75a77b69052e-5213cbd5495mr205627331cf.36.1784722455297;
        Wed, 22 Jul 2026 05:14:15 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d402caf9sm13896591cf.30.2026.07.22.05.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 05:14:14 -0700 (PDT)
Message-ID: <3793653d-f06e-4353-968d-ea42200899a5@riscstar.com>
Date: Wed, 22 Jul 2026 07:14:13 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spacemit: prepare both DMA descriptors before
 submitting
To: kr494167@gmail.com, broonie@kernel.org, dlan@kernel.org
Cc: guodong@riscstar.com, linux-spi@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260722034103.12190-1-kr494167@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260722034103.12190-1-kr494167@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 10:41 PM, kr494167@gmail.com wrote:
> From: surendra <kr494167@gmail.com>

Do you have a more complete identity?

> k1_spi_dma_one() currently submits the TX DMA descriptor to the DMA engine
> before preparing the RX DMA descriptor. If preparing the RX descriptor
> subsequently fails, the function jumps to the fallback error path without
> canceling or aborting the already submitted TX DMA descriptor.
> 
> Fix this by preparing both the TX and RX descriptors before submitting
> either of them to the DMA engine.
> 
> Fixes: efcd8b9d1111 ("spi: spacemit: introduce SpacemiT K1 SPI controller driver")
> Signed-off-by: surendra <kr494167@gmail.com>

This looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/spi/spi-spacemit-k1.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
> index 215fe66d27b4..96b41b67fcbf 100644
> --- a/drivers/spi/spi-spacemit-k1.c
> +++ b/drivers/spi/spi-spacemit-k1.c
> @@ -278,25 +278,25 @@ static int k1_spi_dma_one(struct spi_controller *host, struct spi_device *spi,
>   			  struct spi_transfer *transfer)
>   {
>   	struct k1_spi_driver_data *drv_data = spi_controller_get_devdata(host);
> -	struct dma_async_tx_descriptor *desc;
> +	struct dma_async_tx_descriptor *txdesc, *rxdesc;
>   	u32 val;
>   
> -	/* Prepare the TX descriptor and submit it */
> -	desc = k1_spi_dma_prep(drv_data, transfer, true);
> -	if (!desc)
> +	/* Prepare the TX descriptor */
> +	txdesc = k1_spi_dma_prep(drv_data, transfer, true);
> +	if (!txdesc)
>   		goto fallback;
> -	dmaengine_submit(desc);
>   
> -	/* Prepare the RX descriptor and submit it */
> -	desc = k1_spi_dma_prep(drv_data, transfer, false);
> -	if (!desc)
> +	/* Prepare the RX descriptor */
> +	rxdesc = k1_spi_dma_prep(drv_data, transfer, false);
> +	if (!rxdesc)
>   		goto fallback;
>   
>   	/* When RX is complete we also know TX has completed */
> -	desc->callback = k1_spi_dma_callback;
> -	desc->callback_param = drv_data;
> +	rxdesc->callback = k1_spi_dma_callback;
> +	rxdesc->callback_param = drv_data;
>   
> -	dmaengine_submit(desc);
> +	dmaengine_submit(txdesc);
> +	dmaengine_submit(rxdesc);
>   
>   	val = readl(drv_data->base + SSP_TOP_CTRL);
>   	val |= TOP_TRAIL;		/* Trailing bytes handled by DMA */

