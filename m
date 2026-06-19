Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85432FA2E;
	Fri, 19 Jun 2026 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781890412; cv=none; b=Tf4FUIhCMafDkh9loeFp8hxZmt9jaV1+gf/mrAZkuk49x6eGZPR+NkQznjmIzm1zFbSZY7Sg+AnQAxzZB2PCkeguMMZt+6m3ov6NxON+K3DvqQ5uYoxXQkyyb9m+vQ1h8/aWdGNkWr36shiC8+TVEnzPqj1MAF2jFueeglt0DHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781890412; c=relaxed/simple;
	bh=APf6CYk6N2Dr+Hehj99OXrNN3/3jIhG22KAimTo/SCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3bYRTqPnFqCULHKaFOKxE2knqr+Bkvdvv8YqcBdFP+ocjGddzltwH68cb5qHXmje6WTc6qePCx972Hz6QgfZqgpEHlaYCYarEHxgrY6piKHP3RxFmwpGe8GtYQLMCoEE+ytFs8OFBW7P+Imr9dNTb2FNrWvP1BA+8sSsdn4voE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc02rNxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc02rNxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8E51F000E9;
	Fri, 19 Jun 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781890410;
	bh=jUAGYTKOtwMpNBSHQMUJ5aes50Gr7xk+ZO5i531tYG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nc02rNxNGB+A8xG3KABMWnBbTanTkHfoAO1dG+WRyE2ITIbzZRejVtJT+Y5ZAeB39
	 0Cx4+Xql/dyHXNrsxqTHCQTMWqSWfnmd09A0ITkKCJdX+rJf4fwPXoN+Qpj1OcCyVG
	 8MJFO3aQRYU+cckSsLKhh7P3u4HmJ3A9NctgLvdyEJtl2tHMlvxq0gTr4Uf4Kt4GiV
	 jsadi7RhuMv0WPAjdAwtSItBxDbQnM4hCZ7bQ4KfptPqdTPHoFqBYSOoQgMvHszDQo
	 EaoIsr1MSLjG7bey5jSmQZBRt5bBPf3734uSnn9WsoduQULWPifW99gLYFukuGwz3O
	 SXpfQSa9Q4ugQ==
Date: Fri, 19 Jun 2026 18:33:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com,
	a-dutta@ti.com
Subject: Re: [PATCH v4 08/16] spi: cadence-quadspi: add PHY tuning support
Message-ID: <bc3d98bd-bfbf-4981-8c14-4ffec0f55f7b@sirena.org.uk>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-9-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emUb/++xjn7z2sWr"
Content-Disposition: inline
In-Reply-To: <20260618073725.84733-9-s-k6@ti.com>
X-Cookie: Courage is your greatest present need.


--emUb/++xjn7z2sWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2026 at 01:07:17PM +0530, Santhosh Kumar K wrote:
> The Cadence QSPI controller supports a delay-line PHY for high-speed
> operation. Without calibration the PHY is unused and read capture relies
> on a fixed delay, limiting throughput at frequencies above the base
> operating speed.

> +static int cqspi_get_phy_pattern_offset(struct device *dev, u32 *offset)
> +{
> +	struct device_node *np, *flash_np = NULL, *part_np;
> +	const __be32 *reg;
> +	int len;
> +
> +	if (!dev || !dev->of_node)
> +		return -EINVAL;
> +
> +	for_each_child_of_node(dev->of_node, np) {
> +		if (of_node_name_prefix(np, "flash")) {
> +			flash_np = np;
> +			break;
> +		}
> +	}

This isn't going to do the right thing if there's more than one flash,
that doesn't seem a super sensible hardware configuration but I'm not
sure I see anything stopping it being set up and system integrators do
enjoy differentiating.

--emUb/++xjn7z2sWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo1fWQACgkQJNaLcl1U
h9CBbwf+JUro882D48ocB6LXQj2ooeWVcGnBvdpgmPzUwbsP7ETh+7BH1ofWUp8z
58gs3CxQfnlH6CosGuHQ14dJmr41Lc7YRjOMn56SFgJFnNiYN72XRLqT5+SQD6cu
D5Q/Wiv0oI7F1wSRMPyTU/8XWMxHFYl39mX4gqiI5Q+IcGzQw1SYOliNeZ4djAVa
FDkRmkvMJNphmQMgNyNbK3WGP9HxHI+6DKrCuliEcKDX2OJ/UBXvrw6JtSGXYavl
OtPcY2UsK8fwFKuLmPV23w6QBFVD4krToRNED1n+koRWwOuZNtQ3zr4nRYTZItQ2
pEOS4CCkI2cEPPu79/61uPeZ3IITVg==
=wojw
-----END PGP SIGNATURE-----

--emUb/++xjn7z2sWr--
