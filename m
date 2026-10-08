Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222C3EC830;
	Thu,  8 Oct 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448608; cv=none; b=H7eeP8zLif7VSPk3JN35x0P5KMvf63EvVfR1TAScFAPh4M7JoZkbNJ7d+fLiPZXpUJVhSVj/ewgulPzvQWC6AJy2tZoLjlAStwsvRlTzcFAFJKsaaZe4tIkuzUeISdQXWGMxGYvZs/LmGZgxG1wDt/ClOMLdv6Xx7aHoEa2QA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448608; c=relaxed/simple;
	bh=2CnL9zUWhVoDK+CrhOc4XAGFdTLKxKk4z4dtrk7xVJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTYnN0Sfn0yq0ydy1cRdY1j/Rtltrbhq/L/LZILSIgfAzksbkYGm2A+hkuUAxOhYM+/7rP9W2RGzNIP5u819f0drOyGehqIQU4l6MTWvbJsm8+01tNrYvW8ZbQ+187UI+G4Vgv4+WJnWm1wsXpQrNxqCjUipAnn0k+eV5VGnVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl9HS+hY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl9HS+hY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E871F000FF;
	Thu,  8 Oct 2026 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448607;
	bh=2CnL9zUWhVoDK+CrhOc4XAGFdTLKxKk4z4dtrk7xVJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hl9HS+hYhcUaWZQ+m2rEEM+ITObU/vWUZx1BDy/OoEKXA3sZ+PhMmaWMATUSBxoKv
	 W1DdoJdfwS3W653HZNJfR1197VkjVc6ojEBzR8ZKG5FTibA20i0ZjdcBJEMHwBBFeY
	 ZKuTtXtRHAcdJvb96vgeBV9W7frxYHWslkBYQJXCVplu+mNW1SUyQr7DHlK96M1p/B
	 5ih7PtYZL+gWPzUW9WV+mSbsby2DqzHXMNfB7nf02XU8/HahcuDdRWM7Ezdeq9vPH9
	 5yx81leof3+gjaE9tcuV/Hfk12dOlvOsJYvJCaCKEp0KYFTKy0t1LQy+uv//7rVNmi
	 XwaoyCADJY86g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 3F9531AC57CE; Thu, 08 Oct 2026 09:36:45 +0100 (BST)
Date: Thu, 8 Oct 2026 10:36:45 +0200
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH 3/5] spi: cadence-xspi: Add irq-less support
Message-ID: <asdWHQGNfEeGop2M@sirena.co.uk>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-4-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wJo3xw8ck7BgNLyf"
Content-Disposition: inline
In-Reply-To: <20261005081141.33688-4-paul.cercueil@bootlin.com>
X-Cookie: You will forget that you ever knew me.


--wJo3xw8ck7BgNLyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2026 at 10:11:38AM +0200, Paul Cercueil wrote:
> From: Tanmay Jagdale <tanmay@marvell.com>
>=20
> Make the interrupt line optional. If not provided, the driver will
> instead resort to polling registers.

This needs a binding update to make the interrupts property optional.

--wJo3xw8ck7BgNLyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasdWHQAKCRAv73Ows9A4
iWUOAQDv4d3so/X+bhkXiwXbiv6FktJQd3kLoft2zuG5ZbHvWQEAmrSz/6cIYlHX
JE35pttFWPJJ0Vqr4e5t5xZuFSZ4sws=
=sI7R
-----END PGP SIGNATURE-----

--wJo3xw8ck7BgNLyf--
