Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556579CD;
	Mon, 15 Jun 2026 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519048; cv=none; b=mSSyDvr2ZFJjcyRDLyN6ey3rWrupkZF0k9WbyHykVvtgvIUzhXlqFL02jSjGZQfRAKYxUp6+mO9BKF7fFSDC7MPFSbgLiPJ848ZKcxL8BxdGTz34EJ8++MlwwT5Lbk5Bswa1en2/2C6qR4NfB0IRYfUE9uhhkbLGmMafSv4SmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519048; c=relaxed/simple;
	bh=e6FR948efBXD1kKaijtZma5Tu9CLpRPYxviWmS/WyH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXbxzDkOzRbCU7Dh8TB7p7wqhB5/8EgE/Bh81z4s8JKXrWxvOkSxP/GdgP9633D5aXosxatZ33MrpUTHtTFdh0+AHNhRzBfe68iS2deBGmevEVJKOmm5v8bX5x0P8PdP+JIMZ7jxBXh7LxFhuyWrMZN9Ea5cL3FzVFL71Mhjx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZUqOZJE9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZUqOZJE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781519047; x=1813055047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e6FR948efBXD1kKaijtZma5Tu9CLpRPYxviWmS/WyH4=;
  b=ZUqOZJE96UxYSe0BerKLLGZAP+seWHtJ3AgE2SEdGlWqwuV3Gg/rB5rh
   X3kAbA849/Iga626KPiNmDoGaSrBjp8Z7uE+2XQQYDNjqGgO047jc6KY9
   FLO5loKosjMfBO2R3/Q5xgnpxzY4f4bMqpU15jXUEgAYv/eHw2Pabmztd
   SWW9dL5d/cS2mlRRBbiQt7RP/rmQIW/Pg47a4bTnYSjHwQtof2km0HUM2
   icgOi0Ak7i+jVSUc5bdE343CMix8QOWtSKRoKVRgM+KItBXimcVpUI323
   dF2zP2ydkXJMoV2EshGfrrG+lgc44gqNLW81Pu7tCeEqUlozQbfCmoByW
   Q==;
X-CSE-ConnectionGUID: hfzY5t+0RsuQFcDb3BdrKw==
X-CSE-MsgGUID: +ziSKTYtRoeQ8lTI5VSYig==
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="asc'?scan'208";a="58297258"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:24:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 03:24:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Mon, 15 Jun 2026 03:24:04 -0700
Date: Mon, 15 Jun 2026 11:23:17 +0100
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
Message-ID: <20260615-disallow-dosage-333752ccddc1@wendy>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
 <20260612125856.8530-2-changhuang.liang@starfivetech.com>
 <20260612-mute-aqueduct-029ac227314e@spud>
 <ZQ4PR01MB1202FA8F122134F7153D26F7F2192@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="91bPSu8DoDeqQSyg"
Content-Disposition: inline
In-Reply-To: <ZQ4PR01MB1202FA8F122134F7153D26F7F2192@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>

--91bPSu8DoDeqQSyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 03:38:46AM +0000, Changhuang Liang wrote:
> Hi, Conor
>=20
> Thanks for the review.
>=20
> > On Fri, Jun 12, 2026 at 05:58:55AM -0700, Changhuang Liang wrote:
> > > Add a new compatible string "snps,dwc-ssi-2.00a" for the Synopsys
> > > DesignWare SSI controller version 2.00a.
> >=20
> > Two things. Firstly, driver patch suggests a fallback to 1.01a is possi=
ble. Why
> > haven't you added one?
>=20
> Will support fallback.
>=20
> > Secondly, I am going to expect that when your starfive user for this ap=
pears in
> > my inbox that it has a device-specific compatible, so you may as well a=
dd that
> > now.
>=20
> Our standard SPI control is completely based on the Synopsys DesignWare S=
SI controller version 2.00a.=20
> However, for the controller that accesses the flash, a set of modificatio=
ns has been made based on the=20
> Synopsys DesignWare SSI controller version 2.00a, and the driver part als=
o requires specific adaptation.
>=20
> Therefore, on the JHB100 SoC, the initial device tree source I have plann=
ed looks like this:
>=20
> spi0: spi@17f20000 {
>       compatible =3D "snps,dwc-ssi-2.00a";
>       reg =3D <0x0 0x17f20000 0x0 0x10000>;
> };
>=20
> sfc0: spi@18000000 {
>       compatible =3D "starfive,jhb100-spi";
>       reg =3D <0x0 0x18000000 0x0 0x10000>;
> };
>=20
> Thus, I plan to add a new "starfive,jhb100-spi" compatible string for the=
 controller that accesses the flash.
> For now, I intend to keep these as two separate series.

No, if you have two integrations of the designware IP with different
programming models on the jhb100 I expect to see two different
soc-specific compatibles used. I don't want to see bare synopsys
compatibles on the platforms I am looking after.

Cheers,
Conor.

--91bPSu8DoDeqQSyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCai/SlAAKCRB4tDGHoIJi
0koHAQCiPtRNw/1gwXZK/BdT6j8FL5iATsOXXHwrJLZCXolWCwEAiwpuHr/ltCBv
LyeszfI6AUWfr17w0u0wGH7YiVPCsAo=
=17ze
-----END PGP SIGNATURE-----

--91bPSu8DoDeqQSyg--
