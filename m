Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68802DEA95;
	Tue, 10 Mar 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167209; cv=none; b=D8T2vvwmq3JeKg1qtgCQ0VZpPlkd9AmIjxTp9TfiStaX/IRu2D3mvXjrdH2+TcYabIT2lmEhZAfT4xDo/BlOh7IP6vWhSJ1S9BPtUaKOp8ljxydPpiAH5MBuNQFkUMwcFbNBPtghfSwI7HtHs+5ntjvRSPr1Adcb1NgMdF68P3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167209; c=relaxed/simple;
	bh=u71ylBXX43bPBzfPHncR52udzq5yhNxIRgu1+tDOHuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCB5B9QrbU/EywsMqubxUdJNEchAS4JbJ5NmJ2jvquJ9CjtwZ5VXTmlMkijGoVZ30MwLRj78fZ/kd3/taGMwWZMfEZw+A1lRyGcQS9FAn0G6TZxR/r2vW5RQtrVHSkVaWnDKLUono5etGDc6MeuQ49rBY7+V85AFQl7xMzHvGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BncYExWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BncYExWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2210C19423;
	Tue, 10 Mar 2026 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773167209;
	bh=u71ylBXX43bPBzfPHncR52udzq5yhNxIRgu1+tDOHuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BncYExWGjos66rGnQhUNyNFKwc+tOVy2HTAuCPEuZtgZSRyZ0pzKVj046+ZN//nEk
	 qmxjlmQHLuB7Igx3zfVPe2a5N3fw3c5vaHqvDt47LOzYR8hm8vcKznw9JHBB9BW8xr
	 Dyxv3yFSf81Uxzi8Q6dZC6Gr5Suon/BIIV108S0eblCXpBOocM7TrA5KEg0Jz2zcK0
	 5BN9lwAB/vz7zRS9R1uvtUwR4QntbWNDmKLLsFAjEAF8CMXoOp7HHWMoQkIlzndO3t
	 GNHBtJ6UZQH7fCjszAcolz5H0MJjNXUN6xpsaKuK5CFKoFL+3cxhdsMbPSMrRVKjzK
	 aeEt4vqow8D9w==
Date: Tue, 10 Mar 2026 18:26:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: SPI loopback tests
Message-ID: <f35c50cc-741c-407d-97e5-81c62fcc15e7@sirena.org.uk>
References: <20260310133254.GA51497@francesco-nb>
 <09f06ce4-0405-442b-bf3d-5722a6977a4d@sirena.org.uk>
 <20260310-marlin-untoasted-ecca1e3e80e8@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nZMcoPOh+3SQznGO"
Content-Disposition: inline
In-Reply-To: <20260310-marlin-untoasted-ecca1e3e80e8@spud>
X-Cookie: A fool and his honey are soon parted.


--nZMcoPOh+3SQznGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 06:12:38PM +0000, Conor Dooley wrote:
> On Tue, Mar 10, 2026 at 03:55:51PM +0000, Mark Brown wrote:
> > On Tue, Mar 10, 2026 at 02:32:54PM +0100, Francesco Dolcini wrote:

> > > I am aware that you all DT maintainers shared in a pretty clear way your
> > > view on the abuse of the spidev multiple times.

> > > What would you be your advice to handle the need of an SPI loopback
> > > test? Am I missing something and there is a solution already available?

> > I'm not aware of any idiomatic way to deal with this with DT
> > unfortunately.  Perhaps the DT people have some ideas here?

> I dunno, the suggestion seems fairly reasonable to me. I don't think
> it's really abuse of anything, because the compatible would represent a
> real hardware configuration. The only think that feels "abusive" is the
> fake reg property you'd need.

In theory we should have a compatible specifically for loopback usage I
suppose.  Depending on how the device does it's loopbacks there may
actually be a genuine reg (if there's a chip select that's still
selecting.

> Not sure that there should be a "linux," vendor prefix though, there's
> nothing linux-specific about doing loopback. Probably should be
> vendor-less?

I think at this point it's old enough that it's just ABI and adding the
option of having it vendorless would just cause people to ask why.

--nZMcoPOh+3SQznGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmwYmQACgkQJNaLcl1U
h9BFmwf+MwUeHgh6Ij5dEMubDN8hQYH+KaCAy5I9qYlsOchTp28/HBBsRu025Vbj
C/FC8lFeu4CZO+yAilfm0gY2psB7Ec6xNDvckywzxBdrHCUDcP5WW+avq5ssMyzs
Z8FSspfccdPTIe4lvyy28njFmCsNBJRv1V7i+BMy2X50QiOnOPOop8IHWnl8GzDs
KDEeeYkVR6PbUVXMkQQJvjCAxLA+DTmEl2VFhyGa9EcAHgvKV8Ak7523iwyVB950
0y3oN7DWCclsC8YGtTwYLW17U3lS2Eo8Pq0tQQmDIsj7/lGyHDbjb94NGeDKC6eY
Z+fkfXD3/TQvLBViFAXLJH5hFlbhDg==
=U2Mo
-----END PGP SIGNATURE-----

--nZMcoPOh+3SQznGO--
