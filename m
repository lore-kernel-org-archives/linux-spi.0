Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BD39DBC6;
	Tue, 10 Mar 2026 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158156; cv=none; b=uOaryOm6xx/Th8dLeSi/4cOfINUSkiUWo3UKYhz+WWROxIcLuVrw1sQujMsLlVawzO5sTZcfLFKa2+g4fc0eiVFXdfkGkdoPPeHMuWO8RmlXEkx3HnuHDlvelqLlfGjgIqbmcnYT+AyXNoeGEnATgJbSMgJXE1mXVE2kSHUxFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158156; c=relaxed/simple;
	bh=hi4g9/aPLBstCnOp8v6dsNDWlzGbKt5GkBSUSKH9KWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUlvUhkn7scjGb8VUH1UI1nBETp76nnFU98gThRzNrvBURYDf6zN28TyQ4Sv+gZva5Ou8GfKWDqR2BP9mz1uXJF6fVZyaHMfo4d+l0zc6xmAP8IIRQT/49P8DHIuBMlczIgJ4k+1UBJisMSkfoxEYakQszwBfMvhkwzBPexjMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6E2Lrr9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6E2Lrr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7747FC2BC86;
	Tue, 10 Mar 2026 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773158156;
	bh=hi4g9/aPLBstCnOp8v6dsNDWlzGbKt5GkBSUSKH9KWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6E2Lrr9omTaZM9KLi9y373hw2pKOruHTT9DxIBG5+AUpfjQh7EnahZytO3es8Uxj
	 VyND86tXX1XfR6KZylJ/HdVhOqTKvZFIcR73tUWjxFPpQXHspmau/iAMrrcug891Y0
	 PB2RVxHivyHsjbKmV9YtlCkK8/3wCat8yO4kJPTpTW3MS90K53qQ0hqPXfia7Vat4o
	 MtgUii+HMriIMaRCwGd4PhLcomM6Kdhx+fplHiwW9B/tphUObjYQU791qAc9PktSoG
	 HsEJVazNk9MtLfZ5qNLsznaB8HJkWWxlUfv2QFYJyECMZ2YbaLh8Jx8inEwlUvy1d2
	 l9O6ALMWJ5pGA==
Date: Tue, 10 Mar 2026 15:55:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: SPI loopback tests
Message-ID: <09f06ce4-0405-442b-bf3d-5722a6977a4d@sirena.org.uk>
References: <20260310133254.GA51497@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z2pNUbWxG5oH6HHO"
Content-Disposition: inline
In-Reply-To: <20260310133254.GA51497@francesco-nb>
X-Cookie: A fool and his honey are soon parted.


--Z2pNUbWxG5oH6HHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 02:32:54PM +0100, Francesco Dolcini wrote:

> So far to test this we had some out-of-tree DT overlay abusing the spidev
> compatible, however we'd like to move away from this approach and have a
> solution that is 100% in mainline.

> Manually unbinding/binding the driver in userspace does not seems as an
> option, because there is no device node.

> One option that I could think of would be to add a new compatible that
> to describe this single wire loopback connection (something like
> `linux,spi-miso-mosi-loopback`) that would bind to the spidev driver.

> I am aware that you all DT maintainers shared in a pretty clear way your
> view on the abuse of the spidev multiple times.

> What would you be your advice to handle the need of an SPI loopback
> test? Am I missing something and there is a solution already available?

I'm not aware of any idiomatic way to deal with this with DT
unfortunately.  Perhaps the DT people have some ideas here?

--Z2pNUbWxG5oH6HHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwPwcACgkQJNaLcl1U
h9Cbpwf+PfXH2MhQzFdCjkvDAW05VJFy1ywWhKEKUdXxYDI8NAHtp8Yzo4tNdix8
G2dmffdrN74rFEwcOdYmHiJiR2IRuiIb9eOjkSbyukzDWkyjBj08YdbX4z/tRErK
TQhB49T+fqlrlb9QAGaXG+KPYLl6aGG3J9NzZ0xue19u1ujOjHErjsFX1KYVcCWf
/RXMEEjEycylSdVw/hCr4bnievjZiOn/9Y1WI4z4FNI7CaYOteUtPgGpWtusvnTL
gdv3DuRgYhpAsnGoxFtz9hYMmICxpp5nGrkYElokWal2UpBO5+y/n+j7C7cRupUO
JFq1/mm9/+udB097qyhX1xLmSNS4EA==
=as0O
-----END PGP SIGNATURE-----

--Z2pNUbWxG5oH6HHO--
