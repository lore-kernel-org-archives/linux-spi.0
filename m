Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F43321FF21
	for <linux-spi@vger.kernel.org>; Fri, 13 Feb 2026 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980431; cv=none; b=JoWrwhgT72YNhc/Q3wNKBvrTh38m7OSgvFPAtt342VQuL6549/XjSMhzxvMygAYtJbCAcllLgAr3X+Ef64i6QbtUAI7cCHgmn+pAJHQTKd5O7t/JEkx/SK30CRsHE+oVlNxgFesJha4EGhqJJsxYpn1rA7vC5SrfES7j9dAznes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980431; c=relaxed/simple;
	bh=T8C0kW3L8kfQ8lEZOMNDH8DIXhN49QbsDcqIXTGf1uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdbcnjmQFMWvVve49OdGdPKIJhn0sMhpzQp4zB0jTet0s7dIIqlIeEU81O7+N8MRC3DN3FR3D82Vg3hUwHXafHwM90xAlNwg39jCw0lZ3WGHTkt5Vb24XJH07Oir4P39UbTxJ+Surqr0BWmJUN0L4+8D+ymVRbnoldguVOedHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=X2g2njXx; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="X2g2njXx"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0DBD5240027
	for <linux-spi@vger.kernel.org>; Fri, 13 Feb 2026 12:00:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1770980421; bh=DkXQFRF6rnThdSPYfiSLSD241i5nICJqc3BVoN723YA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=X2g2njXx8+MMcA1akYv0HBbC7bzhH2RhKZOuCe4Y+A3rLk4Z4A3FGrb4CsD6yxekR
	 PVqW9rTvuIrYzpxlhT8cU7yVFspBhPU9o9XUSMICBnqhU4VVsWoLqZFFsPeqqBHnlm
	 6Gm0Xk7T/Nus/kc93Ih5uAqxSEy2SYBUcw6TBpymXddppHDCa30iBQEEMg+oK+JfTr
	 hvFFOGSD+1ZFAZBBg2O/e5PEqW0zjfFGQ6bKlXx8yGgacHRTOzeJxTP2V4LBdWfFkG
	 oJPPxd0hbKT5BNziMjyetQIrTti1PwSJKUkTiwmkoQ0NECNAFW2VxWm2BEBgjupSI7
	 hloV7W8ny+HFw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fC8Ml6gzsz9rxF;
	Fri, 13 Feb 2026 12:00:19 +0100 (CET)
Date: Fri, 13 Feb 2026 11:00:20 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: wpcm-fiu: Fix potential NULL pointer dereference in
 wpcm_fiu_probe()
Message-ID: <aY8EQ_7Oho-5BeM_@probook>
References: <20260212-wpcm-v1-1-5b7c4f526aac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260212-wpcm-v1-1-5b7c4f526aac@gmail.com>

On Thu, Feb 12, 2026 at 08:41:40PM +0800, Felix Gu wrote:
> platform_get_resource_byname() can return NULL, which would cause a crash
> when passed the pointer to resource_size().
> 
> Move the fiu->memory_size assignment after the error check for
> devm_ioremap_resource() to prevent the potential NULL pointer dereference.
> 
> Fixes: 9838c182471e ("spi: wpcm-fiu: Add direct map support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---

Seems reasonable.

Reviewed-by: J. Neuschäfer <j.ne@posteo.net>

Thanks!

>  drivers/spi/spi-wpcm-fiu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
> index 0e3ee5516587..0e26ff178505 100644
> --- a/drivers/spi/spi-wpcm-fiu.c
> +++ b/drivers/spi/spi-wpcm-fiu.c
> @@ -459,11 +459,11 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
>  	fiu->memory = devm_ioremap_resource(dev, res);
> -	fiu->memory_size = min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_TOTAL);
>  	if (IS_ERR(fiu->memory))
>  		return dev_err_probe(dev, PTR_ERR(fiu->memory),
>  			       "Failed to map flash memory window\n");
>  
> +	fiu->memory_size = min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_TOTAL);
>  	fiu->shm_regmap = syscon_regmap_lookup_by_phandle_optional(dev->of_node, "nuvoton,shm");
>  
>  	wpcm_fiu_hw_init(fiu);
> 
> ---
> base-commit: 9152bc8cebcb14dc16b03ec81f2377ee8ce12268
> change-id: 20260212-wpcm-d86f76761645
> 
> Best regards,
> -- 
> Felix Gu <ustc.gu@gmail.com>
> 
