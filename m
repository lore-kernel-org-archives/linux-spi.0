Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E431E844;
	Wed, 11 Mar 2026 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223860; cv=none; b=TAVf511TWcBgcti2RDjkw9QeOhKERoTsaDzNRROOYMYOzem2dlZuZJom4qnR/lo384EJ11ooy5Ye/QmfR/OO9PwrmyelFfT39deo/SJMUiZQCES0AWSsg4fwxftUHjQoRxKm11dMHibmx/cAMPctwiLOH5UGcSKs3DXXkbS6rGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223860; c=relaxed/simple;
	bh=1sphpO4kW4lKXuuPA66/6QQwudKM3Ht8eYtxAAIbFzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzRB7BHp0XaIvdK1CXS95kToFMzcZ5jSMRJ5S5Ixuf3zOBhrNY7jOTY5vzu/yPiTzD2Dr05nJ1TfziC5JdauH3q9+/V3TsWxRKGF+uTlINnuj+qifym4VNIEHayDsrT4O3g6BkonX561WODWpP/K8/Caf4NA+HMFCQbFye39n0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKux0UPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKux0UPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEB7C4CEF7;
	Wed, 11 Mar 2026 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773223859;
	bh=1sphpO4kW4lKXuuPA66/6QQwudKM3Ht8eYtxAAIbFzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKux0UPUiKKMRN+42S4lnNRqcyC7QilxKbRDUBJT4iQSUEpelIo3oHtTmLChtOrBt
	 J2aHSqBlAxB1ZTYjqu+d6xuVkeXyVIRk2HL4e7b6NjWA01oTm6yvxH1W88XQC2UPnp
	 UlLFHdhcrTXeZHt5cGl3gJn0uFBKlfN25HXjnoDGlaAmCba/kJTFReLbp1rBXI1ZI9
	 H/EEoIfjIx/IxEl+c/5uuLs4R0PHueyMlUJW5W5amR0HTBgPc1LG677IiEslUPqtFZ
	 USY75XCTg6VlxrA+iT0wrZLeIGBzUapaPW8ODx0JQmA24URyBLybbT6dQvreNj1cIe
	 0fNk8BpWBNOPw==
Date: Wed, 11 Mar 2026 10:10:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: SPI loopback tests
Message-ID: <20260311-passably-pampered-314ea21b9f1f@spud>
References: <20260310133254.GA51497@francesco-nb>
 <09f06ce4-0405-442b-bf3d-5722a6977a4d@sirena.org.uk>
 <20260310-marlin-untoasted-ecca1e3e80e8@spud>
 <f35c50cc-741c-407d-97e5-81c62fcc15e7@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sg6O97Ulhk1afUCK"
Content-Disposition: inline
In-Reply-To: <f35c50cc-741c-407d-97e5-81c62fcc15e7@sirena.org.uk>


--Sg6O97Ulhk1afUCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 06:26:45PM +0000, Mark Brown wrote:
> On Tue, Mar 10, 2026 at 06:12:38PM +0000, Conor Dooley wrote:
> > On Tue, Mar 10, 2026 at 03:55:51PM +0000, Mark Brown wrote:
> > > On Tue, Mar 10, 2026 at 02:32:54PM +0100, Francesco Dolcini wrote:
>=20
> > > > I am aware that you all DT maintainers shared in a pretty clear way=
 your
> > > > view on the abuse of the spidev multiple times.
>=20
> > > > What would you be your advice to handle the need of an SPI loopback
> > > > test? Am I missing something and there is a solution already availa=
ble?
>=20
> > > I'm not aware of any idiomatic way to deal with this with DT
> > > unfortunately.  Perhaps the DT people have some ideas here?
>=20
> > I dunno, the suggestion seems fairly reasonable to me. I don't think
> > it's really abuse of anything, because the compatible would represent a
> > real hardware configuration. The only think that feels "abusive" is the
> > fake reg property you'd need.
>=20
> In theory we should have a compatible specifically for loopback usage I
> suppose.  Depending on how the device does it's loopbacks there may
> actually be a genuine reg (if there's a chip select that's still
> selecting.

Okay, fair enough.

> > Not sure that there should be a "linux," vendor prefix though, there's
> > nothing linux-specific about doing loopback. Probably should be
> > vendor-less?
>=20
> I think at this point it's old enough that it's just ABI and adding the
> option of having it vendorless would just cause people to ask why.

I'm not sure what you mean by "it's old enough", as this proposed loopback
compatible is new, right? Don't think this is any different to i2c-mux
or regulator-fixed etc etc. Unless you thought that I was saying that
"spidev" should be a compatible? Definitely was not suggesting that!

--Sg6O97Ulhk1afUCK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabE/rwAKCRB4tDGHoIJi
0l/PAP0VS6cznCqy9RY/4yr+s4yuSiXNsDrMdVfhH7Dxx0Tg6wD/TRpGc9BZlAwX
+PkUH/lFqKh70YJWoJnk0iobXFDNAQs=
=anzb
-----END PGP SIGNATURE-----

--Sg6O97Ulhk1afUCK--
