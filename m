Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE636EAB9;
	Tue, 17 Mar 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768959; cv=none; b=qdunNrR7KnsaTzfNjk/CS4LkIGLUmGjkJRd3wkj+SVp/DmKKH7xr0N8I2WMZBGc+IsPI9mmugoTOHAUylzSMaGh5zVifddDo4S3S/eLue2aNPNzDEPGYHhcaS8tv17lOoL2jenNGWt2LN+44lsChszOnRq8g58AjQ4r6vQkPpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768959; c=relaxed/simple;
	bh=nL58ZTyQgQKeDQgN2UccFUvwuyhxP5wYCPpEzCsd5nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a83WgulwzZ5sCmIRldtWB7RWRsxoudjAih89SkYIOkkhnGyuOS8hQXq9h6Bouox6fbAcm8uw2kQqvYatiwH4CUfcsvx8xo6Tuw3PIKCna2l8Tm/YhlhkprsFBbB8XRbv9pOuu4oMi+4Y8puMLkTuQSOyMTO2Mnhm74vNbjR2Ix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gR1WX1Pd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gR1WX1Pd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B83C4CEF7;
	Tue, 17 Mar 2026 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768959;
	bh=nL58ZTyQgQKeDQgN2UccFUvwuyhxP5wYCPpEzCsd5nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gR1WX1PdxZLsTNofifTCt//xBohxPiKCWGQV51kn0MRunWIrCvncGfheigoO45CVK
	 9cKpS+OyhP8F73lOgN/8lciZrNj6+ujqb7EDqoAAghVk8x4lLQSLcDOtNCpcaKEg7P
	 qyT5CJwsrN09ZWbvRwh+KiSaOGEb1+hG0ASV9rRDIo692oFPy/8pikXmc/kBo7BvQO
	 qkj5s+LwsvcWhiu9uAiu1CxedUH7FuDL250C8BOpZxY3nnghvmJPTB8m2C2rw9OqDW
	 kmpytxOWAnRopjXGl0lTpIZbMRhhSDDGPdOscexft7WOhjNtSjh4oFFWVmmkKLOAry
	 fUkpxI9tFd+cQ==
Date: Tue, 17 Mar 2026 17:35:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Harshit Shah <hshah@axiado.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: axiado: fix use-after-free on probe failure
Message-ID: <df8998fc-f3c9-48a6-a4a4-33a8726bb386@sirena.org.uk>
References: <20260312102811.29223-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CZljpLV+cYBxkItS"
Content-Disposition: inline
In-Reply-To: <20260312102811.29223-1-johan@kernel.org>
X-Cookie: Must be over 18.


--CZljpLV+cYBxkItS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 11:28:11AM +0100, Johan Hovold wrote:
> The SPI controller allocation is device managed and must not be released
> before returning on probe failures (e.g. probe deferral) to avoid
> use-after-free.

Felix Gu already sent a version of this which was applied, please check
if there's anything remaining to be fixed here.

--CZljpLV+cYBxkItS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm5kPoACgkQJNaLcl1U
h9CrpAgAgDpv5+EP99knD/ps1fLFaukjL88bAiAylF+AD69XHGUPyVAfOP6ttgi1
WpGU5a7OQA1QVs9BfvT9KftHt/7qZGGt+z34+x9+KYK8PhmBzqCM3mapxF7X1sQS
U4ZRLvsrU8FEe4IO/qXzD6hzgIbNWiVjEWJrduuQjyx3cU91+3XIXpUlMuOj0tLh
Af0Acg0DL33bO6HQFhF78lVSJD+zaRov7xYZiMlqqQzgidYQEQRcpP/ikJIvbUOV
8lhGc0Zw6Km6MlCFv336FnmFQjsjtv/VOwVIwSKdGSsxcguIxBkxs/ik7n0CPblh
1eMPXt0nxCNqxYcYeLLfUe2YKDgEcQ==
=EADA
-----END PGP SIGNATURE-----

--CZljpLV+cYBxkItS--
