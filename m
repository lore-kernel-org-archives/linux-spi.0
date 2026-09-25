Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605654E1C79;
	Fri, 25 Sep 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354320; cv=none; b=N734PlauZH6OfoWyo3hgnj37nFI4tOBEwoKjwcxOsV0f8loaaA4dFSjgH5384S1I8UDqax4LVM5qk+PpOWtiraoIqAzGRYVUxDzl1YJDJ5cqrZM+tMdlieRwgyJXg6b68CnBzT7Vp377/OSbigb4QKnxIlwJVqGS/daU4RjHSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354320; c=relaxed/simple;
	bh=A4f+YsMNxXeMMTF0Pbspf8rDOD3A57LymApkJs7cEAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdwEjxDYYkNQTmgkyHM2WVMPqbCyYmK1rienj+zYikHU/axJ/5U5Vsrd3RGROfXCqMsv+YwkwHJRGEB7bE2KCO/eDHKzzmpyj5fuNF4Tnv6DL1Vtg6Z6Dsy8LxPIH411UMnoIi9j/q40CLNzDwocsUEcakG66nDjE+x93ncFKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFBmO2pT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFBmO2pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FA11F000FF;
	Fri, 25 Sep 2026 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354311;
	bh=+3ptMQHZioL0GyGzjw8mYJksnNJNd1gNgEW48A3+JCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OFBmO2pTQ9pyN6XN3mtT8SxQxFQw6RGKcjpfM7vn0X57HYAyB0zuHFlfdmi1vbHYb
	 Z0Sa98UKxpt43/kf1PbTnOFjo3YcS8L8dQgY5rJTBEqC9VP3OEoOAav1nwFFxMG9uB
	 gZUYbU96vzgXnZOo4yFeWJr/M79ZB5BXkNqiT+2eunJvxPrvZaZVFhdzuCUQnjCVPM
	 P+MEBsGeF4FvJBexauDSb1nPe+U4g9CgAY9P3bvh5/G/iKUMUe32m27wI2jdMPskj0
	 RYIpoYCBitJsDfWPiLeOlaMBHsj2lMJmCuSVEkzrQSkJZsLCFcTVdr+vaUA6ad3T+W
	 4HdXFwO32p2wQ==
Date: Fri, 25 Sep 2026 17:38:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Fei Xie <fei.xie@horizon.auto>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parshuram Thombare <pthombar@cadence.com>,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
Message-ID: <5600a2ce-0428-4f1c-af72-668a55ef6fce@sirena.org.uk>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <20260921093701.1341766-3-fei.xie@horizon.auto>
 <arFEjzkHGMbecWWV@sirena.co.uk>
 <20260923061211.1608907-1-fei.xie@horizon.auto>
 <67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
 <87pky1ll4g.fsf@bootlin.com>
 <arZHjbzUEFhydnHt@nsa>
 <87ecehljdy.fsf@bootlin.com>
 <85dc596e-4378-4d23-b48e-80053cb5166d@sirena.org.uk>
 <87qzihjxlo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M4ifCx97cv0pZVcl"
Content-Disposition: inline
In-Reply-To: <87qzihjxlo.fsf@bootlin.com>
X-Cookie: Love America -- or give it back.


--M4ifCx97cv0pZVcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2026 at 02:59:15PM +0200, Miquel Raynal wrote:
> On 25/09/2026 at 12:59:49 +01, Mark Brown <broonie@kernel.org> wrote:

> > It might potentially help a heavily loaded system if you can do fewer
> > waits, the rest of the tasks running on the system will have more time
> > if we're doing fewer waits for interrupts.  Not sure it'd be enough to
> > write home about though.

> Definitely, but this is already possible, one may implement
> ctlr->mem_ops->poll_status. This way the core can leverage the hardware
> to perform the polling. It is not directly visible on benchmarks,
> because it won't reduce much the wait time, but the system load will
> decrease.

You'd still get a benefit from taking just one interrupt per sequence
rather than one per operation, that can help when the system is heavily
loaded.

--M4ifCx97cv0pZVcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2o4EACgkQJNaLcl1U
h9CNHgf/cvBZ+GyYuwWHmdwSwoY03PKLi2c5ks2Bwn3dlZ+RRSJ3Prtp/wdxPYgZ
3HFHtyKuIzWS1NGA6cKIEvBausOBN2Z5HQUIFXZ6Le3j54yIQqb+bVMB0H/AjGef
LA/tDAokGoff0PhaGUQRlo05AokS2EOS13kMMdlC6DzrVHNgVGFV+k+kU7h42kt5
xvxL8zHrZe1nVdtUkGvpvunV78AdVVyPcE6+/HzZnLeThoZcD0yVx6F/eqAQVbVr
mPVqzKhPkDxMlRitiScWu2I3Ybg3NYABe9W5ElpK7GxE/FlURwlFmajiBdM1rnf0
iE95xIyteW0awKr9ixhrLM78vnrNsg==
=3DcM
-----END PGP SIGNATURE-----

--M4ifCx97cv0pZVcl--
