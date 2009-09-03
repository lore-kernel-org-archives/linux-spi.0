From: siegbert.baude-Mmb7MZpHnFY@public.gmane.org
Subject: Re: [PATCH] SPI: DaVinci SPI Driver
Date: Thu, 3 Sep 2009 16:25:14 +0200
Message-ID: <281fb76e0909030725k1f82b9d5wca1d22e3f3417af4@mail.gmail.com>
References: <1251834668-32246-1-git-send-email-s-paulraj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: s-paulraj-l0cyMroinI0@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1251834668-32246-1-git-send-email-s-paulraj-l0cyMroinI0@public.gmane.org>
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

Hi Sandeep

I had another look at your code and am wondering about the correctness
of more comments, and  I wonder about error handling in the ISR:


2009/9/1  <s-paulraj-l0cyMroinI0@public.gmane.org>:
> From: Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
> + * davinci_spi_bufs - functions which will handle transfer data
> + * @spi: spi device on which data transfer to be done
> + * @t: spi transfer in which transfer info is filled
> + *
> + * This function will put data to be transferred into data register
> + * of SPI controller and then wait untill the completion will be marked
> + * by the IRQ Handler.
> + */

Is this true? For me the code seems to be polling in the transmit
case. Look down:


> +static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_trans=
fer *t)
> +{
[snip]
> + =A0 =A0 =A0 /* Determine the command to execute READ or WRITE */
> + =A0 =A0 =A0 if (t->tx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_io_bits(davinci_spi->base + SPIINT, S=
PIINT_MASKALL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_data =3D davinci_spi->ge=
t_tx(davinci_spi);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val &=3D ~(0xFFFF=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data1_reg_val |=3D (0xFFFF =
& tx_data);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =3D ioread32(davinc=
i_spi->base + SPIBUF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf_val & SPIBUF_TXFUL=
L_MASK) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(d=
ata1_reg_val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 davinci_spi->base + SPIDAT1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (ioread32(davinci_spi=
->base + SPIBUF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 & SPIBUF_RXEMPTY_MASK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax()=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* getting the returned byt=
e */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->rx_buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_val =3D=
 ioread32(davinci_spi->base + SPIBUF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi=
->get_rx(buf_val, davinci_spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

In this case you're polling the SPIBUF_TXFULL_MASK bit before you
write and then the SPIBUF_RXEMPTY_MASK bit before you read.
cpu_relax() is just an alias to barrier(), so there is no wait for an
interrupt, am I right?



> + * davinci_spi_irq - probe function for SPI Master Controller
> + * @irq: IRQ number for this SPI Master
> + * @context_data: structure for SPI Master controller davinci_spi
> + *
> + * ISR will determine that interrupt arrives either for READ or WRITE co=
mmand.
> + * According to command it will do the appropriate action. It will check
> + * transfer length and if it is not zero then dispatch transfer command =
again.
> + * If transfer length is zero then it will indicate the COMPLETION so th=
at
> + * davinci_spi_bufs function can go ahead.
> + */

I can't find anything in the below ISR code with regard to differing
between READ and WRITE or checking transfer lengthes.

> +static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
> +{
> + =A0 =A0 =A0 struct davinci_spi *davinci_spi =3D context_data;
> + =A0 =A0 =A0 u32 int_status, rx_data =3D 0;
> + =A0 =A0 =A0 irqreturn_t ret =3D IRQ_NONE;
> +
> + =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base + SPIFLG);
> + =A0 =A0 =A0 while ((int_status & SPIFLG_MASK) !=3D 0) {

SPIFLG_MASK is many more bits than just the interrupt flag. If you got
an OVRNINTFLG set, you will never end this loop, as you do not reset
this flag in davinci_spi_check_error()! In addition you would
acknowledge the interrupt, even if you just got an error and actually
another interrupt handler would have been responsible for the
interrupt that just occurred.
Because of the last argument I would move down the next line into the
following if-clause.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IRQ_HANDLED;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(int_status & SPIFLG_RX_INTR_MASK=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_data =3D ioread32(davinc=
i_spi->base + SPIBUF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 davinci_spi->get_rx(rx_data=
, davinci_spi);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable Receive Interrup=
t */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(~SPIINT_RX_INTR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 davinci_spi->base + SPIINT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void)davinci_spi_check_err=
or(davinci_spi, int_status);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_status =3D ioread32(davinci_spi->base +=
 SPIFLG);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}

There are also two small typos, "untill" and "bbased" inside comments.

Regards
Siegbert
