Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742928;
	b=NLbEM/jJCHw9xyJ9GvmCvOPAJwgVb0KW3aR7qFFZdSsGXP9CphhQIywTaSEDZpGFXxC4
	 0Z5zPFPpxW2a3jXPipgcxHGN9HEfQy8rf7wxk2+j+FqMlAN/J/7YWnVZLCRGoR6+XCHYA
	 j0KdpW+aX1t4jNiAzVlRGch9wykVKIuyoSYdkqRHpvYM3jFXmKTSokfQVHVHkrUaZIPv4
	 XDNjqBcJjgQS+LTelEccNIZg+h/kCaMnYKN1L8JIxgF7zAnN2UEAKQncZPDAjj4EpLGl/
	 5ZAAiwzPYA5WOiAMr6s0Vhz3vvl8i6pJb23UXQbvK2t5MI+xcStkPRYkG/NMQVHoH4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742928;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mIUR5ntttE9fwFh/8Lo0ajKHgNXRqQ8nKqInF8hk5mY=;
	b=n/7fxflkS+v3pYTRK9u/zOrVL/+IeMV+lAt0IIgpqTs0S5YdmbdyzJ2XmcJRxmQrw4Zc
	 yZ3448mMYzRZYeNORACfbNnSjTbhfZBdx/+K3avjAbKEhKdwAh1L2fBkVkQU6+VGZLCUo
	 4UUNDOLxXoYqd45cOYmRoz6nnpi2EEEZEGMu14Jh4cl7MgPCsVOHCpefny0y9ChefBfMg
	 bjPlHZqM0/32dZiiTDUNekmPw77paxY+O4j0Q/oD9Z5MGCAIfQpsCHCCXCDIzeHfgFwaf
	 cgJ/lKG/NRdyNw9wXKFqEZKSVYRYlfL/PxDhvX3SR6Z5eeYihl+hecEsfor48ug7l0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJuxrC22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A4606A31E;
	Fri, 27 Nov 2026 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJuxrC22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71DC1F00893;
	Fri, 27 Nov 2026 01:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795742927;
	bh=mIUR5ntttE9fwFh/8Lo0ajKHgNXRqQ8nKqInF8hk5mY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=iJuxrC22yvOvXpmfp0jHkY/240TJy7mBRXrdccwNanQ2X5I3UxEOSLK6ROTQ+Puvg
	 msr6R0jq50c5UVop8Swe1yJc2ORleebLU7IAYmLsZozeix8Q7tUcw00LLyhPsdn6/v
	 kO4YfO4oi1ZsYj8ErkvGp54AvtL9nBdQmJSVckUr5ssQVxIn2apDCGJSkxBNr6fMm8
	 im9SGKT1hZb0AM8a6Bh6NEeUDPacjcEE5teW+lKhSi+pYJ2A07kWuIr8XCU13y8A4R
	 mcX5s2esM0U0UWPWAy2G0XZmqQGyorqqaz8QiqE/Vpjnozy5CNOIz5TfDUL5awOyQU
	 o83P39zkWNQuQ==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 6/7] spi: cadence-xspi: Rework resource discovery
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
 Tanmay Jagdale <tanmay@marvell.com>, Jisheng Zhang <jszhang@kernel.org>, 
 George Cherian <gcherian@marvell.com>, 
 Witold Sadowski <wsadowski@marvell.com>
In-Reply-To: <20261120115925.173568-7-paul.cercueil@bootlin.com>
References: <20261120115925.173568-1-paul.cercueil@bootlin.com>
 <20261120115925.173568-7-paul.cercueil@bootlin.com>
Date: Fri, 27 Nov 2026 01:28:41 +0000
Message-Id: <179574292141.838304.9533014529156283849.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jJCPUyCZdKpv2ZkbTcksOLnmoUQRf86RdFAkE8AdC0U=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI57pze+mARy/N2n23SGsr8sRnXGOuX/NOQk7i0fj5D4
 qq5/RUvO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRCgFGhgtlNiIdRr9l119N
 FE05zVa34klokFzbpprqNdeqA7ZqJDD8U2K8mPxwoouM4z+1C0fzMyW5FQMfJlcLu7ROsnGtutD
 CAAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The previous code worked, but calling
> devm_platform_ioremap_resource_byname() on ACPI where resources aren't
> named causes warnings to be printed, one per call:
> 
> cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)
> cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)
> cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)
> cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)

>  #ifdef CONFIG_64BIT
>  	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
> -		cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
> +		if (!res)
> +			res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +
> +		cdns_xspi->xferbase = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(cdns_xspi->xferbase)) {
> -			cdns_xspi->xferbase = devm_platform_ioremap_resource(pdev, 3);
> -			if (IS_ERR(cdns_xspi->xferbase)) {
> -				dev_info(dev, "XFER register base not found, set it\n");
> -				// For compatibility with older firmware
> -				cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
> -			}
> +			dev_info(dev, "XFER register base not found, set it\n");
> +			// For compatibility with older firmware
> +			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;

Shouldn't we go directly here if res is NULL instead of trying to do the
ioremap, otherwise we'll continue to get errors?  OTOH if we *do* have
the resource then we know we're supposed to use it instead of the legacy
one so we should propagate the error instead of guessing.

-- 
Mark Brown <broonie@kernel.org>
