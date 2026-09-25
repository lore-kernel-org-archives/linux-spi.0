Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53E471CE4;
	Fri, 25 Sep 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337603; cv=none; b=GQbKRsMeRdoV0AUn1GveTtNfkSGwhlo2HZRyszhV9Ne67c92qlMKNyA7DnPIrWfJhAPJZbAguzZrtVU6xoNIdLsT0477WVg06kXoR/nzabz/qiFdIQLUCLSjWDI9YTGhbY6pLt98BKpkW/AhmhPfXZUkfJqfQtAdGEy0GuZWM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337603; c=relaxed/simple;
	bh=wcFx+NSLHXnNYa8iMdvZaIg7OJRD4w5e5OPyy2AjYGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5PmvU/Yc+H12kpBWRJq8umkKxL1b2Rii/f7AubjNtQBcq1wSwzs3mG3d3WyCKru4ZTsx7Sz5g7Z1K4cNCFk0p3GMXiwH9PvS+dk1QhSSGeYLm9W9uNN525VdZaCVf5AVinV+NNB6GqkBdnJ2WPvM5S4jL0GRxud9Gf2ajqzURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSjRlykW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSjRlykW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1112D1F000FF;
	Fri, 25 Sep 2026 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790337594;
	bh=yao8TTMKIXgdl3wojlTg6Y/FV7O0NF2CMfYlrTOp9Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSjRlykWg86Pu/F5pZgdu+XMDVimFtOYOZIljKg1P5E3dX88R1AGcXUDCo9B3qOT1
	 l2DYpCyMSOEYqTWEkc3I0iw1bb9xY4mhaGznERZiWWfD5M/O44bDcY/S3LB20qnSWk
	 fMCTe4duP1S5JUTr/BjOO8hvPQOqi2ROhZapmoSNM6XYX2yOPQD/puh7tLADBJEybm
	 QjAmA5I4pCZln8uFPMdeA1VFKcg06nE7xBFAj269LT81vuGwSLrZjmY4e8tNU3M6Z0
	 5dgSzQozSQqr5WE3uKkW/TKS9efUKP+zrmEZ4JW3QnKbCmzIbsmD2TaaMwU0GNqbns
	 YoWhtVKeUehzQ==
Date: Fri, 25 Sep 2026 12:59:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Fei Xie <fei.xie@horizon.auto>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parshuram Thombare <pthombar@cadence.com>,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
Message-ID: <85dc596e-4378-4d23-b48e-80053cb5166d@sirena.org.uk>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <20260921093701.1341766-3-fei.xie@horizon.auto>
 <arFEjzkHGMbecWWV@sirena.co.uk>
 <20260923061211.1608907-1-fei.xie@horizon.auto>
 <67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
 <87pky1ll4g.fsf@bootlin.com>
 <arZHjbzUEFhydnHt@nsa>
 <87ecehljdy.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jDLHmqGwvebW3fWJ"
Content-Disposition: inline
In-Reply-To: <87ecehljdy.fsf@bootlin.com>
X-Cookie: Love America -- or give it back.


--jDLHmqGwvebW3fWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2026 at 12:23:21PM +0200, Miquel Raynal wrote:

> > As for PROGRAM and ERASE commands I really did not saw any added
> > value.

> Yes, most of the time is spent in the wait_ready, which is not getting
> faster with hardware automation.

It might potentially help a heavily loaded system if you can do fewer
waits, the rest of the tasks running on the system will have more time
if we're doing fewer waits for interrupts.  Not sure it'd be enough to
write home about though.

--jDLHmqGwvebW3fWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2YjQACgkQJNaLcl1U
h9BG/Af/VlsMwBCFOEYj/oDnzW99d3z6TFME0rFxNTBnEzGCGCwQXc5d7DSDtg84
XV7214iwuiQXIFuZpbAXAETQ2r0W24h1lISlLeKyqlkKmBQ14RGQJNpUVmv80zqs
aWk7Q3qFkWWnJJrPFNiApBREsaTraPIXydnWkx5khAjUNn5U7kTWWPbB+ohcsLEQ
TFlyHV9six7mwAZeUMqz606OltqhLBHxPF8sKp+6/PhhlubMYf9DYtwGUHbGYVRp
ucYW2ySARCKDuRWanGABrLA1DRuTUd9OLzx71srTgHR5Z2TsSvGsu/7kNvcnAw0c
YPXZKonOnwLBQTzkS+gGouRWZDyAPg==
=ueYj
-----END PGP SIGNATURE-----

--jDLHmqGwvebW3fWJ--
