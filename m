Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298667;
	b=VPx0vl2YA8Me+q8Vu/dNckf1jl252hbQqIhPioQkcKxSf2olb51JKeprZunfxiOgFYP8
	 V8PzNan5VotvEA7JXvBk9Z9CJN+8kCOaIftt9M+pGLD1UQx500G/NKEewcn7zHvO6Y7VQ
	 kfIXk4mq0SX880YaJbDhklUzU7658kjEOTLmg6RCmntqv0KdK6sxc93hMEMYsj7TECHBx
	 iGohegBEgK++EsZp25k+5kb5nCZ6DtZj9s9WSz2CVAb6ovuz3TxJUEZ+nHqwbXW6ZgZJJ
	 zmJTXixIARtZ6DbMXwmQQCtzepHbFfXiJu2I4xY0LofuyJtWr92PF4a0bPaXsOwfUrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298667;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=F760Mk1uIUQV26WsiHC+9R/Q97QRLIlgW6f//fSzAhY=;
	b=dOosZWHc5ozIoLX5AJtoPcPx/5hUDvPi6io0X4lHNhhx/OTmePKTmLKbHwtZRE8esJXm
	 ShGgzdzXCbVqsBjl3vZNabbp3EbDQHOLQmSAUHzSPvBSVLtp8kTEQoG5NNA3I+Mvf2Zu9
	 U9WSBOLkL8+AUymNLVS+syWEKb3xH9ijJc7uTdBzqXFeffitfnBXduxtIZggGzP5IwAXz
	 zwcVF0pZIFNZNxQ3bCjMRlmyFu9YFrVjBcZDiRY39uLxeAaD2YDxh0L8A1msvTBTSwh4f
	 qiF4lvNpK0+niXTqQsQT26PUSAmYLY8ZtLn9xv2kC3pAncWV7NWP5guAdT4BeFuE8Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ED71jWCp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC088606A320;
	Thu, 29 Oct 2026 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ED71jWCp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810461F01816;
	Thu, 29 Oct 2026 18:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793298664;
	bh=F760Mk1uIUQV26WsiHC+9R/Q97QRLIlgW6f//fSzAhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ED71jWCpo5R12PRzcpdO9+2YMjtHCg494+a/Jlxjwi23poyrxw9wEOEM5/T+ZxcYT
	 Xt25BRLechGSCc+EfhFrf5Zp1/pvQYLlPPa1kkSIsTNm0Ra87PSKa7n4TDNSGZjTx1
	 cFcmXI/ycU5kBg5dWwOpHPEruTy7btKiyTkay1U+MwftaCC/WRR9IxMpxAMdFvIj0v
	 aSnacRKj9M3/5NYIAEn9yEt86jtKjvdrlnD+7JEJpCyIBCNNbpiRTomuaOeP3rWgT/
	 rfflYpNwjJ5xoCzeWbHYyLGwwjYwXaFupVDbQxZzFRCpr6QkjVyk5Mm1z0MfbABON7
	 1APRzm7qy4Ttg==
Date: Thu, 29 Oct 2026 18:31:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parshuram Thombare <pthombar@cadence.com>,
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 2/3] spi: dt-bindings: cdns,xspi: add ACMD and internal
 DMA properties
Message-ID: <20261029-tag-scrutiny-b9ef1299e88c@spud>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-2-53cd44690e04@analog.com>
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
	protocol="application/pgp-signature"; boundary="s+FgKpNUxYDWZfC4"
Content-Disposition: inline
In-Reply-To: <20261029-xspi-cadence-add-acmd-v1-2-53cd44690e04@analog.com>

--s+FgKpNUxYDWZfC4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 04:03:17PM +0000, Nuno S=E1 wrote:
> The Cadence xSPI controller supports an auto command (ACMD) mode where
> high level sequences (read, program, erase) are handled by the
> controller and data can be moved by its internal DMA. Whether ACMD can
> be used, and whether the internal DMA bus requester interface is wired,
> depends on how the IP is integrated (e.g. external SRAM, interconnect
> wiring) and cannot be discovered from the controller.
>=20
> Add the cdns,has-acmd and cdns,has-internal-dma boolean properties to
> describe that. The internal DMA is only used by ACMD, so properly
> reflect that.

Why would these properties be needed? What the controller support surely
can be determined from the specific compatible for the SoC integration?

>=20
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 18 ++++++++++++++=
++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Docum=
entation/devicetree/bindings/spi/cdns,xspi.yaml
> index 38a5795589de..9708ede79730 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -40,11 +40,29 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  cdns,has-acmd:
> +    type: boolean
> +    description:
> +      The controller supports the auto command (ACMD) mode. The IP may n=
eed
> +      external hardware (like SRAM) at SoC integration to fully leverage
> +      ACMD.
> +
> +  cdns,has-internal-dma:
> +    type: boolean
> +    description:
> +      The controller internal DMA bus requester interface is wired at SoC
> +      integration, so the controller can move ACMD data to and from memo=
ry
> +      on its own.
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> =20
> +dependencies:
> +  cdns,has-internal-dma:
> +    - cdns,has-acmd
> +
>  allOf:
>    - $ref: spi-controller.yaml#
>    - if:
>=20
> --=20
> 2.56.0
>=20

--s+FgKpNUxYDWZfC4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauOQ4AAKCRB4tDGHoIJi
0sn2AP9WsI/1zVJ4hlcFyFvGf/LAIt2/tgTfe+4dboFbM/wtZwD/XsvtowiuMsX6
Yz3Yy1K/XjpeAGHRMe44wkTS3zRUpQA=
=bKV3
-----END PGP SIGNATURE-----

--s+FgKpNUxYDWZfC4--
