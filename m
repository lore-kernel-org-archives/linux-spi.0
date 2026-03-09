Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573123A63EC;
	Mon,  9 Mar 2026 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059380; cv=none; b=aeqiQeru7ETubv7K+LwgD/Toj9ZcDcbKhsDrnJ2x83AJHssiqNcTsNcyskGS9+Mvale/EP1QNXulY3EseH9AUuHLhyNn0kcHTpgBr5yJ2obkKzwNI6+rb+CjVVBHnxTerdehZ5/HRfJlc3Ebl9/qBsHfegqCjCYQvkrM9tDL3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059380; c=relaxed/simple;
	bh=sdACc/Vbt9m0Tf3WatUwZZmOXL5NI62/15tUJ8fQl8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxBoMIJBZNSWYGB+eFbwcwANLjMsXzyOTJrM4rWQgesy7fS3o0ZUtWLxvyNW8hCn3D8vRfMoEB5Vi89432L3Le9vOSlRzvayAZJADSSgl9Ej+VnuWvIdnXUwGsWvXihHMFXjjdh35TMUoHixSO/CQd1PCrGCkouxeESi3rzos7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMDb8XsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMDb8XsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82263C4CEF7;
	Mon,  9 Mar 2026 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773059380;
	bh=sdACc/Vbt9m0Tf3WatUwZZmOXL5NI62/15tUJ8fQl8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMDb8XsIm65PkNu73oLSZoi0tfbQDim/GSj7cTRxWJMUOPPHL2GFZ1NF3os0/1jQ1
	 KSqFUuUZkKacY7gSY8VK0MpssUjeTR5dRxOs6lKincVkR/h8SSvWLSmRweSFReyqJ7
	 fgzYbHiMie8oxNTlQhPYonhvAUqG9b54NebTJb+EvL6QLlyFYxhKBRUQ4OcCfW/8+0
	 496unukW4tkQpsDz1WqSo0UavpBwMHSyI5lQlOSAYuy1hCKHWKcGN9Gj9gHa7q3CLo
	 xjbKUXlkxLsvXFmoF1KSijZ96TjG58B9jJbTLpYeM9xdXdPZy4nQQ1hEVbwnGmX7ZU
	 0uwBoAfd0PhDg==
Date: Mon, 9 Mar 2026 12:29:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Jon Lin <jon.lin@rock-chips.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip-sfc: Remove redundant
 spi_unregister_controller() call
Message-ID: <52755ab9-7387-4f4b-95d4-2bfdeedc3e5f@sirena.org.uk>
References: <20260305-sfc-v1-1-6fbf6df0e899@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AClr4NiypPa3ZHRv"
Content-Disposition: inline
In-Reply-To: <20260305-sfc-v1-1-6fbf6df0e899@gmail.com>
X-Cookie: I don't understand you anymore.


--AClr4NiypPa3ZHRv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2026 at 11:38:21PM +0800, Felix Gu wrote:

> The driver uses devm_spi_register_controller() for registration, which
> automatically unregisters the controller via devm cleanup when the
> device is removed.

> The manual call to spi_unregister_controller() in the remove() callback
> is therefore redundant and should be removed.

Not just redundant, it'll be a double free.

> -	spi_unregister_controller(host);
>  	dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
>  			 DMA_BIDIRECTIONAL);
>  	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));

This does mean that if the device is being force unregistered with
children still present those children might still be submitting SPI
requests while the DMA buffer is unmapped, but in the normal course of
affairs it's more likely that the devices will be unregistered before
the controller.  It would be best to either roll back the use of devm or
add a devm based unmap of the buffer here, the current remove function
has correct ordering.

--AClr4NiypPa3ZHRv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmuvS4ACgkQJNaLcl1U
h9Chiwf9HWSa3dh2cae/FqNy2jBr53e+UB+ij8++KuKvJ4c9nWTndSDG8yv26YUJ
U0WQ7a8K4o0lnfzzdba92bwMC0HbkvNaK37jUBWjv2jfb0VaviYe/DPIRIEaXdJ7
9Ahv5K09vfBXWvzlGmBpaDX0mI1n7agTLuDTnIOAhe0vGuCDJFyQy7O5eg3Vzazs
vC8THtwX0jIsWXId9lRQkdu5dcg6+8z5jLgdzJkg7BEsPvadhk4mgUsNeuUKc7rZ
m8ajxOr9qxHM8WAYrn7J0R50rJCl+gVQmT8m3U+NvRjCbfjuD9+uhttWdPw7mK+k
fg3ykuWMZWrzhsIQLnSr8vY+RnyLzQ==
=JX79
-----END PGP SIGNATURE-----

--AClr4NiypPa3ZHRv--
