Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385911;
	b=FXejLNsRFpYN35n9+dEzse0M9Is6/4qcP1kDXpobPTrsd5dnULpPFSx3UqOnZksWBsvT
	 FhGXJ+fmuWXHXS0RW9G7gQ3px8eJJkJGox2ovSvVMgk5nMsSTfIaJG4Y5SHftqVmtt25Q
	 w5MwNMUJ9Ku8AUqNRP6lyDyZv30y2Iag7Pz/z99gDsnuSInte5dWn5Pwj1FOZEzaZyvkA
	 n9lXDPDiYmeIDRxUMkZzrU7qhwbdmbLN4ta18G3nzk0KOgvDGr441oeBQHawtIeU1iAEJ
	 Cu4/RNfU8OUNK3B1fFOFIqEt1VsQx+Hkf9/ZUVTKDQzMK9ULG4BoObOGzBcmEPagFcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385911;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5EPCnIcfvXerHvRmTGariLfLXLNGocNWN1mkzax41Wc=;
	b=pBoH7O0R+/0BJofnNCK/SomzHqMm7xM5KiSw6150WSwijhztKHxMchkRn8XKvd8/F3Ar
	 ZDPkynXjYk98/cBWReEDSE1JDTIMYseEht3Xy6G4ys49/fdUdgn8Sn26sJ47zk4ltFFG1
	 9lIAqsRzNW/SZLA8ek5rnpv0IEVC1VgfQJbShbkp+CfHXB2xrEPjbM9FesmOGcz+F5AoP
	 NES87jppl3OO78ikKK0aKu0oQH1Bmz9IWNrS1qT6FML8jYQX9EW6NJYrWC7fY4xd4ARDX
	 wo5IDvvAGOypfREl+ECaDCGiQVHTIn6TWhRIvrftJ4Euykz8ysau4Ps290M/OVuVVpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbaV4lxW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC079606A31D;
	Fri, 30 Oct 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbaV4lxW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4510A1F000C1;
	Fri, 30 Oct 2026 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385910;
	bh=5EPCnIcfvXerHvRmTGariLfLXLNGocNWN1mkzax41Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cbaV4lxWKK5WATUJ1chE7QyUtFKPWgYg/uWeiSgJ06C0O3r29jyraE3caiUocEG0e
	 bsSNPSvZJzik9l9p6c7QAxBUoOjfPpWPQL9xTeBnXhsl8N0g40eCloezfiWm+OUiDN
	 trsUdhqAZhMctuclEr2SuSX6wlV4wzbC3YKj6BhzXKJsTOsswTgdlqy6b5HMClSijp
	 Twf89t9LxdzNen76s/XWYBERULPTZrTbgDTboDE+54t7q5jCujYoGCfVcN/AbfrNDb
	 QHu4WWYbJ21TJ6UPmhoJQdXRDt66DOV7maeZfLmuTmtrJxrKx/WpjLAAHKIPbdr7VN
	 jKM/CRNmOzd0w==
Date: Fri, 30 Oct 2026 18:45:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parshuram Thombare <pthombar@cadence.com>,
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 2/3] spi: dt-bindings: cdns,xspi: add ACMD and internal
 DMA properties
Message-ID: <20261030-ecologist-booting-a6ae4eb55a28@spud>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-2-53cd44690e04@analog.com>
 <20261029-tag-scrutiny-b9ef1299e88c@spud>
 <auRpD5u6JQgwQM4f@nsa>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uKc01hmH0VtcXB41"
Content-Disposition: inline
In-Reply-To: <auRpD5u6JQgwQM4f@nsa>

--uKc01hmH0VtcXB41
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 09:57:36AM +0000, Nuno S=E1 wrote:
> On Thu, Oct 29, 2026 at 06:31:00PM +0000, Conor Dooley wrote:
> > On Thu, Oct 29, 2026 at 04:03:17PM +0000, Nuno S=E1 wrote:
> > > The Cadence xSPI controller supports an auto command (ACMD) mode where
> > > high level sequences (read, program, erase) are handled by the
> > > controller and data can be moved by its internal DMA. Whether ACMD can
> > > be used, and whether the internal DMA bus requester interface is wire=
d,
> > > depends on how the IP is integrated (e.g. external SRAM, interconnect
> > > wiring) and cannot be discovered from the controller.
> > >=20
> > > Add the cdns,has-acmd and cdns,has-internal-dma boolean properties to
> > > describe that. The internal DMA is only used by ACMD, so properly
> > > reflect that.
> >=20
> > Why would these properties be needed? What the controller support surely
> > can be determined from the specific compatible for the SoC integration?
>=20
> Alright, I'm more used to describe peripherals than this kind of IPs but
> I imagined that these being properties of the IP that would make sense
> to describe them in binding. Ok, but I sees this leaves the door

Basically the "rule" is "if it can be determined from the compatible, it
should be". Adding properties ends up with people having to figure out
exactly which features/quirks etc that their device needs and if things
are discovered after the fact it requires updating devicetrees that may
be bundled with firmware etc. Properties that are used to say that
something can do a feature should really only be used when the board
layout etc is what determines if the feature is available. That's much
more common for ADCs or w/e that are off-chip devices.

> open to just add properties in integrations that would not make sense
> and if we're going to have any compatible conditional kind of handling,
> I guess it makes them pointless.

--uKc01hmH0VtcXB41
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauTlsgAKCRB4tDGHoIJi
0tT0APsGkClLzsaUhB//dnE4VWj/t8QllLlPxrmNyrTe7hZakgEAi2lH8ESaq6J1
8mgwDkF846CJavKSTS5WpWN7TgYW/g0=
=N0N9
-----END PGP SIGNATURE-----

--uKc01hmH0VtcXB41--
