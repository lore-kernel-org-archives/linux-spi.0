Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86347127F;
	Fri,  4 Sep 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519282; cv=none; b=lW3QvCiLTz3SmycrF4fWPi0yjHuu3gJR7L0rbUC5kndDWvaLtAQuJHivghMzwSpZl1h3h/CozCskBme22h0zz+2jRNR247jzk6HBGYgCycUzRlcd+NATAMisicoJO2c/Pu4FSQExyoN0RB5XYrajhFIkDlVBkgwoRKXLVBc5PMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519282; c=relaxed/simple;
	bh=RWXv6LAGjSKmS1TDSZzLlUJ3NJkoPeyjiPfEru1BXB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDKYThr27egB1IHpRp80U+8IUc+aRhsnxOHCzmysR3Iiy6qkTGoJoCVS7cVG7cYEoVvzYVSxLQMs78wq0qxSWFsFMUcCs21DO26ToVu8AMlwBZFxZgmY5BUwyZ8PnjZDwLd+N0zBWWwcRsrYuyxw98U0ihGlN/Hsj+4xmQxb3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZWtsFD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZWtsFD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4691F00A3D;
	Fri,  4 Sep 2026 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519280;
	bh=DKGcsNhvQvyX65WRsiWMdw7zbIu6Dm+Ns5yHU/Yl7MQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZWtsFD0IFC9WfCLXixG8ZwAduj+OUv14NrmjvbHHnXLd/vlwPgJhqIo0hx5YbqcQ
	 d6O4zqymS5/JcqhvzwMOvkEFs6JA8iyNBqTCcFkiBsmdB1AzhcKgMK8EHlCW0zia8x
	 wYYPW137Yg7II5xUM2HeyV4Zwgb6RFfif5WEzhcQjgKAuNNthK5Vtk6MGvdJNvvdeX
	 s1MbVwtUAsMlBD48Syzww/jsZGFRigCw0bIRY3VF2V7V7z9Xc0XyWF2Of2v7kM9m/s
	 SL4tV+MUEWwmil52cuC2/qX8a951HyXMHYCyHG2PnfvqzM8svgSADjJX0gr+2gzX4Y
	 hal71DpIznH8g==
Date: Fri, 4 Sep 2026 11:54:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	afaerber@suse.com, bartosz.golaszewski@oss.qualcomm.com,
	james.tai@realtek.com, cy.huang@realtek.com,
	stanley_chang@realtek.com, jyanchou@realtek.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org
Subject: Re: [PATCH 0/3] spi: realtek: Add support for RTD1625 SPI Flash
 Controller
Message-ID: <606e580e-b1d6-4dd3-bb3c-e46d20da78eb@sirena.org.uk>
References: <20260904031252.244280-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfNF2zAxbgSEaXCh"
Content-Disposition: inline
In-Reply-To: <20260904031252.244280-1-eleanor.lin@realtek.com>
X-Cookie: A is for Apple.


--tfNF2zAxbgSEaXCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 11:12:49AM +0800, Yu-Chun Lin wrote:
> Hi all,
>=20
> This patch series introduces support for the Realtek RTD1625 SPI Flash
> controller.=20
>=20
> Please note, this series depends on the RTD1625 clock driver patch series,
> which is currently under review.

This doesn't apply against current code, please check and resend.  I
think it's just the DTS patches - I'd just drop them from the series for
now, it'll make life easier.

--tfNF2zAxbgSEaXCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqao2oACgkQJNaLcl1U
h9AHVQf/ZGL7zGjqObIWwauUZG3bh6i+a5W+RRbI+yZL7Cp6J9gcBdfMJFPDH22/
zNVUuIVxFYto+MyS0oNEj0/q2QC2fnTxt2IXcYAvKFDswmxKkc77Maoy03sMkRBc
0V6o0JiNz/0T8r3v52ZWncKO4+c5ZMxOay1rUwg5GZ/pTKkvXjTDEp1vT8DsdlXt
lWhkWCdqHksaxa4bijRm85IE7iQw2L4ca1VmDArp5aWMFG6GdkVyYUtu/IJGkKlD
iYXCQG9+wRmvPQXmgYkNpYf4WZQAgPVzaKqN+WzIQPV10whA0jEOvlTGPfjW/0OK
jBaIl4NxI1HvyNEPvcrl/MT+RAwYAg==
=8YF8
-----END PGP SIGNATURE-----

--tfNF2zAxbgSEaXCh--
