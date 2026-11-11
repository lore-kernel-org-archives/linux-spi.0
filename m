Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419894;
	b=Lv/CRrsiQqLFAsFtBlC72TZZ8WfSBOImNKCNGo5a8aqXBetJNMEQZjzy7giRjVxqN7Zu
	 qrDhnpNEbmNtARt4ZxPbw3DncG61PwbGXkU3VFNJDi/PapqWC7FngpBvBwRhApeZLz+/v
	 y4wQ0HQ0FBIwB9Ah/6yhSq5weOrupWaD1kNi+6bEWR4M8+CURdCTy+9eA1cbb66zEs8qq
	 rQs7JCSNCcSRVRrTFcCfoJzZ+rJzuydJfMSMyPLSRRF40C/lMvhxleYeizgxviMpvc1at
	 CXD244d3tDYRG66SW/9aBdJrxF1LWtwSfI9FsDrTCx2FgE8eexVIzxvjSK//LMJ8rCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419894;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8H4s3shsiQmwooHu/vEAttbU1FoXbJGGHBPwi9lUhVo=;
	b=AJXgdKZ8JaVJR9oexR+q0OjjbGgjgwsT/tPZe7P1ybJOnO6zF0n5u0UidzLnTTltJ6bO
	 tCV6pVmijw4K8CltFgRaAQM7Ea83j1sFnFw0bdSzttNQ/vTuwOXt18umgHFgWrUucXO49
	 EGbEOY/5eNP96GPtf6tGk6/zHXKTyZnOMYJfa9KHI5YL7mjLChiHt8SwVj1fC8U83SyMH
	 2b7B2RV7TRA7kcRDi6BXg3Y1WmwUjM+DbciTsl/0In+FGwRt8yLsLO1a4AWU4mnMUlehD
	 RNZ6nfJgoa/okBeCLbiMo+5bxXnHP9pWRKKhc2lDebFCyIdkk/S6MN6IbJ4pxMmOJXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSa1eKa6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBF606A896;
	Wed, 11 Nov 2026 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSa1eKa6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F541F00A05;
	Wed, 11 Nov 2026 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419893;
	bh=8H4s3shsiQmwooHu/vEAttbU1FoXbJGGHBPwi9lUhVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FSa1eKa6iK3Hr1wpC1pIzdf6eK88oMlzzrfqQaNODrMGRNl6Pa/H7/u2CMiXCBQGg
	 6Oqzq3NSjNsUKdiEqvv9xfEIAL6o9FWD2UqBOV1DlDrdhea/dnYt3PBNjGK637NywH
	 rPKOezfWv+bv1F0U+Wc7Rve6FVlovpOiPp3NXDzuz3WcC3SnvVpYm+CPobCnzLVbaf
	 W6pS63PsSRiF2GAVr3VhssMoQVeAblAcza9/tJzYW5FEkL8aON6IiglF6TS2NuDLCe
	 ITu0b4irQrCGvmV+KzE+G6QHOpY31fy+OFwKHN7HMxYjkbdlJQQBq6abDMMUhNPUq/
	 EDhEIVE6a/0cQ==
Date: Wed, 11 Nov 2026 17:58:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
	Pratyush Yadav <p.yadav@ti.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Konrad Kociolek <konrad@cadence.com>,
	Mark Brown <broonie@kernel.org>, Jayshri Pawar <jpawar@cadence.com>
Subject: Re: [PATCH v2 6/8] spi: dt-bindings: cdns,xspi: add ADI SC846
 compatible
Message-ID: <20261111-entomb-backdrop-815e4dc81c7e@spud>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <20261111-xspi-cadence-add-acmd-v2-6-d339046ada8b@analog.com>
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
	protocol="application/pgp-signature"; boundary="H10kgaQOr2Aztqer"
Content-Disposition: inline
In-Reply-To: <20261111-xspi-cadence-add-acmd-v2-6-d339046ada8b@analog.com>

--H10kgaQOr2Aztqer
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 01:23:07PM +0000, Nuno S=E1 wrote:
> The Analog Devices ADSP-SC846 SoC integrates the Cadence xSPI controller
> with its own PHY timing configuration and with the support needed for
> the auto command (ACMD) mode with the internal DMA, so it cannot be
> described by the generic "cdns,xspi-nor" compatible. Add a SoC specific
> compatible for it.

I assume it's the phy timing that means the cdns,xspi-nor compatible
cannot be used as a fallback?

>=20
> On this SoC, the controller clock and reset are always wired, so make
> them required.
>=20
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Docum=
entation/devicetree/bindings/spi/cdns,xspi.yaml
> index 3cd7321319bb..d6ac05b2efb4 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -18,6 +18,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,adsp-sc846-xspi
>        - cdns,xspi-nor
>        - marvell,cn10-xspi-nor
> =20
> @@ -53,6 +54,15 @@ required:
> =20
>  allOf:
>    - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,adsp-sc846-xspi
> +    then:
> +      required:
> +        - clocks
> +        - resets
>    - if:
>        properties:
>          compatible:
>=20
> --=20
> 2.56.0
>=20

--H10kgaQOr2Aztqer
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavSssQAKCRB4tDGHoIJi
0iO5AQD9XtCG4DPZaY6jzh09TFrUBwyIR9QqELQuOAtjo51ldAD+LhfAwQyByyBd
v3xIVxM/jOZKe283PHf9s+gfZEjApgg=
=/LXf
-----END PGP SIGNATURE-----

--H10kgaQOr2Aztqer--
