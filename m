Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788903C943F;
	Tue, 10 Mar 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164384; cv=none; b=BYPlR6SjLfqKw9difXQYaWeEg7px1/SkhQ5818TkGSBrvnLm1sLLUF2Anb8TDvs9xPEclOPHXVuz2kRwrbNdZJucIxIr3sPf1yfzPac0X/mPMROqopO3EvomJJsW8BnEQzPntQZC7Lqjg4gceN6bhL6en6snBd5SH1u84gQkIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164384; c=relaxed/simple;
	bh=oSHifN4rjfWLWngOPdHD8IlkX/TGgTWveU9beYmIoOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B84lhzB00MKKfBikwO8T+krGrtl4Jm2DyFyQOJOp/3VALk7ZkuA3+wE2qvwgTVqKz9ASL75F0BUAiOAQpwfI9v5YUxCB/LCm+FmTr+z/zC4ke5T6trsS2tLA9iXMDkidMEsam8apbVUudgrUhQnfYZe95qp+j9rjLj5NMvhjas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I54GKpue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I54GKpue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B05C19423;
	Tue, 10 Mar 2026 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773164384;
	bh=oSHifN4rjfWLWngOPdHD8IlkX/TGgTWveU9beYmIoOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I54GKpueEmjP+LdXwCxzJPMLeweIWlb+fCJeYMQXSweXwNIkFb5f1ncKkcGbeIDQD
	 LMkfdJPdkBCeHfvTHzaTaDfVumEqER0l1c2+f2htHXEIrYMPWWYovLC6wFQs30H5WM
	 9b1XK9ZqyyK2GaBX2uXSWQqpPS05GTBU7R4D4+VcC1Hta3TXJPnIRjQBHmWH/xgBJs
	 Us1nCBice7ral1FXdSbwMgqjRbhCMm6PBTiZT0EutBkwl3KetrIcW9kpSco3Q4rf5e
	 lz4gZtpQLo5dtFE3KW1oJE1V9dEtKHcjARf+uholsBfMORKnUn3x0IeChW4luq3zeA
	 D5k8kc7/gsrTA==
Date: Tue, 10 Mar 2026 17:39:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: cl634@andestech.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: atcspi200: fix mutex initialization order
Message-ID: <9320992e-7caf-46dd-a0ad-7df31e48cc24@sirena.org.uk>
References: <09d5b199fa1f375b2fcdc3236ca9b2ee4a1fba77.1773136472.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9RB+mo0dDqQ0r8nt"
Content-Disposition: inline
In-Reply-To: <09d5b199fa1f375b2fcdc3236ca9b2ee4a1fba77.1773136472.git.xiaopei01@kylinos.cn>
X-Cookie: A fool and his honey are soon parted.


--9RB+mo0dDqQ0r8nt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 05:55:47PM +0800, Pei Xiao wrote:

> Move the mutex initialization to the beginning of the probe function,
> before any registration or resource allocation. Also replace the
> plain mutex_init() with devm_mutex_init() to benefit from automatic
> cleanup on driver unbind, preventing potential resource leaks.

> +++ b/drivers/spi/spi-atcspi200.c
> @@ -567,6 +567,10 @@ static int atcspi_probe(struct platform_device *pdev)
>  	spi->dev =3D &pdev->dev;
>  	dev_set_drvdata(&pdev->dev, host);
> =20
> +	ret =3D devm_mutex_init(spi->dev, &spi->mutex_lock);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D atcspi_init_resources(pdev, spi, &mem_res);
>  	if (ret)
>  		goto free_controller;

Shouldn't we be using free_controller if the mutex allocation fails too?
We'll leak the controller struct if that happens.

--9RB+mo0dDqQ0r8nt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwV1sACgkQJNaLcl1U
h9CYsQf7BdHoOtgabjJ9wrfT2uASawSwfHZ5gFvFDBRDQQwguJbyFYCKQiCdQBVj
/ttE/dzpivfaxblBYP8LinQYUTHBDPEx/SjUwDYgCIolQQfwmHqActOftlTW3siM
Uk6B1zuNV7TsevvMz2je4lUI9x1gn6vGPjm9k9RA+IfkB0vO1IB0RwG3SfuaVScm
US1qNDtm87zB1MYcQwUGN/HW9Inh54ZMVWB5UQymDFwTQZ/JHKI1LYdHMWTm1PFE
ApeIt5HP6pL5wYQF4u6JdSMgYii37CuldHadZb+16kL9wdlONWjjxAjyccZUYL3U
30VuC1+KZEzZiLqg3lEngPi3rlw+7Q==
=J4Vl
-----END PGP SIGNATURE-----

--9RB+mo0dDqQ0r8nt--
