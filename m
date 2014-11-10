From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: meson: Add support for Amlogic Meson SPIFC
Date: Mon, 10 Nov 2014 15:11:40 +0000
Message-ID: <20141110151140.GA3815@sirena.org.uk>
References: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
 <1415525113-25598-3-git-send-email-b.galvani@gmail.com>
 <20141109101712.GM2722@sirena.org.uk>
 <20141109225650.GA27950@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8LcJRZYx/wLV/pN5"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
	Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
To: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141109225650.GA27950-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8LcJRZYx/wLV/pN5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2014 at 11:56:50PM +0100, Beniamino Galvani wrote:
> On Sun, Nov 09, 2014 at 10:17:12AM +0000, Mark Brown wrote:

> > This will busy wait for up to a second, that seems like a long time to
> > busy wait.  We also appear to be using this for the entire duration of
> > the transfer which could be a fairly long time even during normal
> > operation if doing a large transfer such as a firmware download, or if
> > the bus speed is low.

> Yes, probably the timeout value is too long since the maximum length
> of a basic transfer is 64 bytes. Can you suggest a reasonable value?

10ms?  It depends somewhat=20

> > > +	while (done < xfer->len && !ret) {
> > > +		len =3D min_t(int, xfer->len - done, SPIFC_BUFFER_SIZE);
> > > +		ret =3D meson_spifc_txrx(spifc, xfer, done, len,
> > > +				       last_xfer, done + len >=3D xfer->len);
> > > +		done +=3D len;
> > > +	}

> > I noticed that the handling of /CS was done in the spifc_txrx() function
> > - will this do the right thing if the transfer needs to be split for the
> > buffer size?

> It should. When the transfer gets split, CS is kept active for all the
> chunks and the value of CS after that depends on the value of
> cs_change.

Can you be more specific about how that works?  I'm just not seeing the
code that handles this.

> > > +	if (!ret && xfer->delay_usecs)
> > > +		udelay(xfer->delay_usecs);

> > The core will do this for you if you implement this as transfer_one().

> Please correct me if I'm wrong, but I think that transfer_one() can't
> be used in this case. The hardware doesn't support direct manipulation
> of CS and allows only to specify if CS must be kept active after the
> current transfer. So I need to know for each transfer if it's the last
> and this can be achieved only implementing transfer_one_message().

This is already in a function that's operating at the transfer_one()
level, the function is even called transfer_one() and besides it's
clearly not something specific to this hardware so should be factored
out into the core instead of open coded.

--8LcJRZYx/wLV/pN5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYNWsAAoJECTWi3JdVIfQUbQH/R+WA5WkTd5kxqYoVA77kn/3
CX0Rs9IR+peXFR0ZkVYxQA+Or/APV3EiJ8O6ECf0aiHh4oRv+a5NyZSgELarfOiL
jraGi5PKLWW3Ac2DUL4RFeGHQ6NgAMOMKH+6nMxE/d6IS81zVLzFdQrBTNORzWmQ
cftA0dfZNYDqMGtLYt5zrvC/ZdRiu2qRZgF8AoHy/TWep/xthjPcO2YquXB45DBk
jPDSl8pEe5gSKoSvhG9udCOSpaah40tSoi+45GXqKbzshWmiKtM3CqpuGljFH/FG
dJLOUog401k4j3DYFX6oE3MUmJ9qPBCySBnrCrYQOvjxf4DAF7rHJK1+WRUfdrs=
=X4Go
-----END PGP SIGNATURE-----

--8LcJRZYx/wLV/pN5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
