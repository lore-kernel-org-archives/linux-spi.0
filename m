Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F253DEFF6;
	Mon, 16 Mar 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686960; cv=none; b=pRNjvkn2A5qGFMDFCH8sRnkjAbRCT/srdkV7Gtll8IPfpHePmst5l5dh1BloUWFI6ffnAB0VoAWyVZ3plvhWVHFY9rHLma7DfmD4uQv1m2ukYQuCIM/r58DPKGQurr4hrHSOVGldwMDZtI3YdRuhWjnkzeymaFVHkC7wCv65lgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686960; c=relaxed/simple;
	bh=2IxvQZYqeeFGPbIivEchlH+syjCBxggxKe+799lUBJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt6Jz7kAj+CSefFnOpqHFQtLKbr0BL8OXaKYrUVC8KSdFmq/TC9FD0ZWKbIosVYBqz2WNU+zYFo4pqmFzZMXsPbnxYENlUP/QDwxGPRUfsLTKQm7/el9ZkHZEvQKTw9owCU+2APxQx1H73++b7NIgi6upjB/kQholJ2dtZgP73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbPIaRr9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbPIaRr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D39C2BC87;
	Mon, 16 Mar 2026 18:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773686959;
	bh=2IxvQZYqeeFGPbIivEchlH+syjCBxggxKe+799lUBJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbPIaRr9VUsDQXpDKYWPASJn7CctFBA9UncZ+o+Wy9BWCtlNZQoUKecUqGcWtfbGy
	 vadef+uXrkQWA5k+N45WMJSBmKIUH1Vy0E2Y6pm+PsG7Mz4B8/DePBjOa1XPEm7zR9
	 1eTEpvb6Q/9mDaiRfIVVTgBee//XEdnzg20r78baG5myWTHQaYNGQAAtuBHU25rCDn
	 PxUCmeG8c+sNKjVw6ASDhLMDLjTjK8CKQdHWKc51YFmlNcxd6lV8m5WtTcz0t95ke5
	 Euz8lWA0TFp18Jm/u1Aonc5arraver8m2OYzRAyMF4L2nXGJljfvM0fEyU/UN2ax5o
	 vTX9+orYYFUKQ==
Date: Mon, 16 Mar 2026 18:49:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH spi-next 04/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
Message-ID: <585afe0e-0ffc-44bc-b3d2-63e5075ab1f5@sirena.org.uk>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
 <20260316-spi-fsl-lpspi-cleanups-v1-4-1b695607702d@pengutronix.de>
 <e4c711c1-5229-4685-aadf-f88aca9fbd3d@sirena.org.uk>
 <20260316-original-dove-of-respect-1a6e04-mkl@pengutronix.de>
 <0f04cc7e-c960-42fd-9a45-49777e49dd4b@sirena.org.uk>
 <20260316-venerable-caracara-of-advertising-a9e9b8-mkl@pengutronix.de>
 <b6787850-11cf-4b38-a5ea-da2c5d0811f4@sirena.org.uk>
 <20260316-imperious-amusing-dogfish-0ca492-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rw9a4v8lJ2g0AlWx"
Content-Disposition: inline
In-Reply-To: <20260316-imperious-amusing-dogfish-0ca492-mkl@pengutronix.de>
X-Cookie: Not a flying toy.


--Rw9a4v8lJ2g0AlWx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 07:31:04PM +0100, Marc Kleine-Budde wrote:
> On 16.03.2026 18:16:01, Mark Brown wrote:

> > Oh, dear, so that's potentially going to go badly if there's a SoC with
> > a bigger FIFO that didn't also increase the watermark field width.  We
> > should at least warn about that, and ideally do something sensible.

> Good idea, I'll add a warning if the FIFO is bigger than the watermark
> field.

> To handle this situation I see 2 options:
> - warning + limit the FIFO to the usable size due to the currently
>   hard-coded watermark width - this will result in reduced throughput
> - increase the watermark mask to 8 bits - which is basically how the
>   unpatched driver works.
>   As outlined in my previous mail, the other code in the driver takes
>   care that the watermark stays within the limits.

I guess it depends how optimistic we are about hardware engineers
keeping the FIFO and watermark depths in sync.  The first option is more
defensive, but like you say it'll hit performance on future devices that
do expand the FIFO.  I guess I have a slight preference for that?

--Rw9a4v8lJ2g0AlWx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm4UKoACgkQJNaLcl1U
h9CEjAf+KX4+iymhin68XpboextOC8PLGsCkhHStdjVb/VglAcc//7Nn4NwkZrQf
lR51mQXi/VlkfjZL0LJg6c/U19pfjT10arDI0M98pqpjUIcwieAvjCuzQVKjMDKr
Z0WbORCnZxYuU2WMNouDxd09DHUZw2LGtyBP0nNj7cnZlg3hfb58wmt4xh3DVQjt
x562KjthLTQqYPATWVTExekjLQc2iLnCKppKvJ9N+x7LWb6f+qWeyEW0vr2W3Zv6
319hd99BGZStC1ztY0ibrhMjh961O6rn8l2cPneispqgHUvfR5drfgym0xUz2WPr
4S7yduT8k2TkDWts05MQn9U/ghbrrw==
=kcd0
-----END PGP SIGNATURE-----

--Rw9a4v8lJ2g0AlWx--
