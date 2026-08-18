Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D32EEE9E
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080738; cv=none; b=octSM9iorjdElUsV4yyPYBRxdYKHjhNyOTcMGpNKQUd9ImnmX5cI1eRTOefj/Ks9d5P0GTMYhtZ/xDXnlRxgXbkuabdJqxx7vQegpLbwGOif6QM4Nvof0UH1juf3OEvvgIUBeOccoaGoc5kqI4HmC9WG/CzC4Mil53GvaSzIeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080738; c=relaxed/simple;
	bh=jqQd5F59tbTAPgnUyV/sjeBrYDu7tTQ+iPtobeC9hZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGnkQupgx2WLBWynFTPiMMjQ3p2PwalGjaoA8lkR/6UThFJxu0fmgdVsezS+4L5lDXGyxOdUKvOtXJP/ZOtEjXcDvJYlztg+Kj8G/+o2igKBUXdvHzNqQ//Xdq14S4cIKdjKxtHi0Gbr5/AjTduYkz/uk7Ej2SwD0g+7xr40m9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/em6jrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/em6jrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18861F00A3A;
	Tue, 18 Aug 2026 19:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080737;
	bh=43OiqDOcPxgFoPF8NKokfs0ZrXLrrHfYSjEg4EDrunI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O/em6jrKSUTxzS6i2+Hj9sEwNgWTj7ht7E3tsUEKIHt2iMfsHWK/cgJZHTFetQgr7
	 D5QWoagG3aAPO3T64ikoAZf6jpCG2Ys6Mg78cTn58Qd0eTfOi7ZBuYe0SfwaHrM+iS
	 qdORk4oD0SMLtrgwTQK6HLCQMTaRN1lVl9ONrShvAPYPJ2FmDXc8NiYz7gh9MdiOMd
	 wyYr05Le3RvcBb72A62gzPmOuR2JkmRhsVGrU+a6/bv2jAP3V+1bnVW4U/ZqmBLfIf
	 DHQMGupmatN0O35q1Xmx3BJ0oEjGEws4CxSNpWfS3lXdhIH91WgyiecztxkQFJrb9m
	 /Afs6KB34wAEg==
Date: Tue, 18 Aug 2026 20:18:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: zhuyinbo@loongson.cn, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: loongson: pm: add .freeze .poweroff .thaw .restore
Message-ID: <9b51a60a-a608-4ab4-aba8-63cc95dee8b5@sirena.org.uk>
References: <20260818104241.850042-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hYr/Aw57QF1g2cE4"
Content-Disposition: inline
In-Reply-To: <20260818104241.850042-1-lijun01@kylinos.cn>
X-Cookie: Smile!  You're on Candid Camera.


--hYr/Aw57QF1g2cE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2026 at 06:42:41PM +0800, Li Jun wrote:

>  const struct dev_pm_ops loongson_spi_dev_pm_ops = {
>  	.suspend = loongson_spi_suspend,
> +	.freeze = loongson_spi_suspend,
> +	.poweroff = loongson_spi_suspend,
>  	.resume = loongson_spi_resume,
> +	.thaw = loongson_spi_resume,
> +	.restore = loongson_spi_resume,
>  };
>  EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops, "SPI_LOONGSON_CORE");

This could be done using SIMPLE_DEV_PM_OPS().

--hYr/Aw57QF1g2cE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqEsB0ACgkQJNaLcl1U
h9B1Ygf+J9HoM+bijPSjx2essCAGbeff+qtkbUbjK7+4CMRpIYl7hpO2/leLNzTC
CxvN5TshSlsGwZnl1qG7YM2cZZmkTr/TTdUDt2Rupav7I2/DxWJ7DqWrofIw5glI
Qu1c53E+vOCMi5NIX67BjYh8yhC2GehpeHfM/mO3hoFCNhy//svspWiA/uZcMs2T
AFhxR+wR0q1DtQxxiROoIo1vCucCZ1HqWlQLDTYgUpRYqhJITuKP2EuQPxzOp2Sb
vmhPu5ZxTzZVV84OAA1IK6UQCtrI9lKS2jj5OcQ3Njw4bDAvqrWPrpQWUuiixrg8
m4FBgyynIUIuZ7VlnxEoojQKbgailg==
=3s5P
-----END PGP SIGNATURE-----

--hYr/Aw57QF1g2cE4--
