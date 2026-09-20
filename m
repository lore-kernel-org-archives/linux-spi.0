Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA683C660C;
	Sun, 20 Sep 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917251; cv=none; b=kIsG8yGoXHY39xOm3Y9yA50ZXaYYGj9kw7Y6YK+M9SHrhp6a4z02OoyA5kSUXZp3Tkf5/su1nxowsOo4YFVi17pBLO7nBXsw0QfHU7kNYFrJ8n5rr+/IrnLoj7V+/WOeXXnS6WmRVeNd6N/553iVI3Z0A5p0hza5BOjGHtoR7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917251; c=relaxed/simple;
	bh=9JFC61fLcqOJsrY9G9LCQS/YXmaR2eiPpTUSKkDZjG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O19PgID5DMvFRO92Cz9PtFlCXplytP+CdJK0d7bfUfTtIXm9Sr/zaLYAiADqFYBei8ZAdYQy9qolfQbxNxtGLik/gNEgjeHULnsvJt6QdOTwgvbbTegW/xWvSNi6SIwPDhW2IKzj2PZJPPU2097axPT7jD7nxqaK0XlZ9m/sk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M//vKF8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M//vKF8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2791F000FF;
	Sun, 20 Sep 2026 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789917250;
	bh=kZaPaPWcaqh/4FwcKd+l66xVOigjD2gi6FGr27tzrt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M//vKF8dSfjDgMT/VoBVgl4UO5heb4Pq4T88rUJfJyuwOLtYq1GahYbR4WvBctN1m
	 X2k/TuQqPpR6RiBNvxQoQ3Gx++y/gtpBPuD5NwoIqTJ1X/VjlNVtzXZ2zIq58lqHTL
	 y3zgJLdMPFelWQ4dgvMohYVLJuW3S9a0wDIKQ3C8rVjZi2OPxwpfSLw53ibQKZlfcI
	 5RyrEjYUTNYwGVfGNFL9WlKBOkO59BMNLHkWYO9qJnX8HNAuVPY+++6h8Nyfmbm0zU
	 rCIJebLyddsPk/hQekX73m+kNmVF0WFC6cEXUlHZR9tIIKlnwfJOyIdlKJZej4vxEz
	 Njsh1BEFXWIJg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 6BF7011D5575; Sun, 20 Sep 2026 16:14:06 +0100 (BST)
Date: Sun, 20 Sep 2026 17:14:06 +0200
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: cs42l43: Workaround for wrong speaker ID on Dell
 XPS 13 DX13260
Message-ID: <aq_4PuwVngaLZ3_F@sirena.org.uk>
References: <20260919134730.895381-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8efyI6YdWTD1N54N"
Content-Disposition: inline
In-Reply-To: <20260919134730.895381-1-rf@opensource.cirrus.com>
X-Cookie: Orders subject to approval.


--8efyI6YdWTD1N54N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 19, 2026 at 02:47:30PM +0100, Richard Fitzgerald wrote:
> Create an acpi_gpio_mapping so that speaker ID GPIOs can be read directly
> from the ACPI GpioIo() instead of relying on the spk-id-gpios property to
> have the correct number of pins. Change the reading loop to read each pin
> one at a time until it reaches a pin index that doesn't exist.

...

> Instead of quirking this specific system, the code can be rewritten so
> that it will always use the direct GpioIo() mapping. This works on all
> ACPI systems, so avoids having to keep adding quirks for other systems
> that have the same ACPI error.

Is there an overlap with cs35l56_try_get_broken_sdca_spkid_gpio() here?
Didn't check thoroughly, and if they are doing the same thing it's
probably reasonable to factor out incrementally.

> +       struct cs42l43_spk_id_gpio_mapping *mapping __free(kfree) = kzalloc_obj(*mapping,

kzalloc_obj() needs slab.h (which will be implicitly included anyway but
still).

> +static int cs42l43_get_speaker_id_gpios(struct cs42l43_spi *priv, int *result)
> +{
> +	struct fwnode_handle *gpio_fwnode = dev_fwnode(priv->dev);
> +	struct cs42l43_spk_id_gpio_mapping *mapping = NULL;
> +	struct gpio_desc *desc;
> +	u32 spkid = 0;
> +	int i, ret = 0;
> +
> +	if (is_acpi_node(gpio_fwnode)) {
> +		mapping = cs42l43_add_speaker_id_gpio_mapping(priv);
> +		if (IS_ERR(mapping)) {
> +			ret = PTR_ERR(mapping);
> +			if (ret == -ENOENT)
> +				return 0;
> +
> +			return ret;
> +		}

Could we see an -EBUSY if there's something else using another GPIO from
the same provider?  I'm a bit fuzzy on the ACPI mappings so possibly
that can't happen.

--8efyI6YdWTD1N54N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqv+D0ACgkQJNaLcl1U
h9C33Qf/ddWofx892QH4FfM9tTxo6KjLtZvjyew8bzgUUdbzqGc7jbNmsMKcOt7K
OONzUN8If/RNQRBG61cHQTUe0/skcjBvvhk1wWMoviitL7oAOWCN7WWqoZ04cI21
oVrjByKwtv50wlye6YgCXRCsi3mcS5QFjNIahv+HLulVJh37RFQt9FvkuduAnAge
Qpv/KuIChuUher/LMBviHFGuRW8IqzhnkGror/i5AU/M+6W6nQOpllhprrPAx5LH
2R0V7WHn7O7M4y+/Adul9QVpMGvenYPLkitQ352+OiCprBRJ4G6MKDNgB/fJMYh9
s9+zuNOsqsPZ+fj77cljOYx8ZwL3Qw==
=my0V
-----END PGP SIGNATURE-----

--8efyI6YdWTD1N54N--
