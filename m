From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 19/26] DT bindings: spi: add spi client device
 properties
Date: Mon, 1 Apr 2019 14:37:23 +0700
Message-ID: <20190401073723.GH2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:40PM -0700, Sowjanya Komatineni wrote:
> This patch adds below cs timing properties to allow SPI master configuring
> setup, hold and time interval between two SPI transactions to meet specific
> SPI client device requirements.
>  CS setup time
>  CS hold time
>  CS inactive delay
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
> 	t=1553666253; bh=TbJVgRAIkjok3TkKNkfcvYc4WGyZhOpiH6sUZvadGrQ=;
> 	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> 	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
> 	 Content-Type;
> 	b=Tud9guY5XCzkjKA2k2n0+xO/vTfMTNhH1e0viAyYmlgoG/j+uSBAAmOeZucVUlmEa
> 	 rwqxlSm+rkYMUfgSWqmJXqEjgRIAqMhA32FOJmhgpblGwYUR22hnbdhbk4TcqMNsIO

Something got corrupted?

> +spi-client device controller properties:
> +- nvidia,cs-setup-clk-count: CS setup timing parameter.
> +- nvidia,cs-hold-clk-count: CS hold timing parameter.
> +- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock between
> +  transfers.

Why are these being done as nVidia specific properties rather than
generic ones and why are these being configured in DT rather than by the
client driver?  If the devices have particular timing requirements for
chip select presumably that's going to apply no matter what controller
or system they're used with so it seems best to configure this in the
client driver and have an API that any controller can implement.

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhv7IACgkQJNaLcl1U
h9AEqgf/YoGQ0dATzvZWKHgwUBIvOTH/AvNUrsaqqDJPL+MuDNSk3AR3ABYp4iVw
4KXFTefhstBK8FL36SVtPHBREKKHdjjOZy+2TuyKAE/4h8yZ8+L95ilY8c3J/DIa
8FvTv+ACN95gjeHTt0rWvcX5BEHVfwNAmhbGgMChjno3kqr77jnJFt+XziSKsolc
Uhf6veVqDGRVIc7dgBjh1cR2O0iSDfiyN/1OOj1YXuCa57pge6c6T6K20uvO+WxA
wMQvPYEkyxJr7hCAvXrkXQOgLe7LI0jKgh8n0ftFVJD22gI1ykQ8LxFKdh7LM7Je
ULFzhu6rWw/4dOE1orrBUi1ffduWWQ==
=JrKD
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
