From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: ARM: bcm2835: DMA driver + spi_optimize_message - some
 questions/info
Date: Wed, 2 Apr 2014 19:15:47 +0100
Message-ID: <20140402181547.GH2269@sirena.org.uk>
References: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7D++KM2hc3yR3ZWd"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43389276-E591-4E09-AB84-491C2CB2D9A7-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7D++KM2hc3yR3ZWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2014 at 06:06:11PM +0200, Martin Sperl wrote:

Just a general meta comment: your mail is over 700 lines long, that's
way too long.  Please split things up into smaller chunks or take a
higher level view as something this long is just asking far too much of
the reader especially without work to structure the text.  Things like
splitting out the device specifics help a lot.

I've just skimmed through this for now, I'll try to find time to read in
more detail but there's a backlog of patches I need to get to.

> * right now I am not really using dma-engine, as it is too CPU intensive
>   setting a complex SPI message up (a typical read+write SPI message takes
>   typically 21 DMA transfers)
> * instead I started a new dma-fragment interface that has:

This needs to be resolved for mainlining, if dmaengine is not up to the
job we need to either decide to replace it wholesale or extend it (more
likely the latter) rather than just doing something custom.  I do see
the need to improve the DMA APIs here but that needs to be done in a way
that's joined up with other work on DMA.

> * there is some provision to see if an spi message contains is of a
>   single/double transfer type and in those cases take an "optimized"
>   spi_message (done by the driver) instead and fill it with the data
>   from the submitted spi_message and make use of all those "vary" cases.
>   this would reduce the DMA creation cost for those synchronous transfers
>   (spi_write_then_read, spi_write, spi_read), but this is not fully in place

I don't know what a "single/double transfer type" is.

> There is also one question here with regards to semantics:
> When do we need to call the "complete" method?
> When we have received all the data or when the CS has been de-asserted
> (after the delay_usec)?

Users might reasonably assume that the transfer has finished at the time
any callback runs and that has to include the /CS change otherwise the
device might not have reacted.

> So the questions are:
> Are there any major questions on this design?
> Does it look acceptable from a design perspective?
> Is it generic enough that it might get used with other devices as well?

I was having a bit of a wood from the trees problem following the design
here but broadly there does seem to be a reasonable amount of usefulness
and reusability here.  A lot of systems are going to struggle to use the
full feature set due to restrictions on things like minimum DMA transfer
sizes and not being able to DMA to control registers and like I say the
DMA API issues need to be addressed.  Trying to do chip selects with DMA
is also going to be a lot of fun in the general case, especially with
GPIOs.

I also suspect that there is a cutoff point where PIO makes sense even
if we can DMA.

> Do we need all those "VARY" cases or would we need to vary by more fields?

The main things are probably replacing and changing the data.

> I still think that the optimize/unoptimize_message methods are quite similar
> to prepare/unprepare_message so the question is if these can not get merged
> into a single pair of methods.

Drivers are currently using prepare_message() for actual hardware setup
specific to the message that's done around actual transmission whereas
the optimisation can be done very distant to the actual use of the
message.

> Also the question is how I should initially submit those "generic" components.
> Should I create a helper.h and helper.c with those components, so that they
> can get split out later or should I keep them separate from the start.

I'm not sure what those helper bits are but in general keeping things so
that they can be reused is best.

--7D++KM2hc3yR3ZWd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPFPQAAoJELSic+t+oim9UxUP/ja59t+/sLJJe3wh15ApBLo3
Ujly/EuO+0QCM7vLrkfuZ/urLvQJJaBYt/HB+QRgzzPn/EcKwWT67J37M8j2LELr
UTmWVoOheKhIpDNqOCAd0/sN4hsQHeXfPKIq7AM/FwF5JQMJPNdpUV/uiHcGKS6P
NO4wPmPAUSRHs358UZaFvY62PwbNwAmm0sbiB1yEw+C7QZvnIfvadqdAK0RrrOo5
KszN4wa80ftl1d4uxCkOnkPBIEsnSdhJ4O1kKVfpOsYkzLcIJA3L724e1M4+bIty
ztMaBQS+LJxn604+jlwHhylCTDofXxjYLEWhfIJJFXZ93CQiALknvABICjJRFhRm
4HTqdanpem8iSLd9GPKNaNioR1G8/RmGQZKIepZlCc09+NdQ1DoNgQat1JZXD5I7
p7l4e4LrlphTEKeD76hgv1NuvDTiTCdn0eNhAtX7lcO3EGUoShiiz8W34ggP912B
JxIxt1J1veYCG7mzxdXlSptT87isoRsFhxb7JWqHnH20k2QsdnmilTmXxNlPwoAY
ScnCgwjdvG8RmQXALq+OzVcWKth5hEJE3E2P8wedQFmZcUGB+z0OS5Fz6oL3tATp
lSPO4OqbVE7TwxpcBI/Fet7MYyofgUlVtgzM1oqtIDacnXUjeMjHGNK1ZAqjEgHq
FBmWNzyBXSNY37indXOT
=TOOV
-----END PGP SIGNATURE-----

--7D++KM2hc3yR3ZWd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
