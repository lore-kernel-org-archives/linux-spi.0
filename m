Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F847C105;
	Fri, 25 Sep 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347894; cv=none; b=Y1GDBX0pk2VpYIXBr5m7BEDMvC8dGD+5ZbsWmMkaKqdeXUX150BkXW6S7vrjQ+sz3p2KI+8pI7V7CXcbV2cN8w2uHZvl3y+gbpPEPSnXzHwhX6GUpPPPBCpxXiuTn2+G9dEeQm//PR1UiUp5no2ifGIewR0hWIWS77QsIr8IuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347894; c=relaxed/simple;
	bh=Lcufvu9DcRngnHsiGG+C34I8FrTbEUuL5Ug8p2fJxMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI0GkSuSfaT215v5zFX0k2JhZ1/xIIgTz0+0OTyx/YEYIknf/LOTV+Km1r83aPjLirm6P4xgjKyO/9aAFfgd55/apwxrVftZExgGD3exa8XbLop3OU1n7f1nwmJLAfx/4wpfQ0d3rALpHRFfOqhwpZzYL43OQTZURiIKbd0ob5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKcrpjy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKcrpjy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4202A1F000FF;
	Fri, 25 Sep 2026 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347893;
	bh=dMqWeEckCDF4LCt1cE9auikBgmzp/3kSsHAe8tUCFfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DKcrpjy6Mjl90XwbDXe18tt4mwS6XBBEqfStNAHAN5k1ZFZyy1ew7YQWnDfPoHzSm
	 7L0MOyKqP7JfWzPXthU4FB1y0t8VbHvTbrZY6sOIfeolFqhYGacvkqQ3dvpCPjSoaS
	 xb0M5md63n/AzgI3SzyDwrABhP3HvZQzf+oYD2+ZvyxEPidKxe6I5It2Kv0KNLsJS9
	 AK2qR0rlcu8n1Xba6wYqpvgeSL1qht5xLPWeOmf5V1DePIE3C7iT+NxvggdVvtWcgd
	 kLTg7MkyUnguEpU5mv0ddy+PD8sY9B28Lkarz4epSnONLBgz7UNbZjgfv7am9qf1mh
	 P4ue0TyrPZJqw==
Date: Fri, 25 Sep 2026 15:51:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: cs42l43: Workaround for wrong speaker ID on Dell
 XPS 13 DX13260
Message-ID: <537aaad3-685b-479e-800a-a5abb94acaa7@sirena.org.uk>
References: <20260919134730.895381-1-rf@opensource.cirrus.com>
 <aq_4PuwVngaLZ3_F@sirena.org.uk>
 <24c995b6-44e9-4225-bcd4-b4e7f6ebfcb4@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WOhxICitd1WRa8Ek"
Content-Disposition: inline
In-Reply-To: <24c995b6-44e9-4225-bcd4-b4e7f6ebfcb4@opensource.cirrus.com>
X-Cookie: Love America -- or give it back.


--WOhxICitd1WRa8Ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 02:14:34PM +0100, Richard Fitzgerald wrote:
> On 20/9/26 16:14, Mark Brown wrote:

> > Could we see an -EBUSY if there's something else using another GPIO from
> > the same provider?

> I'm not sure what you mean by "another GPIO from the same provider".
> If you mean can the codec driver also try to read the same GPIOs:

I mean we're looping over all the GPIOs from the provider, what if
something else already requested one of the others?

> 1. No. It's read here in the SPI bus driver because on these systems the
> cs42l43 is the only device that appears in ACPI, so it's the only one
> that has access to the ACPI GpioIo(). And there's only one instance.

So this is all hyper specific to some specific systems?  I can't see
what in the code is limiting the workaround to those systems, but it's
possible that's in wider context than I looked at.

> The ACPI property takes precedence and overrides the mapping, but the
> specific case of the cs42l43 SPI driver we know that the node containing
> the defective _DSD property is always different from the node containing
> the GpioIo() definition.
>=20
> On the Sashiko complaints:

If I care about Sashiko output I'll say something.  There's no harm in
looking at it and it's possible that some of the stuff I don't mention
is valid since the false positive rate is such that I can't generally be
bothered to figure out if something that's not immediately obviously
valid is actually valid.

--WOhxICitd1WRa8Ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2inAACgkQJNaLcl1U
h9CQAwf+J4PMZhdsNHQRJzqV+FDJch8hmWUdwZWuSUYdC1wd6iiXBDEQ/vIo97Bl
aiqhoHik3qD+1TwxkW/DCY/JVMvezvWj8zPtNYgcsQ1AetfQ5OA76EdD0RtR33Vm
euPckYZ6uFvwfYEWw0PUlulkoDOpmeiW7/R90uav1AGwNEeNOt63dmwElYCQQy2h
VDImWZQYQltIsYIpJAqnn7xH0novCWRBqQo4XYsMF+dQuuieDXTsPprGbuXIqVEL
3MJOE7YUlRrgJTL7PlrChPo16J1xzmK63U7nxARv1PDW9bZdfO79fV4PNN3uaXuT
SYcyDSxCktMfOPsufgUd2Az1u1NAgg==
=frWQ
-----END PGP SIGNATURE-----

--WOhxICitd1WRa8Ek--
