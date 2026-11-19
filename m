Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086130;
	b=4U+OB3aKjU61KNePwz/+KNqU56xUu+HA98ZcD9NKFqJrwDEztxG7s124GkNLksiFKStc
	 2ZPc56mRKVGQLu8h8w5+BFAdC6nP2M7rEw4/rGywK/mus6aaLhHiwlgp2NrCX7kyGPDMw
	 rt2CpyWqHcWDFc3/v+YO+jgg1vjwYE24AfkA2dmMlxYfwaAUResPjZOo51nXmzEWw7Hvc
	 ZhkpOcGzfiAKPol5uTI4FYNGElKIrpOw8PP/w9b9zjsz+hRSCE6A7xXtIudzoSdtOW7kW
	 gpsnHXN2eSEF01ts5hs5MLFQFXlAfNnlW4qayadMRzOiE4PsWRYMHEuwn1ohR7eaz+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086130;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iJ289iMCz5xAzHlapJusKbqEqrWvns+8UKRTR9Uk9iU=;
	b=lYqRzghA8PJ4l1Mwt0zYewRcvEFFwAyCn4taZHxLfKNJAZR24VjAqrKHNOadamerxwk+
	 aM3rtW3+ulw8QajM8iBtaMPuK5oz5tAUK5/dBOwawqSe8eBD58HZCJOpRsXDz1jHgoFrt
	 /9bjtQ37w6AfImwyfMuBscpr8P3XhxalaKLCKIl7v+31g4RO1dvYUytzUU47Ou5qLXvcl
	 VIY4MSAUaV0vsd2HfPTElW1J3dziL1mtGRxQ52jVB9CFRhXrmPhjWb76mXDMOUg8kpyT6
	 7c/xkKiwT1BDTHi9BVGOaS4ZEfIs5/oXAjzwjDHxnTxD6P0u/3kRzy82n/6Xr/65yCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcDAX8ch;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865F606A320;
	Thu, 19 Nov 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcDAX8ch
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E132A1F000C6;
	Thu, 19 Nov 2026 11:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086130;
	bh=iJ289iMCz5xAzHlapJusKbqEqrWvns+8UKRTR9Uk9iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GcDAX8chMsZcwHLAlbUXneBa+4Djex+cGrewl4QpZVADAJtpk/2QdeBi9SubUYoZo
	 muDKRCNF/nXOrXp9robQVqMFCNz6aFhcqAsx/lMI3CVgx3pwY/EFcBi7lPEDL4YYBV
	 XbdKu62wgd8VmCiOUzyAblklXJoW6aytT/Cr2ihON33oC0vKh+XHFP6UmOQ5xMtHBp
	 5135ucs6byeFJHFJ8IHGYH+0x1pDu6aWOAjuSyw2oZidfnWkmp6HDwL9MMkEo7/DpK
	 DbdEOQjQtGgQHkLLZ98jGpbomQ1WEn3LYpyOKQV57q9s2z+R4eGtXrl1oggk9UjoV8
	 ll/6ZfOoL2GpA==
Date: Thu, 19 Nov 2026 11:02:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Wang Yang <yang.wang@deepcomputing.io>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yixun Lan <dlan@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	broonie@kernel.org, yh_chung@aspeedtech.co
Subject: Re: [PATCH 1/9] dt-bindings: bus: Add SpacemiT K3 eSPI controller
Message-ID: <20261119-defy-stumbling-72b230220a49@spud>
References: <20261118085742.1817536-1-yang.wang@deepcomputing.io>
 <20261118085742.1817536-2-yang.wang@deepcomputing.io>
 <20261118-backdrop-scrap-1bee34e06336@spud>
 <av4iWQb33bya48G1@aurel32.net>
 <20261119090553.1886090-1-yang.wang@deepcomputing.io>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3eRFCAKT41jyFTl"
Content-Disposition: inline
In-Reply-To: <20261119090553.1886090-1-yang.wang@deepcomputing.io>

--d3eRFCAKT41jyFTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 05:05:53PM +0800, Wang Yang wrote:
> Hi Conor, Aurelien,
>=20
> > How is this "eSPI" different to the eSPI described in fsl,espi.yaml and
> > implemented by a driver in drivers/spi?
>=20
> Thank you, Aurelien, for clarifying this. K3 uses the Intel-defined
> eSPI interface intended to replace LPC. It is a different protocol from t=
he
> Freescale/NXP SPI controller described by fsl,espi.yaml.

Ah I think this might be confusing af, because that device also
supports what it calls "eLBC"...

> On K3, the controller exposes a CPU-accessible window for the eSPI
> Peripheral Channel. The EC client accesses its command, response
> and memory-map regions through this window, rather than exchanging
> ordinary SPI messages.
>=20
> The proposed controller driver handles clocks, resets, link
> configuration and window setup. The EC transport handles the EC
> register mapping and host commands. The distinction is therefore
> the protocol and access model, rather than the use of MMIO itself.
>=20
> I will make the Intel eSPI terminology and this access model
> explicit in the binding description.

Please take a look at a similar series from Aspeed and see if you can
cooperate on creating something common between you:
https://lore.kernel.org/all/20260313-upstream_espi-v1-0-9504428e1f43@aspeed=
tech.com/

Thanks,
Conor.

--d3eRFCAKT41jyFTl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav7XJwAKCRB4tDGHoIJi
0jzJAQDtL5rkRZE8LnDVXeZtgQgA+RtqttjgRFyFtUphoHdWFAEA6xsUZag4jTnB
9N7iFMdYFqfgcKj+Eu+uiTeCMD2HRg4=
=jIrP
-----END PGP SIGNATURE-----

--d3eRFCAKT41jyFTl--
