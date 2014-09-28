From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/4] spi: reenable sync SPI transfers
Date: Sun, 28 Sep 2014 13:24:12 +0100
Message-ID: <20140928122412.GZ27755@sirena.org.uk>
References: <1410705908-20847-1-git-send-email-jepler@unpythonic.net>
 <1410705908-20847-2-git-send-email-jepler@unpythonic.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DcnznOculh5cIxbp"
Cc: linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff Epler <jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410705908-20847-2-git-send-email-jepler-ixP+gI44yfQ4d9/VWYMlNA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DcnznOculh5cIxbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2014 at 09:45:05AM -0500, Jeff Epler wrote:
> one source of excess latency in hm2_spi / hal_spidev is latency due
> to async transfers.  Make the __spi_sync primitive actually synchronous,
> rather than building on an asynchronous primitive.
> ---

Please submit patches using the process that is documented in=20
Documentation/SubmittingPatches, in particular it is *essential* that
you sign off your patches and you need CC maintainers otherwise it's
likely your patch will be missed.

> +        if(!master->cur_msg)
> +                return;
> +

Please also follow the kernel coding style.

> =20
> -	status =3D spi_async_locked(spi, message);
> +        if(master->prepare_transfer_hardware)
> +            status =3D master->prepare_transfer_hardware(master);
> +        if(status >=3D 0)
> +            status =3D master->transfer_one_message(master, message);
> +        if(status >=3D 0 && master->unprepare_transfer_hardware)
> +            status =3D master->unprepare_transfer_hardware(master);
> =20
>  	if (!bus_locked)
>  		mutex_unlock(&master->bus_lock_mutex);
> =20
> -	if (status =3D=3D 0) {
> -		wait_for_completion(&done);
> -		status =3D message->status;
> -	}

There's many problems with this - the most critical are that it is broken
for multithreaded use, it's not even trying to do locking so both other
callers and the thread will break, and it's not waiting for the transfer
to complete.

It would be good to do as much as we can inline but doing so needs much
more work than this and needs to consider other aspects of performance -
your patch will also make performance worse in many situations.  My talk
at ELC this year covers a lot of this, the slides should be googleable.

--DcnznOculh5cIxbp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJ/3rAAoJECTWi3JdVIfQBmAH/RgwImsc//zQLjEkZ5uRq6q7
9bZhnbkEpJu3Y+WTKSxqkwe98L9ouJr02av0jfUMaHitjDuahpjdhcoDBvadjqHD
K9B5kwnqOzSFEE9jKnI3odqxkwsBMyBMCl26Q21flAvSG16QBjwpkp1R+tDTrBkt
wtn22+EZ/oYHvazrPzfoSPFC+RcKNM6pTZQ2SHWk91r9DhOdMTnszTatEXEFNkpn
znhtF7RQVsvN42c+FzqFJQX6J2izmVsvRWpRU4K83aQGVrhmsGJkplHIQTLCXtuN
IMKAYxUzZJXyZLi54szmIOiAnwPApePy4d4dcKKp8DZSYtU5L7c8+cTQq6wWWfQ=
=1/4m
-----END PGP SIGNATURE-----

--DcnznOculh5cIxbp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
