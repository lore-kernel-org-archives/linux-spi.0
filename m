From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v3 1/2] spi: implemented driver for
	Cirrus EP93xx SPI	controller
Date: Tue, 20 Apr 2010 09:16:19 +0300
Message-ID: <20100420061619.GI19534@gw.healthdatacare.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 19, 2010 at 12:02:39PM -0600, Grant Likely wrote:
> On Sat, Apr 17, 2010 at 5:00 AM, Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>=
 wrote:
> > On Fri, Apr 16, 2010 at 11:30:45PM -0700, Grant Likely wrote:
> >> Thanks for the patch. =A0Comments below.
> >
> > Thanks for the comments. See below my replies.
> =

> >> On Tue, Apr 13, 2010 at 7:10 AM, Mika Westerberg <mika.westerberg@iki.=
fi> wrote:
> >> > +static int transfer_method =3D EP93XX_SPI_METHOD_INTERRUPT;
> >> > +module_param(transfer_method, int, S_IRUGO);
> >> > +MODULE_PARM_DESC(transfer_method,
> >> > + =A0 =A0 =A0 "Used transfer method (0=3Dpoll, 1=3Dinterrupt [defaul=
t])");
> >>
> >> Should this really be a module parameter? =A0Would it be better to
> >> expose this knob as part of pdata or in sysfs? =A0(Assuming there even
> >> is a real need to manipulate this control)
> >
> > Hard to say. At least it was easier to test both modes by just
> > loading the module with correct parameter but it could possibly be
> > placed in pdata also, if required.
> =

> Is it the sort of thing that can/should be changed at runtime (sysfs)?
>  Is there the possibility of multiple instances of this device on a
> single SoC?  I'm not strictly opposed to these lines, but I ask to
> make sure they are the right abstraction.

I've actually decided to drop the whole polling mode.  So this
parameter will be gone in next revision.

> =

