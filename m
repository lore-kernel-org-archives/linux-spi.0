Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA334D4E2;
	Thu, 26 Mar 2026 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553119; cv=none; b=pyUfujP6+cjNNWtuymsbiLlaSDwIvG1diLhw0uWSH51W3+DxuMEvzt5CspQLDJQEfxt1ysmHDOqSmfYr8X87gL1j65ZJnfTT5kjTN2e/EsIrFLxqQiKqPesnNTF4061rXuiVoWrQFssJfuCK/cEYPHuENToteTGJdGs4QwauvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553119; c=relaxed/simple;
	bh=yufsYZ6NEr+gKLHQH7d0E7s4+Y6Mgw7ZGyXsBXZuOEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrmxAxM8qTsaSGffRg7jH+hmRNYa6avjAq9eNt2mvHk68wsrYj4YxI/tFo0lkluNdcJVIh6pFmXszpgERW7GAX0drp4PWRryQe/n34WwYiNiyRNjFUcJVJBg/ZyIQCuWnkQowfdaHCV+inUOL8ZrJCtCy+5FPYSb0l8Iu0fzWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XziT5N44; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XziT5N44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62909C116C6;
	Thu, 26 Mar 2026 19:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774553118;
	bh=yufsYZ6NEr+gKLHQH7d0E7s4+Y6Mgw7ZGyXsBXZuOEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XziT5N44OOdbFhso2aE29G0BJoMklyNhIeLkKXjRTtu9+KwEir78XSszIj0hJUudj
	 uqBiL310AL4o3LOAKgUgJclcIUMpfba+dK6ITy4c9s8tkeW1P3fjsQ8pubA7uUIJF0
	 jylHPklGJB9HEolJB3OGVGsUUYTdj1QDo2CUKMqKSUxKYxxf6e/ZnxSjBEbz3zkVh6
	 rkVu8NFAvsNJqz5cFM56Al8n43/NGZjkmgBwditBSKoMWg7eZ1iU0kBcE1C0L5K5US
	 EaIPDIYmMxPCsnYI3pIgL/SEPsRHQdxpCDGngBw9ps5X9GhyOv29kjM/yTVxYXQm+P
	 DKWfsvkA0HUsg==
Date: Thu, 26 Mar 2026 19:25:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johan Hovold <johan@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: fix use-after-free on managed registration failure
Message-ID: <e8588793-02ad-4339-bca7-fe55db697e89@sirena.org.uk>
References: <20260325145319.1132072-1-johan@kernel.org>
 <acT9-MoL5zfss8Hp@ashevche-desk.local>
 <acWGuheUdu4Bdb8S@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CV353R66yeEixrhe"
Content-Disposition: inline
In-Reply-To: <acWGuheUdu4Bdb8S@ashevche-desk.local>
X-Cookie: Here there be tygers.


--CV353R66yeEixrhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2026 at 09:19:22PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 26, 2026 at 11:35:56AM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 25, 2026 at 03:53:19PM +0100, Johan Hovold wrote:
> > > The SPI API is asymmetric and the controller is freed as part of
> > > deregistration (unless it has been allocated using
> > > devm_spi_alloc_host/target()).

...

> > > An alternative would be a partial revert of the offending commit, but
> > > it is better to handle this explicitly until the API has been fixed
> > > (e.g. see 5e844cc37a5c ("spi: Introduce device-managed SPI controller
> > > allocation")).

> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Seems Mark dropped the original change, so this is not needed.

Not intentionally?

--CV353R66yeEixrhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnFiBkACgkQJNaLcl1U
h9DC9wf8D6IdzFFFi4DudgIcUE2ONQ3G554xsNbbLHjzFedxSzjifOq9GsslAIdb
siXVD5nCe5OvQ0d6Jj8q4++1ZgmFbcs4jNM4tYyD9EGOedJPCw0s4Sa0Xjm6usmv
60Wg5TorJy+oY63U/SE9oPuqUcCPqca5SfZy+hIRReQIvo35SbTAvw3Rmof+3sEo
DiXMrZTnAgrtnYCcuHScJ1N+Zh4wP4d/YeAae3QS1fGeZiBsIKH4bOEf0Hzer2/M
dd2epuzWnIuJdQ8+6uLsc+QOTgNN+WdFQbVxWIppE992SXGvdQ7rovX9hAm0hdyE
CLmIuy7+c6B+pZLyGuwRGJ07apcftw==
=uEcw
-----END PGP SIGNATURE-----

--CV353R66yeEixrhe--
