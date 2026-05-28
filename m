Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D73B8D48;
	Thu, 28 May 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989824; cv=none; b=aiysi78EX3ubg8xC8thpWSRn3mwg7c9gOiCGDyn4DXofyn4N257Mkb+ggdE4wmTaseVsAu1nkZWAhWfVeGVzWL122iiDRuyXnBl8E6V33GTM3RvHaQeSpDScw5x1koyHH748eu4cVlkOWU8ff+HEcyFJ8BSlt57TiOCT0dWa4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989824; c=relaxed/simple;
	bh=WtqR32Sk1TdIvcqyWQMopsFtKMiRE7pJG2DVRB3We/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMN11twO511CYXL34LobqO93s7lDm5BXJzx8OMh12aiwmbrqLTTjUL/LhfeKx7MqyM0QYhcDzIIxq7DErewAcTwvaZSWluMjDLfdiTrSTdcJVQcd81x7w9nE+bT8V3r85Cg3+TP9eEnIfTaNa/6i76WKVoYeCRjZdy5LQkyno+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1NWSE88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1NWSE88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22881F000E9;
	Thu, 28 May 2026 17:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989823;
	bh=Ew+PCmfH8+DLsOwWNMBYxmqZmSklKm/4ETgUFhXg9U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D1NWSE88IZHKHzj0tlR39Y8NgfRrnNXWwA0F+h2NYM7OD/4tZNAPq+h+Fp/10Fe3W
	 srednJmCWPp4AN+rRShTEU9k67QguKkuzScp0RHzNyHnh2YafJiZBqB2DMKVSVH+CR
	 pMbVlEz4A15oeXjrPlNK5EV9EJ70eMQ816Qf9PIU2Qkq7fhumFr51cAoKgO9qF53hM
	 Uf5asWGQlyochEMKyu3A/+IOiMoVJTfKyM2rRLP8nCj/aZyGF2dBXo8n5Q5ihaaHzk
	 aOgWbsubLI3sYQLvN+ovVW1zOpDVyZnCrPVuSQMqL4wI9s8P/j6MzpqX9fE+HhZomD
	 N+IryXlU2O4HA==
Date: Thu, 28 May 2026 18:36:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com,
	a-dutta@ti.com
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
Message-ID: <20260528-clergyman-kindling-20971775ba78@spud>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-2-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pQNz/q7IjnyAqEJl"
Content-Disposition: inline
In-Reply-To: <20260527175527.2247679-2-s-k6@ti.com>


--pQNz/q7IjnyAqEJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 11:25:15PM +0530, Santhosh Kumar K wrote:
> Some SPI controllers support high-speed operating modes that require
> controller-side configuration before the device can be driven at its
> rated maximum frequency. In these cases two frequencies are relevant:
> a conservative speed usable without any such configuration, and the
> maximum speed achievable once the controller is set up accordingly.
>=20
> The existing spi-max-frequency property accepts only a single u32,
> which cannot express this distinction. Extend it to accept either a
> single value (retaining full backward compatibility) or a two-element
> array [base-frequency, max-frequency], where base-frequency is the
> conservative operating speed and max-frequency is the highest speed
> the device supports after controller-side configuration.
>=20
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Pretty sure this hasn't been tested, dt_binding_check cannot even build
processed-schema.json with this applied because there are multiple
definitions of spi-max-frequency with it applied.

The sashiko makes the point that this breaks every binding that uses
minimum/maximum to set constraints too, because these properties do not
apply to arrays unless applied per item.

I also don't get the point of this property, why can't you just set the
max that the device can do and if the controller can configure itself to
be fast enough it will do so, and if it can't then it'll pick whatever
the fastest it can actually do instead?
Seems like you're abusing a peripheral property to encode information
about the controller.

pw-bot: changes-requested

Thanks,
Conor.

>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.y=
aml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..c88f6f3a1801 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -41,9 +41,15 @@ properties:
>        The device requires the LSB first mode.
> =20
>    spi-max-frequency:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
>      description:
> -      Maximum SPI clocking speed of the device in Hz.
> +      SPI clocking speed of the device in Hz. Either a single maximum
> +      frequency, or two values [base-frequency, max-frequency] where
> +      base-frequency is the conservative speed and max-frequency is the
> +      highest speed the device supports after controller-side configurat=
ions
> +      such as data training.
> =20
>    spi-cs-setup-delay-ns:
>      description:
> --=20
> 2.34.1
>=20

--pQNz/q7IjnyAqEJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahh9OQAKCRB4tDGHoIJi
0lxfAQCiYNypuQYi25j9taj720oiiR9VKl5PbBX+BUJBEjZjqwD+MX89+OgpNete
q9HGB/H/VITdOUGVene2p+OvlTO+QQE=
=veuz
-----END PGP SIGNATURE-----

--pQNz/q7IjnyAqEJl--
