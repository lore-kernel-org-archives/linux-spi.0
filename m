From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Bug in in spi-bcm53xx (rcu_sched) exposed by 0461a41 ("spi: Pump
 transfers inside calling context for spi_sync()")
Date: Wed, 10 Feb 2016 18:06:07 +0000
Message-ID: <20160210180607.GZ13270@sirena.org.uk>
References: <CACna6rxQPv_Ut9NwN+BMbwSW+5-tJMoKXC3QWDfSP7zsCqfj7Q@mail.gmail.com>
 <20160210124828.GX13270@sirena.org.uk>
 <CACna6rzL-++_k68-VFQ4A9+gKHBJwhB5PJgU7wDwLQwi0vCCQQ@mail.gmail.com>
 <20160210131552.GY13270@sirena.org.uk>
 <CACna6rzHFx8VQs39gRGMKoF=P_t_MwGKQhUQb0O6x4OQeYrX5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eP8xGX2lG1UwfyBj"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6rzHFx8VQs39gRGMKoF=P_t_MwGKQhUQb0O6x4OQeYrX5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eP8xGX2lG1UwfyBj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 04:30:03PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> On 10 February 2016 at 14:15, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Don't busy wait in the driver, ideally implement DMA support.  Add some
> > sleeps if you really need to.  A PIO driver really isn't fit for purpose
> > with large transfers like you get on flash.

> The only place with busy waiting seems to be bcm53xxspi_wait. I tried
> adding cpu_relax() before udelay(5) as well as cpu_relax() at the
> beginning of this function. I didn't chage anything. Should I raher
> use some timer & sleeping/waking mechanism?

Yes, you'd need to either add some actual sleeps (probably a brief one
after every transfer) or work with the maintainers of the lockup
detector to come up with some other way that the thread can tell the
detector that it really intends to burn huge amounts of CPU time in
kernel.

> I'm afraid there isn't a real DMA available. It seems Broadcom uses
> something called "Boot SPI". Enabling this mode maps flash content
> into a memory, but it may be a bit complex to implement. It would
> require flash driver to have better control over SPI controller and
> I'm not aware of any existing API for that.

Read support has actually just been implemented (it ends up just being a
callback with a MTD specific accessor), write support could also be
added along similar lines I guess.  See spi_flash_read() in -next.

--eP8xGX2lG1UwfyBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWu3wOAAoJECTWi3JdVIfQL7IH/RQCjK+CnJvArd8gMSzr7nNx
aKTkpOSJcKQItQr+RUnmW7ipL8Upfu5ut75x49zXEYzqTLePy2UdTRfNOGcHM6+1
uWwpKgR3RcvN82qGzGmfa7zq8x553ONHoJV1K8WOVAmGSuEpiG1i6BZOAMFudFzb
myn37zDiuWq72Y5iXk6X+OaQ9205OmmWzUZXXSWy+jJdiCgfUIpeWZQRN/dcbKF1
TDWlBQQ6gZTaWExtoKrF8QbwPZ/G4DjJpKpr5sQcmERL4slvtWTumZwS57wyNrBu
0kR3eevOmn6ZzKUav/E6ISI0ofWf5ncV19PpSag/Q018RgcUKXlUc8O5J9+BGIA=
=NBjp
-----END PGP SIGNATURE-----

--eP8xGX2lG1UwfyBj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
