From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting
 queue_kthread_work before the message is unmapped
Date: Tue, 12 May 2015 11:20:34 +0100
Message-ID: <20150512102034.GM2761@sirena.org.uk>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org>
 <20150508221309.GK2761@sirena.org.uk>
 <352560EA-A323-449B-8F37-6066328D2081@martin.sperl.org>
 <20150511180016.GU3458@sirena.org.uk>
 <8F4019F0-7C56-4C9C-9193-A2A23B533165@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QqzFzR/RUlLahzby"
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8F4019F0-7C56-4C9C-9193-A2A23B533165-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QqzFzR/RUlLahzby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 09:27:35PM +0200, Martin Sperl wrote:
> > On 11.05.2015, at 20:00, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > No, it's supposed to be usable for PIO too - it can keep logic simpler.

> but only slightly - it is a simple
>   (xfer->tx_buf) ? xfer->tx_buf[i] : 0
> so I do not see a huge difference.

People can make the logic more complex than that.

> > Indeed, just having a page that gets reused would be better.  I'm hoping
> > that someone who needs this will get around to optimizing it at some
> > point.

> I could possibly look into that, but it goes against the point you
> made above about PIO.
> Either we allocate the memory completely and make it work for PIO.
> Or we only create a scatter/gather list of the same page and leave
> tx_buf == NULL.

We can tell if it's a DMA transfer - if it's a DMA transfer then using
anything except the SG list is a bit dodgy anyway since you're not
really supposed to have the CPU look at anything that's mapped for the
device (though it's generally fine if the device never actually DMAs).

> So unless we have a separate flag to say we only need it for DMA,
> then we have to keep the the current logic with allocation or we break
> other drivers.

We essentially have that; anything looking at a DMA mapped transfer had
better cope.

--QqzFzR/RUlLahzby
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUdPxAAoJECTWi3JdVIfQLAMH/3X4A7bBSwWTDV/e8wXtS4pc
7oEr1uB3l4TYMVTChE0JysKZv6tlirEKhSgawG7/O6roZa1JQrGr03YwTBJhj82f
3EpKOr3a9JR3L/KWFyVwCR5o7yN0pffcmArkmKLovjlluyv1HAc6FCB4ZUFj65as
em/im5Kgqyn+Li0eP++sw/MnRgHcUoPKWEkN0ffEbLFW4DklSRKan9ikNWhYdv0I
k9JUlQIt+jvG+MmMqhu2OzlmgG/OZMnOXdMs1/aJYR15mQmGU7//O9UKpQieQIko
PLbmEo+dIP1V+tSEB8+mT5/5ZH/kXRIM05l2uEr8BP0CUBnNHuTxyYdry+xQPl0=
=ZzlM
-----END PGP SIGNATURE-----

--QqzFzR/RUlLahzby--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
