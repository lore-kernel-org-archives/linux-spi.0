Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42338D40E;
	Wed,  3 Jun 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502848; cv=none; b=ebBjfb4PxbLIkLRthR9Itxrpo6bJoyDxiMNllQTqwd6HU4an09gamNrFrZFvwBvV8Jtsh70CEVsgMbhIjzU8y+Hu/WGh1mFC7CHpqdnvkqtUtUzvSIxynVEKuFgI2z80WGhWmU7gSFvr5p+rlTkSDfQbvOTXLIuZ0/Bc7SD3a+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502848; c=relaxed/simple;
	bh=4DcE3gdg2zZx4lddjSrV/qCrZ+duToKva+T9bA0+opQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjARa/7S57EON0oD0oD/Ansy0lJkf43iQ+hjEeqfs3u7KxAIGbhZ6iMPN+Slhv6q+uFr0wA1JZFprxQLqeCFUx+hunlzsjqDDCKbCTFuaFiMq9kRcOijlqxKMmlJmwkFd6sGHaKk60J/iaPEdhWFm7/qoT959Wy6/rc/ozTksYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzcwUY6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzcwUY6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964A81F00893;
	Wed,  3 Jun 2026 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502846;
	bh=4DcE3gdg2zZx4lddjSrV/qCrZ+duToKva+T9bA0+opQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XzcwUY6hOFK7yIkrn0LZIMQD3zb+4dRS2+e6jrsGkybCCbdk2Z1Sa4GpSNGVP8m2I
	 R5sMMGyzSggulE3CYbjsmaeCAq3BoNzwy/ydL/TIdYWOWhKxjwBvWXqzZFpPlrYMb0
	 ZnIiauKyY8o25Bk5pVkIvPbOqhAj25/VMLY/arDAFX1srPFeIaFJvcwQydW0Rtt7Pp
	 618etvKuJwRj4dtzGwJY0Brhy4q9hA+0y86M6Sq3Wmv4TNzKcKuDRCqCYmLGbcXtQC
	 uHSTXp7RxLa+bc91uQYWOtKZknSb1WUwhYXG2O3yUVApF0mTRb9hxsqzjf8zsELMJb
	 9NOk/d3RtSk2A==
Date: Wed, 3 Jun 2026 17:07:21 +0100
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
Message-ID: <20260603-neatly-twine-e89b923f5cb6@spud>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-2-s-k6@ti.com>
 <20260528-clergyman-kindling-20971775ba78@spud>
 <eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
 <87cxy92llq.fsf@bootlin.com>
 <20260602-aptly-bunkbed-1bd3a8d63d54@spud>
 <875x3zzkji.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s1EwmNtQnf9Fscw6"
Content-Disposition: inline
In-Reply-To: <875x3zzkji.fsf@bootlin.com>


--s1EwmNtQnf9Fscw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 05:54:41PM +0200, Miquel Raynal wrote:
> Hi Conor,
>=20
> On 02/06/2026 at 17:18:15 +01, Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Jun 02, 2026 at 02:05:53PM +0200, Miquel Raynal wrote:
> >> Hello Conor, Santhosh,
> >>=20
> >> >> I also don't get the point of this property, why can't you just set
> >> >> the
> >> >> max that the device can do and if the controller can configure itse=
lf to
> >> >> be fast enough it will do so, and if it can't then it'll pick whate=
ver
> >> >> the fastest it can actually do instead?
> >>=20
> >> If I may, this is not doable because there is always a phase at low
> >> speed. By low speed, I mean the speed which allows reliable data
> >> transfers between the host and the device. This "maximum low" speed is
> >> non discoverable, it is necessary to describe it. As of today, it is
> >> widely used (and I believe for good reasons) and covers 99.99% of the
> >> use cases.
> >>=20
> >> >> Seems like you're abusing a peripheral property to encode informati=
on
> >> >> about the controller.
> >> >
> >> > The controller-side approach you mentioned is similar to what I had =
in
> >> > v2, where a compatible-specific base_freq is used for non-PHY ops.
> >> >
> >> > Miquel,
> >> >
> >> > I think we should revert to the v2 approach.
> >> >
> >> > The non-PHY frequency is a controller limitation/capability rather t=
han
> >> > a flash characteristic, so it seems more appropriate to keep it in t=
he
> >> > controller driver as Conor suggested.
> >>=20
> >> The non tuned frequency is the maximum frequency one could use
> >> reliably. It is not controller specific. It is mostly board specific,
> >> and to some extend may also be chip specific.
> >>=20
> >> The tuned frequency is the maximum frequency one could use reliably
> >> after line a controller or chip specific training procedure. It is
> >> also the result of an aggregated set of non discoverable hardware
> >> limitations:
> >> - board routing
> >> - chip capability
> >> - controller capability
> >
> > Right, and this I guess is what scuppers letting the controller driver
> > sort the configuration out itself and leaving the property as-is.
> > It could be that the speed in spi-max-frequency is lower than the "base
> > speed" of the controller but because of board routing or device
> > capability that the tuned mode is still required, right?
>=20
> I do not actually expect any tuned mode/frequency to be mandatory.

I think you misunderstood my use of "required", I meant that the new
property/information was needed in the scenario I described, not that it
should be a required property in a binding.

--s1EwmNtQnf9Fscw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiBROQAKCRB4tDGHoIJi
0j5OAQCWb0zo1IHNOKEyAsgZCqvYqoIIDdppeJHQXnA34qJKgwD+LjAZKbifRJpB
IlxAJqU+VfU6Udqf4CwOEBPWL7ulWAY=
=iGpw
-----END PGP SIGNATURE-----

--s1EwmNtQnf9Fscw6--
