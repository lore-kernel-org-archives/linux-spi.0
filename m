Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000754119E5;
	Mon, 31 Aug 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181244; cv=none; b=m0pO/L3Upb6s8JVKnTTeb+F/0lPPQW/9ctfx3mj/vNH2/2pM3Vg2ciEC6eQpDcw5PNt9HYhyE/7jFepbYuelEPG324ECU78DB8nknozUsJUvn1ydYssHkSDu0yT0hZhK7y5PpNOn18n8uKQOOjF96k6A1PP99ljYimtCm3eAr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181244; c=relaxed/simple;
	bh=LccMWHwKeNmBt5/n07sCdFGBtusyOXIFYHFflnDLqvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=W0HAPgy3ILy0+57enwDg1HBriZ1MpNCCWZlssDmt4P3gIl5G4ux0o0Xg/SX+UQ8UIY8FWaaV3uCZZsJkkEZRhkhxfv4sOCz1cgW3XkbMRYJ7ALATAWiscsH0kATQ3Bp04s/p+4tQdfcjSDZ8hA+wqxmeh5fPWyCfXu+sjIHuDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLgHCqzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLgHCqzx"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 287931F000E9;
	Mon, 31 Aug 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181240;
	bh=LccMWHwKeNmBt5/n07sCdFGBtusyOXIFYHFflnDLqvA=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=FLgHCqzxbqKrYSvv1tmT3a5UKLzs9NUdK9AKQiHCw9o36tzIr/dV7TVZGPUdE2Dy8
	 r5ZpBM5Hsb4Ce7UJZJ8c0qM6d8SrsUZWgio4jttTy89LjZHNmtZMfJJdFNqw8Z8i27
	 s08tF/cBL8p2VIdqcXcnBQY8NgaXrM7epnlyJzs0p+gxtDycOf+nUG9Zp7bSXA/bst
	 v6+iqd+M9t8Aa7CiSzzZDQ+xpVRk/CymchL1V1SMadSMPopPmzrHO4r1v86qMUllTV
	 pLVySKfEPCp31YnRw8m5p9KoVBSle3qhEdUeWZVRVoQZrbR2N4vr17gxJW4evQuZAS
	 HRBU8vx5lDzXw==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d55e914e04fb4ece455ae1e1571756b36266d056b52f931a1c322b7d976b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 31 Aug 2026 15:00:36 +0200
Message-Id: <DL35CFJ3BXZ1.2RE00JYDZKXXU@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Report platform enforced SPI flash write
 protection
Cc: <tjakobsen84@protonmail.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Takahiro Kuwano" <takahiro.kuwano@infineon.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Mark Brown" <broonie@kernel.org>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-spi@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com> <DL34V3WU5UY1.3FYYB7UPWYY83@kernel.org> <20260831125526.GJ124825@black.igk.intel.com>
In-Reply-To: <20260831125526.GJ124825@black.igk.intel.com>

--d55e914e04fb4ece455ae1e1571756b36266d056b52f931a1c322b7d976b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Aug 31, 2026 at 2:55 PM CEST, Mika Westerberg wrote:
> Hi,
>
> On Mon, Aug 31, 2026 at 02:37:59PM +0200, Michael Walle wrote:
>> Hi,
>>=20
>> On Mon Aug 31, 2026 at 2:05 PM CEST, Tobias Jakobsen via B4 Relay wrote:
>> > Patch 2 adds the only user, spi-intel, which already computes protecte=
d
>> > range state at probe but has had no way to expose it since the SPI MEM
>> > conversion removed its visibility of the MTD device.
>>=20
>> Where was it removed, though?
>
> After the SPI MEM conversion the driver is a regular SPI driver so it can
> only use spi_new_device() to add and configure the SPI-NOR chip (via
> platform data, struct flash_platform_data). Prior this it was creating th=
e
> MTD device itself.

Yeah, but it never exposed the _is_locked() op, right?

-michael

--d55e914e04fb4ece455ae1e1571756b36266d056b52f931a1c322b7d976b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCapV69RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jAFgGAiFgQYm7EIaJ9tj+3pgn9H/Kd3nsSinNu
gxLBHL8eYoUknmaw/7ZZ+4RD3WlGpKZTAX9IcgVNg/qj0kKts6FgERhU7YiR6PH4
db+oZKWRvC0XXedaqzqD69aXQQhY5p+rC7c=
=IYD5
-----END PGP SIGNATURE-----

--d55e914e04fb4ece455ae1e1571756b36266d056b52f931a1c322b7d976b--
