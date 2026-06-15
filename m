Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB41A6800;
	Mon, 15 Jun 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523957; cv=none; b=F8mjy2y25VpMxGIHs+Xu4Y1DeA7K3Dry8v8Jz0GDSXBEPUGSEnK0p1x692runYD4cPVXpRn3P0d4a5/mv60n7H9ZlAZ2aBtIvghm0kaQXClErdmXFDJrpj05QcbzcWgE4dFzt6MXpani2p6LeYZZxKpAiyRbjq1YbxIRZJYYrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523957; c=relaxed/simple;
	bh=yYc7Ac7XyGZOrltM8nT86fjG2nfQcBxaOu3f1ay9NMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7A1csFC6TeOueFu3Tooiu62+zjCoi5YSJTcjYOFkWjUwOLFhl01FNyRvZkF3j4UcB8FRm1CABvPBQApAZgg81BmWfbVaorXpsEjSrTVUnR/xtSVKQok7HQXR+IvdmTAp6W7xLXrnA9lGrVCnKR12RoWE+vrjN4QJdRa2+AioRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdmLYTh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdmLYTh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A41F000E9;
	Mon, 15 Jun 2026 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781523956;
	bh=yYc7Ac7XyGZOrltM8nT86fjG2nfQcBxaOu3f1ay9NMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WdmLYTh64eVTybjTk3GEJHTtM7d4RyEgs/jevXYI7yIBtVR3csgpMBUogINM0TWyB
	 0MioJzKLo/8SoB8zL3lA41sAlXMFDeOy4nzgkFx7f8hPKStDr92ADsVGyS3p5G9ZUw
	 tCgaSHsyps1x+264hz44VABUfysEyXEtBvNJIAqJMCrBrevF14fOlCVPSqZNQ/md81
	 wW0uP5hBZEOjZHg7lysq16qYIfF/hodnviimN49WLOJddXld3iNBwf62uW1QSLmQ+8
	 q30TyNj1vjOzATtKWpW5iCQsnruzlqeLwyhImnjEAYiEkmGsJDII+9VAOPG4CU5xYs
	 GXI+glb/kAWqQ==
Date: Mon, 15 Jun 2026 12:45:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RESEND PATCH v1] spi: uniphier: Fix completion initialization
 order before devm_request_irq()
Message-ID: <dffb3303-6371-4415-ac0e-488c421e2555@sirena.org.uk>
References: <20260615023415.190655-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E9udDncSR5MQRtcC"
Content-Disposition: inline
In-Reply-To: <20260615023415.190655-1-hayashi.kunihiko@socionext.com>
X-Cookie: To stay youthful, stay useful.


--E9udDncSR5MQRtcC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 11:34:15AM +0900, Kunihiko Hayashi wrote:
> The driver calls devm_request_irq() before initializing the completion
> used by the interrupt handler. Because the interrupt may occur immediately
> after devm_request_irq(), the handler may execute before init_completion(=
).
>=20
> This may result in calling complete() on an uninitialized completion,
> causing undefined behavior. This has been observed with KASAN.
>=20
> Fix this by initializing the completion before registering the IRQ.

I thought you were going to rebase this, why resend the same version?

--E9udDncSR5MQRtcC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmov5e8ACgkQJNaLcl1U
h9DnhQf/TqVWYIYObZkRlWHMCFZI/SOnruaxzdWNmtOVZzTD7hKF9YHekhf7UiOL
ZXQeSEV2jGTQLrYvirhQ4j2CowakasUTO7negD+eLEAIVPfJsK+ePBC+yHSQRolO
2luHKCSFSdZokVg0wZnka5QmVFC8ORsGxIJqTrjx332v+pe9UhZvkxwSfzfMsTgR
Wq3Gtpazv9WmhnDT0WLAaMEgMFWYdqW1CkGK/PDdkGUVUEC99rtP1X8xKPpv2l9W
Fj2v4Yz+yUhWe+MVqv61asoQumqckKGZm90BUZgCDamGYObdxZp26eDUHSjrfMzF
ZN6G1r8GaAHxPeTtC0V/vaqDuqe99g==
=PWvI
-----END PGP SIGNATURE-----

--E9udDncSR5MQRtcC--
