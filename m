Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2031A807;
	Thu, 24 Sep 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270515; cv=none; b=MbGz9Q54N4auO8Ivqm8uSmQ0bvkW1V4m2w+RcCUKr77QNE7pOFCx1eke7EtrbHvVW8h54borAxC0edP2c/rb83Q65rgCz4eNwqXarCm9YmfboVDTLnaogdo29vJ5xRT9ys5uWqOiNOkXBQ224tdQdpgm2tv6PiWEga3oj94NdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270515; c=relaxed/simple;
	bh=sCchGc7fFyWlPVq7Afzzg4iXQGGA1KxJ3D2l2itwLoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1LY+IV8BaTlQbu+VBparNNVizFShW+bMwPjleEQQRh0VTV44fl0f+bA3H9/GfWhH9ilv1ttPFPVy5nh4/nWJfzPdvTmSKXWmK2NoIK3Cd2OQbcfVxB/XfZiHmQmIgpM8e0SuHuTCMTPd72Vdo/PNPMy4SUdqoi9h/Kb1yA/ln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfLXy7gD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfLXy7gD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694AB1F00893;
	Thu, 24 Sep 2026 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270514;
	bh=+tdgUn4LCmpZMy1NvZZmFJ3S3QlMO+Bl0qktKJCidag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gfLXy7gDws5V13oaRpXzFbpiwcTyxOwsZHw/BzOTUIb8sNMyscqhTtX6QZS3Ig9Hv
	 M/qjdCxFSMTZTXdSEwGGpAaUoWZvtpFNuD020pkaIusrxX7KhYRbmM5klkuDu1kMGj
	 Mc2KX0hk0WENTCPZgIQ6gz87qWFKSwGTaW+lxk1hFxvZf/Ab946PiE/P18FNJZKFmk
	 iPFiFc73GzOwjp+/awPO7jdeDVMT/VaxeEw8aD6fr8mEARgAUtXmIa13zxIqU/yJFI
	 qMCFjWfZiu2dgflIBMPfPiqgkx2/M5wdNmVRzZNf18MlAI1vCVo2I0keO4eO89eXV2
	 O4sUv/huJZNRg==
Date: Thu, 24 Sep 2026 18:21:48 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: net: meson-dwmac: add T7 support
Message-ID: <20260924-stinger-stoplight-7c327c3225fa@spud>
References: <20260924-t7-node-new-v2-0-319d3c19b4b2@amlogic.com>
 <20260924-t7-node-new-v2-2-319d3c19b4b2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lQQ+GaL+1qrjKfL/"
Content-Disposition: inline
In-Reply-To: <20260924-t7-node-new-v2-2-319d3c19b4b2@amlogic.com>

--lQQ+GaL+1qrjKfL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 05:51:09AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Add the T7 compatible to the Meson DWMAC binding.
>=20
> The T7 DWMAC controller requires the following compatible combination:
>=20
> amlogic,t7-dwmac
> amlogic,meson-axg-dwmac
> snps,dwmac-4.00
>=20
> Add a conditional schema check to enforce this compatible combination
> when amlogic,t7-dwmac is used.
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/net/amlogic,meson-dwmac.yaml    | 17 +++++++++++=
++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.ya=
ml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> index 5c91716d1f21..b529ca5577a9 100644
> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> @@ -23,11 +23,24 @@ select:
>            - amlogic,meson-gxbb-dwmac
>            - amlogic,meson-axg-dwmac
>            - amlogic,meson-g12a-dwmac
> +          - amlogic,t7-dwmac
>    required:
>      - compatible
> =20
>  allOf:
>    - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,t7-dwmac
> +    then:
> +      properties:
> +        compatible:
> +          items:
> +            - const: amlogic,t7-dwmac
> +            - const: amlogic,meson-axg-dwmac
> +            - const: snps,dwmac-4.00

This is not how fallback compatibles are described.

Instead of doing this, which affects all other compatibles in the file
by allowing dwmac-4.00 for all devices, please do this the normal way.
dwmac isn't special, it's just this binding that's weird!
Can whats currently in the binding (before this patch) be largely
replaced by just doing:
  compatible:
    oneOf:
      - items:
          - enum:
              - amlogic,meson8b-dwmac
              - amlogic,meson-gxbb-dwmac
              - amlogic,meson-axg-dwmac
              - amlogic,meson-g12a-dwmac
          - const: snps,dwmac-3.70a
          - const: snps,dwmac
      - items:
          - enum:
              - amlogic,meson6-dwmac
              - amlogic,meson8m2-dwmac
          - const: snps,dwmac

You'll have to check this yourself against the amlogic devicetrees and
see if this is correct, but with this you should be able to add your new
device without doing anything special.

pw-bot: changes-requested

Thanks,
Conor.

>    - if:
>        properties:
>          compatible:
> @@ -38,6 +51,7 @@ allOf:
>                - amlogic,meson-gxbb-dwmac
>                - amlogic,meson-axg-dwmac
>                - amlogic,meson-g12a-dwmac
> +              - amlogic,t7-dwmac
> =20
>      then:
>        properties:
> @@ -93,6 +107,7 @@ allOf:
>                - amlogic,meson8m2-dwmac
>                - amlogic,meson-gxbb-dwmac
>                - amlogic,meson-axg-dwmac
> +              - amlogic,t7-dwmac
>      then:
>        properties:
>          rx-internal-delay-ps:
> @@ -139,8 +154,10 @@ properties:
>            - amlogic,meson-gxbb-dwmac
>            - amlogic,meson-axg-dwmac
>            - amlogic,meson-g12a-dwmac
> +          - amlogic,t7-dwmac
>      contains:
>        enum:
> +        - snps,dwmac-4.00
>          - snps,dwmac-3.70a
>          - snps,dwmac
> =20
>=20
> --=20
> 2.52.0
>=20
>=20

--lQQ+GaL+1qrjKfL/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVcLAAKCRB4tDGHoIJi
0uGLAP9vG/nnFjmSd9oHG4dx6aOQ6l08pSiuAib8S4dTKMhDiwD/RyvtCdjF7f8+
h9rqmIr5nqu+zvpDF0FqjtuCMmJ+fA4=
=Nzj1
-----END PGP SIGNATURE-----

--lQQ+GaL+1qrjKfL/--
