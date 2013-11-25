From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Subject: [PATCH] Fix long standing chip select issue for
 non-default CS-polarity setups
Date: Mon, 25 Nov 2013 16:38:40 +0000
Message-ID: <20131125163840.GG14725@sirena.org.uk>
References: <A4EEA261-22E6-41A7-82C4-68E8606E0863@martin.sperl.org>
 <20131125111603.GC14725@sirena.org.uk>
 <52934420.1040603@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wZwWzkkm73dI25u3"
Cc: bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: martin sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52934420.1040603-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wZwWzkkm73dI25u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 01:35:44PM +0100, martin sperl wrote:

> We just filling in the "template" value for the register used the next
> time the control-register needs to get configured for a transfer.

> If you look exactly you will find that
> bcm2835_spi_start_transfer makes use of:
>   bs->cs_device_flags[spi->chip_select]
> and bcm2835_spi_transfer_one uses the:
>   bs->cs_device_flags_idle
> to fill in the "flags" and then writes to the control-register.

> So if there would be a race between spi_setup and the functions above,
> then the worsted case situation is that:
> bs->cs_device_flags[spi->chip_select] and/or bs->cs_device_flags_idle
> still contains the "old" flags.

It doesn't look like that, it looks like the update first resets things
to a default and then writes in the new value.  It also appears to
affect the entire array rather than just one value.

The other thing is that as with all your other code this is full of
coding style issues, these will need to be fixed.  Please, as previously
requested, read and follow CodingStyle.

> But if this is a race, then it exists regardless of if there is a
> spinlock protecting access of those variables or not, because then
> it is a race between spi_transfer and spi_setup which is totally outside
> of the driver.

Yes, this is the point - the two aren't protected against each other,
setup() is supposed to only take effect on the next transfer.

> Maybe that a device may change spi->mode while the driver is working?

Yes.

> If so then such an action would require a full bus-lock to avoid running
> into a race with other device-drivers. Then the driver could reconfigure
> the polarity settings on the device itself and then it can change
> spi->mode and can call spi_setup and then finally release the bus lock.

This doesn't require a bus lock, it only affects the individual device.

--wZwWzkkm73dI25u3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk30MAAoJELSic+t+oim9M7gP/ipE/g+WgfGou6w6SBrxG/2F
Hw4E4CLBy7o3vZsnQM2brXhkUpiBwf4YsHDYwc6t+meNw8rp38lDkzfhrbFMblI+
kPRpZmSkncHM66hhXXqjFVe688QOVMnjCUGFzNByVusPDDKuDmqu//UNIwOo1P8h
cqAAH75X6g+oavCfYSYvSEkjclHSXn4oMk7PffWTcWXZxxRdr+ptd0c0sq//XNOL
EvR37YeE/2MYjtedv6Qq/vW8QTttMNByfc0t+6VGthGTM2YDCZaHBaT32kugziez
E4u/QWhVW04vhW6/pA716I6CJosgIdmf+4R0fb+2RA56TlE/EFX0sr5Y9PY2vSSb
cqSX2/M4YVUBDodbzVcQRx70NAjgcNmrFj4AzAiaJR4C3SjsczrhWavbicBb5aAG
pD425XRShPkbhN7JxNU35yt1E16pdvK3XkZJ+Rm5jufDSUAFhKW/fgDncblQ7kd7
3G0KtHXun7qpGTF4KgDYuvtDzF9IQCG9Ovx726K7Qd+xpFpxx/kukuFD3I5apj8P
tjpYT8CeLfswKYJgkqGhRDLCXhrRD0cH/wceEf8K7P8Is0yse3wo0qwW1EdSKtCy
hHK4+XWz4Xfle8bnlYQoJ6q+eQZXohsfWK716+CNE49DgnQJjUFCDzX9Lmt0+SHY
FKwffb6c+SbciJSiZwa+
=wr3R
-----END PGP SIGNATURE-----

--wZwWzkkm73dI25u3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
