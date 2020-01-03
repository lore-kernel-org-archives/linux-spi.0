From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Date: Fri, 3 Jan 2020 01:04:09 +0000
Message-ID: <20200103010409.GG3897@sirena.org.uk>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <20191227002239.GH27497@sirena.org.uk>
 <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, fengsheng <fengsheng5@huawei.com>
To: kongxinwei <kong.kongxinwei@hisilicon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afad8a97-6159-bf7e-466a-fdbaf0a07d4a@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 28, 2019 at 04:31:53PM +0800, kongxinwei wrote:

> > I'd be much more comfortable here if I understood what this was
> > supposed to be syncing - what exactly gets flushed here and why
> > is a memory barrier enough to ensure it's synced?  A comment in
> > the code would be especially good so anyone modifying the code
> > understands this in future.

> Because of out-of-order execution about some CPU architecture,
> In this debug stage we find Completing spi interrupt enable ->
> prodrucing TXEI interrupt -> running "interrupt_transfer" function
> will prior to set "dw->rx and dws->rx_end" data, so it will result
> in SPI sending error

Could you update the commit message to say that, and ideally also
add a comment saying something like "Ensure dw->rx and dw->rx_end
are visible" please?

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4OkwgACgkQJNaLcl1U
h9AkFgf/fypiFJ4eRlJVOmkAYnGY01lAChSELOS/91cDAaOXJSQhz/hwB/cdeHjq
2KYpCiICZDeG8FB6y6dvAWUMCkVxGH0WVGS9/OlnmI+aDoPjqyiyJ5R1a+bRBAcE
YAaX12ARLr0uj9l9Fh6hhZxScRgit+ZKRB12T77pdyFFcoCh4kJLSD58D+78OmEO
YUXkkBxX7cayLE5CKvl2UrQp8K18T4EKZ4YX7jDCUuY4wXkoScvm7G3ik25DhEJR
jenBxAnbnw0De745jFhdI5VJygGUOF3caiWT3wc2tOIQwI1LJThI0cp4d3DRbphU
XpWJcoIuRXqY+TfLjulA4WjTtGsDew==
=Xa85
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
