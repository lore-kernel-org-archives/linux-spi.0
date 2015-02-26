From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: dw: move to SPI core message handling
Date: Thu, 26 Feb 2015 11:44:12 +0900
Message-ID: <20150226024412.GJ6236@finisterre.sirena.org.uk>
References: <1424794676-15774-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1424883204.14897.47.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WK7GFmZHL0+Wby+V"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424883204.14897.47.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WK7GFmZHL0+Wby+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 06:53:24PM +0200, Andy Shevchenko wrote:

> 1. The message status override (discussion in a separate thread).
> Summary: we may and must use message->status to indicate an error, if
> any, is happened during transfer, e.g. overrun/underrun interrupt, am I
> correct?

Yes, of course.

> 2. How to handle timeout error in case of asynchronous transfers, when
> transfer_one() sets DMA and returns 1? In transfer_one() I setup DMA
> descriptors and in case of bad luck and getting many timeouts in a row
> the DMA Engine would come to lack of memory, thus I would like to
> terminate any ongoing DMA transfers. Moreover, spi_unmap_msg() does
> unmapping before calling unprepare_message(). I'm not sure if it's okay
> in DMA case to terminate transfers in unprepare_message(), would it be
> already late?

That sounds like a reasonable concern.  Feel free to add any missing
features like cleanup callbacks to the frameworks, one of the advantages
Linux has is that we can extend the frameworks rather than having to
work around them.  Though perhaps the core can just terminate any DMAs
it knows about, I haven't looked to see if the DMA code will get upset
about double terminations?

--WK7GFmZHL0+Wby+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oh7AAoJECTWi3JdVIfQTskH/jFkg/j21Loc/GW47d20Pyax
NjMDiadeapPPGLqu74Fv9RuvbTMkgZCQCCCkauUf/fjDkJOVtUdEYNpmEvd3o5PW
chQqTnkexnTtnbTDHQfyfTDqUWbXcxYfQFmAGPCw0kOlFXNINBy+4aq9KNl3Nq0Z
+Gf1bYuGQz+zs6nY7g1qA3aXvgqTh2pB3epAmq+oRsbe2KhH3IWp+THEF3FlJaMm
J7For6jTjqW1OVHwIoChYhzE65c9PAmU7zwQb3ZgBE772nAjLye/3u4ajnQr5/RK
+npeA5J2vioNPNBAwiBM4ue2rhcwC71Pq+XT8U98JEQttEcqsfIOQgOf7VCVM0I=
=Sq22
-----END PGP SIGNATURE-----

--WK7GFmZHL0+Wby+V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
