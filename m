Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AD4CB5B;
	Sat, 16 May 2026 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898844; cv=none; b=KKRXxuIxWkiqeCux4LkT+glSIC3KBd3mbdvajCNBnut76d0VkQj2Jj3ufhdC7BSH8CZNBUP2KBfve0lcRzbugLBePxGv+5r+0Cji+LcJlqEkkbbkGOoLIqSTQOqtZ/xgJJH/DYyv3dTswP8uHKWu522fLehkjlYNAB3Obo3OlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898844; c=relaxed/simple;
	bh=tC3tc67e1rjXFTm4a+YhTFeCUO8009I38itP0yRFXMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXvtPl8vzVKnBSIVP/pzci2uBfJYcd7+GsKeaQJ830GXbuwm1dXyZw1QFb6XYnHa7CgWwBI9MwNO6rc52MSZuoP7x/cNRMRVfXFPGY/fGeXh+IJIaXExA6XowU73xfWVqxbxYE3N6/ow8HhJwoyJgaJ4/xrH+dGMITxPlPIQ09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvIBi9PU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvIBi9PU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73CAC2BCB0;
	Sat, 16 May 2026 02:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778898844;
	bh=tC3tc67e1rjXFTm4a+YhTFeCUO8009I38itP0yRFXMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvIBi9PUWYnPP3LrOg9tJKZmzOvg8Ht38jk4zSpWK+cAwNU/86F6EyHglftCPSP36
	 7Lf1wuT/DMUALD8MsdgHlztc2CdIQa456GvdQuH8224rh05pDA0lHVN75JTadBFQkW
	 fJfaVKAGDWfF00B5OcUcv4L6XLBdMPsWRDfvlK7pAluxz/h/x3CQNTKjypcwTnxQsd
	 UxSwt1OcjA+fDt411NEA/FHJTuZ2rlDlN/767g+HlUqI1OeaUwdZ/WSM367fzhDQg3
	 kI9bTGnqJ8AECEFMwAkaSg+KuCCpmWDzcmwtD2f9BhK6lSh+gOoAjjEgFnZoirIuYa
	 NfAIOUB3xHOBQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EA71B1AC5A48; Sat, 16 May 2026 03:33:59 +0100 (BST)
Date: Sat, 16 May 2026 11:33:59 +0900
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Wenyou Yang <wenyou.yang@atmel.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: atmel: two fixes
Message-ID: <agfXl-FiZ-PN_cGT@sirena.co.uk>
References: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgBfB4Al75NmT1Tz"
Content-Disposition: inline
In-Reply-To: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
X-Cookie: Truckers welcome.


--xgBfB4Al75NmT1Tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 16, 2026 at 01:20:33AM +0800, Felix Gu wrote:
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Felix Gu (2):
>       spi: atmel: fix resource leak on DMA buffer allocation failure
>       spi: atmel: fix DMA resource leak on probe error paths

This needs a rebase for current mainline, I didn't check but I suspect
it's conflicting witj Johan's fixes.

--xgBfB4Al75NmT1Tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoH15cACgkQJNaLcl1U
h9DSqgf/SDvgELG0D6BD608Bqj/xKOajAIUp9OE8LrfZ5JvHQbD2bjmnozLy/ioO
dFsUzuZg1nBvofOv7dWBtU02vywfsr/e4jiHCJHkP56xMwFzbaOmZrgkWWoKi11X
tGOjT4NqNKs+cEd2TM3kNbdn9U4oL9hzkxi0RpXMLuoQ3z5y2H3WGWnTlDwTFZgp
6d8bsmlCva36OkslO9QIP8dqr7495k9TNo+32t0G156NON6tDZqxK4LZ9Ah4g6S1
lxaSQCzj8/1RMkuQYCis9/9VMlWTzG5d/2+Gi5WdRhJjRKot8YEW3CYbUIQT7OJk
Xx69cEkD8d3oQiyqzP8SBrNKaFfgpg==
=+a7L
-----END PGP SIGNATURE-----

--xgBfB4Al75NmT1Tz--
