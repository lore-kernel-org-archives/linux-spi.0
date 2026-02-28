Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4380423A69;
	Sat, 28 Feb 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772288580; cv=none; b=NbE0f2OV4Zh9VEDYreBE6JDUDwWgbPlrBHrQCkSmkYVpjbmWoOwYG1y2KcysFsb6ItauU4jPoisEkHAabEfk2QQWPlgSpd2zgWei+tXcLvCUihPEw+zgtyLmUct/HjXm2oG8ngM5sUYZMgwfInwETAvLmAdAf3YOQ7eCJhua1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772288580; c=relaxed/simple;
	bh=E29j3PXXVta4w6LHdGwWm4bPeP4mtQJEKrEXDi6leDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlVs65fUKZ2l72D3MdZ7hyxOI2PVizFETTtBWvKwpi6B7h4+fJeu8uHMcowf53O3B4MfTPnXzkDQJXmIVdtP2yrYdw0iIuxAHGg8UuOdKImLvMq8E1Xc9hHi9ZqRzOxn7l9NUl7Y6tMphErVMCEBDrVk1dWT4SRZeD/2izcVbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKao7JYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKao7JYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCDCC19424;
	Sat, 28 Feb 2026 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772288580;
	bh=E29j3PXXVta4w6LHdGwWm4bPeP4mtQJEKrEXDi6leDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKao7JYyKjsxNVZ41dffrCBBuDFSPsL/pKV3yVYgkpIHJ/kEgvFqP/iwEpMzjtnRL
	 ukAPO/dLAP3jmPvZcuxuMi2f+B2DmPhsHwxzBkCrXvuLNxYC6iRn8KVwHdOUjYCCE9
	 xEAt5h+ZDjp4/v01ert0NjjQ8r2TcPnfNwJUGdoGUD+vG4MIVkaX6wfDzb41co4cCQ
	 vRe74HxwDa3bxN/Evv2LaFYrvmD3/EbC0YeMkq3Od2/Srpm7C4z/Vk2yhb2KFzjPgg
	 n1NhKyr0owlPSyG4Ul3diyVIyqIKgXwmQ6rauQ36GdtSUx8yM82VQD/aHGQQ8HAf7q
	 hbxI3hGDpLc+w==
Date: Sat, 28 Feb 2026 14:22:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Ron Economos <re@w6rz.net>, miquel.raynal@bootlin.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, wsa+renesas@sang-engineering.com
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
Message-ID: <20260228-ragweed-theater-b02967937353@spud>
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
 <aaL2WVO_7bl6vNp5@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W5080Fu5H1v47UF5"
Content-Disposition: inline
In-Reply-To: <aaL2WVO_7bl6vNp5@sirena.co.uk>


--W5080Fu5H1v47UF5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 02:06:17PM +0000, Mark Brown wrote:
> On Sat, Feb 28, 2026 at 05:54:06AM -0800, Ron Economos wrote:
>=20
> > I'm getting an SPI failure with Linux v7.0-rc1 on the VisionFive 2 RISC=
-V board.
>=20
> > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is s=
till busy after 500ms timeout.
> > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: detected =
FIFO depth (1) different from config (256)
> > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is s=
till busy after 500ms timeout.
> > Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is s=
till busy after 500ms timeout.
> > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: operation failed wit=
h -110
> > Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: probe with driver sp=
i-nor failed with error -110
>=20
> FWIW confirmed on my system:
>=20
>    https://lava.sirena.org.uk/scheduler/job/2504026#L715
>=20
> (which I didn't notice as that was just buildroot and not running
> kselftest-dt...).

This probably constitutes random speculation, but I am curious if
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts=
/starfive/jh7110.dtsi
index 6e56e9d20bb06..390fa87edbaf8 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -873,9 +873,9 @@ qspi: spi@13010000 {
 			      <0x0 0x21000000 0x0 0x400000>;
 			interrupts =3D <25>;
 			clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>,
-				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
-				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
-			clock-names =3D "ref", "ahb", "apb";
+				 <&syscrg JH7110_SYSCLK_QSPI_APB>,
+				 <&syscrg JH7110_SYSCLK_QSPI_AHB>;
+			clock-names =3D "ref", "apb", "ahb";
 			resets =3D <&syscrg JH7110_SYSRST_QSPI_APB>,
 				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
 				 <&syscrg JH7110_SYSRST_QSPI_REF>;
has any impact. Going from jh7110 specific code to bulk apis is an
ordering change, right?


--W5080Fu5H1v47UF5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaL6QAAKCRB4tDGHoIJi
0kFhAPoCPebF/64V6tTerETc1p/3aNrGWY/eLrfG7sMraKTcWgD9EjA9vV4LOEhp
TztKNTybWwjf00xB3tli5R7BAyXslwM=
=LE7H
-----END PGP SIGNATURE-----

--W5080Fu5H1v47UF5--
