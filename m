Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BF39DBE3;
	Tue, 10 Mar 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166362; cv=none; b=saQd//wRg8TeubCvIeOy/dM+9aftcsooAD2SmmqNmaLAQCs/mIyxfGaR1sLJ3faf+j76XuOtGcAV+twNiDzT/cmJL0yRHe9azevgIzHUtxg4wnzPtxWMsCCiCke8eTedqtDiTrJh8ROiJ4I+BJl7Lkf29eLqyZlxOjc77kSGO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166362; c=relaxed/simple;
	bh=XOYqlcCsaIl0G8bSNNRD5pDqv63/HMFFPi8Ddmj+o2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCxOPqmfVcQY2SgRFbJrp9G2yaFLRSS3bWotYsMCTav+gENt1lvEGAP5zNMzpLTY/ArXFds5OZ2AV+ZrCV6FNAWc8c68JSEF689t0rRpPrGcNNga/nrd6wYJQNL44LZQjRmi1CdvttvEVpQYY0EibAKluRd6A+UxK2Dg0UFup88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPvYXLR5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPvYXLR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4D5C19423;
	Tue, 10 Mar 2026 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773166362;
	bh=XOYqlcCsaIl0G8bSNNRD5pDqv63/HMFFPi8Ddmj+o2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPvYXLR5c0Cuz/whDDp5CTM+X+j2VQ/DDIoi4v7sq7KKp4RHKWI+UZJyN64sZlQmN
	 KvALWUrv72MU19GjYxKxAJ9sOgZvOCzFWwJai5tW7P+aI9vya9o33ctNzZAxNLbDLS
	 Z8YNsZ3IadmghGoSXMnI8EF7fpRgxOtuiR3q+39j7Fri+tzYseM/jjIH3qwW7NKm7c
	 8YGfY/8+EagBpD2CM+eMe3LGlLf2AwoDWt6+eZnleW5DBUEDSfI+nYAGRkN6HO3Kb1
	 6BS2h2quwoL8KFXEkFjhFCCkLpH+j+2v+D5yHou06gg+LnwAwNPsFOxdNESG9guYnu
	 adXQra1jJIASg==
Date: Tue, 10 Mar 2026 18:12:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: SPI loopback tests
Message-ID: <20260310-marlin-untoasted-ecca1e3e80e8@spud>
References: <20260310133254.GA51497@francesco-nb>
 <09f06ce4-0405-442b-bf3d-5722a6977a4d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8tzOIo09d+FWgqBq"
Content-Disposition: inline
In-Reply-To: <09f06ce4-0405-442b-bf3d-5722a6977a4d@sirena.org.uk>


--8tzOIo09d+FWgqBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 03:55:51PM +0000, Mark Brown wrote:
> On Tue, Mar 10, 2026 at 02:32:54PM +0100, Francesco Dolcini wrote:
>=20
> > So far to test this we had some out-of-tree DT overlay abusing the spid=
ev
> > compatible, however we'd like to move away from this approach and have a
> > solution that is 100% in mainline.
>=20
> > Manually unbinding/binding the driver in userspace does not seems as an
> > option, because there is no device node.
>=20
> > One option that I could think of would be to add a new compatible that
> > to describe this single wire loopback connection (something like
> > `linux,spi-miso-mosi-loopback`) that would bind to the spidev driver.
>=20
> > I am aware that you all DT maintainers shared in a pretty clear way your
> > view on the abuse of the spidev multiple times.
>=20
> > What would you be your advice to handle the need of an SPI loopback
> > test? Am I missing something and there is a solution already available?
>=20
> I'm not aware of any idiomatic way to deal with this with DT
> unfortunately.  Perhaps the DT people have some ideas here?

I dunno, the suggestion seems fairly reasonable to me. I don't think
it's really abuse of anything, because the compatible would represent a
real hardware configuration. The only think that feels "abusive" is the
fake reg property you'd need.

Not sure that there should be a "linux," vendor prefix though, there's
nothing linux-specific about doing loopback. Probably should be
vendor-less?



--8tzOIo09d+FWgqBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabBfFgAKCRB4tDGHoIJi
0us4AQDberWiHL/wYl4n07XAHYvXzM/NpzH84fuZ9slgBaUMngD/QcRRnRYvRrHB
LCITRjOyynyFDnicPDkz9e69LTpx6wk=
=3HAS
-----END PGP SIGNATURE-----

--8tzOIo09d+FWgqBq--
