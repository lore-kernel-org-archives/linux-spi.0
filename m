Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0736BCDD;
	Wed,  3 Jun 2026 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477479; cv=none; b=sQPehqAdfVDCDIbCnBgAdyiuzdrFujFYCmpO3Bq0dqqwnZX8VNTmWaOf2XW166sNAqWmf+fLwk1fA2tAVDib5p9PBrtq/4YRxoarHL+alnLk8ar7vS0UpZN3aQMR09kC9Ib97kupI063IrOeNyD/IE7mZ+S1SRNwAzPw+ymwHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477479; c=relaxed/simple;
	bh=IIqWNvuaCFfyXb7RpNiIEodF4oOXvycYLVDdIB/K0tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msGZ0tLtNltk4rnECsLLwJ/jVyO56peVFpv5vWFe2CGNluBciYcAKBtyPqVw66Ihdo8I/1Ubu7C3OFp7sHu5f9f39Q8fxMF0OIyuJsXLt0/SQyqoOzWR2bsrDjsMw28N3/+LiXfScJADYMd1eQSlmMn+IAiW9wN4uBWe2lPf+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJyQ/xW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJyQ/xW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA4E1F00893;
	Wed,  3 Jun 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780477478;
	bh=IIqWNvuaCFfyXb7RpNiIEodF4oOXvycYLVDdIB/K0tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJyQ/xW/+yUWGJUaRhUBL3xWCEZwCGL+JkBZ0ppz/i4NNTt05nVcSjqOZaSJwAO0V
	 Od5mmEoIdaP4GQ4BCnSY52sd6ofV+w7y+P4tJAIRxQT2jt19jFgF75XfaxRkXyZi1H
	 pJzunLoIOBSQxSj9uFN7jemWHJg7mSP9QPUc20LKYn/K9i2OMx01Zx4PkdUQ5+fMyo
	 eYrLrNAGU5EzXwAdLnLVKhd1SNaTZuW9xEbWdKBr+cX3EKiwC4a+0V7ysPx9lleEnJ
	 7As0RsY0gjKTY0UGtmnE+w0v8YwbS6LEQyuJz8CU+El9uf9kYpSvsdpe4KKbJmV4jF
	 Ky9Fz4P896thg==
Date: Wed, 3 Jun 2026 10:04:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add for Nuvoton MA35D1 SoC QSPI
 Controller
Message-ID: <bc0f42c0-b85c-4239-93a4-429193338f99@sirena.org.uk>
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
 <20260603043551.1062112-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sb6ZY9Vyc+0GIO+z"
Content-Disposition: inline
In-Reply-To: <20260603043551.1062112-2-cwweng.linux@gmail.com>
X-Cookie: micro:


--Sb6ZY9Vyc+0GIO+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2026 at 12:35:50PM +0800, Chi-Wen Weng wrote:
> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Sb6ZY9Vyc+0GIO+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmof7iAACgkQJNaLcl1U
h9DynQf/bCLcSynH3iL4U78NkMHh291CZ97AEcRUiIFy65RAzaofPIvhPKHslR9b
EBr4EebxnhZ5GCPwCK1ZnoMt5Dne0Y0zEXixdN3DzuNwLtY3PpxDj2yQhBKG1crw
VhElpG/aZilMjg4GWHWHo04BUc3eSG2FssD/xWuSSoFjoCMb8B+BLiJJrb2jNEpN
GmBPNCoS9cygrJLHkWvbJ5ixmgFjDqgpKtEo1zyhp82W1KfwUPwxShk3YDxR1Nqt
rZRUC6NKYsHYTeNoYlaCapLc60hQwAWyIP81/oTUMVLm+j7q5IrgaCf6TGYha48G
xnhrOQfPiQpMmTg85oNO12HN5+0iCw==
=M+zJ
-----END PGP SIGNATURE-----

--Sb6ZY9Vyc+0GIO+z--
