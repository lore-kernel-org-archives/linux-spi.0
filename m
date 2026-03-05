Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531D282F11;
	Thu,  5 Mar 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748868; cv=none; b=bICqhmiG8resHn/3pZViUbWYPr+/J1guC2KXVgN3qcvTGadhC8DFZxdAE4ve6J3+op1j1cgc9hFnWcjGqyoh3u3k/y1Uyu2QmKVQVA6c926BRSmBCjkUWxMDdDCRHvzZ5dyALevc/EgpOrt61Gxv0zvSvgDdYACpi/ouhhMB5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748868; c=relaxed/simple;
	bh=w9TjvGcKwJt8/ARHSEztsvDfZLAllFDGqn1q3g9Xd0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhl0qlwnOELBESPBeLaUkbb6jonE65K+e5nh+8BxgoBCRiizmzFCSVY/L5MeOgpYSMpvLateBRVz5twJrLtNQLgiUU7ThBU3j4KVImknqJgqmiSaRQU6KvU95GyE5IkzxzQqHyiSUcObb7nSKX2C5qm7kQAiV0yU0hOX8Swkhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8LIfBUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8LIfBUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BF0C116C6;
	Thu,  5 Mar 2026 22:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772748868;
	bh=w9TjvGcKwJt8/ARHSEztsvDfZLAllFDGqn1q3g9Xd0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8LIfBUNHfNlibr/LWwaJVc97mlmmpka3bZTOtYcYLewV61glSEY65BPIi89kVjse
	 aktYtnm8J8wbRpWVH6pQlpHVXyj57XCUBqn7uvSMs6oRTgTNTEvdFG0o9X9MBJBhjf
	 H3JgF4iPNGjmU2x/kKAIQXB9q0kj6ByzShtSMNLC4Rqj5BLZ3irmhbFoN6G4hooGRS
	 h6nqq8pycmsEKZ6ywT14M4laQkXWpZ0o2NgkM4lRgC0WWAGNIbIZ5cJxu5NsZobzph
	 LbbNyAhJ73PMLjO3VyswNRriU/pQS+AxYFPQx8gb3YuZe8C6mHDs/SvfpDV9obO1wj
	 ffjs0SNWQKyIQ==
Date: Thu, 5 Mar 2026 22:14:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Han Xu <han.xu@nxp.com>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH RFC 1/7] spi: Add 'rx_sampling_delay_ns' parameter for
 clock to RX delay
Message-ID: <c5c762db-86f5-4ca8-b2da-a7e0b73b8f27@sirena.org.uk>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-1-9326bbc492d6@kontron.de>
 <20260303210131.2966214-19-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b1uVgqjIjfycBOiD"
Content-Disposition: inline
In-Reply-To: <20260303210131.2966214-19-Frank.Li@nxp.com>
X-Cookie: Onward through the fog.


--b1uVgqjIjfycBOiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2026 at 04:01:14PM -0500, Frank Li wrote:
> From: Frank Li (AI-BOT) <frank.li@nxp.com>

Please add a human step before sending these reviews.

> > + * @rx_sampling_delay_ns: spi clk to spi rx data delay

> Comment is too terse. Expand to clarify the unit and purpose:
> "clock-to-RX-data delay in nanoseconds; see tCLQV in device datasheets"

I'm not sure restating the unit in the comment as well as the name is
super useful...

> > +	/* Transfer characteristics */
> > +	u32			rx_sampling_delay_ns; /* clk to rx data delay */

> The inline comment duplicates the field name. Remove it or expand the
> block comment above to explain when/how drivers should use this field.
> Also: is u32 the right type? Consider if negative values or larger
> ranges are possible, or if this should be `struct spi_delay` for
> consistency with cs_setup, cs_hold, cs_inactive above.

...especially given the contradictory feedback here, and the comment
about a negative delay is obviously not appropriate.  I'm not convinced
anyone needs an explanation of what to do with the field either.

--b1uVgqjIjfycBOiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmqAD4ACgkQJNaLcl1U
h9AnSgf/aUqkU1qA+35Es3IE9yRd/Tn35gI+K3cIbQwk2tKVgQ3JnJBxhVyqE0XV
RCO3HXJTjOF/G+5OUcCyE5O0fPnHv/83+tKYdO6gteK2qDmL4FQOoxEo7uyhck0A
wCEyYwQ+mA30wOE8S5d4npnhB9K1aIw1gMGFjvUfWUc2gHysTVL7mJOM7oo24dCB
kbfSgaXXcavf8j8YQQLMzjuJ6xAAYf0Rkgw6cNr7nuxI3bUK6jJPY1z9FpcKj6rT
MNcV9et+BaiGEpoVKmx8sGybIkhD9XNHhFHJLlNLi9LKhsVhzzmGQ/n3mUmpaeE1
8B5vtuGNBMwiL4K5tZ/FoXEL0RhlaA==
=yiHr
-----END PGP SIGNATURE-----

--b1uVgqjIjfycBOiD--
