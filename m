From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: bcm-mspi: Add support to set serial baud clock
 rate
Date: Mon, 6 Apr 2015 10:46:36 +0100
Message-ID: <20150406094636.GC6023@sirena.org.uk>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>
 <1428002603-21892-5-git-send-email-jonathar@broadcom.com>
 <552037BB.7050803@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dOtxUVmLoGkyu1PA"
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <552037BB.7050803-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dOtxUVmLoGkyu1PA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2015 at 12:12:59PM -0700, Florian Fainelli wrote:
> Le 02/04/2015 12:23, Jonathan Richardson a =E9crit :

> > +		/* Calculate SPBR if clock-frequency provided. */
> > +		if (of_property_read_u32(dev->of_node, "clock-frequency",
> > +			&desired_rate) >=3D 0) {
> > +			u32 spbr =3D clk_get_rate(data->clk) / (2 * desired_rate);

> Usually, specifying a "clock-frequency" property is done when there is
> no clock provider available, yet we take this code path only if we could
> find a "mspi_clk" which sounds a litle weird.

> Once there is a proper "mspi_clk" clock, I would make it mandatory for
> the clock provider to be able to provide the rate as well?

As far as I can tell it's already mandatory if the property is present -
it's taking the clock presented to the block and then using an internal
divider to bring that down to the desired rate.

We are missing error handling though.

--dOtxUVmLoGkyu1PA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIlX7AAoJECTWi3JdVIfQThUH/R+N431/FW64SW9FYGRYdUBW
mmPexicfM/zDQkl+zrw54yNUtWwUE/h4GcqVle1uU7J4dARbvBI0AeEXMjZfA6Fa
4fI8YnDE67YHkvl6bqmnSyHcw4V4b9zUuMtxOmOLDi0A4zILsVodbPkJbo5SYu6B
xKVmgFAhRw/MdxdxxiYt0CLQ8GIu6O635IX6Cfcf0IBNc8uICFf4MdrWi2HG4xOF
RrAke52eHmiK9skR67VAH9Vm2sh8iyKJeE++ewbWo+7fYot1gpmF2HPkpcPtW1cQ
EoY3ShjogBbxfpKfuH6yyfX/w5rYPT9Y6sjdbWaUjfOZ/VgPhD6a/ioNVaDaUK8=
=gcDB
-----END PGP SIGNATURE-----

--dOtxUVmLoGkyu1PA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
