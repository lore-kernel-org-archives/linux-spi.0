Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A564219F6;
	Thu,  9 Jul 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600265; cv=none; b=J0UlIoqc+dfGK8pfTxc+QdiGbXMrQyrwrRUvkgzHRI7b7IqNFBBsAh33dQtjHWyS0kVoV6DTuNPkEaGt4OdN3OsMFaXyXWnEscu0xi9odvy4FGjXdNCDWBiY82HivU+T851zLcUdld2+P8htgNZmKQKMEmJT3cEGqyYVze6rV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600265; c=relaxed/simple;
	bh=Kd4NBNv+JPrGPrHCy95MEswdC92ezY0vpr9w627tsCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj13lr6R6PSSOd5KBEr29U70IsKv6JYGRDrh3pXYSAS4WdZqL1dUMGnCSqOTQysB2TCY7YVRtgd5u6Npa9imqPZAKKGXpXZLYdO/ahx3KWYe+oIbPMhOIIYCiOgpSoYeQxyem9AbumWODIZXXWRGeN/3dOQctiF4QvYRgV+cgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqBGz4IR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqBGz4IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C981F00A3A;
	Thu,  9 Jul 2026 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783600264;
	bh=Kd4NBNv+JPrGPrHCy95MEswdC92ezY0vpr9w627tsCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IqBGz4IRXoPI1GqtYy4ej7mhohuF7hXU+ywvU3KVqJUSgsDxB3f8AxrgBQz7RGdae
	 N3Mlz5IS9f1Z8arSR6nDyraxM28Hlv7RKB9JJaf+jylKQoxUmOpZVh2DaEZsqJYjRh
	 pclSTKi9yqplC6gXRzS23XpORP1YW3+h+3TzvqhRrN/y3/DqwKI3kEc6A3eAyKFHNp
	 h5i+azNE9Y46sabrdwNNlAbOFI4BI1ux4TdrzIwR36JL9d3UtItKpZYMluTBf8rwwg
	 ionXCRs9AS5qoWlHaC8atr343NYCQo3nJhIYaYTgTlt0wXddKAMh9udL2xrvVIzayc
	 QwZ4qwknK3JIg==
Date: Thu, 9 Jul 2026 13:30:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, tudor.ambarus@linaro.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com, luka.perkov@sartura.hr
Subject: Re: [PATCH v2 1/5] dt-bindings: spi: Document LAN969x QSPI
Message-ID: <d151cc26-aabe-44df-8b55-d830af97bd43@sirena.org.uk>
References: <20260709112006.390742-1-robert.marko@sartura.hr>
 <20260709112006.390742-2-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mH7z/dQ9Z33mkKO4"
Content-Disposition: inline
In-Reply-To: <20260709112006.390742-2-robert.marko@sartura.hr>
X-Cookie: MS-DOS must die!


--mH7z/dQ9Z33mkKO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2026 at 01:19:07PM +0200, Robert Marko wrote:
> LAN969x has 2 QSPI instances, so document their compatible.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--mH7z/dQ9Z33mkKO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpPlIIACgkQJNaLcl1U
h9B7SQf+JYxR2E+1y6DqzmpAzovfm06hV1X8TJjOX6tLg5si37+iBMlnh5VUfFFq
Cf1BRqbzyROuW3Fa2Bo0Ts9zpa+aGOgFfoh/6LNFwlKSzJKKOIWhA8Vuhz6e7ICR
r374LLQs4yu60/qN126W+ejhmlNvTHHny98QUePxUJH3pOD7kc/3aeDb9RP+mIle
Zt9VtHxV6lM2PhVfK2SLAprun0SmAUHhYBHGrJOR74GZHZIcBHpEzwXxpzdjOq01
c+qhyF6cifUbWH3MVKdYLrUh9esvLIbqOY+YYdYRBZTqZn9+z7DtvL0oMPhNSumz
dX3h+uQfSD70qOswhszqHGdXfMOTUA==
=f3gd
-----END PGP SIGNATURE-----

--mH7z/dQ9Z33mkKO4--
