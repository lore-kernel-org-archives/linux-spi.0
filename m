Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F0630AD1A;
	Mon, 15 Jun 2026 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521125; cv=none; b=SugVrXx3sHs5tA3cC0JeQUONnSqBKP433OZf1UcL8+1n9tyX+kjzgwHwy94wPgaJLLNej26VSfGAcD5/tb8nieCpPWLwM/zaqWFp1vXmWRdvK9Aop9vavgZfeXnRpRFv20X2MIiTIG1Y6ul0gLwUKXQtBUm3FAnqG0xUTbiVo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521125; c=relaxed/simple;
	bh=eX116ZmZWLRLVRGZZmaQX+HBBCwo6J3ncAuSHT4+93k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPNas3CE8D82g9uVkIe2yU82ZODn+9bCb0inYn1uCeBDhD5iGP2i1vIxnNFz+h6CJWB/QDzF3Dwg+1RjVPciOI9AlygNi9HF/wml+ETZeDigZLB9SzbIuTX6JDadlAimpeLwFNCy8GsjysK8ubtKMmzqO6SnPQlaAygBfkbK2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BETXeWYq; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BETXeWYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781521124; x=1813057124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eX116ZmZWLRLVRGZZmaQX+HBBCwo6J3ncAuSHT4+93k=;
  b=BETXeWYq4tDbIgOaimwHYDJi5yp//zT4OVivsdquJCfkB28GZO7SIupV
   asgSXUmDvDoAoNvmmlqDNUbtejNLmAZP1u8EJxefMXLO45VR08fEY3JVP
   dTF/6hX3ietgYwVagx7E2txLpQbg91OE4ObxSJlcej2X8qA8ai0ubWYtz
   A5IRqtxBLNwpfwQz0WQA6/sMz8riWAhRt7nfDv+4JJmLHXG4BLUa/fE62
   yzIdpgAraRL5hffEiPbfZFnAIOF2eij7z08ZyYFsrDk0/WK3aZnT3DKaB
   Mv+v4mh1hJ002QL/o9hebla40KKlHcl6Dd5IzGIojFMh8c1+ZKLIS33sl
   A==;
X-CSE-ConnectionGUID: wr9h5fdqRpywT5+TOakhmg==
X-CSE-MsgGUID: bPuuKTJJQT6Sx+X0XNqjow==
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="asc'?scan'208";a="68188465"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:58:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 03:58:37 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Mon, 15 Jun 2026 03:58:35 -0700
Date: Mon, 15 Jun 2026 11:57:48 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mark
 Brown <broonie@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support
 for snps,dwc-ssi-2.00a
Message-ID: <20260615-regretful-unviable-3a6a65f48d9b@wendy>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
 <20260612125856.8530-2-changhuang.liang@starfivetech.com>
 <20260612-mute-aqueduct-029ac227314e@spud>
 <ZQ4PR01MB1202FA8F122134F7153D26F7F2192@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
 <20260615-disallow-dosage-333752ccddc1@wendy>
 <ZQ4PR01MB12028430668DE1F9AE8645A9F2E62@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/xIMeAPBUa6tS9wt"
Content-Disposition: inline
In-Reply-To: <ZQ4PR01MB12028430668DE1F9AE8645A9F2E62@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>

--/xIMeAPBUa6tS9wt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:49:07AM +0000, Changhuang Liang wrote:
> Hi, Conor
>=20
> > On Sat, Jun 13, 2026 at 03:38:46AM +0000, Changhuang Liang wrote:
> > > Hi, Conor
> > >
> > > Thanks for the review.
> > >
> > > > On Fri, Jun 12, 2026 at 05:58:55AM -0700, Changhuang Liang wrote:
> > > > > Add a new compatible string "snps,dwc-ssi-2.00a" for the Synopsys
> > > > > DesignWare SSI controller version 2.00a.
> > > >
> > > > Two things. Firstly, driver patch suggests a fallback to 1.01a is
> > > > possible. Why haven't you added one?
> > >
> > > Will support fallback.
> > >
> > > > Secondly, I am going to expect that when your starfive user for this
> > > > appears in my inbox that it has a device-specific compatible, so you
> > > > may as well add that now.
> > >
> > > Our standard SPI control is completely based on the Synopsys DesignWa=
re
> > SSI controller version 2.00a.
> > > However, for the controller that accesses the flash, a set of
> > > modifications has been made based on the Synopsys DesignWare SSI
> > controller version 2.00a, and the driver part also requires specific ad=
aptation.
> > >
> > > Therefore, on the JHB100 SoC, the initial device tree source I have p=
lanned
> > looks like this:
> > >
> > > spi0: spi@17f20000 {
> > >       compatible =3D "snps,dwc-ssi-2.00a";
> > >       reg =3D <0x0 0x17f20000 0x0 0x10000>; };
> > >
> > > sfc0: spi@18000000 {
> > >       compatible =3D "starfive,jhb100-spi";
> > >       reg =3D <0x0 0x18000000 0x0 0x10000>; };
> > >
> > > Thus, I plan to add a new "starfive,jhb100-spi" compatible string for=
 the
> > controller that accesses the flash.
> > > For now, I intend to keep these as two separate series.
> >=20
> > No, if you have two integrations of the designware IP with different
> > programming models on the jhb100 I expect to see two different soc-spec=
ific
> > compatibles used. I don't want to see bare synopsys compatibles on the
> > platforms I am looking after.
>=20
> Okay, I will change it to the following:
>=20
> spi0: spi@17f20000 {
>       compatible =3D " starfive,jhb100-spi";

This one is compatible with "snps,dwc-ssi-2.00a" and "snps,dwc-ssi-1.00a",
so it should probably have those as fallbacks. The latter for sure, the
former if you know there's some non-discoverable differences between 2.00a
and 1.00a hardware.

Cheers,
Conor.

>       reg =3D <0x0 0x17f20000 0x0 0x10000>;=20
> };
>=20
> sfc0: spi@18000000 {
>       compatible =3D "starfive,jhb100-sfc";
>       reg =3D <0x0 0x18000000 0x0 0x10000>;=20
> };
>=20
> Best Regards,
> Changhuang
>=20

--/xIMeAPBUa6tS9wt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCai/arAAKCRB4tDGHoIJi
0npmAQDsg6YBqoSXb5BlCCoIOel0O41cbZtYZDxZ2mjOoB5LvgD8CrtnPmapUBou
h1Bii8MSHVHRua6XkJsQHOe3RJxbyAc=
=jX7z
-----END PGP SIGNATURE-----

--/xIMeAPBUa6tS9wt--
