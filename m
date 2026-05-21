Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73548296BC1;
	Thu, 21 May 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349162; cv=none; b=pi/PG6+tGijQ3eeNMmS0WBA5ZJEiTmD5dI8tE37bTMT70leLEU2VSK7MzjcRGKUi5anmU/dKr8IluLPf5WnHZXJVsmaJA+cO10Zx0S//x31EPEl0NGztlHU82QwX86nfoonfw16xhAks+PhLMNE/ziGWEATr3nY2eQBhdp7CxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349162; c=relaxed/simple;
	bh=17bU1lBLOi8AKQDNXtASw5a7wGGEosPhNWApuCmr2k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9ieqZly4edldUq4W/fV7A8jnVY7W+ub5VTWpBn+l9/mvTH2TbZ7iqlfkyKZABRTBrfkR/Ya4jCvvuK3cT/B1r8nnYSUgslmJYVcKo2RVNIsZAQLFhU6nbCtJ9UC3ardqlcKnGxOKDwhQFRudS2rmbI8OkXfStjtwBCX7dm0oD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwuvkU48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwuvkU48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274011F000E9;
	Thu, 21 May 2026 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779349157;
	bh=yP5/+w0dxYLW6BfNfnnvg+NVMgxrKNjH7qmtgDCEO2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dwuvkU48fl9j03rjoSYzwVhlfiZwJ1wJ8yG0fZo7dH6f2cmp9sFe8Uc8NBplynKRj
	 joK3g3LUJtZkeWAA/+SxKPPr3UxH28YGo1arawLEOZ83uHE4T5P77WWQG+wDsAJdMM
	 bYM3ATYYBHYLMM8crblwMMF16QwqTD0qE6yh/Y71mSZ6GKkkTXEkyzD3OE1zJ12P/n
	 GqQyT7DGs/Td+1+iNgj0UAFa2e2vn/Whf9uTx3tbZ7pG+p9ArpLDPm96HM8VgO1JFe
	 2OtQuIMdT5nfWRvXNE5wnkvYocsKZq5J99OdIOB4b3XR1MaZsnepX/Z+C6lhHUEMSn
	 Ao5fJGFylSWIQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wPxzv-00000003DSj-01TH;
	Thu, 21 May 2026 09:39:15 +0200
Date: Thu, 21 May 2026 09:39:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>, linux-media@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fix controller registration API inconsistency
Message-ID: <ag62oyX6ySknD6iV@hovoldconsulting.com>
References: <20260512140131.998680-1-johan@kernel.org>
 <3016d236-ed02-4998-b1d7-c50a6fa2a7a4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j1dX5TLfdxexzhGu"
Content-Disposition: inline
In-Reply-To: <3016d236-ed02-4998-b1d7-c50a6fa2a7a4@sirena.org.uk>


--j1dX5TLfdxexzhGu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 02:38:51PM +0100, Mark Brown wrote:
> On Tue, May 12, 2026 at 04:01:31PM +0200, Johan Hovold wrote:
>=20
> > With most drivers converted to use managed allocation in preparation for
> > fixing the API, the remaining 16 drivers can be converted in one
> > tree-wide change. Ten of those drivers use the bitbang interface and can
> > be converted by simply removing the extra reference already taken by
> > spi_bitbang_start(). [4]
>=20
> > Fix the API inconsistency by no longer dropping a reference when
> > deregistering non-devres allocated controllers.
>=20
> > - *
> > - * On success, this routine will take a reference to the controller. T=
he caller
> > - * is responsible for calling spi_bitbang_stop() to decrement the refe=
rence and
> > - * spi_controller_put() as counterpart of spi_alloc_host() to prevent =
a memory
> > - * leak.
> >   */
>=20
> The xilinx and xtensa-xtfpga drivers use devm_spi_alloc_host() and
> spi_bitbang_start() but still call spi_controller_put() in their remove
> paths.

Thanks for catching that. I've just posted a v2 here:

	https://lore.kernel.org/r/20260521073816.766596-1-johan@kernel.org

Johan

--j1dX5TLfdxexzhGu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCag62nxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQinYQEA/X9+NIfrSBmeqnd57BXK
sHq6tHF1F78GomLD68OPwEUA/34qMWa7NrGAS+IQoUqq68G4Q4keJGnP5w+MVIOx
NpgK
=B0YE
-----END PGP SIGNATURE-----

--j1dX5TLfdxexzhGu--
