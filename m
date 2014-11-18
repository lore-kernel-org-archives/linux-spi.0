From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: Add 'last' flag to spi_transfer structure
Date: Tue, 18 Nov 2014 14:06:58 +0000
Message-ID: <20141118140658.GI22111@sirena.org.uk>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-2-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
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
In-Reply-To: <1416264471-774-2-git-send-email-b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 11:47:48PM +0100, Beniamino Galvani wrote:

> +	list_for_each_entry(xfer, &master->cur_msg->transfers, transfer_list) {
> +		xfer->last = list_is_last(&xfer->transfer_list,
> +					  &master->cur_msg->transfers);
> +	}

It's incredibly sad to iterate through the entire list in order to find
the last entry, especially given that it's a doubly linked list and this
is a bit of a hot path.  We should look at the previous entry for the
list head instead, or perhaps better yet by doing this as part of
spi_validate() which already itereates over the entire list and is where
we do other similar fixups.

Though looking at this I'm not sure that a flag is the best approach at
all - why not just have the driver call list_is_last() in the transfer
function or ideally provide an inline function that does that so that we
can change the implementation later?

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa1J9AAoJECTWi3JdVIfQ6SkH/3cdLDQfSJnP1yztcWiTP2H0
tKqdrVTCqE9+0oB7imoc8AKgh8DNsGVFPcFEwbYyKZIjsKDfyvGRwDVqDVMY91tz
KVECDQUYF/37VwMLGs8OSdd9SMF0CwRZbQMNivtAP5OabtpamZXFm9ubBMvrDmFZ
5FWNJ4TNKqHngUSwy9VIR7UvXdgl1N0KiwFCbbLvENk1ozmou3T5DCXZfe8RnvKR
MceKTZvLgirOAwJIDSN4zsYjJa9By91xieerdKO0l/pgg+N5XpuZ3rDGN0GeQDSo
ofOAgD2MNuAOSD7oyQELmDsHHuZwe42cKfGFG3Ux+MlATw+S87uao17PV2ry5oo=
=ehmG
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
