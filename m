Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039842;
	b=wlWZaS/7vPwQrKMAHnSH7Jf5kI6YkwPjlwgP0L3t2wK4ixwsUY9WzenWyB5JmrGpkeDF
	 iA532JhTP4aYAefSrXF4VGWx81UlZAX3MUQxHuas7CsSNZBWny632H64cYCCwFB4vlMSh
	 VORy17isqMJN3NjVcQ7p0gHzpxq3YAJMvIubJmIKhfa/86MjbNCYKTM8wuGBVmpQLbSUT
	 K3F/+iuM3c06KiYLZvP9Yh8wOs+C09LD2F7H4YFnEms1Z1qO3qCgswwJ/uAZ7Fek5r0eH
	 A27458xshQr+d+Ent6Yr14kvglg9Kp8YnJl6jSkjwEeiA7h7E598w2B+cQ8q35YbJsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039842;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=aqSyYu+jA7QD7ixyq7XtysEQBlg5TZeCmD7JGK41Hzk=;
	b=qbGME4IwOODBXjSFNyFXLDdo7EN4563eSMbkCtusV5ITen3Fwe1nUr5WqXQoo4LVKCwp
	 WLpElDfjgcM6RGr4xNyPevr/VfAg7hN/COb2tNvFS8n3ADfI3F+Rabx6qkDQj0K8eoheZ
	 ehzCQNERp9wvtaQNRo1FOXN+rC9NLJHdH2mnsQ1zyAX/TMP02XDEXIF3RYGGaR6fnApAA
	 A2TzdxWfqQpP2b/4D+8yyxp+N8nEa8vQTwrDnaWWAK/PGOH7zWVnIyjQ1u8ysSHExiw36
	 Ms71/Sg4qRKhh+RQ9et31Hj8PGtOzXrFzQX+7Qnrcf8GNeZZuphkr41goAg0AM90S1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=C9u7IwL8;
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B14606A32A;
	Wed, 18 Nov 2026 22:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B14606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=C9u7IwL8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=aqSyYu+jA7QD7ixyq7XtysEQBlg5TZeCmD7JGK41Hzk=; b=C9u7IwL8od2s/LBGaU8QBaFgtF
	DM6GLz3c9mQoYwQZxEP+O+Bv8F6Y2PrcaxPQH+W57zzrmLY5QvOIi24gIc+rkk7DZZmQCxuWPYFr4
	B/AcjfrN+p4/g7CXSJeARwkW2Zz8L5Wc7unydDrAfty77UOX6cszWUnVt8zWzL0R56JIyiY2EhZ2x
	EH0Vzkp/bxuSgz8hTfiXEdcB3P187nbXY8zOe5zU/d5pBgGRi8eUz4SNShRAnE2SaI4e2ksq3WYjD
	Ik1HaiDqyW8A5wr9um58k/k9CO3jP84L3Z9aH2An9j8FXFZ9Bbs0G7GtO+OOQfDysywhne4wGDYw0
	EApEcm5Q==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xTnrQ-00000000XZ4-32WB;
	Wed, 18 Nov 2026 23:10:36 +0100
Date: Wed, 18 Nov 2026 23:10:35 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Conor Dooley <conor@kernel.org>
Cc: Wang Yang <yang.wang@deepcomputing.io>, Yixun Lan <dlan@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	broonie@kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: bus: Add SpacemiT K3 eSPI controller
Message-ID: <av4iWQb33bya48G1@aurel32.net>
Mail-Followup-To: Conor Dooley <conor@kernel.org>,
	Wang Yang <yang.wang@deepcomputing.io>, Yixun Lan <dlan@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	broonie@kernel.org
References: <20261118085742.1817536-1-yang.wang@deepcomputing.io>
 <20261118085742.1817536-2-yang.wang@deepcomputing.io>
 <20261118-backdrop-scrap-1bee34e06336@spud>
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
	protocol="application/pgp-signature"; boundary="uwS4iCT+BxiI+7D2"
