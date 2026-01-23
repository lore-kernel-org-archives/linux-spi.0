Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C398834;
	Fri, 23 Jan 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172037; cv=none; b=SW1QTirKT1GgIW4/z4OGD0o7CLSGAUMMDdL+zCw/deuIsFwsUbaHWtnFDGc+DYP9Fib3Gz//sRIWMnjuA7vPbOcyBQ7v25nVbF0b1G6i8+nLBfP/2vVP0718NMOiPFlrHMsToUdJTCbB0i7IXrT8sAEIUHMdPoRKw4sGWX5UnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172037; c=relaxed/simple;
	bh=KA0auLM2WZmdiUqzVD7z426D8s2j5QylO9g+IVKSsos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcxVodBn9UeDLKGRzNa4Om6cPIzrbhlwYJc63UOPWFpzLv7jEBR8ZXsIqg5Z5M30euKd5ojPRko/xqTwWP4DessNpMO2m4WojDHWZg7vc4ullPmRdxYGymsEfarRuaeXpR3S/Sn6sbE+UqMmCJFSQK18ObGTdk5qaLKEcLGbtfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6A/Uhut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6A/Uhut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7DAC4CEF1;
	Fri, 23 Jan 2026 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769172036;
	bh=KA0auLM2WZmdiUqzVD7z426D8s2j5QylO9g+IVKSsos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6A/UhutrltXKg0Ze3Z88CXbsT8kV7KLPdZaxgk9/sV+5erkF1IOxrr2uTLhstJhU
	 pHUmdDhYj1L8O9W7i57NDBgQJeehkvSrqv9lYGP+eVcEnFlaQJT1u1CyEJ69BYnqlt
	 CIAH3/umq6ixwmD4Gk9PxhTPpOC/MevbBxhNXp1YK69CBkobxtl5uV7RcM8Bz8vUGx
	 7AlZHgAvE9fabl9y1jhzc3sH79fLLYMC043soa1Fxeqj75J5F6MwHdLCj2jK7oKHW6
	 k0LtpjN22uIedkIwJ8N4Zsoh8F7ZA0v6PWjPfFdacpgkUFUEstl2qU4wubMaXgi4gp
	 lqBcaOrTr2jsQ==
Date: Fri, 23 Jan 2026 12:40:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Andrew Lunn <andrew@lunn.ch>, abdurrahman@nexthop.ai,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: xilinx: use device property accessors.
Message-ID: <a979b1eb-87c9-4c08-8d30-0fe18ad07a26@sirena.org.uk>
References: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
 <d6c5547b-0426-40d0-85b9-b64f183d37b6@lunn.ch>
 <ac0c9ceb-0c34-49f2-a486-1d87e488f607@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MYMPkRZsPXfWaiNo"
Content-Disposition: inline
In-Reply-To: <ac0c9ceb-0c34-49f2-a486-1d87e488f607@amd.com>
X-Cookie: HAIR TONICS, please!!


--MYMPkRZsPXfWaiNo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2026 at 08:11:47AM +0100, Michal Simek wrote:
> On 1/22/26 17:18, Andrew Lunn wrote:
> > On Thu, Jan 22, 2026 at 09:00:29AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> > > +		ret = device_property_read_u32(&pdev->dev,
> > > +					       "xlnx,num-transfer-bits",
> > > +					       &bits_per_word);

> > It could be my grep foo is broken, but there does not appear to be any
> > users of xlnx,num-transfer-bits and xlnx,num-ss-bits. So it would be
> > better to just remove them. There is no point Maintaining an API
> > nobody uses. And it would be silly to spread that API to ACPI if
> > nobody it going to use it.

There are no upstream users of this driver at all so obviously no use of
the properties.

> "xlnx,num-transfer-bits"
> bits_per_word is initializing bytes_per_word which is used in code for
> transfer sizes calculations.

The example AML posted was setting xlnx,num-transfer-bits to the default
value of 8 bits FWIW.

--MYMPkRZsPXfWaiNo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlzbD8ACgkQJNaLcl1U
h9BU3wf/XVcT8SnLwiHP1ScW3J/ygfIAVS0Cm7z0h9+wPmUAy4PsRCrRXMSi8iDx
zKCwAuFxw1+rAEI4YNVqJDOOdiOls1RL3xnUWpHMLep2iZHDFAKTPHpdPQTNSu9/
OryXysdQU1MV+03dvuFm45jJinr6+/y5XMF5PtOLxbcaLkeQk+nrJ05l+D0zCo1Z
oS9SGIi2pZwyraKRSrLT63plf3C712i/5ZuZE+Zcuhxg9CFF+fVo48yeTW9sxuLc
CzsXNBt7U1PSO5Wi31+V1HFHqguDVpevKxq98Q3yjZ376HmtGYLwSXrKbrHKUz/G
WC6K1k3uTu5agtsgKMFVmFxRZYf+Pg==
=8eDh
-----END PGP SIGNATURE-----

--MYMPkRZsPXfWaiNo--
