From: "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] SPI: DaVinci SPI Driver
Date: Thu, 3 Sep 2009 12:36:21 -0500
Message-ID: <0554BEF07D437848AF01B9C9B5F0BC5D923DA4D0@dlee01.ent.ti.com>
References: <1251834668-32246-1-git-send-email-s-paulraj@ti.com>
	<281fb76e0909030725k1f82b9d5wca1d22e3f3417af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: "siegbert.baude-Mmb7MZpHnFY@public.gmane.org" <siegbert.baude-Mmb7MZpHnFY@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <281fb76e0909030725k1f82b9d5wca1d22e3f3417af4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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



> -----Original Message-----
> From: coocoo.channel-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org [mailto:coocoo.channel-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org=
]
> On Behalf Of siegbert.baude-Mmb7MZpHnFY@public.gmane.org
> Sent: Thursday, September 03, 2009 10:25 AM
> To: Paulraj, Sandeep
> Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org;
> dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;
> akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
> Subject: Re: [PATCH] SPI: DaVinci SPI Driver
>=20
> Hi Sandeep
>=20
> I had another look at your code and am wondering about the correctness
> of more comments, and  I wonder about error handling in the ISR:
>=20
> 2009/9/1  <s-paulraj-l0cyMroinI0@public.gmane.org>:
> > From: Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
> > + * davinci_spi_bufs - functions which will handle transfer data
> > + * @spi: spi device on which data transfer to be done
> > + * @t: spi transfer in which transfer info is filled
> > + *
> > + * This function will put data to be transferred into data register
> > + * of SPI controller and then wait untill the completion will be marke=
d
> > + * by the IRQ Handler.
> > + */
>=20
> Is this true? For me the code seems to be polling in the transmit
> case. Look down:=20
[Sandeep] if you look at=20
http://focus.ti.com/lit/ug/sprued4b/sprued4b.pdf
page 26 , there is no TXINTFLAG to complement the RXINTFLAG

and if you have a look at page 19, there is no support for transmit interru=
pt
>=20
>=20
> > +static int davinci_spi_bufs_pio(struct spi_device *spi, struct
> spi_transfer *t)
> > +{
> [snip]
> > + =A0 =A0 =A0 /* Determine the command to execute READ or WRITE */
> > + =A0 =A0 =A0 if (t->tx_buf) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT,
> SPIINT_MASKALL);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->=
get_tx(davinci_spi);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val &=3D ~(0xFF=
FF);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D (0xFFF=
F & tx_data);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =3D ioread32(davi=
nci_spi->base + SPIBUF);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf_val & SPIBUF_TXF=
ULL_MASK) =3D=3D 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32=
(data1_reg_val,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->base +
> SPIDAT1);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ioread32(davinci_s=
pi->base + SPIBUF)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 & SPIBUF_RXEMPTY_MASK)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax=
();
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* getting the returned b=
yte */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =
=3D ioread32(davinci_spi->base +
> SPIBUF);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_s=
pi->get_rx(buf_val,
> davinci_spi);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count <=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>=20
> In this case you're polling the SPIBUF_TXFULL_MASK bit before you
> write and then the SPIBUF_RXEMPTY_MASK bit before you read.
> cpu_relax() is just an alias to barrier(), so there is no wait for an
> interrupt, am I right?
[Sandeep] yes that is correct
>=20
>=20
>=20
> > + * davinci_spi_irq - probe function for SPI Master Controller
> > + * @irq: IRQ number for this SPI Master
> > + * @context_data: structure for SPI Master controller davinci_spi
> > + *
> > + * ISR will determine that interrupt arrives either for READ or WRITE
> command.
> > + * According to command it will do the appropriate action. It will
> check
> > + * transfer length and if it is not zero then dispatch transfer comman=
d
> again.
> > + * If transfer length is zero then it will indicate the COMPLETION so
> that
> > + * davinci_spi_bufs function can go ahead.
> > + */
>=20
> I can't find anything in the below ISR code with regard to differing
> between READ and WRITE or checking transfer lengthes.
[Sandeep] as I have mentioned above we do not have a transmit interrupt
>=20
> > +static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
> > +{
> > + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D context_data;
> > + =A0 =A0 =A0 u32 int_status, rx_data =3D 0;
> > + =A0 =A0 =A0 irqreturn_t ret =3D IRQ_NONE;
> > +
> > + =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
> > + =A0 =A0 =A0 while ((int_status & SPIFLG_MASK) !=3D 0) {
>=20
> SPIFLG_MASK is many more bits than just the interrupt flag. If you got
> an OVRNINTFLG set, you will never end this loop, as you do not reset
> this flag in davinci_spi_check_error()! In addition you would
> acknowledge the interrupt, even if you just got an error and actually
> another interrupt handler would have been responsible for the
> interrupt that just occurred.
> Because of the last argument I would move down the next line into the
> following if-clause.
[Sandeep] Yes that's correct
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IRQ_HANDLED;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(int_status & SPIFLG_RX_INTR_MA=
SK)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_data =3D ioread32(davi=
nci_spi->base + SPIBUF);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx(rx_da=
ta, davinci_spi);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable Receive Interr=
upt */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(~SPIINT_RX_INTR=
,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 davinci_spi->base + SPIINT);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void)davinci_spi_check_e=
rror(davinci_spi,
> int_status);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base=
 + SPIFLG);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return ret;
> > +}
>=20
> There are also two small typos, "untill" and "bbased" inside comments.
[Sandeep] OK Thanks
>=20
> Regards
> Siegbert