Content-Disposition: inline
In-Reply-To: <20261118-backdrop-scrap-1bee34e06336@spud>
User-Agent: Mutt/2.4.1 (2026-07-04)

--uwS4iCT+BxiI+7D2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On 2026-11-18 17:51, Conor Dooley wrote:
> +CC Mark, spi,
>=20
> On Wed, Nov 18, 2026 at 04:57:34PM +0800, Wang Yang wrote:
> > window, clocks, resets and link configuration. The EC uses this memory
> > window rather than the ordinary SPI transfer interface.
> >=20
> > The controller implementation is carried as a separate prerequisite so
> > that the hardware vendor can review it independently.
> >=20
> > Prepared with Codex assistance from the existing DC-linux EC support.
> >=20
> > Signed-off-by: Wang Yang <yang.wang@deepcomputing.io>
> > ---
> >  .../bindings/bus/spacemit,k3-espi.yaml        | 146 ++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/bus/spacemit,k3-e=
spi.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/bus/spacemit,k3-espi.yam=
l b/Documentation/devicetree/bindings/bus/spacemit,k3-espi.yaml
> > new file mode 100644
> > index 000000000..30985ee0a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/spacemit,k3-espi.yaml
> > @@ -0,0 +1,146 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/spacemit,k3-espi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SpacemiT K3 eSPI controller
>=20
> How is this "eSPI" different to the eSPI described in fsl,espi.yaml and
> implemented by a driver in drivers/spi?

eSPI in fsl,espi.yaml is a Freescale (now NXP) SPI controller, it=20
implements a SPI bus.

Here eSPI is a bus, replacing the LPC bus, as defined by Intel:
https://www.intel.com/content/www/us/en/content-details/841685/enhanced-ser=
ial-peripheral-interface-espi-interface-base-specification-for-client-and-s=
erver-platforms.html

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

--uwS4iCT+BxiI+7D2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUryGlb40+QrX1Ay4E4jA+JnoM2sFAmr+IlkACgkQE4jA+Jno
M2u7Pw//e3NQMW5zCgglmLHZ41Ne5HfOAqECutIMDry7Tiignz2Wv4A1BCM3BV/q
xlsE+HEjYrQiJ/ruU93iQ1DvXgvvsXp+nL5vOnPw+XCUlwiSaR93jCWkKWkYJpN3
ZytuPUk1kN06MRND2NakKtSw8ExyLklo3MvDMFtS0Y4Pc5dmG8E47DYADH8sZRZ7
Iw7MTh/ZnGl56ydGt7BE1A3IIa+hrCgQnv7hN7ApM5SOeF+XhelLWoLA0flqq021
lp1bxIHANUiJOCIIyTn6L69GkfUDGXRCLZyPm0WhBLf9RQD17lX5COGmEjCzdeiK
ZHuzdFDK0YYCKXq9fvUE1aDL9fe8bSjtz7sRnCBXWvH/Wb39vhQbuq0mvOK5e265
4xdDRBeFVX0dsuBy/0gIQ0i1zG9MayaML0QvqCjET2L9oNGRmuzyCorINFijJtM4
yKg/bDEq8EtnhWmyblVm9HgmKZ92euYYyUxTZS5iA7NrbrFXWqui9HtAcy3dVXa9
WmB6is/oHXKtSQ8WAHYzjd3Q/k753uf0hijQLFpLRg1lLiFEm/qenRh/9R8/+XVc
77g3nlWVQ2RAj675ydet7gpOF1ccrsQbTg3CraPRJsfs2JasEYz0wlFH4kmWTAcj
zX+UNgiclADpqKIquiydOEGBRkra3TcbMlJ0ZLtIdYUo0V8rYto=
=bfSu
-----END PGP SIGNATURE-----

--uwS4iCT+BxiI+7D2--
