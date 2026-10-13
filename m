Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA43A0E97;
	Tue, 13 Oct 2026 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888167; cv=none; b=jBCZBubUg/YR9rKB6u3ybpFv6mxd/iE26kIJZkOyA8wBe7aU6jo0v+27tI1fyQzypX3fJbCX/PWqM+OuWNaidsgwdZ/PjSZUyouaV80ckCbM6rzr71268UEKJzV3brWWQYTNATVYYb7elncz9frl+XFqm6+Lx4FG0TH+2DA2dHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888167; c=relaxed/simple;
	bh=rUT6K7AY5D2DVy8ivjBEMxKwOA16dGMElIUDHmpKhoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsfC4R7aEh2BsX/H0nPCl5gp32c8IBAf0wBn9rZyoEr0YlDci8PmDTeAj9veyW48Zi7EQV8BZw9TnHNQLaiej1SQlyMdiWqMVpyVAv6p1TKf3POTO6Gy+1nqmTaZ8TNfnd6dQ9iL9h1CioEDF6bhi10jQjOLLjv0plNGvV35CwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNXfKFA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNXfKFA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A621F000FF;
	Tue, 13 Oct 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888166;
	bh=FLoSrQhPeG9d2sAUZV2WghRPf9g8Vd0+KKpGYtfoJ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZNXfKFA0ehUZk2802jnLM7KmyXkqxYpf4ZkwhwrvnJOYdPqWUzBVh3OsCGtS0d/Lr
	 +tO72X2EnCthHmkKMEZiEhpgjjzT0tfaBI438ud3mNswBO7y92IBi5DyDZe7w9dpwM
	 dN145mmeBSs1TOYXa5wKT416dCZDCV4H6gOEf/N5m+ZfxWaEs6+945LYlearv6jfTB
	 aELnkmOWh1XRC1liALSQ1YOU22eM+Z5Yjflplxjj4cNfewO6koVLQ6dMsRsmccSfYb
	 23fi+MH1/VdigrjOUktQRpVBYMLyEZjhpgZ3ldrdLeaiO2LtDQVdcIkyi/PC3XQ6sn
	 HCxdoNQEIPeqA==
Date: Tue, 13 Oct 2026 11:42:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH 1/5] spi: spi-mem: Add support for panic mem writes
Message-ID: <eb16cf0a-6b7e-4ea3-89c5-61ba0729492d@sirena.org.uk>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-2-paul.cercueil@bootlin.com>
 <asdVM883VTQy7WvH@sirena.co.uk>
 <5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wVYvEWtD/Zuy0eL6"
Content-Disposition: inline
In-Reply-To: <5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
X-Cookie: Some equipment shown is optional.


--wVYvEWtD/Zuy0eL6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:25:07AM +0200, Paul Cercueil wrote:
> Le jeudi 08 octobre 2026 =E0 10:32 +0200, Mark Brown a =E9crit=A0:

> > This also needs to ensure that the queue is idle - we'll still execute
> > spi_mem_access_start() which flushes the queue, and we've got runtime PM
> > operations there which might be a bit challenging in a panic situation.

> Does it though? The kernel is panicking so the queue won't be processed a=
nymore,
> it should be fine to just ignore it.

Do the other CPUs know they're panicing yet, and what state is the
hardware in?  I'm a bit nervous about assuming panic got things into a
good state.

--wVYvEWtD/Zuy0eL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrOCyAACgkQJNaLcl1U
h9BbGwf/fEtwrUNGtObi0G+lPINw3irgjq4aUPmA1lkFzhV/7zmAOBtXjCy4/pp/
mx3qbP/STKN47G8E/m1e7qhkOOXfEVt7ckY0ZNg4zUeRMi7w7ok1gQHm49bgy+eD
7Eq/n2UBWtgSIz+CGU0+RxW1BLmz2rnHnJd08g0LlGFsHn7rxmBBQOJ8nnIUqirj
2B019P3McvROJvYBGgWY9jHdqAQbiro5QE1qBVKZMYjXNTonO/9RrFvVATDOi+CK
m/TKGKWt3ynbkpCSrBBN3dwc7W1s7Mk/q3gPdXJymZXsOJOT0Zlrv1ByjTX1hwMw
sbsRiuv17q4Iae/oAdeCliHjjOmOJQ==
=RxOc
-----END PGP SIGNATURE-----

--wVYvEWtD/Zuy0eL6--
