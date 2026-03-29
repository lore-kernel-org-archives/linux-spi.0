Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABC2EF66B
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794318; cv=none; b=tvWu8999SPI7eTYQ/dbEcyF04WpZoLcLvdYcsQLHurtHP4Ao8dM5tHsfMyKVri/vZ2rpKR2rVk4PwwnNKR7fyticPujFoBY8smm1Z2wZOxZsuCRFrdcgvBEaOX/ouBM7+/QVIM4PXejRiIzZyLWPa11ansWnlFAmaFFbJOHnzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794318; c=relaxed/simple;
	bh=k0MR+sEg7BG98cHvppZlvtZ+mvBFLKhJ9cJteQsw1cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlElLzsvMv+eoA4aQF7XoJtCkC+X9tBKSTJlBY6dFug0pJJKtTnLZPvjAGezannOYB9+DrRFmK3OBbKeOyVQ6LHXjc4kbdHvOCuntrfVUREtRXPvz61SnLeRR7uVhvYP4a7Q3JPyTUUZjeFS5J7DaK6eQ1Cr3ecGEjobYj56k/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otYB9V4B; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otYB9V4B"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c15849aa2cso3765143eec.0
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774794316; x=1775399116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7jZAm3dfhoBdqrOFQ8/Yd7Si3TepRvXWt/kcVJ4rT8=;
        b=otYB9V4Bpus1+9+Dc3ghJnUXQfMyf1YqQn7KNkj4u55wgUEM1zEhFV+HKBYd2LVppT
         zFDzJ9K5JesdPJ7x+LxMGH6NZxkB/Bk6zJ01xboXZoqfZHhbgkPPKJoJIzBmNBba6q3f
         PMdwcC5dc0vVmJBRkDdL2Ab3kiRvSx0RlnMA5PBdLr6C0hg2c47lKanNSAVYKIJq/3zj
         P2echT29rN7trYoRvb9bihz/ZmKQ2iokVH/D/u5FN6h6WK7k8AsM5jM48XoR4+6G1qGV
         EunX32H5qJO1SmVbR3OYewJAb/p8WQRABKveoM1FpjohEa1+rubHr5Vwbas8ptXcriMm
         E5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774794316; x=1775399116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7jZAm3dfhoBdqrOFQ8/Yd7Si3TepRvXWt/kcVJ4rT8=;
        b=L0aw6Jgfv8B+wv73Q0ww8yzF5ovXyBmmpp8+10KXDk7QbShNYV7haA9xgYbI0dBPL0
         /mhIfvqhed9vzEVzrsRGnNXF9MWZ7GFlaA+adBjSc52loYqD+gXFNBo9h9sS3hiJO96d
         f3JqAbFzl01SuwrdJuQvYkb1sbJ+Llsld8uVctHbLi8tkTchTCGCLi3e+c4NsUZeUJ89
         sYaXMtW45PD6nonruCimuovZu9COkmRSPq68xwx5N/ETP0FTCG/qI72snaNEEgyoiCv4
         EF+jj2fm+Z8rsPawiwX0Duwm21AQH7impd6NPunXMy9uW4/jxcwyO4p9qulKTaVkBaEI
         pdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEiBLn7HPy159LD5KpeBQCOC6z6sjKhs3ociItYUnEh+bAubL9/MA2GnrrhaWg+KWqtvWqEkYZRBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+2wmPuzlUHXpBhmnzN6UQ37wJfJRwe7D29Mckgl1wuhHrh0J
	SySMWEG7p59sniYcqjpsGbDgPAn57uCjlIiAlYXL71rELg0jYyrAOmGo
X-Gm-Gg: ATEYQzyxsJ6OckQr4PNv1yUvChnAP8HJTiULbNo1wyi11714uFeSt9gvXRIDczuNiov
	WJsOiNDLcRqRo2DJMc3hRwLeEH+653RXiAa+abbuPi5/e69K3IP0HzTuS0RH2h4UAMK/nQHS+DW
	IExMhyOH5sQh0Wfc3LoCmFFjFGRvn8Lj/Yzr1Wfb5D5SmRusWBOKPAt6Z+1febiMuU4JXH7SQof
	eoq5EiyVthOYmq50BXnPpxK+xr4WWhC265vqCSzbuKDiw9AZ51n/YUABHSpa/N3t9IDDh8o1fEw
	LxVImX/T/GM0wUQIJ8QAsmtFjX/R4MxIKkPxqbab6eOYERL9SrplgPebSgZ3RLdMiZU3ez9mAT9
	MW+t8jgrpYt3H7hAuw7At7F2CJycpv/YgXaaDRjMfLd9ERqmyhY7jto9AqEPmEXv22czzDDbcho
	ghoaltH3ypaaPkfDs+IXx1NlitGDmn2Lw=
X-Received: by 2002:a05:7300:d705:b0:2be:2acf:4098 with SMTP id 5a478bee46e88-2c185e7fb82mr4580049eec.31.1774794315783;
        Sun, 29 Mar 2026 07:25:15 -0700 (PDT)
Received: from localhost ([2804:30c:979:9b00:9cc3:5a7a:e884:2060])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c796d895sm4457793eec.28.2026.03.29.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:25:14 -0700 (PDT)
Date: Sun, 29 Mar 2026 11:25:56 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: charles-antoine.couret@mind.be
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] spi: add SPI_MOSI_IDLE_LOW support from device
 tree
Message-ID: <ack2dPiLpO0uE2VE@debian-BULLSEYE-live-builder-AMD64>
References: <20260329125725.2984756-1-charles-antoine.couret@mind.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329125725.2984756-1-charles-antoine.couret@mind.be>

Hello Charles-Antoine,

On 03/29, charles-antoine.couret@mind.be wrote:
> From: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> 
> This flag was introduced but was not added as device tree property which is
> limiting the possibility to use this flag on real devices.

I'm not seeing why a device tree property is needed for SPI idle modes. For
idling high, the configuration is requested through spi_setup(). It should
work in similar way for idling low. See spi-summary.rst. If believe a dt
property is needed despite the spi_setup() interface, can you elaborate on why?

> 
> This flag can be configured as done for other flags.
> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> ---
>  drivers/spi/spi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9b1125556d29..489a64e20305 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2363,6 +2363,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		spi->mode |= SPI_LSB_FIRST;
>  	if (of_property_read_bool(nc, "spi-cs-high"))
>  		spi->mode |= SPI_CS_HIGH;
> +	if (of_property_read_bool(nc, "spi-mosi-idle-low"))
> +		spi->mode |= SPI_MOSI_IDLE_LOW;
>  
>  	/* Device DUAL/QUAD mode */
>  
> -- 
> 2.53.0
> 
> 

With best regards,
Marcelo
