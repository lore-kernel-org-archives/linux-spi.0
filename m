Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053323;
	b=CTWlHHvIl0vC4Bv3G2Wm3sy1UK2Fdjov9aDs2K88TNBOVQK3UOK8zQ3bBK0a1HEdPeaK
	 5HX5xSKTElRC/B6aQrAdUXeLFvSR0CXun9f6y/TvUtM0vP2Zl50L3SWvHUKNPtI5ewb8C
	 3e1tHg2lp8CBx+k7n5kpECFo4okPbE6ulh5yy5iIekVOnXlGOUYdXNZcqjjUvrx5C7ixR
	 7NUwjF92zxmFyETeT8TA++07cL83vh4LNg+XZZsesCaNaJAmc+2m3iGRICu9DWfjCCaFK
	 fqvBlkQPbGT7aRug85uzDu0+np560bQ1cwtNQ0UiSOs7oYbWyVJSS7AGa+rtHH44mhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053323;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QA1kOfxjG/MnyYsOh4wQOQBuCe/Lea0Y2f5e2X4Rzmk=;
	b=b+DRkECZQcqIMsPBOCfmJH9NkB4/oJgSVbpnwrBGcMo1YBivtbQdLZQuHkDePiI7r8jO
	 NPS/wYzrXl6DxN6yCzUItWuE5rCAXPxFTLDNtp+lD4tl+TKYcMrbmff3UscsumZ+nG2PU
	 bJ3+sEgVQS60iJasNNl/WQRpF5RE66YcPdreuGA+Yqvf2M7cNDsYP3NbqL08vrOAs0hLw
	 ojNq5zN2ITvj8IPvBEmF3TReKytLNNoOVlHw2uWfYdc+gi+tlAWMMh/yB70Hzi1+hVK9C
	 UyC7n0iIzLv53O0kHXjb1NMItVGdcdJ+H1xE0lVW6lvOgKu9yrd73e4FA7G5aLCBtVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMXQW+hc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D311606A32D;
	Sat,  7 Nov 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMXQW+hc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28541F008A1;
	Sat,  7 Nov 2026 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053323;
	bh=QA1kOfxjG/MnyYsOh4wQOQBuCe/Lea0Y2f5e2X4Rzmk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=KMXQW+hcC4cYbWwVQGF1T2EFV8oYAxfo3hWOIqL23S9khWxhi3gjT1Q9PuFqi5Rg9
	 q3d2D0qJPHUM2+fUunDUV6oUWYrO6CwdhFZVyzGn8xNiEec6KLqJ2FNF38Hyy7uNzC
	 f7shtyi+wWhYfdg+tYJu77SeLpyM2NVlMSQJkMVWwTcd3vNuv7nUrljJQ1c+jRdm75
	 lLZA9vyxPe3t/cBsnd8nyeEwaTJVcwX7LTiDn5YTxCRQp6mKqsop8N884QsU2qwsmi
	 ZByfkDsfs8Lz7a9bhy959vY4FH5RXmwStILwqdWnj03OS7pOetZ0KeTjveeA/xZLoh
	 e6I0RstXqUoFg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 608DD28F342C;
	Sat, 07 Nov 2026 12:08:39 +0000 (GMT)
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
Subject: Re: [PATCH 4/5] spi: cadence-xspi: Rework resource discovery
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
 Tanmay Jagdale <tanmay@marvell.com>
In-Reply-To: <20261104100643.162694-5-paul.cercueil@bootlin.com>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
 <20261104100643.162694-5-paul.cercueil@bootlin.com>
Date: Sat, 07 Nov 2026 12:08:34 +0000
Message-Id: <179405331442.3424803.15355811538378604772.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CtOjthHpOtpZJLqkF4Yo0UfEBke3ZgrZVUxyUESOAl8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeixy77iVwh8+SO2OCG8NijwzX3XZe8iU+Am3JJ/fcm
 tucL7K+o5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABNZvpuRYco0ha0tLDPYdObc
 P7JirtnMtf9mCuQ6a27fuXRJ64unO2QYGbbNfC91/vOvpit1cap9vWdeXw11fblE1Tf0ypuwS2m
 PH7EAAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The previous code worked, but calling
> devm_platform_ioremap_resource_byname() on ACPI where resources aren't
> named causes warnings to be printed, one per call:
> 

>  	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(cdns_xspi->sdmabase)) {
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(cdns_xspi->sdmabase))
> -			return PTR_ERR(cdns_xspi->sdmabase);
> +		dev_err(dev, "Failed to remap sdma address\n");

devm_ioremap_reource() already logs.

>  	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
> -		cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
> +		if (!res)
> +			res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> +
> +		cdns_xspi->xferbase = devm_ioremap_resource(dev, res);

This will still do the warning log if the lookups fail on Marvell.

-- 
Mark Brown <broonie@kernel.org>
