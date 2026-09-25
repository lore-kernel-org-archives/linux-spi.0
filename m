Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC09349CE2
	for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339185; cv=none; b=CezMi1VMTxQp8Op2s8O5P8rMyIWBd2RA2RR1hlCO0x9cDwaPkL7SnFsPpxMMbs7J2AHf9Ya6Iz4S5wV7IZ+8Z673FSkWve51hCU0ETN+evOGTM2k7F4PgWaVhHfV3p0zWDSKofuZQZHuAxWxXojgP2A+zXBPjvK24/1CSc2dx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339185; c=relaxed/simple;
	bh=afWnVZ1G8exZ+i2ohaM2c7fDP6sFFHebcYukXdXvDVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WImhf5kPHWFb1eTZmIljAW7UNK67KTqQccUimHA3qwqbdgwVhOmy2uQDVAucs7RXajFDGz2hfivbiPxGh6Xz+hfGijDeFBhYWDu5woetzDLNM3bLIC7Lutw50uLEDNKfDNoAyblEOHwPSiIIMvTAqbQfAWshZcF5zwH/biy7VB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYtoTe+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYtoTe+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262D11F000FF;
	Fri, 25 Sep 2026 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790339184;
	bh=hm+YlcEmEAPA9dOOIEx/A6hhNWZkI4TqSNI2fWxoAgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eYtoTe+A0h//jL3b/28Oht/WbacMwYZh+/TIKs1Mew4VFprwoj0GQtZA5N0ECF+TU
	 CxLbtyFYa47Q8mutnBBYsCacVL208B2Pg0PgG/iAwgV9P11oTWqfTp9B2lV5R54i2U
	 v9Kz/bcnPSy+G51mBEKMRVtfVjHuccIAWHPfqEq/IeOO6bLgGo58pHdGantcvoCed7
	 ijLQP3eynkHGKAFTJo64hHmjdvDYy+NT+FN4UMdv2FwuWSxk6RZMM70Rra2hoIe18/
	 JmejMkQzqpgDG7Cn3XkztrmThdEPNRixajRdi+cvfwFZkW3GLytA+v8fOIVyqUkFQt
	 BDemiRBMHktfg==
Date: Fri, 25 Sep 2026 13:26:20 +0100
From: Mark Brown <broonie@kernel.org>
To: "Wen Bin, Leong" <leong.wen-bin@hpe.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Subject: Question about lack of timeout in spi-altera-core
 polling path
Message-ID: <22c2d358-9e6c-4ca6-a498-18b09e34efc9@sirena.org.uk>
References: <PH0PR84MB15263715756E3D68DA63C119BD812@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
 <c2451875-9217-47ef-a8c9-486b9215a7a6@sirena.org.uk>
 <PH0PR84MB152600654436F023F1F5BBF2BD802@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mRelSdkWU/eSEuvi"
Content-Disposition: inline
In-Reply-To: <PH0PR84MB152600654436F023F1F5BBF2BD802@PH0PR84MB1526.NAMPRD84.PROD.OUTLOOK.COM>
X-Cookie: Love America -- or give it back.


--mRelSdkWU/eSEuvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2026 at 12:20:59PM +0000, Wen Bin, Leong wrote:

> Thanks for the quick reply and clarification.
> Understood. In that case, is it okay for me to proceed with implementing a timeout as a fix for this issue?

Yes.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--mRelSdkWU/eSEuvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2aGsACgkQJNaLcl1U
h9BDbAf/VWaFOpUuzGkHQzrVqTiwRvPYl8lEuAKZWVCJbOvsrdMJW+uLCwzF7pEv
8b2RAjhutBYKKWVTCJe1ROeVE4ptp7S81G9AVuvlIwHcKgMWc7TGRPl/YVtSU52U
LZ0C/OhiznoncNNTzaojU0CEhxgAjgEiTlU12UUA+UOSJPD+uVtsMBbp4aYwtvqw
eevtQTAS5vdeJe9oJcf3nOFRkeaU2XU2Pjj+N905vbnX4HwV+4HZIcC9d6OY+rLJ
dz5t5Wr0iGSKrDaIY13QP8p3+0fZ0NPzLiTY4DfHaWKQoyZ0W1seR1wiqmHuadrm
Ql929LKtTpMH+pGjlB/hZipamM98Ow==
=OuHP
-----END PGP SIGNATURE-----

--mRelSdkWU/eSEuvi--
