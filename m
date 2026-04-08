Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD33A7588;
	Wed,  8 Apr 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650290; cv=none; b=DwCapJbV4objbLlfuvteirXp6PQFnYc6YY5NRoT4085a3M7xZxkfHNTqxQ+IElL6WT06sTZTsa+9UqUB2JKErimsc68yfJIXxKMbLUhVVmSANqIPfcXjkzAebogrP/+3Svp81eMTz5emQldHnJ9e4vfZhgyfnR30OBa0cD3F5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650290; c=relaxed/simple;
	bh=LhtodMFw2/6gKoZTyB7e9ukrGBe+xpLOFlrYpdmVppI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+adbTfsjgobTaW0OUKZvt+XjOy3HMmHVzk9HPFpr5HZ7AJIsvrE+68I0ILXAKG7pk3ZHr+R/3E+f2rLuZfiD+ZzuJBq0+X4xZ4ahpT5kbXb5Fmn0CVgF/sQ/iv9oYc3pNCOszn6yr/LOpgRWMzFcK+KLHsg06t4uxvfNjrMKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InAuYfFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InAuYfFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1702C19421;
	Wed,  8 Apr 2026 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775650290;
	bh=LhtodMFw2/6gKoZTyB7e9ukrGBe+xpLOFlrYpdmVppI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InAuYfFhwxn/ZQHlReZstpkT+z+royy0edL2CV0qdAtpU8QEVp5mYjwf1eepcnIYJ
	 al88BZTAIgTbKGTSV4CLqyJuzxk+a0eHsHCCgeccGKmn7Yp3l383JzU5KtOdM3tKIK
	 rgMxM3P+eNUbCXI+3PnI4f1+jTjsmbOzNaJLLCADbBcwXTEw/ldlsDG9H+3JreTixD
	 a4OX5ChAT6nXuRp+TkJvafmhTLT1e/z6hngCLGAljsd0Qy1zv+bIci/XHQtaDyx/QX
	 uj2rzRflzd4i4SPZ+sceIPD1F9MshVScMwC6wg8Bl5FdXwFM9xNqqkWVCZTWIYbfM0
	 y618bBxn7jXEw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wARkl-00000000iyJ-3RHQ;
	Wed, 08 Apr 2026 14:11:27 +0200
Date: Wed, 8 Apr 2026 14:11:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pl022: enable compile testing
Message-ID: <adZF70NON1o8mmg_@hovoldconsulting.com>
References: <20260408084407.107416-1-johan@kernel.org>
 <66cc9a3a-bf75-4a9b-952d-2da82c847308@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TDXM5U/XEFVB98Q6"
Content-Disposition: inline
In-Reply-To: <66cc9a3a-bf75-4a9b-952d-2da82c847308@sirena.org.uk>


--TDXM5U/XEFVB98Q6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 12:47:41PM +0100, Mark Brown wrote:
> On Wed, Apr 08, 2026 at 10:44:07AM +0200, Johan Hovold wrote:
> > There seems to be nothing preventing this driver from being compile
> > tested so enable that for wider build coverage.
>=20
> $ grep amba drivers/spi/spi-pl022.c=20
> #include <linux/amba/bus.h>
> #include <linux/amba/pl022.h>
> 	struct amba_device		*adev;
> static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
> 	status =3D amba_request_regions(adev, NULL);
> 	amba_set_drvdata(adev, pl022);
> 	amba_release_regions(adev);
> pl022_remove(struct amba_device *adev)
> 	struct pl022 *pl022 =3D amba_get_drvdata(adev);
> 	amba_release_regions(adev);
> static const struct amba_id pl022_ids[] =3D {
> MODULE_DEVICE_TABLE(amba, pl022_ids);
> static struct amba_driver pl022_driver =3D {
> 	return amba_driver_register(&pl022_driver);
> 	amba_driver_unregister(&pl022_driver);
>=20
> At least amba_request_regions() and amba_release_regions() don't appear
> to have stubs for !AMBA?

Hmm, it builds here on x86 with gcc (15) both as a module and as
built-in.

It seems the probe function is discarded before linking as the amba
driver struct is never used on !AMBA. It definitely compiles.

$ nm /tmp/kbuild/nu/drivers/spi/spi-pl022.o
0000000000000000 d __exitcall_pl022_exit
0000000000000000 r __initcall__kmod_spi_pl022__527_2185_pl022_init4
0000000000000000 r __mod_device_table__kmod_spi_pl022__amba__pl022_ids
0000000000000000 t pl022_exit
0000000000000000 r pl022_ids
0000000000000000 t pl022_init
                 U __SCK__WARN_trap
0000000000000000 d __UNIQUE_ID_addressable_pl022_init_528
0000000000000008 d __UNIQUE_ID_addressable___SCK__WARN_trap_496.15
000000000000006d r __UNIQUE_ID_modinfo_529
000000000000003b r __UNIQUE_ID_modinfo_530
0000000000000016 r __UNIQUE_ID_modinfo_531
0000000000000000 r __UNIQUE_ID_modinfo_532
0000000000000030 d vendor_arm
0000000000000000 d vendor_lsi
0000000000000020 d vendor_st
0000000000000010 d vendor_st_pl023

Johan

--TDXM5U/XEFVB98Q6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCadZF7BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQit5gEA5AA27ZUAsNN3opHFcWQJ
jhPoGNLbkx1fn9AyTDi0oxQA+wX1IZ1+N0qfM4dL2xVbikanaMR2n4JjW4Hph/pG
d9kL
=6rCk
-----END PGP SIGNATURE-----

--TDXM5U/XEFVB98Q6--
