From: Hu Mingkai-B21284 <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds
	and mpc8536ds board
Date: Thu, 2 Sep 2010 16:30:18 +0800
Message-ID: <73839B4A0818E747864426270AC332C30561B6D1@zmy16exm20.fsl.freescale.net>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-6-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-7-git-send-email-Mingkai.hu@freescale.com>
	<AANLkTinzea7-k3Wd6EsAy+ipThHMhkpMF3pCP7g_6O6J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Gala Kumar-B11780 <B11780-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Zang Roy-R61911 <R61911-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <AANLkTinzea7-k3Wd6EsAy+ipThHMhkpMF3pCP7g_6O6J-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On Behalf Of Gra=
nt
> Likely
> Sent: Tuesday, August 10, 2010 3:11 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Gala
> Kumar-B11780; Zang Roy-R61911
> Subject: Re: [PATCH v2 6/6] DTS: add SPI flash(s25fl128p01) support on p4=
080ds
> and mpc8536ds board
> =

> Hi Mingkai,
> =

> one comment below.  Otherwise this patch looks good, and so does patch 5.
> =

> g.
> =

> On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wro=
te:
> > Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >
> > v2:
> > =A0- Remove the whitespace inconsitencies
> >
> > =A0arch/powerpc/boot/dts/mpc8536ds.dts | =A0 52
> > +++++++++++++++++++++++++++++++++++
> > =A0arch/powerpc/boot/dts/p4080ds.dts =A0 | =A0 11 +++-----
> > =A02 files changed, 56 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts
> > b/arch/powerpc/boot/dts/mpc8536ds.dts
> > index 815cebb..a75c10e 100644
> > --- a/arch/powerpc/boot/dts/mpc8536ds.dts
> > +++ b/arch/powerpc/boot/dts/mpc8536ds.dts
> > @@ -108,6 +108,58 @@
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> >
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi@7000 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc85=
36-espi";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x7000 0x1000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <59 0x2>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mp=
ic>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,espi-num-chipselects =
=3D <4>;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-=
cells =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cel=
ls =3D <1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
0>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-f=
requency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition=
@u-boot {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 label =3D "u-boot";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg =3D <0x00000000 0x00100000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 read-only;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition=
@kernel {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 label =3D "kernel";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg =3D <0x00100000 0x00500000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 read-only;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition=
@dtb {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 label =3D "dtb";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg =3D <0x00600000 0x00100000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 read-only;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition=
@fs {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 label =3D "file system";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 reg =3D <0x00700000 0x00900000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@1 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
1>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-f=
requency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@2 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
2>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-f=
requency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@3 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "spansion,s25sl12801";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
3>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-f=
requency =3D <40000000>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma@21300 {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>; dif=
f --git
> > a/arch/powerpc/boot/dts/p4080ds.dts
> > b/arch/powerpc/boot/dts/p4080ds.dts
> > index 6b29eab..48437ad 100644
> > --- a/arch/powerpc/boot/dts/p4080ds.dts
> > +++ b/arch/powerpc/boot/dts/p4080ds.dts
> > @@ -236,22 +236,19 @@
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi@110000 {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,espi";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc85=
36-espi";
> =

> Should be more specific here by specifying the exact device; plus a list =
of what
> it is compatible with.  For example:
> =

> compatible =3D "fsl,p4080-espi", "fsl,mpc5836-espi";
> =

> the reason for this is that the driver for the existing part is still abl=
e to
> bind against the node, but if it ever needs it, then information about the
> specific device is available which can be used to (for example) figure ou=
t when
> to enable silicon bug workarounds.
> =


Make sense, I'll add it.

Thanks,
Mingkai


---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
