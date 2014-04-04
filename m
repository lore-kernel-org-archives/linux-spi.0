From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH 1/2] devicetree: Add devicetree bindings documentation
 for Zynq Quad SPI
Date: Fri, 04 Apr 2014 07:38:00 +0200
Message-ID: <533E4538.70107@monstr.eu>
References: <ee057d8c-50d9-4d4b-ac86-d7c5fc44b1b0@TX2EHSMHS034.ehs.local> <20140403210135.GX14763@sirena.org.uk> <CAFcVEC+sqB9VQUEgiFN_MwHcvYFqEifh6EuHPLAkKZOnBiaQ9A@mail.gmail.com>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="StdWMl9Q0AaEu5jNiAqw8S3odGLnk4Rfx"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Punnaiah Choudary Kalluri
	<punnaiah.choudary.kalluri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary <kpc528-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	punnaiah choudary kalluri <kalluripunnaiahchoudary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFcVEC+sqB9VQUEgiFN_MwHcvYFqEifh6EuHPLAkKZOnBiaQ9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--StdWMl9Q0AaEu5jNiAqw8S3odGLnk4Rfx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mark and Harini,

On 04/04/2014 05:01 AM, Harini Katakam wrote:
> Hi Mark,
>=20
> On Fri, Apr 4, 2014 at 2:31 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Thu, Apr 03, 2014 at 10:33:06PM +0530, Punnaiah Choudary Kalluri wr=
ote:
>>
>>> +Optional properties:
>>> +- num-cs             : Number of chip selects used.
>>
>> What does this translate into?
>>
>>> +             num-cs =3D /bits/ 16 <1>;
>>
>> Why the odd specification in the example - why not just specify it as =
a
>> number?
>=20
> Same as discussed on SPI cadence thread.

I have discussed this briefly with Rob and it is more up to Mark
if he wants to have this with 16bit width or not. I expect that
"num-cs" is getting to be shared across spi drivers
and maybe in near future you will move "num-cs" of probe to spi core
that's why it should stay 32bit for easier integration.

I have asked Harini some weeks ago to try to do it just with
of_property_read_u16 because you can directly setup
master->num_chipselect and you don't need to read it as u32
and saving to u16.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--StdWMl9Q0AaEu5jNiAqw8S3odGLnk4Rfx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM+RTgACgkQykllyylKDCFYHACfRnVIuDYW4iKWeGhw3YWDRwAu
jsEAniwyjNmI2fVlwuieSK+osHzM8dR2
=lwtq
-----END PGP SIGNATURE-----

--StdWMl9Q0AaEu5jNiAqw8S3odGLnk4Rfx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
