From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel-spi fix cs_change
 behaviour
Date: Fri, 28 May 2010 11:49:14 +0200
Message-ID: <20100528114914.51538915@hskinnemoen-d830>
References: <4B9FA253.5030109@iis.fraunhofer.de>
	<AANLkTilADPBrg9J3n5d3r0HYjTdiaSUbKAH4Iz9Imjb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Manuel Stahl <manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTilADPBrg9J3n5d3r0HYjTdiaSUbKAH4Iz9Imjb8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Tue, Mar 16, 2010 at 9:22 AM, Manuel Stahl
> <manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org> wrote:
> > There is a problem in the cs_change behaviour in atmel-spi.
> >
> > In include/linux/spi/spi.h it says:
> >
> > Chipselect stays active during the entire message
> > (unless modified by spi_transfer.cs_change !=3D 0).
> >
> > The last parameter in atmel_spi_msg_done is named stay, so it must be c=
alled
> > with inverted cs_change value.  =

> =

> Any users of this driver have an ack/nack for this patch?  Haavard perhap=
s?

No, the current driver is doing it correctly. I've NACK'ed several
patches like this in the past.

> > @@ -501,7 +501,7 @@ atmel_spi_interrupt(int irq, void *dev_id)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (atmel_spi_xfer_is_la=
st(msg, xfer)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* repor=
t completed message */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0atmel_sp=
i_msg_done(master, as, msg, 0,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 xfer->cs_change);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 !xfer->cs_change);

The normal behaviour is:
  * After all transfers except the last: CS stays active
  * After the last transfer: CS goes inactive

The cs_change flag is used to invert this behaviour. So for the last
transfer, cs_change indicates that CS should stay active after the
transfer (though the driver may not actually be able to do so, e.g. if
the message is followed by a message to a different device.)

Haavard

---------------------------------------------------------------------------=
---
