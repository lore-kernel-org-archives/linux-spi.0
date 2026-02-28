Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CA44BC94;
	Sat, 28 Feb 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293146; cv=none; b=PA1sKD8U68BAryVzdhuV7UXl473ilUgEI1Sz9XbKY1do6P+ehAuTaMs7OyCrNVNUmbzaIsBvWjmTzcktobBz3IRijrM0qsF4u8Be24VqHeF8eTcr2UInxiQCtl7JO8xlRj82uK1ZKeEvYTfZleibzpr1ifPotSu0oxlrrZN5lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293146; c=relaxed/simple;
	bh=RZ24zd2vtYiYR+Is5sPaHhlPzptzRZV6aZNyOrKUIVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaDgY5MP0c8Qlljgwl+nsfI4G9PpkBOU6O7XQ3q3JrKgQbY74iue0cUyuBFfqBIqnA3rF4XVz37iswh3WuuQONlp4GCypqJuD6zCIHnJh90lytH2V7AnOwy/Jl85TjvL7obH62yHzKnv6UKLQdGY60BzNCFon8xnnsxMZRlO2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnwKOAWD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnwKOAWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C61C116D0;
	Sat, 28 Feb 2026 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772293145;
	bh=RZ24zd2vtYiYR+Is5sPaHhlPzptzRZV6aZNyOrKUIVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnwKOAWDengg1oRY0dK5Fy+OeUeopzCcRU/T6Gp6kHFSbbT+nahq4oD9l+JO5iMQk
	 42JBLQ7WMwPlQHsHnea65r/cAl/SDK7pKCHBtuFcf9GCn2FlW60Zd7Gk2flVKhhYJF
	 j+EfqxigH/ZpnmKxImLF3CFLm8k4oShlCmTjKLxBhcMFsFsV3ejSrBIiQbIIAk/WI0
	 MnPIGZVaxPgqBhk9YwZ71mtS77SV4HCIjZz/Qkbalhsb0JWfDyvi2mdBEyHgfipwLZ
	 psyKw2HsToVjffGDun3BUAgb9HPiwK9QXYXJHtMXBJtOCbsKOdpxZgFdx0n+2QZ5n7
	 NQTU1LHsbCO8Q==
Date: Sat, 28 Feb 2026 15:39:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Ron Economos <re@w6rz.net>, miquel.raynal@bootlin.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, wsa+renesas@sang-engineering.com
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
Message-ID: <20260228-defuse-extenuate-cf2a90ae66ea@spud>
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
 <aaL2WVO_7bl6vNp5@sirena.co.uk>
 <20260228-ragweed-theater-b02967937353@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vHElSr6IrLxck0/S"
Content-Disposition: inline
In-Reply-To: <20260228-ragweed-theater-b02967937353@spud>


--vHElSr6IrLxck0/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 02:23:00PM +0000, Conor Dooley wrote:
> On Sat, Feb 28, 2026 at 02:06:17PM +0000, Mark Brown wrote:
> > On Sat, Feb 28, 2026 at 05:54:06AM -0800, Ron Economos wrote:
> >=20
> > > I'm getting an SPI failure with Linux v7.0-rc1 on the VisionFive 2 RI=
SC-V board.
> >=20
> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is=
 still busy after 500ms timeout.
> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: detecte=
d FIFO depth (1) different from config (256)
> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is=
 still busy after 500ms timeout.
> > > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is=
 still busy after 500ms timeout.
> > > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: operation failed w=
ith -110
> > > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: probe with driver =
spi-nor failed with error -110
> >=20
> > FWIW confirmed on my system:
> >=20
> >    https://lava.sirena.org.uk/scheduler/job/2504026#L715
> >=20
> > (which I didn't notice as that was just buildroot and not running
> > kselftest-dt...).
>=20
> This probably constitutes random speculation, but I am curious if
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 6e56e9d20bb06..390fa87edbaf8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -873,9 +873,9 @@ qspi: spi@13010000 {
>  			      <0x0 0x21000000 0x0 0x400000>;
>  			interrupts =3D <25>;
>  			clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>,
> -				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
> -				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
> -			clock-names =3D "ref", "ahb", "apb";
> +				 <&syscrg JH7110_SYSCLK_QSPI_APB>,
> +				 <&syscrg JH7110_SYSCLK_QSPI_AHB>;
> +			clock-names =3D "ref", "apb", "ahb";
>  			resets =3D <&syscrg JH7110_SYSRST_QSPI_APB>,
>  				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
>  				 <&syscrg JH7110_SYSRST_QSPI_REF>;
> has any impact. Going from jh7110 specific code to bulk apis is an
> ordering change, right?

According to Ron, it had no impact.

--vHElSr6IrLxck0/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaMMFQAKCRB4tDGHoIJi
0riuAP9pcpOeD4G8LIGxBhND9gcHitN47yk6s3A5aZEOIx8/oAD+LKck9tLQJDn6
CxytGbXbvq/03XGYg5BKaApP3uGaFQg=
=yy+n
-----END PGP SIGNATURE-----

--vHElSr6IrLxck0/S--
