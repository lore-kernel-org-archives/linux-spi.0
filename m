From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 6 Nov 2013 11:32:19 +0000
Message-ID: <20131106113219.GJ11602@sirena.org.uk>
References: <20131030171902.GL2493@sirena.org.uk>
 <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org>
 <20131030215716.GV2493@sirena.org.uk>
 <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org>
 <20131031001004.GW2493@sirena.org.uk>
 <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org>
 <20131104184511.GR2493@sirena.org.uk>
 <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org>
 <20131106094854.GF11602@sirena.org.uk>
 <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCBbHYs95wY/7dOt"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <844EDAEA-3FDC-48D0-B59E-CECC0A83761E-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KCBbHYs95wY/7dOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2013 at 12:28:15PM +0100, Martin Sperl wrote:

> >> /* generic wrapper functions for device drivers to use */
> >> static int bcm2835dma_spi_prepare_message(struct spi_device *spi,

> > Like I said earlier I'm concerned about the idea of drivers calling
> > these functions directly, this should all be factored out of drivers
> > since there's nothing really driver specific here.

> Actually it is VERY driver specific!

> The thing is that you can not easily detect if the same spi_message has=
=20
> been used and in some way changed without having to walk and compare the
> structure to an existing checksum - and such computation would take say=
=20
> 1/3rd of the time it takes to prepare the message again.

I'm sorry but the above makes no sense to me.  Why on earth would you
need to do these checks?

--KCBbHYs95wY/7dOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeijAAAoJELSic+t+oim9Bt8QAJrIh1FRBKD4cl3sn97tn0bz
WwaUc8EZbt12HtiRrbkMH6bPxE1zXe8R9tt1Z6qe2KGdC4k7Z8pZCvBAoU7tWmXF
G7bUaneIpaJ4ozYZTMdKZTIZ66XVw2QHkKaxXVRS+t7rJr0kxsGqbkyhCVmwtddY
FTUeRRWyWKF+eM56Dd6feUVIWMIcacFfSrmBhBPcJ6Fshb1iSJ9k2DbKTFqIw+HM
XJq9jCidT5Kwg/5+CcKuLyMrSPCcZiyZ8amCgdHnDSjumBFak4laxPVY2zYC0a8I
3YeCt9meyoytCvn5m89GabhxUIrZJageRNSrrq/hS8Hk37FvtdbTIw9g5r1Ll81Y
LYhsqwvlag3WRu8IQDi9CLeMzjOxu3CLFodDrxb3RnxqcxlWRqCNyr/lRctOUuhL
gxkZrLtuGn3b+q3wOH2EJyYmM6REKmguPQtY595GMmY66n7Ls8TbWtnBxmWnTuGs
clEXdYR1Qs3jqO1FVy/XzPz/EKBydMdWMK66tHBpUTFatP9vnSMmRbSZYwNMLQ9L
VgWiS9Z++1nCvfkba+m1rxFlZuiT02CaDXAOhXhZ7pWuLzVM2h1OmXg34XEMjJsK
RwSTLm+LxrRfe1tCsydY0fF4q3Qm37+sqHXmI+hWzXC449jPqz9n57S65rm1BGRw
f3lOh739yOois3hC+HOZ
=FN30
-----END PGP SIGNATURE-----

--KCBbHYs95wY/7dOt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
