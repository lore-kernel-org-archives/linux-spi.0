From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: ARM: bcm2835: DMA driver + spi_optimize_message - some
 questions/info
Date: Thu, 3 Apr 2014 23:02:32 +0100
Message-ID: <20140403220232.GE14763@sirena.org.uk>
References: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org>
 <20140402181547.GH2269@sirena.org.uk>
 <1AA37E97-BDD7-4B53-B092-18D5D7439F8B@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7BnLk9CMipoMykF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1AA37E97-BDD7-4B53-B092-18D5D7439F8B-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H7BnLk9CMipoMykF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2014 at 10:40:41PM +0200, Martin Sperl wrote:

> Will try to keep emails shorter - I wanted to get everything out in one
> and document it also trying to answer questions I thought would come up.

Sending several mails might've helped too - the way a patch series is
structured is actually a fairly good way of breaking things up for
comprehnsibility.

> Just to summarize the current "modules" and their respective files:

> spi-optimize - essentially the patch shared with my original email touchi=
ng:
> include/linux/spi/spi.h
> driver/spi/spi.c

> maybe adding some documentation on how to "optimize" high-volume drivers
> to make optimal use of the interface.

There should be some win from this purely from the framework too even
without drivers doing anything.

> Does this look "ok" from an approach perspective?

Broadly.  Like I say the DMA stuff is the biggest alarm bell - if it's
not playing nicely with dmaengine that'll need to be dealt with.

> I will share one module after the other for initial review.

It's OK to post the lot at once as part of a series but it needs to be
split up into separate logical patches.  Hopefully we can get the
externally visible optimisation stuff merged relatively quickly so that
drivers can start building on it.

> I will brush up the code for the generic DMA fragment code, so that it
> becomes presentable and will share that part in the hope that it live in
> parallel to dmaengine and/or get somehow integrated - possibly as another=
 target
> besides cyclic.

Yes, something like that.  The most important thing is to make it usable
with any driver.

> As such drivers using this specific interface will need to know enough ab=
out
> the HW itself, my assumption is that the driver will need to know about t=
he DMA
> engine used to work properly - so I left all sorts of abstractions out of=
 the=20
> design - this can get added later if needed...
> Anyway this should come with deeper integration with dma-engine.

That would seem very surprising - I'd really have expected that we'd be
able to expose enough capability information from the DMA controllers to
allow fairly generic code; there's several controllers that have to work
over multiple SoCs.

> P.s: as an afterthought: I actually think that I could implement a DMA dr=
iven
> bit-bang SPI bus driver with up to 8 data-lines using the above dma_fragm=
ent=20
> approach - not sure about the effective clock speed that this could run..=
=2E=20
> But right now it is not worth pursuing that further.=20

Right, and it does depend on being able to DMA to set GPIOs which is
challenging in the general case.

--H7BnLk9CMipoMykF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPdp0AAoJELSic+t+oim9xtQQAIbgnjpNMAx9rFRki2mxGEkf
yG9tUBIa3fybfBUBk30PU9Kg2kkGBEQBjZlgGSOsSFfhVT8yEdfVfTmS1U+bioZb
+kz0azwTFdQMgQi3vlrez7LwuR1fQVi7MM8KNDxYf0c3RSd8Nrs/eGkcrpZ+4U/q
/qStU7vdZpb6cIVSfdayT8sUciHPVeBYCpSNO8/oTJl4vyqF72O/fZ31LO7Zf95/
YrzNPR+g0BZ3foEl2WOn16fJWGsXXDkXL30/D5F+SdyrbvT/AXOgMceuKcFddjY7
Wlz8FrK6v2srLIT3QvMrJZklfMzUPROUCbbO+Jk7Tyw0kUaQzjKyxFo0x3iSqpKO
9Z9ErPipNwXcj3EV10zC2x1qWadChxMeH8CPLc0+ECjC38+hqZZBqVsVYyYxBaCV
eDOhp/yAekR0atb52RYIhA1DEeVMEQy7C+i7v7b9Kg9B2GFbYu5/YY9mxCjeky6/
qsuaUjtTza5J4Q/8IwUbeeHfuUGR/x3P7zIozEK+vudbTFi+ggy3AhbndfFWZqRj
QZiVssqgU/EKD+diIi+69uiqfDp2QooKajr+7EkjTPc4towToA/It4W/T4zbf9fT
PQ93xQac1dQ+YHB50T5TooGhFJ9woTv9kcDX3IfqhymmbDeDOvMjBaNLcIUGlzz1
RVkHSyrWar2lOb64ushy
=FkHW
-----END PGP SIGNATURE-----

--H7BnLk9CMipoMykF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
