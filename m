Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF6279DB3;
	Thu,  5 Feb 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318711; cv=none; b=eREBm0pRUqIYynlGx70uxpwcyWjSTcFQsG0XCKML/ylyHbZuKvIhDIbFfp/zJABy10CnBubQo0nIJKaNRKRQPD/XqzCiIFMiADPLZFePCpmoBjySwPvX+AP9ObAiPL8IefDi1ebH/RBFJolIK8ieE0TFEKsekA8iezshJ6C/WPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318711; c=relaxed/simple;
	bh=Jdvd9biND/r/WdJrI+oQtO2ma4r8HnLxLMFiFKljoGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5Z1CUrYmh1UMlDjLIy8o79uTqIREl/RPeCpFU8HV2zJTzVWAPs52ZFCm3HuqC3dao6lfIXpGcFEbuB3gxUB4tNHMA7usuf+wZhaLDT5esXF1GnZiAqtUTaJHDoZgOh2f/vLOGZBgyQZH5tEgnyiZNnvJAID1mFyZS0qpAMpVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1NgKvia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1NgKvia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26EAC4CEF7;
	Thu,  5 Feb 2026 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770318711;
	bh=Jdvd9biND/r/WdJrI+oQtO2ma4r8HnLxLMFiFKljoGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1NgKviaI4JOd1E8pD76RmjeItc+e94R9UbnXP1I+nyqakLlx6/YENdvaqUSVj/LJ
	 fd8xjPcJ1LqK+5fApY5852xi9G4JcGRtI7KmEsqOGM9XHjPpGfBjRNQAVhN3poeOTw
	 vgvH3isrJxqTp//AGHRV6k026/WL7b7UXP+7KCacznQMs/IAt4rx4gSax+E5Z8gFM+
	 XGDzdbQ7QxIp1J3n+pmc5rhQEOAQN2PaAC7y7nC9xum6ciP43yr+jVmYwBHkw7UFMS
	 a6JTa55F2titDZFbzBBTZFS3TyiWjt0LOKAmS+NuY+3iuI3Gk3EiSU8jn39fs8X5qs
	 T6vi/UNcXGWNQ==
Date: Thu, 5 Feb 2026 19:11:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com,
	u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 1/4] spi: spi-mem: Flag DQS capability
Message-ID: <9aaeca54-292a-42f7-90d6-a533ff1f5022@sirena.org.uk>
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
 <20260205-winbond-nand-next-phy-tuning-v1-1-5e7d3976f0f1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="24J2+o9y03R8IWgG"
Content-Disposition: inline
In-Reply-To: <20260205-winbond-nand-next-phy-tuning-v1-1-5e7d3976f0f1@bootlin.com>
X-Cookie: Non-sequiturs make me eat lampshades.


--24J2+o9y03R8IWgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 08:06:58PM +0100, Miquel Raynal wrote:
> DQS is a typical SPI memory signal used to help with reading the data on
> the bus at high speeds (especially in DTR mode) by avoiding clock
> skews. The chip generates a clock signal synchronized with its data
> output fronts, also called data strobe.

Acked-by: Mark Brown <broonie@kernel.org>

This seems fine if the rest of the series is fine; if people like this
approach then it's probably sensible to merge along with the MTD patches
using it and then send me a tag with the SPI bit for me to apply the
SPI driver changes.

--24J2+o9y03R8IWgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmE63EACgkQJNaLcl1U
h9BNjwf9EUEUuHY+UB0cc4qKd+WC0rtyswcboXBt489rM6eND+4A6ZkjdoOZ7QuQ
KiaxQpPtbbTkDO9lfadMjHSk/jlEX+eZjF+SIYFcOYJ7L2ycEpcvIzsjuz2Kfl2X
07ZyH+I0nW9rI7Er/o6ceAeuS3G7b0li69IJ4yO9Lc/YWe4J+QA5ZeR0Zu10vkr7
9t1xIb2G2m1dIpAwTlwMYe5MrmpyYNwLjcAooykRvw7HHi+pKvCMS2pOBSljZzkk
kBasI38h4e48hUVuOzbNUVh3PWtyCI988FeD55mMPVf5ANL7ZI+TJLkz1YLtQFL8
psAixJqHyXyMLpXqTi9fx9+81IAohg==
=TaJd
-----END PGP SIGNATURE-----

--24J2+o9y03R8IWgG--
