From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Add spi-bits-per-word binding.
Date: Mon, 13 Mar 2017 17:55:04 +0000
Message-ID: <20170313175504.mpwjxqbhc4yxk434@sirena.org.uk>
References: <20170217101151.hyzmz5a4lgdy7p5m>
 <20170220153512.6563-1-adrian.fiergolski@cern.ch>
 <20170221190830.xyubgimyc2w5p5v6@sirena.org.uk>
 <983e943b-30f2-7d80-294a-df29bca11738@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4mbz2wcpcfyrq34k"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, miguel.ojeda.sandonis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Adrian Fiergolski <Adrian.Fiergolski-vJEk5272eHo@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <983e943b-30f2-7d80-294a-df29bca11738-vJEk5272eHo@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--4mbz2wcpcfyrq34k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2017 at 06:25:53PM +0100, Adrian Fiergolski wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> In my case, xilinx_spi_probe function (of spi-xilinx controller) sets
> bits_per_word_mask of spi_master struct only to 16 bits support. Later,
> xilinx_spi_probe calls of_register_spi_devices, which calls
> of_register_spi_devices. The last one allocates an empty spi_device
> struct and configures different options of the spi_device according to a
> device tree. bits_per_word are not covered here (why?), thus it is left
> 0 (value after allocation), which, by convention, means 8 bits support.
> At the end, the same function (of_register_spi_device) calls
> spi_add_device which finally calls spi_setup. The last call, according
> to convention, changes bits_per_word to 8 and calls
> __spi_validate_bits_per_word which fails, as master doesn't support 8
> bit transmission. This fails registration sequence of a device driver.
> As you see, the device driver doesn't have possibility to modify
> bits_per_word during the registration process, thus it can't provide
> support for such limited controllers.

I can't see any way in which it follows from the above that it's a good
idea to try to override bits per word settings in the device tree, that
just wastes user time and is an abstraction failure.  We need better
handling of defaults done purely in the kernel.

--4mbz2wcpcfyrq34k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljG3PgACgkQJNaLcl1U
h9CnqQf+I3Atg3XG/Zt+rvSjjfJtt1Ua66P2+CgfMewyyXr9oeYjgnJLyenn8yUe
VP33Ohw0ZLbg7dGwNtKn2K0OeHJLNYDjTbM5Lr3/hcpPQJPj5KUPRCmCJjtof6Gj
Z10hXKA115SjTjsANgJLuywcqb+zYJ9ZvMe+30FUeUvP69R5FxQQHJBMywz2m1Uu
/u+YKxkMPkj4rx+Gx3pkGmItFSSQALVVgKUiv9Lv24ZY+yw4LR0AaJCynfXaH9sl
BNP2iNkXEXdu7VDX4+eVtjV1NIU/rzdy762avRvVCJ8VGPtWOTIs7T2r6atLNupB
Iy5lacb4PmW4mo18eHQfqMgWanVyQQ==
=21bD
-----END PGP SIGNATURE-----

--4mbz2wcpcfyrq34k--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
