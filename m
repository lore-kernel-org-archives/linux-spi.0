Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058887;
	b=iMekVB7zO+LQ6UnHYYADX+zCPatf8DS9VyQkZYEC3+ZGejua81FsjWZZwws+LM8oI8SG
	 /GliM3agUvgjhqS+TffYOsIeLe6CyqSbJi2htMMu+r/CQJ5z5q7QsceSMexDf0ZgIh9xH
	 l0fD7TvNFx+ZbHCHnb6Knp6DSudH6TSciKMvn9CivkoI0J6D4xft4dqvkuJrbGDHIGO73
	 4I6Ne/qMapkqFofCvkYiv9q4Zgv8X0Df2Mo97R2IHWPf7Yl+5YG0FnCy8oV2wOD2olgVj
	 fqbG5TeO4bbEdF2ZvSnjoc3OkNsttdJEp1H7nBACNG9RU1L9NnVgJytqiFgJrkBRkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058887;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sxlRFymConWQJ/LilUMf3Ms8/xKFLsDClNm0h78DigA=;
	b=5RSgwzN8cLTGrV3mTXYmgF+XLdQCzHerfpFaap7U4DLoBqAnb9oypCC9lnw5T2PxDYSO
	 kU1j8GNk5uiLi43/ZbY0TaygcZpzM1Vy7X7TWg20d89ZJhqX5Op2544xmuqx6qbM9W06g
	 Zkz4UMH2stslg9mddiU7giRSL6olNylJAlr9z5eDQcU94xb21/dffs9EDHivI/DPCFzIK
	 Rc0rdIoI4gpEUdZ5mG5aJPibCLnnyWgfdXH/gnyKb0DdEypyi6oawKP5c+4EI1yGmjfEr
	 iU599NBTGK0l9T0YkJgttT1Y2xA1MG2rRG10xbzyQoktMXUcRXtVaYRlXrPYZsincCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWUoIAFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F8606D802;
	Sat,  7 Nov 2026 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWUoIAFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5831F008A3;
	Sat,  7 Nov 2026 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058886;
	bh=sxlRFymConWQJ/LilUMf3Ms8/xKFLsDClNm0h78DigA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWUoIAFd83ogdJ8oEKd/6J+7fQzXiMs95c+BmcnUnP5Y0KwMj7N0KhrwhZ5PP03Tz
	 YSbOJIr1HvgrF11s74sVgaxjtjglWGXwSeHpvAmgtGVPE5GIyXg72mBldz1mRv1xcG
	 GoBNIe2i6bgJ8GIykE+Ni1rpTbOCtTYbXV4hFOVlpORWvplkIA5ixjek1YXxAJk+C7
	 MO4iBuxYoEF6GofN+P4C64tY/oBdL7rtTzobgwXTEe+4ZBTip0YP5Sk0/kGEA432lV
	 Ivl+ilQwJYfGMMHJwbN5h//9FJ0PnKdCdQ/QXhVZUMmz/1h+KjT3RPIkWRIrbrw80y
	 mjiCZ8Q7coMOg==
Date: Sat, 7 Nov 2026 21:21:13 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH 5/5] spi: cadence-xspi: Add workaround for old Marvell
 firmwares
Message-ID: <au8lyXiMUSvcdPWx@xhacker>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
 <20261104100643.162694-6-paul.cercueil@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104100643.162694-6-paul.cercueil@bootlin.com>

On Wed, Nov 04, 2026 at 11:06:43AM +0100, Paul Cercueil wrote:
> From: Tanmay Jagdale <tanmay@marvell.com>
> 
> Older firmwares from Marvell used the cdns,xspi-nor compatible string
> for the Marvell-specific xSPI IP, which is incompatible.
> 
> Add a workaround to support this by assuming that if the "xfer" resource
> is found, it means that a Marvell IP is used.
> S> 
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
> ---
>  drivers/spi/spi-cadence-xspi.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
> index 48a109f3fcdb..d326589a6ca3 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -1301,11 +1301,21 @@ static int cdns_xspi_probe(struct platform_device *pdev)
>  	}
>  
>  #ifdef CONFIG_64BIT
> -	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
> -		if (!res)
> -			res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
> +	if (!res)
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);

This moves the mrvl specific code to all users, so I believe this
needs dt-binding update.

From another side, this assumes other users doesn't have 4th resource
but what about if they have? they will get "Marvell-specific xfer
resource passed, but ..." warning below, this confuse the users.
I don't think this workaround can be added to all users.

Lastly, does the "firmware" mean dtb? But per my grep, I didn't
find any mrvl dts(i) uses "cdns,xspi-nor" compatible string, so
this means the dtb is outside upstream, then can the firmware
be fixed instead?

> +
> +	if (res && !cdns_xspi->driver_data->mrvl_hw_overlay) {
> +		/*
> +		 * Handle old Marvell firmwares using the cdns,xspi-nor string
> +		 * instead of the marvell,cn10-xspi-nor string.
> +		 */
> +		dev_warn(dev, "Marvell-specific xfer resource passed, but using the cdns,xspi-nor compatible string. Please fix firmware!\n");
>  
> +		cdns_xspi->driver_data = &marvell_driver_data;
> +	}
> +
> +	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
>  		cdns_xspi->xferbase = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(cdns_xspi->xferbase)) {
>  			dev_info(dev, "XFER register base not found, set it\n");
> -- 
> 2.47.3
> 
