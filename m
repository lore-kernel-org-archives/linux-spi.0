Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B931D371
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020101; cv=none; b=r9y60NbSYGdc4IoxwIafdLq4d/Zd6nY+AWcfcroQlKnRigxCZspQMqERDkHV4sQMBUP+1PEmjRah0ur8NoA+9UIayOYTkQkkyrRuKJayQTLuSm6Mvg/MVRJk8YYVzzdqln+cAJ7GVuVj3R2xPxtwTjLxHmiUR5g/3OIu6Rz4wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020101; c=relaxed/simple;
	bh=zQza1Xg8RBsnj0IuqT57EsfPaMAU6cUEJEIDvGMIFkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnwbrccxHAvYQXXXikZ4U1qR4x2QcC29Txixe5CyrQqTBcdjHNE+g5FulJregwkgx+3pX3zDhwISkOpFnskepHiLGarvshXvIzxFIbF4aB5m2bSra7wr/V++RD47j07qNBzYiN9zExpORAAVkpN+/FgtA+BNv+RcF6bjHkAmEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGhk7FCX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGhk7FCX"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso5685935a12.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784020098; x=1784624898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/JiP8CsMcVH4hpg9SLgieURGpmT0s4u6q1KF2+2zqAo=;
        b=OGhk7FCXhQNWYoaBhxkuLJfARuet8OtNdke6uw4oTQKcvk92ZjqPHFe7busqIfOXLE
         LmdtzQFl1m2PTB7sKRZSz6Xw8mahWVXJ2VGqyUj5baw14+lcueQpdwONcItwRk6R+sZI
         a98+hs7X57gKYY1wae26SJuL20B50IagktsAL9YVMyextBFI0AfXal74yQZ9k5ue3UdC
         ny+tAAkAuqRkSpxAkXXh2n52mt9dogdM5okSRgmesRcFAYrEJ90QjIorhHSiMgtabLxA
         HiMff2lBFzej9B9y+FED3rLeEmR5bYm5Me21c1lz1XlijFOVvto7jRn1RaNPkAc58T7c
         wfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020098; x=1784624898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/JiP8CsMcVH4hpg9SLgieURGpmT0s4u6q1KF2+2zqAo=;
        b=BvUsodoaUf1+wF+kS9D0H0LE9ty5+tBgIkMTCb7dwlB0eYmT5ASQu/OfejMVxmRAfb
         YpXsi3KTrMa45GDwJWfB5i8/Hs/qcAyXJVKczZrAZOLvwdYv2WP9Ab5NdEDx9gisjzn0
         EpPJCRFb456nUXz626aQgvfr9a2FhVPj6odQuzaZ67iJBQK6XWqotcw46jEo/cz10PkC
         G8K1pga6Tc2DHFLOs4Xzlfo1c2A6y2ZWHmTElmhSiYdb2oJSI+hmJAGbYYi4/I46Ttij
         Jc1Ems7Ow9tUK7fwu4c5erM1U6lOulKYRIh1yYto6IddjmRwr2XxASSrBkganG+9aLJH
         JnBQ==
X-Gm-Message-State: AOJu0YxQszrebVOj5nIJNY0bpEO43fiyQHOET/zck7tP69gsxtAHUoGM
	mFkWy23Hq+QvUShF/Zft1KPJPH+8QioZRQFU1o6SgukoJI8yCaKc6RN5
X-Gm-Gg: AfdE7clzRXAq4dWUEVfY6O6oc94upEQ1q+vlkc96ElleGJEp7Ce1TQ4ezTs9I+1ncxE
	HyCndEeOAKsd6C+G6QvLCiN1F2TkdbTqnXPKqU/7G8k3fIZrRKQlj7v3duSmd3GftnZvslcilP1
	e8yBghALgQVFmDYa8+1jiZaiV0PkPJDSNdyqVlAuceS9/LqBLPCx7T2Mr5t9THiU2gwG7WZJ1Cs
	b/t64cYriPTQQU0Uqm6SCL0pAabLM0SpkvQO1h8djg30m0MrehJifu/KUbwfXcJUHLIgYyumTSs
	gV3E2s637zluINQZElirs+M7FqFapHAy542XaT6vwhYSTFH+7uhMXa3GCjYMATjblgE6bgGQeAh
	djqfMyjPbJG1syaGl+tF72mYJXHFuFR4Z4w5bqeMcAJtEoPndmZj9dus5e0H0JKWrQdPQaPAg+w
	0Di4pJssKDjTnIZOaPaeefJAf12jM=
X-Received: by 2002:a05:6402:42ca:b0:698:3b7c:7e2c with SMTP id 4fb4d7f45d1cf-69c5f22d257mr6190012a12.36.1784020097536;
        Tue, 14 Jul 2026 02:08:17 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2877da7sm1079137a12.5.2026.07.14.02.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:08:17 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:08:14 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, michael.hennerich@analog.com, 
	broonie@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, 
	andy@kernel.org
Subject: Re: [PATCH 1/6] spi: support simultaneous assertion of multiple CS
Message-ID: <f3w4tnfzrboc6r6vlnkzronq7lswdc6lmgf3xhj4jp6mdfeajd@lr4cq6746jq5>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <4a18b2d08916aebb3f8ac01d3c57679caf0e8caf.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a18b2d08916aebb3f8ac01d3c57679caf0e8caf.1783729282.git.Jonathan.Santos@analog.com>

On Tue, Jul 14, 2026 at 02:55:48AM -0300, Jonathan Santos wrote:
> Some SPI controllers allow multiple CS lines to be toggled at the same
> time. The existing code always used CS index 0 when tracking the last
> active CS in spi_set_cs(), and unconditionally set cs_index_mask to
> BIT(0) when parsing DT, both forcing the single CS usage.
> 
> Modify spi_set_cs() to iterate last_cs[] using each logical CS index
> instead of always reading index 0. Modify of_spi_parse_dt() to build
> cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
> so the controller correctly identifies which CS lines belong to a device
> when asserting them simultaneously.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

LGTM,

Acked-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/spi/spi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index d9e6b4b87c89..55fb96fea243 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1090,7 +1090,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  	spi->controller->last_cs_index_mask = spi->cs_index_mask;
>  	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
>  		if (enable && idx < spi->num_chipselect)
> -			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
> +			spi->controller->last_cs[idx] = spi_get_chipselect(spi, idx);
>  		else
>  			spi->controller->last_cs[idx] = SPI_INVALID_CS;
>  	}
> @@ -2594,10 +2594,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		spi_set_chipselect(spi, idx, cs[idx]);
>  
>  	/*
> -	 * By default spi->chip_select[0] will hold the physical CS number,
> -	 * so set bit 0 in spi->cs_index_mask.
> +	 * Set cs_index_mask to indicate which logical CS indices are active.
> +	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
>  	 */
> -	spi->cs_index_mask = BIT(0);
> +	for (idx = 0; idx < rc; idx++)
> +		spi->cs_index_mask |= BIT(idx);
>  
>  	/* Device speed */
>  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> -- 
> 2.34.1
> 
