Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3248663E;
	Fri, 11 Sep 2026 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134380; cv=none; b=bDiKGzxhO9UMjlMkRS9tBPK3vvM1743a192Rpmn1u/Nbvy5zysKA0WtNB553OUF91HDzLokG6MZ1icDg0U37wcb9srlC494L7Q7nSBqtmp9GzTpKTh6v3HzatONq5APG4ieM9KcUSklzL+qvz7phM0ZJXIzj2p6AHrfriDhhcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134380; c=relaxed/simple;
	bh=sruj4QkA2YGedN1gd+nascjI5b+2/fyRVZquTSuDuSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4ZVEQLmBZDW9SfAfJBQ8Pc/sAQ2w2CFUDpPtBhTuzwDn7/NnBrozt+Lzd1Hfct7VCu98vItYzs3j+jOHT0jjf2CU4j0+p6CvihqHdynfdVMoVh7cGuj4BI6JoGEjBJFBvxyi+rxJTcjeOOEWN+vgmBCAikPS88hPqJP7+iEobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejHacoR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejHacoR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1F91F000FF;
	Fri, 11 Sep 2026 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134377;
	bh=sruj4QkA2YGedN1gd+nascjI5b+2/fyRVZquTSuDuSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejHacoR7vMwp/nduIltNss2cl/5BDCPwXUbYHjJ87vNi5McdYiOmkRgc90OKXDmqD
	 TezNeF70vw8PexNJcFoKH7H+NwEK2n/heByhJ+5htbQD3YRJmsYRUlZYRi07WIKIco
	 ZitujEl3Oc9lBFEf2XnAcaBIgDvmf4Amf0DhKnqmnqhNUz/4UEEe1ShDfHFND+6EQX
	 dhnfcvwUG9hzpkhcTFu5j6lMTZBGsJ2jqYqFWh+6bnIEnnJ5VNrcB28TYnbix+9m8v
	 Uu3onHnoqZAHaOTwEG/bWLREJcCW+YwhkI18I33lYv6YLO2Pet2OTwjC2dqRluVHsF
	 i9RWG5//kgGjA==
Date: Fri, 11 Sep 2026 14:46:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: falemi@asu.edu, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dln2: validate chip select count reported by the
 device
Message-ID: <2519c7fe-f13e-468b-b106-3609e6165ff4@sirena.org.uk>
References: <CA+0ovCivEREvoy=Z-D5TSddgTfFknhFrCBPON3a7QD2Kne=MTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r3IUcwNdSqEbY3tt"
Content-Disposition: inline
In-Reply-To: <CA+0ovCivEREvoy=Z-D5TSddgTfFknhFrCBPON3a7QD2Kne=MTA@mail.gmail.com>
X-Cookie: Piece of cake!


--r3IUcwNdSqEbY3tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2026 at 09:43:38PM +0000, Farhad Alemi wrote:
> dln2_spi_get_cs_num() stores the chip select count reported by the device
> straight into host->num_chipselect, and dln2_spi_cs_enable_all() then
> evaluates GENMASK(num_chipselect - 1, 0), whose shift exponent is out of

This doesn't apply against current code, please check and resend.

--r3IUcwNdSqEbY3tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqkBiQACgkQJNaLcl1U
h9DdGQf7BGHvVw8ukxiTxSxkntN/+0cV8Q+hemRgCIF6sHiSxKxvf6ZZrXlk0usT
pROOO56T0bbfoLHpmT8hSIqxRaUWECYXpPAu5vSdDULL+oD79BNOvJ5ngt27+PDL
Qn0bkIAQ2ystnqig486YaDr3shGu4/5AC75Q1C31DJxiNN3vsmP63FIRz4sqt45K
mgpc5XZytIGas1s1qqD36YtYgLWlaolLDX/aWHgx1/SmyGR4wcnHHHJZdPFIINNL
a67xmku02Y8g2V39cCZC26Nd5VBDYx85Gami36Fk0q3M7TjkeVpFoMfR/JJhHQ6w
eN6vL9Ozrc6/jcBnNmTDzr5/TJxqVw==
=z1qs
-----END PGP SIGNATURE-----

--r3IUcwNdSqEbY3tt--
