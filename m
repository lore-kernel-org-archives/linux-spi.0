Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F191E9B35;
	Tue, 28 Apr 2026 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335458; cv=none; b=n3ywUgAEC2CjRzQrxpNg6pYRPSzUvQxCzSn4EyPvvIHTdUQQbSfFOr0Q04waPeQhnhXeG8Ab8MfavKy5EYPMTz/g1x67wnwArKRJt4wj+Ll46+DPXZUFHy909R7R7g0o6tRldJKkNz3r1cryPP4oIyMexT/W9MqXJnLwme9je9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335458; c=relaxed/simple;
	bh=6RCzVcVHnWB7Xitp60ejz8BoMUtumigfr5ZwTpbOtJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4DsFcLzyuh+itm5J8CSzCUzOhA4K8aI+QTPGBhCzfZGpRbZjNAZ3Ihl3JldSSAwmYqoYjOmme809qq7in34h1cPvH3E4VBYYHHu4WE6kBdVAQGXOzgEL9k+NN/ZnA0X81ddIyUg9oTOoSB7HljkRjesl2keNUAZvU0uXJ0IKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ78DAZp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ78DAZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13E9C19425;
	Tue, 28 Apr 2026 00:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335458;
	bh=6RCzVcVHnWB7Xitp60ejz8BoMUtumigfr5ZwTpbOtJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJ78DAZprfEadaOsdbT59/5Ch0WQGduepbtv8F020hgjU0ql+lhvRnGHz+VTrwjdD
	 5EehzHaQkK4rgZw4wM0UqMP8ETaTDZ5Ty7c8ziuHuG1jCyEJwPH0J73BFEm6rBQt5a
	 2vnTUPGVi01plwJSvt8F3c41VgmDMblGOalFxUzPx8tP/M1X2C+lbKUewl/KpFHy+y
	 4uSL4AejTYdfJGJ13o6kdZnGmIhMQ5rZY4rs/o+kOmRIXoMPCbB7clr2ulMJ0kkE9S
	 Ui08MzklpYlwOG35XfZzRRDEkmC0qg5VUlKHcASl8ufgrTMib9ww8R+rO3z3BYWcx9
	 owOWzMyrBOOgQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 31EB71AC583E; Tue, 28 Apr 2026 01:17:35 +0100 (BST)
Date: Tue, 28 Apr 2026 09:17:35 +0900
From: Mark Brown <broonie@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH v9 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
Message-ID: <ae_8n0I_ORDLib1y@sirena.co.uk>
References: <20260427-spi-spacemit-k1-v9-0-ff753b551302@riscstar.com>
 <20260427-spi-spacemit-k1-v9-2-ff753b551302@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uloWIL4Vd8FJnYvz"
Content-Disposition: inline
In-Reply-To: <20260427-spi-spacemit-k1-v9-2-ff753b551302@riscstar.com>
X-Cookie: Victory uber allies!


--uloWIL4Vd8FJnYvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2026 at 10:01:28PM -0400, Guodong Xu wrote:

> +static int k1_spi_transfer_one(struct spi_controller *host,
> +			       struct spi_device *spi,
> +			       struct spi_transfer *transfer)
> +{

> +	/* Record how many words the len bytes represent */
> +	count = transfer->len / drv_data->bytes;
> +	drv_data->rx_resid = count;
> +	drv_data->tx_resid = count;

This is setting up _resid with a number of words.

> +static void k1_spi_write_word(struct k1_spi_driver_data *drv_data)
> +{
> +	struct spi_transfer *transfer = drv_data->transfer;
> +	u32 bytes = drv_data->bytes;
> +	u32 val;
> +
> +	if (transfer->tx_buf) {
> +		const void *buf;
> +
> +		buf = transfer->tx_buf + (transfer->len - drv_data->tx_resid);

This is using _resid as a byte count.  It'll be fine for 8 bits per word
(which is by far the most common thing).

--uloWIL4Vd8FJnYvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnv/J4ACgkQJNaLcl1U
h9BKxgf9HFwNyeCFgiJ1m6lF9UKtdez+pweMTHvDt7wqUtMyufYwnBTIxOIB3Kv7
mh5QcTbeorohLLIvkOV2893vxCNwlLyZdUU+dFQak6B6RQGSYLJoIjDJtSuyjYhM
T+2YKiSllt6ejJCezhmo56WDtVCSJR820A3qYN+T5B/52xwFkNa7SoiBG7PB9Wya
57r8VQLQ4ZeG5MBmwHe23njUPZj2WYYwMUo0Uz0j+9H1gdPugU1nv7B2q9hKCRPe
Xo1mIWG3NiZ28wHyCT73ICpkRSOj62o8nw9EUauWSu9hwI6z4wT508HxWY+tkSAy
qBlmsjEqZ/rJtgIQyFZsnKgAi341Vw==
=TBfs
-----END PGP SIGNATURE-----

--uloWIL4Vd8FJnYvz--
