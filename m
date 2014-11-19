From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: Add 'last' flag to spi_transfer structure
Date: Wed, 19 Nov 2014 09:34:45 +0000
Message-ID: <20141119093445.GV22111@sirena.org.uk>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-2-git-send-email-b.galvani@gmail.com>
 <20141118140658.GI22111@sirena.org.uk>
 <20141118225546.GA27182@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s0H35NU0PUc8VBh+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
	Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
To: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141118225546.GA27182-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--s0H35NU0PUc8VBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2014 at 11:55:46PM +0100, Beniamino Galvani wrote:

> Would it be better to introduce something like:

> static inline bool
> spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
> {
>         return list_is_last(&xfer->transfer_list, &master->cur_msg->transfers);
> }

> or open code it in the driver?

Adding the helper function seems better, it means we can change the
implementation later.

--s0H35NU0PUc8VBh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbGQxAAoJECTWi3JdVIfQe2sH/RfuVlJmbwTuMXxo8oXmtKoc
BkHQLcXVYYGZL+9M7S/W/Pk2xzSqvQuWPMUWraFk39+5XHzlieHbsFkWOd/P7H5i
0yekOEWxbVkHnRzOEBJsXlUNCJbepPUA+0YPBlIMtlTi3ClCDfPjgAZTcLDgLdH4
F6DWpQgHcU6n+bnCUGBNcas1l3v8Q73QhJCtifjxnnS2aUaQ1jZPmWSc50kA8W1i
n/HDZn3VFxnfCTJ+1z/vwAwf4BKC1SgI0qJezWIHLsI8yeG4LgIMqExnqpVXOTUF
vW4JxSeNNtEweyIiEzqLvSFdCDrXUJfYnWoueQIRsOTpUh3mMrtWhInUdg8LFK4=
=JxKc
-----END PGP SIGNATURE-----

--s0H35NU0PUc8VBh+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
