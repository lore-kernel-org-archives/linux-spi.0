Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506981;
	b=rZU8we/ZpjoBtsZEYpHJTzeXGTwqHZrIfoMrzxtAH7Y/O0ObZaoT5Jr5KBhIMUJdI7/p
	 czTXep9lYD/HjNu+WXuhyG5zg/Me/hPDGYM+k7Q+ytl3jhMswxDW07pE16HuwgZZfV5Yo
	 fc+Z9+u1wObCYDNYK8cWrUwqv3O0Kj07XhYFf2DEziQYtZ4X11tT+VHZ/3VK7rPmBrGRN
	 WYwyBM6086vUYoJD67YfDNdCX2Ac09lL4TPaBAyCJSmFL6Qo9xpusYV68L3SrRnaDY3RY
	 8nLz8YTOfpgA34yb3AcH6+LACS7b+bjY0XG10UVXvPWg1zCiTLVT6Klk1cEJJ8r64sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506981;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BaJY9G+O3FV1i4Zpgu7P0a7EUVdMBobV+mJJcOvaSzo=;
	b=tau7XVm+jfzx9Y/jCMnclk8N8ZYzwhKfVLwbZWHbVj+UVBvd93xsdyL2D3ZHL0PBtaOj
	 muPVNEbS1G72gx0CW4cw1uL+rPsPgVYep8hwnkjfU7S3tb3rKCGjk9ZJguY9/z3sD7C49
	 lsACI8MMKafpLIS9cO+77H0kdZ9mSjU107JEVPRmtymoT1P5EWhv5WDu4cgh89JO/jGOo
	 SZ1oXc4exSrdaT1EhJtpaut4J63VMp6/dlVzPk3lxFitq3n4/C6IPWfBpijo3j+4CfiCM
	 Y3R1g1WU9vh4eHxnbZQxdJGqirHdTKPKaYF9AqFd9jWezvLo4Brsp0DoOlvFOWNPwIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j3ysJ/Az";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D2606A31C;
	Thu, 12 Nov 2026 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3ysJ/Az
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E841F000C5;
	Thu, 12 Nov 2026 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506980;
	bh=BaJY9G+O3FV1i4Zpgu7P0a7EUVdMBobV+mJJcOvaSzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j3ysJ/AzR4MH4ikdO1YwwWaxii5G4sAtBGA6cMwZqjr0MixLbSbne7fyiCGMiq1Nm
	 NPwKpU5w5Q+3g4vC9yB0mwBEmKfAhKhuz9JfQ1/st/eJXWm5raMg6NthedUntCrVQF
	 xHuoWCx2h1QnUjuXlFG3nZfS5qJWqMsS+DvSoqIG4X8SJKIDDaNY7dJuUG4T3W9wmY
	 fFPjqG9D4sfdmXo3sVKHEavtE2UdxHaS2WEU/Z/7F3u65rFdrsIviyvgyylKWo8OOj
	 TFpxVAti0skO9O1Yv9sCNeIt0do5m6RDjGZUhYjCZZ1RvVB13KmLDmfFHUrBlY1H2h
	 bKmr7x1CMyXUQ==
Date: Thu, 12 Nov 2026 18:09:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
	Pratyush Yadav <p.yadav@ti.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Konrad Kociolek <konrad@cadence.com>,
	Mark Brown <broonie@kernel.org>, Jayshri Pawar <jpawar@cadence.com>
Subject: Re: [PATCH v2 6/8] spi: dt-bindings: cdns,xspi: add ADI SC846
 compatible
Message-ID: <20261112-sincerity-snuff-9451330d3ed5@spud>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <20261111-xspi-cadence-add-acmd-v2-6-d339046ada8b@analog.com>
 <20261111-entomb-backdrop-815e4dc81c7e@spud>
 <avWHJuW2Xj4BJ_cv@nsa>
 <avWJrWwHe5ApSUbT@nsa>
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
	protocol="application/pgp-signature"; boundary="MquIn60EIiF6IsU4"
Content-Disposition: inline
In-Reply-To: <avWJrWwHe5ApSUbT@nsa>

--MquIn60EIiF6IsU4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 09:41:17AM +0000, Nuno S=E1 wrote:
> On Thu, Nov 12, 2026 at 09:32:36AM +0000, Nuno S=E1 wrote:
> > On Wed, Nov 11, 2026 at 05:58:09PM +0000, Conor Dooley wrote:
> > > On Wed, Nov 11, 2026 at 01:23:07PM +0000, Nuno S=E1 wrote:
> > > > The Analog Devices ADSP-SC846 SoC integrates the Cadence xSPI contr=
oller
> > > > with its own PHY timing configuration and with the support needed f=
or
> > > > the auto command (ACMD) mode with the internal DMA, so it cannot be
> > > > described by the generic "cdns,xspi-nor" compatible. Add a SoC spec=
ific
> > > > compatible for it.
> > >=20
> > > I assume it's the phy timing that means the cdns,xspi-nor compatible
> > > cannot be used as a fallback?
> >=20
> > Exactly. Without proper phy settings we cannot probe the memory chips.
> > There are some works being done to support phy tuning but even when
> > that lands, not sure how generic it could be supported.
> >=20
> > Hmm, I guess you want the above mentioned in the commit right?=20
>=20
> Nevermind, it's already in there.

ye I just wanted to clarify, because it wasn't entirely clear that this
made it incompatible since I'm not a domain expert.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MquIn60EIiF6IsU4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavYA3wAKCRB4tDGHoIJi
0kxGAQCp0V8BVgNuNxizBOeL5wbELjJPl/O+CR2lqdIyCmaMKAD3QeiT17bUF4+H
HUIHcyK3Zx6GdijCvQ1WfbKEsBoMBA==
=VG+/
-----END PGP SIGNATURE-----

--MquIn60EIiF6IsU4--
