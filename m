From: Hu Mingkai-B21284 <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2 2/6] eSPI: add eSPI controller support
Date: Thu, 2 Sep 2010 16:28:27 +0800
Message-ID: <73839B4A0818E747864426270AC332C30561B6D0@zmy16exm20.fsl.freescale.net>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<AANLkTin3W4++cAFcksVBX3QxeV8QF3d5T2tGy_KbEkRs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Gala Kumar-B11780 <B11780-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Zang Roy-R61911 <R61911-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <AANLkTin3W4++cAFcksVBX3QxeV8QF3d5T2tGy_KbEkRs-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> Sent: Tuesday, August 10, 2010 2:45 PM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Gala
> Kumar-B11780; Zang Roy-R61911
> Subject: Re: [PATCH v2 2/6] eSPI: add eSPI controller support
> =

> On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wro=
te:
> > Add eSPI controller support based on the library code spi_fsl_lib.c.
> >
> > The eSPI controller is newer controller 85xx/Pxxx devices supported.
> > There're some differences comparing to the SPI controller:
> >
> > 1. Has different register map and different bit definition
> > =A0 So leave the code operated the register to the driver code, not
> > =A0 the common code.
> >
> > 2. Support 4 dedicated chip selects
> > =A0 The software can't controll the chip selects directly, The SPCOM[CS]
> > =A0 field is used to select which chip selects is used, and the
> > =A0 SPCOM[TRANLEN] field is set to tell the controller how long the CS
> > =A0 signal need to be asserted. So the driver doesn't need the
> > chipselect
> > =A0 related function when transfering data, just set corresponding
> > register
> > =A0 fields to controll the chipseclect.
> >
> > 3. Different Transmit/Receive FIFO access register behavior
> > =A0 For SPI controller, the Tx/Rx FIFO access register can hold only
> > =A0 one character regardless of the character length, but for eSPI
> > =A0 controller, the register can hold 4 or 2 characters according to
> > =A0 the character lengths. Access the Tx/Rx FIFO access register of the
> > =A0 eSPI controller will shift out/in 4/2 characters one time. For SPI
> > =A0 subsystem, the command and data are put into different transfers, so
> > =A0 we need to combine all the transfers to one transfer in order to
> > pass
> > =A0 the transfer to eSPI controller.
> >
> > Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> =

> I've not dug deep into this patch, but it seems pretty good.  I did notic=
e one
> thing below...
> [...]
> =

> > diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> > index 774e1c8..0772c98 100644
> > --- a/drivers/spi/spi_fsl_lib.h
> > +++ b/drivers/spi/spi_fsl_lib.h
> > @@ -22,10 +22,12 @@
> > =A0struct mpc8xxx_spi {
> > =A0 =A0 =A0 =A0struct device *dev;
> > =A0 =A0 =A0 =A0struct fsl_spi_reg __iomem *base;
> > + =A0 =A0 =A0 struct fsl_espi_reg __iomem *espi_base;
> =

> There's got to be a cleaner way to do this.  Rather than putting both poi=
nters
> into mpc8xxx_spi, I suggest each driver use its own fsl_spi_priv and
> fsl_espi_priv wrapper structures that contain the controller specific pro=
perties.
> =


Make sense, I'll change it.

Thanks,
Mingkai


---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