> >> > + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*clk;
> >> > + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*r=
egs_base;
> >> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 irq;
> >> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_=
rate;
> >> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_=
rate;
> >> > + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0running;
> >> > + =A0 =A0 =A0 struct workqueue_struct =A0 =A0 =A0 =A0 *wq;
> >> > + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0 =A0 =A0 =A0 =A0msg_work;
> >> > + =A0 =A0 =A0 struct completion =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait;
> >> > + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg_qu=
eue;
> >> > + =A0 =A0 =A0 struct spi_message =A0 =A0 =A0 =A0 =A0 =A0 =A0*current=
_msg;
> >> > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0tx;
> >> > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0rx;
> >> > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0fifo_level;
> >> > + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(*transfer)(struct ep93xx_spi *);
> >> > +};
> >> > +
> >> > +/**
> >> > + * struct ep93xx_spi_chip - SPI device hardware settings
> >> > + * @rate: max rate in hz this chip supports
> >> > + * @div_cpsr: cpsr (pre-scaler) divider
> >> > + * @div_scr: scr divider
> >> > + * @dss: bits per word (4 - 16 bits)
> >> > + * @mode: chip SPI mode (see also &struct spi_device)
> >> > + *
> >> > + * This structure is used to store hardware register specific setti=
ngs for each
> >> > + * SPI device. Settings are written to hardware by function
> >> > + * ep93xx_spi_chip_setup().
> >> > + */
> >> > +struct ep93xx_spi_chip {
> >> > + =A0 =A0 =A0 unsigned long =A0 rate;
> >> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0div_cpsr;
> >> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0div_scr;
> >> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0dss;
> >> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode;
> >> > +};
> >> > +
> >> > +/* converts bits per word to CR0.DSS value */
> >> > +#define bits_per_word_to_dss(bpw) =A0 =A0 =A0((bpw) - 1)
> >> > +
> >> > +static inline void
> >> > +ep93xx_spi_write_u8(const struct ep93xx_spi *espi, u16 reg, u8 valu=
e)
> >> > +{
> >> > + =A0 =A0 =A0 __raw_writeb(value, espi->regs_base + reg);
> >> > +}
> >> > +
> >> > +static inline u8
> >> > +ep93xx_spi_read_u8(const struct ep93xx_spi *spi, u16 reg)
> >> > +{
> >> > + =A0 =A0 =A0 return __raw_readb(spi->regs_base + reg);
> >> > +}
> >> > +
> >> > +static inline void
> >> > +ep93xx_spi_write_u16(const struct ep93xx_spi *espi, u16 reg, u16 va=
lue)
> >> > +{
> >> > + =A0 =A0 =A0 __raw_writew(value, espi->regs_base + reg);
> >> > +}
> >> > +
> >> > +static inline u16
> >> > +ep93xx_spi_read_u16(const struct ep93xx_spi *spi, u16 reg)
> >> > +{
> >> > + =A0 =A0 =A0 return __raw_readw(spi->regs_base + reg);
> >> > +}
> >> > +
> >> > +/**
> >> > + * ep93xx_spi_enable() - enables the SPI controller and clock
> >> > + * @espi: ep93xx SPI controller struct
> >> > + *
> >> > + * This function enables the SPI controller and its clock. Returns =
%0 in case
> >> > + * of success and negative error in case if failure.
> >> > + */
> >> > +static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
> >> > +{
> >> > + =A0 =A0 =A0 u8 regval;
> >> > + =A0 =A0 =A0 int err;
> >> > +
> >> > + =A0 =A0 =A0 err =3D clk_enable(espi->clk);
> >> > + =A0 =A0 =A0 if (err)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> >> > +
> >> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> >> > + =A0 =A0 =A0 regval |=3D SSPCR1_SSE;
> >> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> >> > +
> >> > + =A0 =A0 =A0 return 0;
> >> > +}
> >> > +
> >> > +/**
> >> > + * ep93xx_spi_disable() - disables the SPI controller and clock
> >> > + * @espi: ep93xx SPI controller struct
> >> > + *
> >> > + * Function disables SPI controller and its clock.
> >> > + */
> >> > +static void ep93xx_spi_disable(const struct ep93xx_spi *espi)
> >> > +{
> >> > + =A0 =A0 =A0 u8 regval;
> >> > +
> >> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> >> > + =A0 =A0 =A0 regval &=3D ~SSPCR1_SSE;
> >> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> >> > +
> >> > + =A0 =A0 =A0 clk_disable(espi->clk);
> >> > +}
> >> > +
> >> > +/**
> >> > + * ep93xx_spi_enable_interrupts() - enables all SPI interrupts
> >> > + * @espi: ep93xx SPI controller struct
> >> > + *
> >> > + * Enables all SPI interrupts: receive overrun (ROR), transmit and =
receive.
> >> > + */
> >> > +static inline void
> >> > +ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
> >> > +{
> >> > + =A0 =A0 =A0 u8 regval;
> >> > +
> >> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> >> > + =A0 =A0 =A0 regval |=3D (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
> >> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> >> > +}
> >> > +
> >> > +/**
> >> > + * ep93xx_spi_disable_interrupts() - disables all SPI interrupts
> >> > + * @espi: ep93xx SPI controller struct
> >> > + *
> >> > + * Disables all SPI interrupts.
> >> > + */
> >> > +static inline void
> >> > +ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
> >> > +{
> >> > + =A0 =A0 =A0 u8 regval;
> >> > +
> >> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> >> > + =A0 =A0 =A0 regval &=3D ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
> >> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> >> > +}
> >> > +
> >> > +/**
> >> > + * ep93xx_spi_flush() - flushes SPI RX FIFO
> >> > + * @espi: ep93xx SPI controller struct
> >> > + * @msecs: timeout in milliseconds to wait
> >> > + *
> >> > + * This function flushes RX FIFO. Returns %0 in case of success and=
 %-ETIMEDOUT
> >> > + * when timeout occured. Wait is implemented in busylooping so this=
 function can
> >> > + * also be called from atomic context.
> >> > + */
> >> > +static int ep93xx_spi_flush(const struct ep93xx_spi *espi, unsigned=
 long msecs)
> >> > +{
> >> > + =A0 =A0 =A0 unsigned long timeout =3D jiffies + msecs_to_jiffies(m=
secs);
> >> > +
> >> > + =A0 =A0 =A0 while (ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_RNE) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> >>
> >> Ouch. =A0With the current code the driver could busy wait for 100ms! =
=A0If
> >> flushing takes time, then don't busywait. =A0Bail out to some form of
> >> deferred work. =A0Let the kernel get on with something else.
> >
> > I've never witnessed flushing to take this whole 100ms. Timeout is
> > there just to make sure that this ends eventually. I can change it
> > to some lower value (say few msecs or something like that).
> =

> Even with a lower value, the driver is still busywaiting which is bad
> for latency.  If I see a lot of busywaiting, then I look very closely
> at refactoring the driver into a state machine that can easily defer
> work.

RNE (RX FIFO not empty) bit is set only when there is stuff in the
FIFO. So it should be safe to read from. In normal cases FIFO is
just cleared and no timeout happens. It shouldn't busywait because
for every iteration it reads next frame from the FIFO.

Timeout was added there just to make sure that if the controller
goes mad we don't hang there forever.

But if you can explain little more detail how to implement this with
a state machine which can defer work I can implement that then.

> >> > +
> >> > +/**
> >> > + * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
> >> > + * @espi: ep93xx SPI controller struct
> >> > + * @chip: divisors are calculated for this chip
> >> > + * @rate: desired SPI output clock rate
> >> > + *
> >> > + * Function calculates cpsr (clock pre-scaler) and scr divisors bas=
ed on
> >> > + * given @rate and places them to @chip->div_cpsr and @chip->div_sc=
r. If,
> >> > + * for some reason, divisors cannot be calculated nothing is stored=
 and
> >> > + * %-EINVAL is returned.
> >> > + */
> >> > +static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct ep93xx_spi_chip *chip,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned long rate)
> >> > +{
> >> > + =A0 =A0 =A0 unsigned long spi_clk_rate =3D clk_get_rate(espi->clk);
> >> > + =A0 =A0 =A0 int cpsr, scr;
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* Make sure that max value is between values suppor=
ted by the
> >> > + =A0 =A0 =A0 =A0* controller. Note that minimum value is already ch=
ecked in
> >> > + =A0 =A0 =A0 =A0* ep93xx_spi_transfer().
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 rate =3D clamp(rate, espi->min_rate, espi->max_rate);
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* Calculate divisors so that we can get speed accor=
ding the
> >> > + =A0 =A0 =A0 =A0* following formula:
> >> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0rate =3D spi_clock_rate / (cpsr * (1 +=
 scr))
> >> > + =A0 =A0 =A0 =A0*
> >> > + =A0 =A0 =A0 =A0* cpsr must be even number and starts from 2, scr c=
an be any number
> >> > + =A0 =A0 =A0 =A0* between 0 and 255.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 for (cpsr =3D 2; cpsr <=3D 254; cpsr +=3D 2) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (scr =3D 0; scr <=3D 255; scr++) {
> >>
> >> Non-deterministic. =A0Big nested loops mean a lot of calculations with=
in
> >> =A0ep93xx_spi_process_transfer, and calculated values aren't cached if
> >> they get replaced. =A0If you can, it would be better if you can
> >> algebraically calculate the factors instead of an iterative loop.
> >> It's requires more thinking at the outset, but it is worth the effort.
> >
> > Is it normal to change speed per transfer? ep93xx_spi_process_transfer()
> > only calls this if speed changes. That's why I used those loops
> > here; the assumption is that it is only called at setup time (and
> > even there only when speed changes).
> >
> > For example in my test system using mmc_spi it was called total 3 times.
> =

> But it is a concern if you have two spi devices with different
> constraints attached to the same bus.
> =

> I'm not going to reject the driver over this, but you should be aware
> of it and it probably should be fixed.

OK.

> =

> >> > + =A0 =A0 =A0 chip->mode =3D spi->mode;
> >> > + =A0 =A0 =A0 chip->dss =3D bits_per_word_to_dss(spi->bits_per_word);
> >>
> >> Why is mode and dss getting copied into chip? =A0chip should probable
> >> instead have a reference back to its assigned spi device and the
> >> original values should be used.
> >
> > This is done because if there are transfer specific settings (for
> > example bits per word changes) we can just make temporary copy of
> > chip and change those values and then restore back the original,
> > once the transfer is finished (see ep93xx_spi_process_transfer()).
> >
> > Mode, however is redundant as it cannot be changed per transfer (or
> > even per message). I will drop that from the struct.
> =

> ok
> =

> >> > + =A0 =A0 =A0 /* read all received data */
> >> > + =A0 =A0 =A0 while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->rx < t->len) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_do_read(espi, t);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->fifo_level--;
> >> > + =A0 =A0 =A0 }
> >>
> >> Another busywait loop. =A0Could end up burning an awful lot of cycles
> >> here. =A0A state machine might be more suitable for this driver so that
> >> processing can be punted to deferred work when the FIFO gets either
> >> empty or full.
> >
> > FIFO size is max 8 frames so there should be 8 iterations when the
> > FIFO is full. So is it enought to to add check that we only read
> > max 8 frames from the FIFO?
> =

> If you do it right, FIFO size shouldn't matter.  The driver should
> easily be able to read however many are available and defer until more
> is ready.

Agreed. There is no need for FIFO size checking in this particular loop.

Checking the RNE bit is enough. The driver reads as many frames as there
are available.

I'll also remove those useless checks as Martin commented in his previous
mail.

> >
> >> > +
> >> > + =A0 =A0 =A0 /* write as long as FIFO has room */
> >> > + =A0 =A0 =A0 while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < =
t->len) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_do_write(espi, t);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->fifo_level++;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 /* are we done yet? */
> >> > + =A0 =A0 =A0 if (espi->tx =3D=3D t->len && espi->rx =3D=3D t->len) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->actual_length +=3D t->len;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return t->len;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 return 0;
> >> > +}
> >> > +
> >> > +/**
> >> > + * ep93xx_spi_polling_transfer() - implement polling mode transfer
> >> > + * @espi: ep93xx SPI controller struct
> >> > + *
> >> > + * Function performs one polling mode transfer. When this function =
is finished,
> >> > + * the whole transfer should be completed, or failed in case of err=
or.
> >> > + */
> >> > +static void ep93xx_spi_polling_transfer(struct ep93xx_spi *espi)
> >> > +{
> >> > + =A0 =A0 =A0 while (!ep93xx_spi_read_write(espi))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> >>
> >> And if it never finishes? =A0No exit path on error.
> >
> > Well with current implementation of ep93xx_spi_read_write() it
> > cannot fail. =A0I guess some sort of timeout could be used here. Also
> > we can take ROR (receive overrun) interrupt and report that back.
> =

> In cases like this, if you've got a guaranteed no-fail path, then a
> comment stating explicitly that is helpful to the reader.  :-)

