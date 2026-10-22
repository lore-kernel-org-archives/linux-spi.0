Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671810;
	b=fUWGCo16gKwVYwCNFLggFydfmB/1aEP/qcP6a7MSPYcq/Z2wb9p1Luqz0BCiEm8bs1xH
	 Al6SYW+gietieL9lzZt/Gu3tc64OM6ua/P6MPFuL6GxAnorZ/FD3cOIALRXnaSIUh4uWW
	 RkJvHk6BN9rSaDdiPJEwGxNUWLRkt4e5SR4bCae/m+2VOpWOWx0fe8WRO2szLejDyp+h8
	 BOcvyQrRosjrvCM9ERw32jqI34Pr4vdkV+67YTpIxIhDVLc2u6UgjQQQzdfOs5MRRlsaf
	 Gkef3/NiM8gN2YIwDBOD1c/Dp+ITO9rd8rAowEalZzgGO2/JFeV/P9B/dDGnhCzW6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671810;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:To:
	 Subject:Cc:From:X-Mailer:References:In-Reply-To;
	bh=akLxImTf0y0bbfRVy+rx+txPUMIriMcoQnnq8uHmVmU=;
	b=J3fB1U6b6v2k8w9JCRUKRD9YrvDSYCsgLO6PJtjwybuPC5CDIfLn2/Uf1TFHNc7ghsVT
	 ib9A8oaFzSrhKV48f39b+kxdMjC4EWJ5D+m62Ldql0RylAlFxBv5JjlnZESYs36V8Fks4
	 QDVYQiw+T/GJR0hqj9Bmco/llLe/zFjQVh8XQ1xdkT/lMTmTNGN/2DcC8AqVRvghf9Hog
	 XPLS3BowwwlnYDIGbjRaKHE0yHZSxtWKBeM9lsPyXJbMaIR4OpR1M++ox6tSrwJm8Yb7F
	 uj5L15DZB4Gv7yNGl0SV9EqSXI4lg4W5Y5lUVZwYOEQZMByZqggxp7Rc55etMt0rTvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpTfO23o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2FCE3606A324;
	Thu, 22 Oct 2026 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpTfO23o
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 387CE1F000C4;
	Thu, 22 Oct 2026 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671809;
	bh=akLxImTf0y0bbfRVy+rx+txPUMIriMcoQnnq8uHmVmU=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To;
	b=WpTfO23oU7nvT4dJXJVvqX4MnSqsi4TxRw32Bjls2eTe1EifZXQ7a5MbMsIBxKxu4
	 D8r/fX/VNZdAz/SD8R+4gT9HxJjqUir7fZEcA+SA0YfjVU9cwJGB8T9yvDiF6+jpDY
	 vyfNeKa1QFGM3RsxxR7Ryk4ACS+ucGk4yD+2E14JFqPDWRsqYKFKLxTj9UKuhPogYp
	 W7h2BBFqkaK1e3jOLdEOIRZu+RNbo0rEL3BcRHB6/Wje58Gn7n4Botg5kpW6NJeoR1
	 OeDpyz6SE29VCBZEGRXAHw/Hehs2fXVpM4OnWnFS3a7VxXHOkXuiJEWaG1egB08vXM
	 lNaKuhIzcO4Wg==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1abe0f32d48531c87fdcbb594fab47308a170e73b30effc29e3ae893b303;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 22 Oct 2026 14:23:26 +0200
Message-Id: <DMBD4AK6UXKX.23K3797G1OUS0@kernel.org>
To: "Changhuang Liang" <changhuang.liang@starfivetech.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Takahiro Kuwano" <takahiro.kuwano@infineon.com>,
 "Mark Brown" <broonie@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH v1 4/4] mtd: spi-nor: macronix: Add 1-4-4 DTR read
 support for MX66L1G45G
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
 <20261022102614.75696-5-changhuang.liang@starfivetech.com>
In-Reply-To: <20261022102614.75696-5-changhuang.liang@starfivetech.com>

--1abe0f32d48531c87fdcbb594fab47308a170e73b30effc29e3ae893b303
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Oct 22, 2026 at 12:26 PM CEST, Changhuang Liang wrote:
> The MX66L1G45G supports the 1-4-4 DTR read mode. This flash uses 6
> dummy cycles by default in 1-4-4 DTR mode, but the kernel's SFDP
> parser does not derive any SNOR_HWCAPS_READ_1_4_4_DTR capability from
> the BFPT table

So why don't you fix that?

> , and 4BAIT only filters already-known capabilities.
> The exact number of dummy cycles is also not directly given in the
> SFDP tables.

What is BFPT 3rd DWORD bits 4:0 then?

Could you please dump the SFDP for this part? See [1].

-michael

[1] https://docs.kernel.org/6.2/driver-api/mtd/spi-nor.html

--1abe0f32d48531c87fdcbb594fab47308a170e73b30effc29e3ae893b303
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCatoAPhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hYEAF/R5VryoZY5m+84ealf3tkGJWe5jEehB4J
3pt7F6qQO6SxZ7KGL9ighYRTdlvkwQWaAX9xhYxaTr2ler0r5fTVSZyj/2QGT23K
1twtzXZn7XH6aGWEe1N0rXtPcPuZsV9owu4=
=2E3m
-----END PGP SIGNATURE-----

--1abe0f32d48531c87fdcbb594fab47308a170e73b30effc29e3ae893b303--
