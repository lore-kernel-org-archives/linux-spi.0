Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FDF46C4B0;
	Thu,  8 Oct 2026 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448376; cv=none; b=rDe/u7PinRlhJ9io5OZHqq4oVb9FphIafWvREY+iL6k6c6iGwFUOmujByx68FNURi67Bz7JKduTjqEajwc0V4HxgAAzZNQYKAcFLy61eLJEm9Kbzsg2spL0QoTRxWr8EGtFz4HhDEWJ7FhTKJ4sUdc+NqCzSSmYimLeRu6cIxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448376; c=relaxed/simple;
	bh=2Y5AyZGjt/AmLcfYQALbd5FIl36G5NmMAj6wzA1rUHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRf2V+iM4lprVp0kPc8nuT0NleUC9BNHCcoeVAA4xEBt98kA9gZDIqdatg386zekN2EZsy8zJ7bBbBgzpvKMKEvvvjcDVpzjHLvH8JEuvUEhRXEPJh4XBRaxlT5i7p0knM+Wq1si8EODedySVL9nQvJ2cnSgXNE6ihzqLrsJ3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSZIqI+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSZIqI+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9721F000FF;
	Thu,  8 Oct 2026 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448375;
	bh=iq8eBcxmqilWyg1kTRJXBDPilNdAqHLw9tPVm6xBm54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FSZIqI+5eN0OMTa541Ep/XXXvSzF3IIQIATRhamU5oibL1crSqXKwKFrGpYWONH8j
	 F8h0Xe2GmdfJ36ZXH9/H4qD/VTcjLPXcwB0nwYTGJ87eoyGSL1AuMjnBY6S2elYgIO
	 V6rr503qHea0rKntXmQryPaxQgPDt0CsxXAEmgTZHehJsYsJQQtVp76tuTSTX+BgS1
	 8rbvyzhmWbnKbKJO0cg7zWz5HfHrGXCMhrt777q3ZVeGGFU6ycSQ5Sp8h7evcdKyh1
	 ewj27Y2hyFNO1WGjIrPG6NIgERQ1z4y7oSg7357M9rXsHGYFB/uDb9HGjHmtvhdBiU
	 5dsxYTxd4IQGQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EEB5D1AC57CE; Thu, 08 Oct 2026 09:32:51 +0100 (BST)
Date: Thu, 8 Oct 2026 10:32:51 +0200
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
Subject: Re: [PATCH 1/5] spi: spi-mem: Add support for panic mem writes
Message-ID: <asdVM883VTQy7WvH@sirena.co.uk>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
 <20261005081141.33688-2-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bMjej1itY0YpvJ9w"
Content-Disposition: inline
In-Reply-To: <20261005081141.33688-2-paul.cercueil@bootlin.com>
X-Cookie: You will forget that you ever knew me.


--bMjej1itY0YpvJ9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2026 at 10:11:36AM +0200, Paul Cercueil wrote:
> From: Tanmay Jagdale <tanmay@marvell.com>
>=20
> Add a 'panic_write' flag to the controller's capabilities struct.
> When set, the SPI controller indicates that it will be able to send
> commands to a connected NOR or NAND memory in the context of a kernel
> panic, which means without sleeping and without relying on IRQs.

> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -398,6 +398,31 @@ int spi_mem_exec_op(struct spi_mem *mem, const struc=
t spi_mem_op *op)
>  	u8 *tmpbuf;
>  	int ret;
> =20
> +	if (op->panic_write) {
> +		if (!spi_mem_controller_is_capable(ctlr, panic_write))
> +			return -EOPNOTSUPP;
> +		/*
> +		 * Only support panic writes if we'll go through .exec_op().
> +		 * The regular SPI path (spi_sync(), etc.) explicitly mentions
> +		 * that it can only be used from a context that may sleep, which
> +		 * is not the case on a kernel panic.
> +		 * If this changes in the future, this could be reworked, but
> +		 * for now this will have to do.
> +		 */

This also needs to ensure that the queue is idle - we'll still execute
spi_mem_access_start() which flushes the queue, and we've got runtime PM
operations there which might be a bit challenging in a panic situation.

--bMjej1itY0YpvJ9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasdVMwAKCRAv73Ows9A4
ia6sAP9XLIb7WVrrhIXZAUfVLxJFlp3a1hqrTX9kyDiYkzJdLAD+JP92HbWPevEy
jt/66JC+BVhdm8A4lcLFxUo7eAT0dgQ=
=YF7K
-----END PGP SIGNATURE-----

--bMjej1itY0YpvJ9w--
