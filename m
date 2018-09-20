From: Lukasz Majewski <lukma@denx.de>
Subject: Re: Questions about the Freescale/NXP QuadSPI controller
Date: Thu, 20 Sep 2018 17:00:32 +0200
Message-ID: <20180920170032.39fb5073@jawa>
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
 <20180919130211.3f2e7e3a@jawa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8871870511445340289=="
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
In-Reply-To: <20180919130211.3f2e7e3a@jawa>
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

--===============8871870511445340289==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/J9Lyo8WuRozmK7bxT3jnmdV"; protocol="application/pgp-signature"

--Sig_/J9Lyo8WuRozmK7bxT3jnmdV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frieder,=20

> Hi Frieder,
>=20
> > Hi Lukasz,
> >=20
> > On 19.09.2018 00:42, Lukasz Majewski wrote: =20
> > > Dear All,
> > >=20
> > > Maybe I do jump a bit off topic here, but...
> > >=20
> > > I've read through the following thread:
> > > https://patchwork.ozlabs.org/patch/939885/
> > >=20
> > > And it mentions some issues with reading AHB content (buffers) in
> > > fsl-quadspi.c driver discovered when new QuadSPI driver was
> > > developed.   =20
> >=20
> > The only setup with two chips that is known to be problematic with
> > the new driver, is when both chips are connected to the same bus
> > (e.g. QSPIA) using separate chip selects. =20
>=20
> I'm using QSPI0 controller, with two memories connected to QSPI0_A and
> QSPI0_B lines.
>=20
> >=20
> > Does your board use this kind of setup, or are the two chips
> > connected two different buses (QSPIA and QSPIB)?
> >=20
> > Have you tested the new driver? It would be great to receive some
> > more feedback. =20
>=20
> I will check (test) this new driver. No problem.

I've ported your patch on v4.19-rc3.

I had to fix the "div0 issue" by adding:
if (op->dummy.buswidth &&=20
	(op->dummy.nbytes * 8 / op->dummy.buswidth > 64))

In fsl_qspi_supports_op() function.


Unfortunately, on Vybrid vf610 when testing I do see corruption of read
data from the mtd device:

~# hexdump aaa.img
0000000 464c eec0 baa5 c5ff 7b99 4dfb e0b6 8a2e
0000010 e98e 5265 683c a635 c069 e402 303f d936
0000020 c243 01a7 7064 fce8 e3a9 200a 7e85 28bc
0000030 4296 a30e 1bb4 88d4 b456 b4a6 f3aa 8cff
0000040 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000100

~# hexdump data_test.img
0000000 464c eec0 baa5 c5ff 7b99 4dfb e0b6 8a2e
0000010 e98e 5265 683c a635 c069 e402 303f d936
0000020 c243 01a7 7064 fce8 e3a9 200a 7e85 28bc
0000030 4296 a30e 1bb4 88d4 b456 b4a6 f3aa 8cff
0000040 01c9 462d 0a43 f893 0e42 67f1 57f0 787c
0000050 49c0 fb2a e514 e954 1d21 affa bac4 38f1
0000060 1ca5 ec46 77eb a854 285b 8e21 12d7 f377
0000070 b441 2baf ee33 596c 98b6 e71a c1cb 876c


Test case:
flash_erase /dev/mtd3 0 1
dd if=3Ddata_test.img of=3D/dev/mtd3
dd if=3D/dev/mtd3 of=3Daaa.img bs=3D1 count=3D256


=46rom the code I see that the AHB buffer has 1024B. It is accessed in 8
bytes packs.

This seems like some cache or HW issue....

In the old driver, to fix this problem one needed to=20
1. Reduce the RX fifo size from 128B to 64B

2. Disable (set to 0) the AHB transfer's BUF3CR ADATSZ field - the
transfer size is the same as in LUT.

(Original patch: https://patchwork.ozlabs.org/patch/675401/)


>=20
> >  =20
> > > I do have a setup with qspi0 having two SPI memories connected
> > > (2x16 MiB), and I'm wondering if anybody has some more info
> > > regarding:
> > >=20
> > > (What's more is that there is a bug in
> > >   * the "IP Command Read" in the Vybrid.) found here:
	^^^^^^^^^^^^^^^^^^^^^^^^ - It would be handy to have the exact
	explanation of this issue.

> > > https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/mtd/spi-nor=
/fsl-quadspi.c#L67
> > >=20
> > > I've googled for some errata or known issues for vybryd's QSPI IP
> > > block (vf610) but without luck so far ...   =20
> >=20
> > Unfortunately I don't know the background for this comment. =20
>=20
> The comment was added by some Freescale employee when the driver was
> added to Linux (by Huang - CC'ed).
>=20
> > Is your=20
> > board using VF610? =20
>=20
> Yes, it uses vf610 (A5 + M4 cores).
>=20
> > Do you experience problems? =20
>=20
> I've already observed following issue:
>=20
> For the current QSPI ML driver (fsl-quadspi.c - 4.19-rc3) only half
> of the AHB buffer is valid. When I do read the whole one - I do see
> read data corruption (on UBI or raw memory).=20
>=20
> This was pointed out in the patch:
> https://patchwork.ozlabs.org/patch/675401/
>=20
> Unfortunately, I did not found any info regarding this problem (in
> NXP's errata or other doc).
>=20
> I will check if this issue shows up on new patches.
>=20
> Thanks in advance for your help.
>=20
> >=20
> > Regards,
> > Frieder
> >=20
> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/ =20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/J9Lyo8WuRozmK7bxT3jnmdV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlujthAACgkQAR8vZIA0
zr3udAf/dknSEr7b8zRlHEKs0rJzbCpI+hEqWEqRWei/jvWKQECVQPiOM7a395j4
Ah58i2lWMnsj+a0c5PCho3HJOpQDmYlVu2uC8CvdDRLvGbc10AEsZ2h8cPcuRaO5
oTVYw53BwAonDJ/pk2fvyoxR87Oz0yU2yApniJBeRuy6qJSZ/ElrnNgn5zIYL3h+
PFzC5lqaY4Vc8CD0cZ236ztgazmwpqP6Y+Js+0/9S348UKNB/9hDpO4/oneY4H2O
7RGYAA7yPlppDCdLqUX9Q9QAKzlOC6fSZPSxfMTTKyr23ODeSzPjB8q/wdfSkAOl
R6WjHZvqZ7GYJkvkg1xJ/qUvVRxjOw==
=2VKG
-----END PGP SIGNATURE-----

--Sig_/J9Lyo8WuRozmK7bxT3jnmdV--


--===============8871870511445340289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============8871870511445340289==--
