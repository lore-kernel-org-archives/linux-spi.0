From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v8 5/8] of: i2c: Export single device registration method
Date: Sun, 23 Nov 2014 17:22:29 +0100
Message-ID: <20141123162229.GA1303@katana>
References: <1414528565-10907-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1414528565-10907-6-git-send-email-pantelis.antoniou@konsulko.com>
 <20141121014631.C86D5C413E8@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>,
	Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>,
	Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141121014631.C86D5C413E8-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 01:46:31AM +0000, Grant Likely wrote:
> On Tue, 28 Oct 2014 22:36:02 +0200
> , Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>  wrote:
> > Dynamically inserting i2c client device nodes requires the use
> > of a single device registration method. Rework and export it.
> >=20
> > Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>=20
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Wolfram, this patch and the next one only make sense in conjunction with =
the overlay
> patches, but they don't necessarily need to be merged via the same tree.
> I'm happy to take them, but am equally happy to have you take them
> (assuming I ack the next patch; I haven't looked at it yet). What is
> your preference?

OK, now I had the time to look at it, phew.

Is this targetted for 3.19? Then you can take it:
Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

There is a minor conflict caused by this patch in i2c/for-next which
should be easy to solve, just remove the irq handling.

2fd36c552649 2014-10-30 15:59 Laurent Pinchart   o i2c: core: Map OF IRQ at=
 probe time

If you target for later than 3.19, then we need to discuss again,
because there might be other i2c core changes coming in.


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcgnEAAoJEBQN5MwUoCm22xoQAIwYwLQpx3DWnPiYlkAL3Eg2
zTs6odMqXEvK7R7GPe8owC4rUMwfqq8wRe97wcmK8n5miNsYOm9wK2c6P1kMYo2m
4rs/+xW6zEdcuqL+SQRpVhzdtekyzqxwylWpwBdTb0hwGRgpgogkiIc+CXG1Vrds
1IpjpDTKiujbzmCTx6v3er/XxLjCn18jWfBzyZgpUEscdNHuH0n6mPilemxuuUBu
M5UFpPgvlfwk+cIgQPafpR8MZeJahstbRrBzWIz/L0ReyuIrCPmkme1qA9/ym1u5
EdGxmx1sZOe8JxXWlbQ7OoSytDkK7N+fKHLmitGRESTGUAiXhhdlnmp7WB8JIVTb
MS6c0iyRb5cEN7gv0Y+F1VHg8xyz+LAc9gwPxYYBR9jUEGZTQudRONcFbGB0dWLP
q6mH/JmQlPZJWTC5G/fbgler9OZ4T/OP1uL46h4BulDFER/E6lZ1tMrpXHWnBlWD
CHitO97/v41YYfIGosL0g9HNb2jseNi0RC30UmLK97vRhSZ1A1+3Txfi514qfTg0
DL6YVcppil/VI6zNi3gbVCQtQrs9bjigZ5tTDWptA+IoFCdL29Q48EyqzS9532wg
NtTbyKN37RGSTB9Gd4IlZHgHPtFhoT5LblUqQPtZy/GNOIWmyC+toDy4JSDZ5K0y
MjeHZbmVuOP3eMC+wrV/
=sIg1
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
