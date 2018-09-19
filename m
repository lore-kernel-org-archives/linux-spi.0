From: Lukasz Majewski <lukma@denx.de>
Subject: Re: Questions about the Freescale/NXP QuadSPI controller
Date: Wed, 19 Sep 2018 13:02:11 +0200
Message-ID: <20180919130211.3f2e7e3a@jawa>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-4-git-send-email-frieder.schrempf@exceet.de>
 <7e95c72c-2cd1-f138-a687-6cca362c95b7@exceet.de>
 <63462dd2-b61b-6522-0619-0cdc89148193@exceet.de>
 <VI1PR0401MB2221D006E89A06B7D343A5E5972C0@VI1PR0401MB2221.eurprd04.prod.outlook.com>
 <20180804153728.0a99d28f@bbrezillon>
 <121b89ad-712f-166b-83d2-6b0f1bdc750e@exceet.de>
 <AM6PR04MB4967E918792A1C0D7D3D5C18971B0@AM6PR04MB4967.eurprd04.prod.outlook.com>
 <b2a29f52-f658-d92c-7b42-3096af6449f1@exceet.de>
 <AM6PR04MB4967C4B3F97004C41220E310971B0@AM6PR04MB4967.eurprd04.prod.outlook.com>
 <09d39759-390a-bca3-caeb-2ee8ddb29443@exceet.de>
 <20180919004247.60c6099a@jawa>
 <e76062cb-f703-2830-8074-d1a812dc14ce@exceet.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0083454060013836886=="
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "richard@nod.at" <richard@nod.at>, "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Albert ARIBAUD <albert.aribaud@3adev.fr>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 David Wolfe <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Frieder Schrempf <frieder.schrempf@exceet.de>, Fabio Estevam
 <fabio.estevam@nxp.com>, Han Xu <han.xu@nxp.com>, Huang Shijie
 <sjhuang@iluvatar.ai>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <e76062cb-f703-2830-8074-d1a812dc14ce@exceet.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

--===============0083454060013836886==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vqT2K5+KmOE+OBjbFahC9EX"; protocol="application/pgp-signature"

--Sig_/vqT2K5+KmOE+OBjbFahC9EX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frieder,

> Hi Lukasz,
>=20
> On 19.09.2018 00:42, Lukasz Majewski wrote:
> > Dear All,
> >=20
> > Maybe I do jump a bit off topic here, but...
> >=20
> > I've read through the following thread:
> > https://patchwork.ozlabs.org/patch/939885/
> >=20
> > And it mentions some issues with reading AHB content (buffers) in
> > fsl-quadspi.c driver discovered when new QuadSPI driver was
> > developed. =20
>=20
> The only setup with two chips that is known to be problematic with
> the new driver, is when both chips are connected to the same bus
> (e.g. QSPIA) using separate chip selects.

I'm using QSPI0 controller, with two memories connected to QSPI0_A and
QSPI0_B lines.

>=20
> Does your board use this kind of setup, or are the two chips
> connected two different buses (QSPIA and QSPIB)?
>=20
> Have you tested the new driver? It would be great to receive some
> more feedback.

I will check (test) this new driver. No problem.

>=20
> > I do have a setup with qspi0 having two SPI memories connected (2x16
> > MiB), and I'm wondering if anybody has some more info regarding:
> >=20
> > (What's more is that there is a bug in
> >   * the "IP Command Read" in the Vybrid.) found here:
> > https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/mtd/spi-nor/f=
sl-quadspi.c#L671
> >=20
> > I've googled for some errata or known issues for vybryd's QSPI IP
> > block (vf610) but without luck so far ... =20
>=20
> Unfortunately I don't know the background for this comment.

The comment was added by some Freescale employee when the driver was
added to Linux (by Huang - CC'ed).

> Is your=20
> board using VF610?

Yes, it uses vf610 (A5 + M4 cores).

> Do you experience problems?

I've already observed following issue:

For the current QSPI ML driver (fsl-quadspi.c - 4.19-rc3) only half
of the AHB buffer is valid. When I do read the whole one - I do see read
data corruption (on UBI or raw memory).=20

This was pointed out in the patch:
https://patchwork.ozlabs.org/patch/675401/

Unfortunately, I did not found any info regarding this problem (in
NXP's errata or other doc).

I will check if this issue shows up on new patches.

Thanks in advance for your help.

>=20
> Regards,
> Frieder
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/vqT2K5+KmOE+OBjbFahC9EX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluiLLMACgkQAR8vZIA0
zr1iSwgAyRvAsZaK9SMBKf/aVHZXYFzozJMsk/CYIMx303TuqjONUJfWLFNQUiZx
TWzJaQj8oMujqV588jvZtGoYAsj4RXUPRds4gY/rRFop9sjhBDbDXXrK29NlpEgI
TaSTJxBWi007GcDnPKdDCWOFGYSrew4Mzyr1oNZ+s7MbM6NAJ6ojIhaxGIq/ysWZ
ZjmRcplsfMi4dJLHq5m19jsjkprnSepr+UaQVbarniMyeLYtWWSnlFuguR964q05
xjiFaXAilmNW5n49gcrglOKAirJRagihxTzYDmh/RAPNxjMW6S9+p0ouOhrJaLyM
yfLNcA/CuxdwPHeT7F7KaIx3bGtZVg==
=2Veg
-----END PGP SIGNATURE-----

--Sig_/vqT2K5+KmOE+OBjbFahC9EX--


--===============0083454060013836886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0083454060013836886==--
