From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH resubmit 2/2] spi: fsl-espi: make use of max_msg_size in
 spi_master to handle HW restrictions
Date: Tue, 1 Dec 2015 14:19:23 +0000
Message-ID: <20151201141923.GJ1929@sirena.org.uk>
References: <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk>
 <56507B3B.4080608@gmail.com>
 <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
 <565CB0C0.9060104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cm5JD8EdJoAV/WT0"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565CB0C0.9060104-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Cm5JD8EdJoAV/WT0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 09:25:36PM +0100, Heiner Kallweit wrote:
> Propagate the 64K message size limitation allowing client drivers
> to deal properly with this limitation.

Please don't submit patches into the middle of existing threads, it
makes it very confusing trying to work out what the currently proposed
patches are:

   8592 N T 11/22 Heiner Kallweit (2.1K) =E2=94=82                   =E2=94=
=82 =E2=94=9C=E2=94=80>[PATCH 2/3] mt
   8593 N C 11/22 Michal Suchanek (0.5K) =E2=94=82                   =E2=94=
=82 =E2=94=82 =E2=94=94=E2=94=80>
-> 8594 N T 11/22 Heiner Kallweit (0.9K) =E2=94=82                   =E2=94=
=82 =E2=94=9C=E2=94=80>[PATCH 3/3] sp
   8595 N T 11/30 Heiner Kallweit (1.7K) =E2=94=82                   =E2=94=
=82 =E2=94=9C=E2=94=80>[PATCH v2 1/2]
   8596 N T 11/30 Heiner Kallweit (0.9K) =E2=94=82                   =E2=94=
=82 =E2=94=94=E2=94=80>[PATCH resubmi
   8597 NsF 11/22 To Heiner Kallw (1.4K) =E2=94=82                   =E2=94=
=94=E2=94=80>Re: RfC: Handle

I *think* the two messages from yesterday are supposed to be a single
patch series but they're buried in the middle of a huge thread at the
same level as some older patches and for soem reason have different tags
(one of which is "resubmit" which is really just adding noise).

--Cm5JD8EdJoAV/WT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXaxqAAoJECTWi3JdVIfQ60wH/2Oeaz2hc1bb4SCre3MWHxsK
dpgHFbhZDP0NWxNPbUtTJnszYnuZTemYOIikn/RPXtE5uenTvnzL3HaT6vRzH2uB
YwhpGYlk4sng7T7z9NA+vhiIp37FC+oehklWzp9ReXlG7fNYahCb2f9ibKCy1eqW
BN+Dj2Lu0yJIASiTcqG9kWnwiVS5CqclOrI/+Ric68NFpux6nZey3bvrzdaFrkgF
5O18SssKmJ4+LbwdzcOxQu5ADNs9x4Fhhw4Le/sv14z7Z/ATZa7jO9UNUh49k9w7
Yy0bscNAT/LZrLFtsJjq/fDdyd4Imjb4tklRDvITNcAiP3APuSER8o3adQKnOIY=
=t3pC
-----END PGP SIGNATURE-----

--Cm5JD8EdJoAV/WT0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
