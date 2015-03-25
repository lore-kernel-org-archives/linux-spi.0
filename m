From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 - RESEND] SPI: BCM2835: allow arbitrary GPIO to act as
 SPI-chip_select
Date: Wed, 25 Mar 2015 11:50:07 -0700
Message-ID: <20150325185007.GL3572@sirena.org.uk>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
 <1426755714-28130-2-git-send-email-kernel@martin.sperl.org>
 <550BAA89.5090707@wwwdotorg.org>
 <20150320095247.GE2869@sirena.org.uk>
 <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org>
 <20150325151611.GA3572@sirena.org.uk>
 <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org>
 <20150325165441.GI3572@sirena.org.uk>
 <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 06:59:22PM +0100, Martin Sperl wrote:
> > On 25.03.2015, at 17:54, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > There is no need for it to be exported, as I said you simply need to set
> > cs_gpio and it will be used.

> That is not true, because for that to work you need to move the driver
> away from using transfer_one_message to use transfer_one.

I'm confused.  You're writing a set_cs() operation but you can't use it?

> But then, as explained I have to revert back to transfer_one_message
> to implement the "aggregating/handling" of transfers inside the interrupt
> handler itself without having to call complete(master->xfer_completion)
> on every spi_transfer. If I wrap it arround transfer_one the code will
> look ugly, as it needs to work arround limitations of this api.

This sounds like you're trying to work aroud the core rather than work
with the core - enhance the core so that it can express what you need.

> From my perspective I want to minimize the dependencies while I create
> this proof of concept.
> And for my testing this with several different devices I need support
> for multiple devices and for that I need this patch go in first.
> Taking baby steps here.

I had been under the impression that you had already done a lot of proof
of concept work with this stuff?

> Also there is another point here, that Stephen pointed out:
> Would not a switch from the use of the "native-cs" to "gpio-only" mean
> a required change in Device-tree? And isn't DT assumed to be a stabe API?

Can you be more specific about what change you think might be required?
Currently the driver doesn't support GPIOs as chip selects at all so
anything enabling them is going to be new.

> So to summarize: do you want me to move to transfer_one instead and
> then revert back for the optimizations?

Drivers should in general be moving to use modern APIs.  If current APIs
need enhancing then look into doing that.

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEwNeAAoJECTWi3JdVIfQcCsH/0w9Fh+UzPvb2tWtA5WEi9Lh
Q9n3XBuiLCO5kL8Ty78SaFF1jvenYA0u/+cCwgD95QBtCrNthDWtiSdZcxqb2Ep0
1uVdgSDitlPym7lOnG9t+zN8iSYfPi1fKCTKLZpb+ezZDr0RqbbQUH13DejGPi7l
HoizLz7J8E+Nw0N9yUCwrzEf7A6x7MD+4GLLm8ewLRSf4PXZTNxIXim+76oFBBiY
TiYAW6kHPR6K3NEVcqGsF94ROGxZXpMp2Lgx0IsUNWm1BBvPGw38K298scjYTOe8
pJqXq1yL2cOJrUiq38B9wpQoe5zmJ+BQaseWCUyMD8iFtVQlXEvcZwJtTCuob6Q=
=tU8i
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
