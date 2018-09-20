From: Lukasz Majewski <lukma@denx.de>
Subject: Re: Questions about the Freescale/NXP QuadSPI controller
Date: Fri, 21 Sep 2018 00:13:23 +0200
Message-ID: <20180921001323.596a39c8@jawa>
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
 <20180919130211.3f2e7e3a@jawa> <20180920170032.39fb5073@jawa>
 <bd116b60-49ce-b4ad-3943-93df505bc710@exceet.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3507236534488758677=="
Cc: David Wolfe <david.wolfe@nxp.com>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "richard@nod.at" <richard@nod.at>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Albert ARIBAUD <albert.aribaud@3adev.fr>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Han Xu <han.xu@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Huang Shijie <sjhuang@iluvatar.ai>
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <bd116b60-49ce-b4ad-3943-93df505bc710@exceet.de>
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

--===============3507236534488758677==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PAb3Bmzn=T6ivPbr9QPMxAI"; protocol="application/pgp-signature"

--Sig_/PAb3Bmzn=T6ivPbr9QPMxAI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Frieder,

Please find some more comments regarding the new spi-fsl-qspi.c driver.

> Hi Lukasz,
>=20
> On 20.09.2018 17:00, Lukasz Majewski wrote:
> > Hi Frieder,
> >  =20
> >> Hi Frieder,
> >> =20
> >>> Hi Lukasz,
> >>>
> >>> On 19.09.2018 00:42, Lukasz Majewski wrote: =20
> >>>> Dear All,
> >>>>
> >>>> Maybe I do jump a bit off topic here, but...
> >>>>
> >>>> I've read through the following thread:
> >>>> https://patchwork.ozlabs.org/patch/939885/
> >>>>
> >>>> And it mentions some issues with reading AHB content (buffers) in
> >>>> fsl-quadspi.c driver discovered when new QuadSPI driver was
> >>>> developed. =20
> >>>
> >>> The only setup with two chips that is known to be problematic with
> >>> the new driver, is when both chips are connected to the same bus
> >>> (e.g. QSPIA) using separate chip selects. =20
> >>
> >> I'm using QSPI0 controller, with two memories connected to QSPI0_A
> >> and QSPI0_B lines.
> >> =20
> >>>
> >>> Does your board use this kind of setup, or are the two chips
> >>> connected two different buses (QSPIA and QSPIB)?
> >>>
> >>> Have you tested the new driver? It would be great to receive some
> >>> more feedback. =20
> >>
> >> I will check (test) this new driver. No problem. =20
> >=20
> > I've ported your patch on v4.19-rc3.
> >=20
> > I had to fix the "div0 issue" by adding:
> > if (op->dummy.buswidth &&
> > 	(op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
> >=20
> > In fsl_qspi_supports_op() function.
> >=20
> >=20
> > Unfortunately, on Vybrid vf610 when testing I do see corruption of
> > read data from the mtd device:
> >=20
> > ~# hexdump aaa.img
> > 0000000 464c eec0 baa5 c5ff 7b99 4dfb e0b6 8a2e
> > 0000010 e98e 5265 683c a635 c069 e402 303f d936
> > 0000020 c243 01a7 7064 fce8 e3a9 200a 7e85 28bc
> > 0000030 4296 a30e 1bb4 88d4 b456 b4a6 f3aa 8cff
> > 0000040 ffff ffff ffff ffff ffff ffff ffff ffff
> > *
> > 0000100
> >=20
> > ~# hexdump data_test.img
> > 0000000 464c eec0 baa5 c5ff 7b99 4dfb e0b6 8a2e
> > 0000010 e98e 5265 683c a635 c069 e402 303f d936
> > 0000020 c243 01a7 7064 fce8 e3a9 200a 7e85 28bc
> > 0000030 4296 a30e 1bb4 88d4 b456 b4a6 f3aa 8cff
> > 0000040 01c9 462d 0a43 f893 0e42 67f1 57f0 787c
> > 0000050 49c0 fb2a e514 e954 1d21 affa bac4 38f1
> > 0000060 1ca5 ec46 77eb a854 285b 8e21 12d7 f377
> > 0000070 b441 2baf ee33 596c 98b6 e71a c1cb 876c
> >=20
> >=20
> > Test case:
> > flash_erase /dev/mtd3 0 1
> > dd if=3Ddata_test.img of=3D/dev/mtd3
> > dd if=3D/dev/mtd3 of=3Daaa.img bs=3D1 count=3D256
> >=20
> >=20
> >  From the code I see that the AHB buffer has 1024B. It is accessed
> > in 8 bytes packs.
> >=20
> > This seems like some cache or HW issue....
> >=20
> > In the old driver, to fix this problem one needed to
> > 1. Reduce the RX fifo size from 128B to 64B
> >=20
> > 2. Disable (set to 0) the AHB transfer's BUF3CR ADATSZ field - the
> > transfer size is the same as in LUT.
> >=20
> > (Original patch: https://patchwork.ozlabs.org/patch/675401/) =20
>=20
> Thanks a lot for doing the test. It seems like Vybrid needs some
> special handling to work around this problem.
> So this means the current driver has never worked for Vybrid, as the=20
> mentioned patch was never merged!?
>=20
> As these issues seem to be specific to Vybrid and as they seem to
> exist in the current driver too, I would like to fix them after we
> have a first version of the new driver that works for the other
> platforms.
>=20
> I hope we can figure out the other issues soon.
>=20
> Thanks,
> Frieder
>=20
> >=20
> >  =20
> >> =20
> >>>     =20
> >>>> I do have a setup with qspi0 having two SPI memories connected
> >>>> (2x16 MiB), and I'm wondering if anybody has some more info
> >>>> regarding:
> >>>>
> >>>> (What's more is that there is a bug in
> >>>>    * the "IP Command Read" in the Vybrid.) found here: =20
> > 	^^^^^^^^^^^^^^^^^^^^^^^^ - It would be handy to have the
> > exact explanation of this issue.
> >  =20
> >>>> https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/mtd/spi-no=
r/fsl-quadspi.c#L671
       ^^^^^^^^^^^^ - [1]


I've looked a bit closer to the new spi-fsl-qspi.c driver and it looks
like it uses fsl_qspi_exec_op() and then calls fsl_qspi_do_op().

In the last function we setup the QUADSPI_IPCR register to initiate the
transfer between SPI-NOR and the internal RX buffer.

Please correct me if I'm wrong but it seems to me like we are using "IP
Command Read" approach here.

If this is true - what was the rationale to use it in the new driver, as
in the old one the "AHB Command Read" approach was recommended (i.e.
faster) [1]?

To be even more problematic the info in link [1] states that on vybrid
there is a bug on the "IP Command Read" HW block and it should be
avoided.

> >>>>
> >>>> I've googled for some errata or known issues for vybryd's QSPI IP
> >>>> block (vf610) but without luck so far ... =20
> >>>
> >>> Unfortunately I don't know the background for this comment. =20
> >>
> >> The comment was added by some Freescale employee when the driver
> >> was added to Linux (by Huang - CC'ed).
> >> =20
> >>> Is your
> >>> board using VF610? =20
> >>
> >> Yes, it uses vf610 (A5 + M4 cores).
> >> =20
> >>> Do you experience problems? =20
> >>
> >> I've already observed following issue:
> >>
> >> For the current QSPI ML driver (fsl-quadspi.c - 4.19-rc3) only half
> >> of the AHB buffer is valid. When I do read the whole one - I do see
> >> read data corruption (on UBI or raw memory).
> >>
> >> This was pointed out in the patch:
> >> https://patchwork.ozlabs.org/patch/675401/
> >>
> >> Unfortunately, I did not found any info regarding this problem (in
> >> NXP's errata or other doc).
> >>
> >> I will check if this issue shows up on new patches.
> >>
> >> Thanks in advance for your help.
> >> =20
> >>>
> >>> Regards,
> >>> Frieder
> >>>
> >>> ______________________________________________________
> >>> Linux MTD discussion mailing list
> >>> http://lists.infradead.org/mailman/listinfo/linux-mtd/ =20
> >>
> >> Best regards,
> >>
> >> Lukasz Majewski
> >>
> >> --
> >>
> >> DENX Software Engineering GmbH,      Managing Director: Wolfgang
> >> Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> >> Germany Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:
> >> wd@denx.de =20
> >=20
> >=20
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:
> > wd@denx.de=20
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

--Sig_/PAb3Bmzn=T6ivPbr9QPMxAI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlukG4MACgkQAR8vZIA0
zr3lrwf/du5GHJWsNZ4xVkEsozpsto7uYs7gRGP7UGfxIi2xw4OrDJlVusW9US7v
gDQicqQBz3JICYME6eMjQ0YrUX2hseSggE4ie5dALT5w9HQ4Q4LWGsW0QqWJTbFl
wMzhQ1y6h9gZojKRv2LVOT5l67UE+dOeiMge0LgE80Al0IESjsueL9aY0zC7BQAK
7wVBFPUvfFoQQtF0pGJ0PE1/c3NiUpS76vDoLNk158uKzwY/RqK6t8M+Yxsl4lIz
ieBSGJvJMjzzRm3tsJaoXyrKFO/oT+47UlgXwMhnDirO+qoqBcwcJLsNh8UqbX2U
4kfvtOnIZszyvYeMVKMn0sVjqyfcgQ==
=iBj6
-----END PGP SIGNATURE-----

--Sig_/PAb3Bmzn=T6ivPbr9QPMxAI--


--===============3507236534488758677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============3507236534488758677==--
