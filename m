From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: bcm2835: can_dma and scatter/gather question
Date: Thu, 30 Apr 2015 20:26:26 +0100
Message-ID: <20150430192626.GC22845@sirena.org.uk>
References: <55420558.6030008@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r/KodJa4+DLyYymZ"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55420558.6030008-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--r/KodJa4+DLyYymZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 12:35:04PM +0200, Martin Sperl wrote:

> The question is: can the spi-framework fullfill those requirements
> as well? Otherwise there would be the need to add an additional
> translation step inside the driver to translate those...

You can see the code for yourself...  we're mostly not doing anything in
the SPI code, we just throw a list of pages into a scatterlist but the
actual mapping is done by the DMA mapping code which is free to do
things like coalesce adjacent blocks.  If the hardware genuinely
requires that the Tx and Rx scatterlists have entries of exactly the
same length I'm not sure that's going to be reliably satisfied if memory
gets fragmented.

> Maybe we need to make the use of the mapping code configurable
> as well, or should such "custom" things go into prepare_message instead
> without implementing can_dma?

It sounds like the driver should just not DMA anything that isn't page
aligned and 32 bit multiple, or special case the first non-aligned bits.
I'd expect anything doing large DMAs to be trying to make them page
aligned anyway.  A facility to provide an interface for cutting off the
start and end of transfers for separate handling as PIO seems like a
reasonable idea but I'm not immediately seeing a straightforward way to
implement it, it seems like it might require most of the infrastructure
we'd need in order to coalesce adjacent transfers in a message (which
would be really nice to have).

> One more thing: is there a helper to create a sg_table for
> spi_message.is_dma_mapped==1?

is_dma_mapped is legacy and should be going away rather than used in new
code since just providing a single physical address really isn't enough,
if we need something in future it'll be done with the scatterlist.

--r/KodJa4+DLyYymZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQoHhAAoJECTWi3JdVIfQptsH/2c5rSr9f0TXfVSDYl3o73Qs
dXrNNAgjD0L6j4NfVEr3uv30Kg0egVrVpicCDW9BPPQs1Degmh9XIAs+b0wQVRLa
8NJWBuJ6P6cvwDAhjq17dhMGeSqE3gZx8z5E5TBpwjRAJaQD8+XGkBl9OYzOhldU
3IBwMj8JPYP1SR+GcVPLwIxpcdK6MlyzIHLJuzJ7vfNW5tX3qMuUuZO85z3yeWB0
nTl/lXIfG2Uz1CmT6VMl8BgJHzbniyCyEwanalnkU17b1njQVzX4uPJAO077+V8n
qFWwVKB0hKrz0dr2gZkDDhHoUt6+9s/9u5ftYGv2LHWia7sGAcAouwjwn++ZeNk=
=ncH2
-----END PGP SIGNATURE-----

--r/KodJa4+DLyYymZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
