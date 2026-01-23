Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C51C5F13;
	Fri, 23 Jan 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177807; cv=none; b=Knp1smR86HV8zEaps2atZHFf9vTQcB+DlbQdgLARgf7a/ya0tjI14qJvOW3rIffW0K+eQ/PAlJUeOwuvsMAnrf2mO1hJI9IQBqX6SKIIa0d5/pOkaMYSReQSnlkxPvU6fFPCnR9fjQBWPOckD+PU2wAazDhRYY16ObSIeBRBU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177807; c=relaxed/simple;
	bh=Lfix2m7CHWR4q/4Ot9pPOvmNqObBdgXIVfhxOl5b3uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k79P/yt8eATA3v53BUDDl6MjJQZ+SQ5eKIK7yKbmiRzNjUQtrHKjt/jSY2op1tZaZNdmLFziLLdZLgXSJqiY+t42WOjDPtTRiLfiXCBKkKC/g4C5waJmm4u1DfoYS8qNqylMixP8yuKL0B1+HvuUtnNvPrDyErtouBoLKluUIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQvr9df4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQvr9df4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF063C4CEF1;
	Fri, 23 Jan 2026 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769177807;
	bh=Lfix2m7CHWR4q/4Ot9pPOvmNqObBdgXIVfhxOl5b3uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQvr9df4pGkqey+o4bkEBtdj5qVuYvbinZtdsqULTu3EzgMnfLbyYFOUWeZ6evWWu
	 mQHxhIgMLk2YPmshlww1igGtvnsL+oDKlZNxDat+5Czy4zjDpJaX0g9sxOZj1T4DbT
	 dIiKq6dH/Swy3MlUJUnKLw+QM0KPmOMXrhpNIaAmwNwDWeXDxna7u2tQxku5jFJFH1
	 +rfGjL4lqBqks0ALw63aqrWUXTaVCjczZfxVKXIiGc7UjVm1ivWf4HwlbRw9diJXhW
	 CrfwhPIueyn2DKNl2bSY+tMom2tDJ4wpp7ZgADFZ7Xv9K6T65Ngku7pEfYbxrnI7I8
	 LExcG8EFGi+YA==
Date: Fri, 23 Jan 2026 14:16:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Andrew Lunn <andrew@lunn.ch>, abdurrahman@nexthop.ai,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: xilinx: use device property accessors.
Message-ID: <0b74efaa-5ba3-432b-ac96-3a822d9d8853@sirena.org.uk>
References: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
 <d6c5547b-0426-40d0-85b9-b64f183d37b6@lunn.ch>
 <ac0c9ceb-0c34-49f2-a486-1d87e488f607@amd.com>
 <a979b1eb-87c9-4c08-8d30-0fe18ad07a26@sirena.org.uk>
 <c0310e06-4a50-47e8-9de7-581eff6f53ec@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XqqYRgKMyYD36KE0"
Content-Disposition: inline
In-Reply-To: <c0310e06-4a50-47e8-9de7-581eff6f53ec@amd.com>
X-Cookie: HAIR TONICS, please!!


--XqqYRgKMyYD36KE0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2026 at 03:14:22PM +0100, Michal Simek wrote:
> On 1/23/26 13:40, Mark Brown wrote:
> > On Fri, Jan 23, 2026 at 08:11:47AM +0100, Michal Simek wrote:
> > > On 1/22/26 17:18, Andrew Lunn wrote:
> > > > On Thu, Jan 22, 2026 at 09:00:29AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> > > > > +		ret = device_property_read_u32(&pdev->dev,
> > > > > +					       "xlnx,num-transfer-bits",
> > > > > +					       &bits_per_word);

> > > > It could be my grep foo is broken, but there does not appear to be any
> > > > users of xlnx,num-transfer-bits and xlnx,num-ss-bits. So it would be
> > > > better to just remove them. There is no point Maintaining an API
> > > > nobody uses. And it would be silly to spread that API to ACPI if
> > > > nobody it going to use it.

> > There are no upstream users of this driver at all so obviously no use of
> > the properties.

> We are not wiring this driver in any DT because it is soft IP but it doesn't
> mean that it is not used.
> But as you see Abdurrahman is able to use this driver is one configuration.
> These properties are stable for years and well documented.

My point here is that Andrew's concern about there being no users is not
relevant.

--XqqYRgKMyYD36KE0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlzgsoACgkQJNaLcl1U
h9C/BQf/X1Nw6y1gy5HtlP23Kb88LW8EdZkFkQWDOyHnDTSAp+LR0evZ2GVksMDj
zVApyJieSvqNYpp/cUncQrxCvvcGGLoXi1Urc8E5ywkFE7940tt94AL1SmdNxZpy
dO0bsnnLaxFTF/rM6OJH91bCEsbs7g+fe3CJ3Rc+ZffCo+S9P/qUrCa5IRW7u8Sg
vbVrhlX4t06ZgpRtvjBOCfHDoxEPK1tfaiHz2qGhTAV+FsnnCWBxSQchOdmhCZ4B
DCWto5MNFprpNXKEbaeb1oaL7bE93EBNIwLfpN/EIGaIvzdE46PZR3dqgiRa2hEC
srVy4hUKFuX0IYfHNbGOdmoPwv0+vA==
=MGGo
-----END PGP SIGNATURE-----

--XqqYRgKMyYD36KE0--
