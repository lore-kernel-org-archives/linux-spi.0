Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403E2F3C07;
	Tue,  2 Jun 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417101; cv=none; b=f5f5YKCRGBSi1SaRXrt3zf2fEIBhh+8T/97G+E4uS0CewuhF/ersyKVWhEKbJiX6ZCV9juj8qusEvhuBlonU0S7Sb1RyAeSO1DXfrjsSwcjKIAE9xFkQWMwnzZfamtoUwN5t9IeyOpqelzI0LKhRM3/MKaXUdKg5N3cZKwCosEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417101; c=relaxed/simple;
	bh=E5lBZBn/6XyQaGLUjyr5xRIhIu6ddOyB1ZKhOi4w6SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6+fIAOC7ImBQDr/r2vLDGlXYpQSXa/0RWVtu/AdeQ0CfMOz5QNysb0c1sNpJW2Yo8iBF12wMVZJy5WStM0qwC0AvJeYd8R4DP3BG1H3/34enIcdyPDAAEOBav0pbm2wauJlU7AyEgZub74buX3l4cJ6hxKhn7U4rX17SGyCDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzTqAnWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzTqAnWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782C41F00893;
	Tue,  2 Jun 2026 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417100;
	bh=E5lBZBn/6XyQaGLUjyr5xRIhIu6ddOyB1ZKhOi4w6SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzTqAnWvhREs7kN0FRcFz4cNP22b8RALpcnJfUsvHX9ZgANlP8wEgvF8Inwnk8WFK
	 6qh65PJZtP8YT4c/C+JaUf874b2joMoJdaZwNd/3+pqO0nqOjJmsitgG1E+FkYL/Pl
	 kO0EENlj9mkH/iGsQqFUA5hQAWR4NJrMfIr6YgfvCtRmeSKLwF0yj3eshsyodsCzRz
	 udHklaals+GNTGEc5mDiFbC65Vp260NwpA5hflI87my2ePxdlrtIexTEGxT8A6fUzJ
	 EUjDiID7e8SCBkm0mg5VuK63PVI7SDh5Z19n2VXMWXYY+QAZ3RRPMSYyf+tnM5Y95B
	 N7D0dXYKBiDDQ==
Date: Tue, 2 Jun 2026 17:18:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Santhosh Kumar K <s-k6@ti.com>, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, richard@nod.at,
	vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com,
	a-dutta@ti.com
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
Message-ID: <20260602-aptly-bunkbed-1bd3a8d63d54@spud>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-2-s-k6@ti.com>
 <20260528-clergyman-kindling-20971775ba78@spud>
 <eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
 <87cxy92llq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AJLPS9b34NY10SeL"
Content-Disposition: inline
In-Reply-To: <87cxy92llq.fsf@bootlin.com>


--AJLPS9b34NY10SeL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2026 at 02:05:53PM +0200, Miquel Raynal wrote:
> Hello Conor, Santhosh,
>=20
> >> I also don't get the point of this property, why can't you just set
> >> the
> >> max that the device can do and if the controller can configure itself =
to
> >> be fast enough it will do so, and if it can't then it'll pick whatever
> >> the fastest it can actually do instead?
>=20
> If I may, this is not doable because there is always a phase at low
> speed. By low speed, I mean the speed which allows reliable data
> transfers between the host and the device. This "maximum low" speed is
> non discoverable, it is necessary to describe it. As of today, it is
> widely used (and I believe for good reasons) and covers 99.99% of the
> use cases.
>=20
> >> Seems like you're abusing a peripheral property to encode information
> >> about the controller.
> >
> > The controller-side approach you mentioned is similar to what I had in
> > v2, where a compatible-specific base_freq is used for non-PHY ops.
> >
> > Miquel,
> >
> > I think we should revert to the v2 approach.
> >
> > The non-PHY frequency is a controller limitation/capability rather than
> > a flash characteristic, so it seems more appropriate to keep it in the
> > controller driver as Conor suggested.
>=20
> The non tuned frequency is the maximum frequency one could use
> reliably. It is not controller specific. It is mostly board specific,
> and to some extend may also be chip specific.
>=20
> The tuned frequency is the maximum frequency one could use reliably
> after line a controller or chip specific training procedure. It is
> also the result of an aggregated set of non discoverable hardware
> limitations:
> - board routing
> - chip capability
> - controller capability

Right, and this I guess is what scuppers letting the controller driver
sort the configuration out itself and leaving the property as-is.
It could be that the speed in spi-max-frequency is lower than the "base
speed" of the controller but because of board routing or device
capability that the tuned mode is still required, right?

>=20
> We must try to think about other (non TI) possible use cases of these
> properties and also take into account the existing DT expectations. If
> turning the property into an array is too complex, we may go for a

I don't think it is "too complex", but it requires removing the
definitions of spi-max-frequency from the 4 or 5 bindings that redefine
it and making a mechanical change to all spi device bindings that
specify a limit. It's not complex, but it will be annoying without
tooling doing it for you.

> second property, but I believe the name should not be TI specific (but
> I'll let the final decision to the DT gurus).

Yeah, I concur. If not doing the 2 cell spi-max-frequency, then
something like spi-max-post-tuning-frequency or w/e I think should be
used. Doesn't seem like TI would be the only people that end up doing
something like this.

--AJLPS9b34NY10SeL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8CRAAKCRB4tDGHoIJi
0owGAQDo4OJ+lanJzDDiAy24r90RjmLY345XbhNb35eu9nR4pQD/bylNWRFr8zIC
ieLJyX/nv5hK66XKGg37ALalXfCBCws=
=ETpe
-----END PGP SIGNATURE-----

--AJLPS9b34NY10SeL--
