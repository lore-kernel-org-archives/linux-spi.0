From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting
 queue_kthread_work before the message is unmapped
Date: Mon, 11 May 2015 19:00:16 +0100
Message-ID: <20150511180016.GU3458@sirena.org.uk>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org>
 <20150508221309.GK2761@sirena.org.uk>
 <352560EA-A323-449B-8F37-6066328D2081@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UC+RhZhEc8lcmajv"
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <352560EA-A323-449B-8F37-6066328D2081-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UC+RhZhEc8lcmajv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 09, 2015 at 08:40:12AM +0200, Martin Sperl wrote:
> > On 09.05.2015, at 00:13, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, May 08, 2015 at 10:02:44PM +0200, Martin Sperl wrote:

> >> Note that I am not sure about the locking, so I left unmap outside the
> >> lock for now.

> > It needs to be, you can't do anything big like unmapping in a
> > non-sleeping context.

> Well, right now it is not in a locking context but outside, so
> I wonder if it is really needed, but then for spi_finalize_current_message
> it is not specified if it can also get run from interrupt context or not.

I'm having a hard time following the above, sorry.  What is "it" here?

Ideally we do want to be able to finalize in any context, though as
you've seen that's not true for all feature sets.  It's fixable if
someone has a need though.

> * dummy_RX/TX get allocated/released even when can_dma returns false
>   should only run this =E2=80=9Cmapping if necessary. I guess that it is =
mostly
>   usefull for DMA transfers - PIO drivers typically implement this via
>   a simple if when tx/rx_buf is NULL.

No, it's supposed to be usable for PIO too - it can keep logic simpler.

> * dummy_tx/rx get allocated/released for every spi_message, which is
>   wasting CPU

Right, ideally we want to push that logic out so that the free happens
when the controller goes idle.

> * we allocate spi_transfer->len bytes to this dummy buffer and with a
>   spi-transfer of 16MB this would try to allocate another 16MB - and poss=
ibly
>   fail...
>   Here maybe a fixed allocated (and mapped) buffer of master->max_dma_len
>   could be helpfull that would get reused multiple times in the scatter/g=
ather
>   list to minimize the memory footprint.
>   Ideally there would be support for this inside dma-engine in the form of
>   a flag when calling dmaengine_prep_slave_sg to indicate that data comes
>   from /dev/zero or goes to /dev/null, as some silicon dma-engines
>   (like bcm2835) supports such types of transfers in hardware.

Indeed, just having a page that gets reused would be better.  I'm hoping
that someone who needs this will get around to optimizing it at some
point.

--UC+RhZhEc8lcmajv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUO4vAAoJECTWi3JdVIfQbG4H/1N3yFzQm6PtBxFHBrRPQqJb
JMUnNjCKYtCOPueBs5BJUKjdyCEOAzoMoIyxlnPTvd899fEPsLHuuHuRhs+raY4k
y44SvnDOS99cYQ1JtXtrEX3m4roilPHbuukFoJXsajSHcFm+OdgxXBSo3VkM0aP5
gOgTgGf+eqvN3aHyPWthmVukJP2zy8dnF0jNVntnGCcS48uuj4jEC7kDKooCB7/u
UjcFek3wCvyVLqF3HfBQxUrzUGylSzzsgog60pjcjykGtwiq1OiI0tfVvaLEWUHA
mX2bZ0UCs9LvlvG5aVuge5MqEdAxnm8+iyJiW6eucMKDajuCNspI8XfwAehPeXo=
=H4LY
-----END PGP SIGNATURE-----

--UC+RhZhEc8lcmajv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
