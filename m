From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 18/26] spi: tegra114: add support for hw based cs
Date: Mon, 1 Apr 2019 14:48:57 +0700
Message-ID: <20190401074857.GK2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-18-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666207-11414-18-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 10:56:39PM -0700, Sowjanya Komatineni wrote:

> Tegra SPI driver default uses SW CS control for transfers and HW CS
> control can be enabled through SPI client device node DT property
> nvidia,enable-hw-based-cs and is used only for single transfers.

Why have a property - if this feature works and is useful why would a
system ever not want to use it?

> +	single_xfer =3D list_is_singular(&msg->transfers);
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  		u32 cmd1;
> =20
>  		reinit_completion(&tspi->xfer_completion);
> =20
> -		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
> +		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
> +						    single_xfer);

It's not sufficient to check if there's only one transfer, you also need
to make sure that the driver isn't using cs_change to use non-standard
chip select handling.

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwmgACgkQJNaLcl1U
h9Cd2gf+IZg5c+h4154oTSypXNSKODiicQai//JHZ+vsyi8kNDmkDif8XKvC8xLJ
osqeztdDZ6jhaIM4G2ar4A7kLWqnA/s5iLl/vOCUgmKj6r9qhHh1BvWOli9GFpnz
9KCXQOQRaXUY6Fja4oF0z7fk52xPIWoh2XrJPuUy18sfla52jMFxIQWu7p7WItd4
Wq57omDJVMJ6gxHYhmD4ED3cGQo3pWI1aRQPvbdMopRCGI5YSAtToZjrnbFByYRg
q6RCcD7BcWoihdUKPeXpeq4oM0MZXrZYfISZe8/7VYgI6b5WpXZC/4sgUfTFVzbq
E/8rSGhA1a2xURQV/0bgEK5cKMzpHg==
=iU8U
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
