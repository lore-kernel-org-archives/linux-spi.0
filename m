Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535345;
	b=sWjNcktM/Ug1MYQu4Lztvm6f18R6g4xtylkhe0IRe/Uo3ODR2pJ1ap+v0bSM+F7g2gI8
	 VkXDB5tai8mE8tvf+sR8I9iurUPurHp0opp8OCZ46jwRKOTsXSCBafqG6lhGqUXrPkhFp
	 pGThLX4Gzia8cc/S45vg7LQxvBouaygtd3IO94KH/eNj3hD6B4onXGGSng1+HvqWvGF7G
	 lUNOk0gMYPQCJHP89+2YjYAaOGwW4tmVf9Bjw1feuL9ms9cMz3eYR/IU1WAI7MIOo51T5
	 VWc9PMTTySFy9Gk88DdoMlqTxMszl5l+S3P44zGyjlXPCeU8JyTEE7B4Es2ohV1pP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535345;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=nBapz3a18fBdBoF8M1EqG41RsBxBURR+NkgFnQrbNM0=;
	b=Yf8L/hhx8wREHFcjsPTA5jr6b/dwiC85dQg9OQdXJIzoSD2sVIICP58yeolHJrx5l5oV
	 pGVVbDfDIWbSK83VbJPqqcjhObwkuESfyWPmJYQ/Wa5WPFJ64LuK9oPLfvEJ5u/EapzHZ
	 QbT18dnyPlDnl020rPZayxbrqkQHzTVf8A10eNqsixDg/JmR4QbOe6P5IR11vgQ7SYsJa
	 fapydeVeAGbofH6ZekhB195KmLu9q1z6MNL1XXI1KIQ0W6AY+oy9u/nbOjVTtWsd19mvf
	 nO5AyftbKhcUWJCN/nRe73xWwfnHyMnNeolzCcuv+Ws/7PDQ9qHivzBfl1pVngebN4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bG5+oEaY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53602606A323;
	Tue, 24 Nov 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bG5+oEaY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2542E1F000E0;
	Tue, 24 Nov 2026 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535344;
	bh=nBapz3a18fBdBoF8M1EqG41RsBxBURR+NkgFnQrbNM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bG5+oEaYVu5ew8mfDug3+KSAB02KGpKVM3amCHum8Md3GAqxmDeheNzercKTq9JCF
	 RZBXlZnXPmgMHO0xzX2WGY70oWof1zYnc6cjosCMSFgjJBC8K181V9+P6Yp8Y2Md6w
	 0cGE9b5IbTTaqMUiRhs3DrKqKfOBUHwvAOd02MFa+Fj1ouUSKtxh4IocDLBaOoh8T0
	 ob/Ei5RzJdY8NvV7rAClqnbP4hco7vskqs2hJ1msXF5uY3GOF/lrSpNgbe1SMBRX8q
	 4e1+OhJsrrlAyUTMyqu53U5VIEpLo7ea9EJfuL8FUFynYplSNenxw3kHX+UJEw5fHc
	 j7L6EJ3eDmJiA==
Date: Tue, 24 Nov 2026 15:48:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ZhuXiangyu <1194781887@qq.com>, Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: spi: rockchip-sfc: add RK3506 support
Message-ID: <31eb592d-2524-4fbc-96a2-be4db40b532f@sirena.org.uk>
References: <20261121073246.1233736-1-1194781887@qq.com>
 <tencent_E24973E955D1A26CF5A4F983929F8F8B0006@qq.com>
 <3bdaa592-7bbe-462d-a012-da6296251b33@kernel.org>
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
	protocol="application/pgp-signature"; boundary="NjOoTaQMc5fFJElZ"
Content-Disposition: inline
In-Reply-To: <3bdaa592-7bbe-462d-a012-da6296251b33@kernel.org>
X-Cookie: Real Users never use the Help key.


--NjOoTaQMc5fFJElZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 04:41:53PM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2026 08:32, ZhuXiangyu wrote:
> > Document the RK3506 FSPI compatible with the generic SFC fallback, and
> > the rockchip,grf and rockchip,max-dll properties used for the
> > power-good handshake and DLL training.
> >=20
> > Signed-off-by: ZhuXiangyu <1194781887@qq.com>

> I will mark everything you as changes requested. This is all half
> broken, b4 review cannot even fetch for review.

FWIW it was perfectly happy to ingest it for me, might be some
network issue?

--NjOoTaQMc5fFJElZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFseoACgkQJNaLcl1U
h9AlHQf+I/y8j6jW93+PG/bA8TL/xoGLUhYY70EWw7VAf/WEw7tQjmDtvNiPTB73
jD9HqV9fAsJExYtfiL91KLKLRijZA2TbwDeF69neDrQfJyg5wzUcf0BnXErha2eW
x3+qA3xhcJFOYCTTC2aYBEHfVmSdi/aT37fjWEU0KZxY3Po5mq+za03rCozBmzvJ
FQYuIZNTdYDnTxJR1R0BK/oXVPzBG7E6/N0o3v+HtZUYa9p62YRv6R8Wx7NC6OqC
rdHOSxV3Dcr12JcRq0HQRZoXNV+WDj3HCaIwHZRgDYdVP0EG18kKUbgb5lTA64SM
XdbGSMve5EigtLsChJB5Uk38SRvngw==
=zAK6
-----END PGP SIGNATURE-----

--NjOoTaQMc5fFJElZ--
