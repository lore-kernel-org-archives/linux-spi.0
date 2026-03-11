Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420693BAD98;
	Wed, 11 Mar 2026 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232172; cv=none; b=MF7lvXO2XLjg4iVWK//wOdsw+WNf3Yo9YSGgzrUqJdjwpRg7Y6HGLMaLOCokWrJ9wW+ssZKKshaycl2lR9S+KGvPL6RwDEQf2+GnYpvqsYVxyl142Vcg+3u+4Eo9h2DmRNvpLdKqoIcqigVdK8zktbyTsSMUR6VbDSQrCUNR9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232172; c=relaxed/simple;
	bh=MgIYIl2Box2oWc5Sxfmic531MvK0GpFDwNWak6rTEvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1MGJLyO0GE08LD4oDk9xKA3LMfEduGZfVhXO8uGAkBlgmtWF+PbllPwa78+CiHjO0efoyqAurAMvIv+0KHLAxIIahyZ+TwVkjnOUTD5+6DG997tU4PfUvye3a0SQgIvXTUb0OlC3p6yUSkFawKwKVujmWIZvLZHY1vImsfF0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETXCXNEK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETXCXNEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2B6C4CEF7;
	Wed, 11 Mar 2026 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773232171;
	bh=MgIYIl2Box2oWc5Sxfmic531MvK0GpFDwNWak6rTEvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETXCXNEKQ5wzrybbyWxBv0ce3Qt3+3TjP5xEwAwrS8bUWFmfy3gYOM11NcpCmq97l
	 eJPBRDQbPqG/29A975iCRVEzztxCdrn7WEaDvO9TF/jDw7AsNarJdhIt2EiK+3pvTk
	 a2b8oZ0wqGu7x/rqYA2YtLq1uETGvScfO8wav+1k9J+Sfvo00z0GArLQEHs2XIQETy
	 kuqtUipxCW26fy6YTAQD852oBYX6koGxmwmC2YBx6p5lNiagoAAAeNQtI5Lcv7tuBX
	 QXteoa3ctinr3z+Z4wtyIbj4Lu16zzZQrWEflsigE5MvCEtBLd8kMIF5UH2+QM7F4f
	 IHBs5QCEvn1Vw==
Date: Wed, 11 Mar 2026 12:29:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: cl634@andestech.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: atcspi200: fix mutex initialization order
Message-ID: <dd58aff2-2408-4aac-b39a-bca8fe4cd64e@sirena.org.uk>
References: <cover.1773193726.git.xiaopei01@kylinos.cn>
 <f47d4c292bdff7a0bad8d316c28c83c0fda36a0c.1773193726.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vio9+FbWuPDpDTZg"
Content-Disposition: inline
In-Reply-To: <f47d4c292bdff7a0bad8d316c28c83c0fda36a0c.1773193726.git.xiaopei01@kylinos.cn>
X-Cookie: When all else fails, EAT!!!


--Vio9+FbWuPDpDTZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 09:55:14AM +0800, Pei Xiao wrote:

> @@ -551,6 +551,10 @@ static int atcspi_probe(struct platform_device *pdev)
>  	spi->dev =3D &pdev->dev;
>  	dev_set_drvdata(&pdev->dev, host);
> =20
> +	ret =3D devm_mutex_init(spi->dev, &spi->mutex_lock);
> +	if (ret)
> +		goto free_controller;
> +

This means we're now using devm to free the mutex that is in spi, but
when we pass spi into devm_spi_register_controller() we'll cause spi to
be freed before we free the mutex.  This pattern gets a bit clunky with
devm...

--Vio9+FbWuPDpDTZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmxYCcACgkQJNaLcl1U
h9AfJgf/X64IpNsFEcCA3B8/QlupaMw4r7EYNqZuxa8RbgHQzmdV6H4NStZJnUKq
ywuMSOzfiVQt3E9R0ZwimEko0rtEz6lw4mEWNYQcpMmz0wbMGkPNRfAJUpBZQ+x4
5phd63hPyyXoChe2LkVc9nH2yLsD16DiyWmsYF5om7I4zLES65SAZySbGrmjHGB3
EvwH4QLdYstIazJpdEOjiYi6QPhFxj9AoYDnYu+ESiq6ggWoVrjzaqusLL208Sfg
dzik+OSdOpqh3M164yYjzj48eGIiCPGuA2KfN9fP3hUmp9Eib5/6py0kol1D01nf
i2mt3nRdsYXXcz7u18Eaqx0ekVTzbw==
=Pflv
-----END PGP SIGNATURE-----

--Vio9+FbWuPDpDTZg--
