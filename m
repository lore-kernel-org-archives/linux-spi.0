Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13535677C;
	Mon, 24 Aug 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591614; cv=none; b=PqnM2e6oprkoKH5fDoQ3LfDPpQZTsCcXuzWYyUUnPZa8hJZ5rXiDVNENDItUSZcJsfTx2cL1G7CbhUoTQ0hVRADop8B6sofklRn78FwE7ugskC7aWX/Pmv8y3CiudO9s5LrJzovXwi54hMSh2vneVinVF3xDkUOclCV8aH6ZeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591614; c=relaxed/simple;
	bh=aHm2EnHUkPFepWRRa/Ty6TAS3a8VDuPzZXn27T65nrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZb0ZMR3duFw5PhnioxSq+NsI6PgwClEyYIvtQjmpn2uAXSBNZV2i8xY3F0ZfWachNwyLnMl6LMU4owEvWwJuCSD/tFzAkl8uOkK5gl37t0RT4bowY3hhxCXV9qDjLHZcMOeouhgKBVHKes8FXzc97md2o3qbfgZA8nzWGly1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYvhHHzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYvhHHzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D80A1F000E9;
	Mon, 24 Aug 2026 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591613;
	bh=HvDdBWD/b23UU+vg6S9XZEJcnKbBpxrpqSQC4IwZkdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RYvhHHzvymTrIPxmkLDVXIoTZDb3OjzWIkHKZ+7n0i/+EripyZcO4BJb8847H0ENP
	 u2d/vQmiNRugm5DC7flQzHAR2acnUtUdLXF9NT/CwPZRwC6dMOBU45oV8NaHYgJPE0
	 QbGaebMnfk6SbkSL5PbDxgnkO7udof27GbMBej/0IXxGbrEqecXIZtCNbFJJVSAp43
	 8jUy4zomG24U/FixrxL5ULgNk+9Ed/3CgqkKfsfo6Sm1+nJUFZSSKCedhV9cm8d7Mn
	 IhYeUyHdnwprnmYpo9nbaFLBl+ssUIKwmJ6+bwSUaSPcDa+qlz7CeI/UC+3gIKFV2t
	 fh70a5Xoj+AIA==
Date: Mon, 24 Aug 2026 18:13:25 +0100
From: Conor Dooley <conor@kernel.org>
To: wangjia@ultrarisc.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 08/12] dt-bindings: net: snps,dwmac: Add compatible for
 UltraRISC DP1000 SoC
Message-ID: <20260824-blimp-spirited-01365897db24@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-8-61ab7aebe9e5@ultrarisc.com>
 <20260824-bride-food-052b313e4b76@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5O4Q84D38y4t01tR"
Content-Disposition: inline
In-Reply-To: <20260824-bride-food-052b313e4b76@spud>

--5O4Q84D38y4t01tR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 06:09:48PM +0100, Conor Dooley wrote:
> On Mon, Aug 24, 2026 at 01:54:21PM +0800, Jia Wang via B4 Relay wrote:
> > From: Jia Wang <wangjia@ultrarisc.com>
> >=20
> > Add the SoC-specific compatible string for the UltraRISC DP1000 GMAC
> > controller to the DesignWare MAC binding.
> >=20
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
>=20
> The dts may not be right, but I am also a bit concerned here.
>=20
> This binding permits 100s of combinations of properties, of which only
> a very limited set can be correct for your device. Just adding the
> compatible permits all of this variation.
>=20
> Please add some restrictions.

In fact, it's particularly bad here because you don't even restrict
which fallback compatibles are used, so there's no guidance on what
version of the IP is even in use!

>=20
> pw-bot: changes-requested
>=20
> Thanks,
> Conor.
>=20
> > ---
> >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Do=
cumentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 2449311c6d28..2ed4564ae99d 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -119,6 +119,7 @@ properties:
> >          - starfive,jh7110-dwmac
> >          - tesla,fsd-ethqos
> >          - thead,th1520-gmac
> > +        - ultrarisc,dp1000-gmac
> > =20
> >    reg:
> >      minItems: 1
> >=20
> > --=20
> > 2.34.1
> >=20
> >=20
> >=20
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--5O4Q84D38y4t01tR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox7tAAKCRB4tDGHoIJi
0lp+AQDCJM0dwn64CDrt7zalPVln36JhAawbBkUx93Z07kRzOAEAvJON583LI3qh
FHzphlniOwb9apW2Tc4SX/52jr+RoAo=
=+EOL
-----END PGP SIGNATURE-----

--5O4Q84D38y4t01tR--
