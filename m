From: "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] SPI: DaVinci SPI Driver
Date: Thu, 3 Sep 2009 16:12:29 -0500
Message-ID: <0554BEF07D437848AF01B9C9B5F0BC5D923DA969@dlee01.ent.ti.com>
References: <1251834668-32246-1-git-send-email-s-paulraj@ti.com>
	<281fb76e0909030725k1f82b9d5wca1d22e3f3417af4@mail.gmail.com>
	<0554BEF07D437848AF01B9C9B5F0BC5D923DA4D0@dlee01.ent.ti.com>
	<4AA01D8E.7090609@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Siegbert Baude <siegbert.baude-Mmb7MZpHnFY@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4AA01D8E.7090609-Mmb7MZpHnFY@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org



> You're right about that. I was not questioning your code. That seems to
> be o.k. for me (without having tested it). I was questioning your
> comment on top of the function, as it describes something, that is not
> implemented in your function. Only one out of three possible code paths
> use interrupts, so the comment should reflect the other two polling
> paths, too.
>=20
> >>> + * davinci_spi_irq - probe function for SPI Master Controller
> >>> + * @irq: IRQ number for this SPI Master
> >>> + * @context_data: structure for SPI Master controller davinci_spi
> >>> + *
> >>> + * ISR will determine that interrupt arrives either for READ or WRIT=
E
> >> command.
> >>> + * According to command it will do the appropriate action. It will
> >> check
> >>> + * transfer length and if it is not zero then dispatch transfer
> command
> >> again.
> >>> + * If transfer length is zero then it will indicate the COMPLETION s=
o
> >> that
> >>> + * davinci_spi_bufs function can go ahead.
> >>> + */
>=20
> >> I can't find anything in the below ISR code with regard to differing
> >> between READ and WRITE or checking transfer lengthes.
>=20
> > [Sandeep] as I have mentioned above we do not have a transmit interrupt
>=20
> Again, my remark was only about the comment describing the ISR. That one
> is not in accordance with your actual implementation.
>=20
> >>> +static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
> >>> +{
> >>> +       struct davinci_spi *davinci_spi =3D context_data;
> >>> +       u32 int_status, rx_data =3D 0;
> >>> +       irqreturn_t ret =3D IRQ_NONE;
> >>> +
> >>> +       int_status =3D ioread32(davinci_spi->base + SPIFLG);
> >>> +       while ((int_status & SPIFLG_MASK) !=3D 0) {
>=20
> >> SPIFLG_MASK is many more bits than just the interrupt flag. If you got
> >> an OVRNINTFLG set, you will never end this loop, as you do not reset
> >> this flag in davinci_spi_check_error()! In addition you would
> >> acknowledge the interrupt, even if you just got an error and actually
> >> another interrupt handler would have been responsible for the
> >> interrupt that just occurred.
> >> Because of the last argument I would move down the next line into the
> >> following if-clause.
>=20
> > [Sandeep] Yes that's correct
>=20
> So here, it's the code that must be changed.
[Sandeep] I have to get in touch with David Brownell regarding this.
Earlier what I did was when I submitted the patch I took care of some comme=
nts pointed out to me but that got a NAK because it was not the original th=
at Dave had sent.

I think these fixes are to be sent as incremental patches.
>=20
> Best regards
> Siegbert
