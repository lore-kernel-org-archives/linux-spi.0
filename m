Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670F1D47B4;
	Sun,  8 Jun 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749422230; cv=none; b=uFoXdr40opnpENcf73405t1hrwCQxopV51LqFuy4bmV5AYdkUk0C8ypzTNsY2ST4HgzlEcEYoQvhYDPFLP7UgYeNlq4JBSDvuYsbg4VN+m/etl9YWPEj+lm8WQpvRXibRm4WuNQjNo8VLQBkTH7GaujkfiMt1NECEmobOIfsNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749422230; c=relaxed/simple;
	bh=prd3tOf0SvXuPF48qrLMv5PQGW/Mf3lzY1R4U3NkFk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM/drMlV+Q3usOwb1+jGmXvQ2El4DrtFuosgTqu2TUbdfjVxGhNw2aUyaSiENs5IiRPT+9mof4PRhhrfd7sjbyxhdaQiGbIZa3ygt6P5TwBMRpp1kd98BsNkuYjDN1AXVSrlsasIo+O+p+ZfvjiYi9M+xJWj2IUjmGBVvXeuROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6f0QvfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6f0QvfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B95C4CEEE;
	Sun,  8 Jun 2025 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749422230;
	bh=prd3tOf0SvXuPF48qrLMv5PQGW/Mf3lzY1R4U3NkFk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6f0QvfTENNe2lj6vYHStzImiG9HrzHWnlqyEJ420vpn8n0w8blUTtZPEKRaGltMW
	 NxAVlwAW9CZdIKXF5vkM7yHa2eJYB0sbiy5IAIBKANbgiBQJJVAxwgOdgG7ciP7VHQ
	 VTHr+86dU1atQTlicC9EZtRCTGAik/MkTZS9xP0ZE6kmwspomju0Dwbu+4OmM+JRXL
	 7y61yy9WhMRskuXXoaf7I0be3uk4NlSwD1BMwWAuA5Tw5SACSeKZQPCY3o9uEUSmBD
	 labfMYt1W5X+3Y8xrD4Gfr2i6ryR4PQxI3zOVFIFZJBBJjcQpqHAag7KxYg89lenN4
	 IdUzP4DowUfjA==
Date: Sun, 8 Jun 2025 23:37:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v5 2/2] spi: atmel-quadspi: Use `devm_dma_request_chan()`
Message-ID: <77c38cda-7ad0-4893-b16d-33a7a55d1080@sirena.org.uk>
References: <20250505184936.312274-1-csokas.bence@prolan.hu>
 <20250505184936.312274-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xpRD4nOZFRzRxibN"
Content-Disposition: inline
In-Reply-To: <20250505184936.312274-3-csokas.bence@prolan.hu>
X-Cookie: Body by Nautilus, Brain by Mattel.


--xpRD4nOZFRzRxibN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 08:49:34PM +0200, Bence Cs=F3k=E1s wrote:
> Leave releasing of DMA channels up to the devm facilities. This way we can
> eliminate the rest of the "goto ladder".

This doesn't apply against current code, please check and resend.

--xpRD4nOZFRzRxibN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhGEJEACgkQJNaLcl1U
h9BGBwf/U0uYeO/irhlkSLmI5OrYjwEiPAKVvSh1CMw103wqerGcpcr81zg0To40
7/gK2xMK4ZpdhYOuapd4KCSWYW3A7TH9xEau1K1VVpgg/ZrH4Fuai/avuURweqWF
464v9g5PhimDB5dWYO0r9OE6kqTqYBsgXEYV+WgrJS2FuJo0pt720XbKzg14Q4NZ
6ruL3Va6C3kkjfRnfncGfoonyXVohdF06RHe5FckHYEruxTr2BNk+71xVed04ZKI
sh2qqcVBXneHQHgEoUeeyVnj5ywtEWI3KhE5EpF02k/N+KFGCRmop+BsWogo+U0+
DufDwXMnnYsabXtCbT1eQVXuQitZpw==
=mwQ7
-----END PGP SIGNATURE-----

--xpRD4nOZFRzRxibN--
