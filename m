Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F23F43BE;
	Thu, 22 Jan 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098732; cv=none; b=Sas0OWJ1VAsx/sOyhtNi9kU+2g5h55/OMWsSXSn8Rq1vMXf8YNcruCg53AYaBW9BfzrPh7EYjANfxnZJTud79Clo5BJrNE26iYYcv5en52jBvqNgZN+uH8PbOmzIzqHUvlfSw7Mnar94d267zG6fzHElxyWUxE+IPKKu2EMA76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098732; c=relaxed/simple;
	bh=DK1YYg25BI5AQFAws2BRE17ZK9T3uULXtOFjXLFKIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8W7SdZ4viA3trjFqzdhNwgLGnN7vURg4I9fExT6pmiTiFFYrJ3nJ+YCYSpzCI08W3XbTca2pxg+W7xH/dcj0KstL9tWgKzBYwjvd5m03Td+ddSXp4Lx8FeI1muAAVI/V+DAiKE87J2IZSfJVZz3237pO/uaQZIKxc1MxF9aigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YB1QiQ00; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YB1QiQ00"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fLUE8mIMTmh7qtKAc4chYUNSdEbOKjMUJH6lfYTEADA=; b=YB1QiQ00RGaI9TdOPXEV2dWZSp
	DTWvjsTCIaYVMmb+bl+HqYf9lP60HS1CG3aubFiUrulYlxZRxNDFgRerfXLT88pohYSfPEJt/oEF4
	caiVcaTLxALk/Qunc/OTCAYCLfgheLZKvapOlC8goWnE1Zg77ZkjjfTyAXp30PNS4wqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vixOD-003zvE-2A; Thu, 22 Jan 2026 17:18:33 +0100
Date: Thu, 22 Jan 2026 17:18:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: abdurrahman@nexthop.ai
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: xilinx: use device property accessors.
Message-ID: <d6c5547b-0426-40d0-85b9-b64f183d37b6@lunn.ch>
References: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>

On Thu, Jan 22, 2026 at 09:00:29AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> Switch to device property accessors.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Switch to generic device property accessors.
> 
> Changed from v3:
> 
> Removed the patches to make irq optional from the series
> 
> 2.52.0
> 
> base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
> ---
>  drivers/spi/spi-xilinx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index c86dc56f38b4..c4b70e95b695 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>  		bits_per_word = pdata->bits_per_word;
>  		force_irq = pdata->force_irq;
>  	} else {
> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> -					  &num_cs);
> -		ret = of_property_read_u32(pdev->dev.of_node,
> -					   "xlnx,num-transfer-bits",
> -					   &bits_per_word);
> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
> +					 &num_cs);
> +		ret = device_property_read_u32(&pdev->dev,
> +					       "xlnx,num-transfer-bits",
> +					       &bits_per_word);

It could be my grep foo is broken, but there does not appear to be any
users of xlnx,num-transfer-bits and xlnx,num-ss-bits. So it would be
better to just remove them. There is no point Maintaining an API
nobody uses. And it would be silly to spread that API to ACPI if
nobody it going to use it.

	Andrew
