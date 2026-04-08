Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48906377003;
	Wed,  8 Apr 2026 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648865; cv=none; b=CwmrYk1Sz+WVMhE08eChdqcLcJqTNVq7aaGbeaNmtlubEoKBcRrmfsTCVbceDqPqbbQ5FNjH4zQLqJoAEygGZNmtUuw2qOWPvWoaF25aEc6WxsHaWfcqgJI8PmUJDY1/4kTQuZvaYiOb0kGe+S135i1yPMVKMBG72tgqnV/3gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648865; c=relaxed/simple;
	bh=JVoLmFOJWRdr5KDtDxCz6934aeaW+a8eFGYcDKhk+ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK2cAjqWadrjiLIeAAWwrsFB2X53Q9o03+liSdg/4t7FIau9KODYtxpFvvazMXOcBp+VtMOVEARjxpDkZGZO93kjdKjhdtLCkIbQw7Vi0u44qKTlfq9zfMcbhGGRAOkQPmHk5sfY72r4uxYyB9CvVFNyJv5N1SKzdGkzkCM2FnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjwtG0d2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjwtG0d2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212CCC19424;
	Wed,  8 Apr 2026 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775648864;
	bh=JVoLmFOJWRdr5KDtDxCz6934aeaW+a8eFGYcDKhk+ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjwtG0d2BWTPJpO9NyEoqnlMZ7IN7ySOeFVdDoari4brwmb1tcUNHJDd5csTSCAE9
	 JXpuFGX8yFVB5BnuxzqzR3Mm6Kp/qDvtJVlgEb+MbEITWnKjTfXEnbNjNZFGk5NfSL
	 1GVpSug4RDsjWhf12Ihe5RXEW/jsoMal1vYFhAwmKvzPUoUPpAeIR5gUDXkytm9nzh
	 ZkATrYBcdDHf2Z+kmMazuCrCp0Gb7NrL5z81INQIM5GvWSmeuVsxMUlZuRwKr6WZ+o
	 L6pN+rtXzzDabGPcLiSrty4C8TmY6UrOVrIb9alEPVG24OlNyD3fOrPGO/KcdwpcHf
	 dR9q3sh6bYviw==
Date: Wed, 8 Apr 2026 12:47:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pl022: enable compile testing
Message-ID: <66cc9a3a-bf75-4a9b-952d-2da82c847308@sirena.org.uk>
References: <20260408084407.107416-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xca3QOo4u8tvCQeS"
Content-Disposition: inline
In-Reply-To: <20260408084407.107416-1-johan@kernel.org>
X-Cookie: Often things ARE as bad as they seem!


--Xca3QOo4u8tvCQeS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 10:44:07AM +0200, Johan Hovold wrote:
> There seems to be nothing preventing this driver from being compile
> tested so enable that for wider build coverage.

$ grep amba drivers/spi/spi-pl022.c=20
#include <linux/amba/bus.h>
#include <linux/amba/pl022.h>
	struct amba_device		*adev;
static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
	status =3D amba_request_regions(adev, NULL);
	amba_set_drvdata(adev, pl022);
	amba_release_regions(adev);
pl022_remove(struct amba_device *adev)
	struct pl022 *pl022 =3D amba_get_drvdata(adev);
	amba_release_regions(adev);
static const struct amba_id pl022_ids[] =3D {
MODULE_DEVICE_TABLE(amba, pl022_ids);
static struct amba_driver pl022_driver =3D {
	return amba_driver_register(&pl022_driver);
	amba_driver_unregister(&pl022_driver);

At least amba_request_regions() and amba_release_regions() don't appear
to have stubs for !AMBA?

--Xca3QOo4u8tvCQeS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWQFwACgkQJNaLcl1U
h9Dh6gf9FDbi1UNlI7zTZbZWUHm3HhUPTOkKX3kkHLhMC+HXIv28lHzNfTjtji1S
Eytd7wUKZCWTN0nXSyj+/8PYvpEHTweynIqUJbUkdLivDf+z5VpGixsLrdx+dO0g
k6fyvxkbeUukuT9WUIMDVMl99j/S9IM2U6WZACMovkWlCqFCCd4mIX2p3eWFgk3S
8XdcluhpGshar3TQFJ+GLV/29L7tQwCr4CdfYClbxOVGo67jh5MwtSwxDGVkrpQJ
PPdrrdfzErpxvLX3NeKndKV1XnOIW6JLkZQkL3hYdRjGTEt49Sap2mmQIsSt3tmE
4V7A+ME1hMS3zIxeb8LGWA6MpOKRVA==
=zmB0
-----END PGP SIGNATURE-----

--Xca3QOo4u8tvCQeS--
