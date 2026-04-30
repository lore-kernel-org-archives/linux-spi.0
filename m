Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6C155389;
	Thu, 30 Apr 2026 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509043; cv=none; b=EKPyj2g2QBJmbOK7ZSCrSSpDiBKcSz0DLuhtxWf5aRitnJk2lvLPD6Bp2zlFBlSlHTjB8zHf/48E38fSWB2dn7kqnktpsPEf5a9DBTkZm/DSaTY1rCO7RbwA9wqNRD8/fNVkvoFR4L6JGqt6KGBzb1sDiqNzgT/V1djJmJMnCl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509043; c=relaxed/simple;
	bh=sVsdMb8/GJvdHAdgUuVheDU0zikHaTEO03xWp9KK0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c85TDlX3eKCpCY1JAcvOyPuxuDNvcmyw37oCc0XfuZYVpf0gMAjg6a2N4dFQe+iHM7A7MEq6otSRFj2HiK1pD4/iBCDcJ80Kc58WCIF5bqv6JlHo2sr48Bqpa+N0WPq0exkMlJ1f8RHceBX5VKMKv2gVNbLpibHGDjzuHK31GeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3zeQxJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3zeQxJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78B3C19425;
	Thu, 30 Apr 2026 00:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509043;
	bh=sVsdMb8/GJvdHAdgUuVheDU0zikHaTEO03xWp9KK0vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3zeQxJTQ62yfg3n6jg+Tt0/CR05CgtilhQro4nKVfkqIYDJyPu1dU/7TTnMX79if
	 hrkQ1m1fbBG/WuESJ8TMSFWm/K8nL96/WKwLP25cKGAZD9IUJcfTrDP4QJY2a/rdRj
	 4DnQ/drK9zdT2Bqx6EoUV7OSmeqYk/brXVRAmVIZx+6WzqEJaxteyWgkjN1grIe5j4
	 JiYvrhprzPJ9xp6lYZfumBhZN9um6JcAIQSVaZZFfyCKORXI6gKIOVkfi9xpTlwTPk
	 YGGJ5bGqvxLAVN7Sf7DvfVvEU3FWryVLFlQIG254XpdPfe0XAav3sYn6/z7ysqlLOp
	 qf5tgxvB6B36g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 599341AC585B; Thu, 30 Apr 2026 01:30:40 +0100 (BST)
Date: Thu, 30 Apr 2026 09:30:40 +0900
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] spi: omap2-mcspi: switch to managed controller
 allocation
Message-ID: <afKisC-NX9YZhaEv@sirena.co.uk>
References: <20260429091333.165363-1-johan@kernel.org>
 <20260429091333.165363-19-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hp6T4+P9KbhhLQYQ"
Content-Disposition: inline
In-Reply-To: <20260429091333.165363-19-johan@kernel.org>
X-Cookie: 667:


--hp6T4+P9KbhhLQYQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2026 at 11:13:32AM +0200, Johan Hovold wrote:
> Switch to device managed controller allocation to simplify error
> handling and to avoid having to take another reference during
> deregistration.

> @@ -1556,7 +1553,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  		status = omap2_mcspi_request_dma(mcspi,
>  						 &mcspi->dma_channels[i]);
>  		if (status == -EPROBE_DEFER)
> -			goto free_ctlr;
> +			return status;
>  	}

Here we return directly...

> @@ -1604,7 +1601,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  free_ctlr:
>  	omap2_mcspi_release_dma(ctlr);
> -	spi_controller_put(ctlr);

...which skips the _release_dma() as well as the put - I think the label
needs a rename and the goto keeping (or some more refactoring to also
use devm for the DMA, but that's more work).

--hp6T4+P9KbhhLQYQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnyoq8ACgkQJNaLcl1U
h9Cn3wf+MBCQ+URyJ9B9Dhx3RTaCizxGrEDKOAJEFSsARlOOE/qhqKoiWgo999yj
NFytt9r/XhsdTdecqMkJdgxSruoqaObr4osHTGStrfzpl52epUtIK8F7XGrA41N+
ONu46ErywSzxXUCu5TS5ydjlg1O5vv+q83zEynbYILL+j17/cUdZtj9S/Cz7sB3s
+bzgBgEwOZmohm7b3Xe5U2v0DSCNEshRMa28xy9XRc4K6LBVU7LdQ3NkYdAnBzuO
/dPU8tXjXAerQqE3GqxVltjvR497gxnm6JJQzZ6+lqJH26yK0O1dukSRx2W/Y8Nv
ATrzm0ElLCZMA9W2+3YxiUiYaRNKdg==
=77ax
-----END PGP SIGNATURE-----

--hp6T4+P9KbhhLQYQ--