Yeah sorry about that.

I'll drop the polling mode so this function is gone in next revision.

> =

> >> > + =A0 =A0 =A0 if (t->cs_change) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In case protocol driver is asking=
 us to drop the
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* chipselect briefly, we let the sc=
heduler to handle
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* any "delay" here.
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_is_last(&t->transfer_list, &=
msg->transfers)) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_deselect_de=
vice(espi, msg->spi);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cond_resched();
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_select_devi=
ce(espi, msg->spi);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 if (t->speed_hz || t->bits_per_word)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_chip_setup(espi, chip);
> >> > +}
> >> > +
> >> > +/*
> >> > + * ep93xx_spi_process_message() - process one SPI message
> >> > + * @espi: ep93xx SPI controller struct
> >> > + * @msg: message to process
> >> > + *
> >> > + * This function processes a single SPI message. We go through all =
transfers in
> >> > + * the message and pass them to ep93xx_spi_process_transfer(). Chip=
select is
> >> > + * asserted during the whole message (unless per transfer cs_change=
 is set).
> >> > + *
> >> > + * @msg->status contains %0 in case of success or negative error co=
de in case of
> >> > + * failure.
> >> > + */
> >> > +static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0struct spi_message *msg)
> >> > +{
> >> > + =A0 =A0 =A0 struct spi_transfer *t;
> >> > + =A0 =A0 =A0 int err;
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* Enable the SPI controller and its clock.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 err =3D ep93xx_spi_enable(espi);
> >> > + =A0 =A0 =A0 if (err) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&espi->pdev->dev, "failed to e=
nable SPI controller\n");
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->status =3D err;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* Just to be sure: flush any data from RX FIFO.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 err =3D ep93xx_spi_flush(espi, SPI_TIMEOUT);
> >> > + =A0 =A0 =A0 if (err) {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&espi->pdev->dev, "timeout wh=
ile flushing RX fifo\n");
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->status =3D err;
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> > + =A0 =A0 =A0 }
> >> > +
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* Update SPI controller registers according to spi =
device and assert
> >> > + =A0 =A0 =A0 =A0* the chipselect.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
> >> > + =A0 =A0 =A0 ep93xx_spi_select_device(espi, msg->spi);
> >> > +
> >> > + =A0 =A0 =A0 list_for_each_entry(t, &msg->transfers, transfer_list)=
 {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cond_resched();
> >>
> >> Why is this necessary?
> >
> > Well it isn't strictly necessary. This is just one of the places where =
we can
> > voluntarily relinguish the cpu for a while. I can remove that if necess=
ary.
> =

> I'd remove it.  There aren't very many places where the driver would
> legitimately want to do this, especially if you reduce the
> busywaiting.  Trust the scheduler to make sure you're process doesn't
> get too much time.

OK.

> =

> >> > + =A0 =A0 =A0 list_del_init(&msg->queue);
> >> > + =A0 =A0 =A0 espi->current_msg =3D msg;
> >> > + =A0 =A0 =A0 spin_unlock_irq(&espi->lock);
> >>
> >> I'm nervous about the locking. =A0I'm not convinced that it covers all
> >> the important cases. =A0Are you able to describe what the locks protec=
t,
> >> and why they are taken when they are? =A0That would help me evaluate
> >> what the driver should be doing.
> >
> > Ok. here is a description of the locking model (sorry if this is
> > bit messy):
> >
> > Lock should protect following fields:
> > =A0 =A0 =A0 =A0running
> > =A0 =A0 =A0 =A0current_msg
> > =A0 =A0 =A0 =A0msg_queue
> >
> > (rest of the fields are basically only set once, except rx, tx and
> > fifo_level)
> >
> > espi->msg_queue needs protection because there might be multiple
> > threads adding to the queue.
> >
> > espi->running signals whether the driver is processing messages or
> > not. It can be changed when module is unloading, hence it needs
> > protection.
> >
> > espi->current_msg is used to hold pointer to currently processed
> > message. This message has been removed from the espi->msg_queue.
> > It also indicates whether we can proceed with the next message. If
> > it is NULL we are allowed to process the next message.
> >
> > Assumption is that when espi->current_msg is not NULL, message is
> > processed and we won't call ep93xx_spi_process_message(). This
> > allows us to use espi->rx, espi->tx, and espi->fifo_level without
> > locks.
> =

> So you need to make sure that the lock is held over the entire region
> between checking ->running, checking ->current_msg, and actually
> modifying the queue or setting current_msg, right?

Right. I think it is currently like that, no?

Thank you very much for your comments. I'll try to post next revision
later today.

Regards,
MW

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
