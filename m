Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F148B38D;
	Tue, 19 May 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188637; cv=none; b=OMgtBd4TmVP18cwpnsuO6wyJBufDAY23o/r385MP8il1km//YB5P48dTTRwx13at00F7WVPZJrB+e9ktMfwIe34Z6o7ihMrPH/kCEjeWJUHcYmmb4x6eaZXgICuitP0TIMvE2KrBt+J5sMBV0OvLVx+nWcnDOm+tBJ2wGk/55FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188637; c=relaxed/simple;
	bh=V7IBH97Z2/GKxpxpkUNDatXbplsDGhepTwPW4cq1SlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMvM9FuA2XLyuKoNvMzB9zDVvy4iqf06XsAmhOdoKoqbdkImr6FXR4SKghzclZiOW+5bgHLn+lVeUwilD8NJugS21MgsWF4ebg6SlgbibQ9q6t+2eX5X4OET6OB4SDDF8jlb3uVJyR5kEYXcKbYCyIMqrxwwzYMJfciMIBYhvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAWomEkv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAWomEkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC2FC2BCB3;
	Tue, 19 May 2026 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779188636;
	bh=V7IBH97Z2/GKxpxpkUNDatXbplsDGhepTwPW4cq1SlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAWomEkvJnuu2fb+G1+FjOqSf/R4BcWsFt8i+vOAas+teqBq761ZuGVjPSpHhdnvw
	 ocDjxTi/rw0M2qWFYwXQ64sGjBb91U5eDPFtOvh813nl8XGE5EA42c0s2nvGdkmi7u
	 8gobw8oAu9SP39OvpwkfwPW0aVnMO/ODGc9275d0LK0esFDf4+fChboD6Zwem9+3id
	 aR171PWtqm5Hu56m9MWZWJKptcYE/xwoKm0ZWY3kQsKySLd5jDj6bWD9HwmYTYxtQh
	 0kCXY33r5AnfJDrmtZgD/UTbgfBGmmeJg+GrXFK2xyefvfy5UC2fIroOmqSK9PpoEM
	 wzU1Cwzplec3Q==
Date: Tue, 19 May 2026 12:03:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: clg@kaod.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
Message-ID: <659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ym/3v19Weq8ydfWw"
Content-Disposition: inline
In-Reply-To: <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
X-Cookie: Huh?


--Ym/3v19Weq8ydfWw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2026 at 05:57:08PM +0800, Chin-Ting Kuo wrote:

> -			while (k < cols && buf[i][k])
> +			while (k < cols && buf[i * cols + k])

This really needs () to make it clear what's going on; the precedence is
well defined but not everyone is going to know that off the top of their
head.

--Ym/3v19Weq8ydfWw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMQ5YACgkQJNaLcl1U
h9B3pAf/am7wOig3BHiAuTlInU7joZdU36Y27z2iCl3tYJ1+lR0IKbwk13HQ65ha
oelRLYtS0WA/lKoyVTCWx2iGhjhxYTdgiQ1Wpta7YDltIy9DHQLpCZjruh7+kS/G
wqj1XvTObSW5coagxf/u3QfSt6IB2m+X5FlNHTaiG16RFXewUBQH7OtS7+ZHArJ0
lf2EakmCFwG+5NYEzYNe70qY8je0okRhaf1vzeHLbER9t7tpKF4EqJWqysgzoLxb
g+re13ZwT/O+tETcGPFo/P68eMXxqIOq5xvJca98XV4s0Fz22aIHitK8dl+HkPRh
aSZ+o1havyWnTEllOggQHwYQsf+ssQ==
=wLZU
-----END PGP SIGNATURE-----

--Ym/3v19Weq8ydfWw--
