From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] spi: bitbang: convert to using core message queue
Date: Wed, 11 Apr 2012 22:56:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204112254420.10361@axis700.grange>
References: <Pine.LNX.4.64.1203141837170.30291@axis700.grange>
	<20120315092923.951203E04FD@localhost>
	<CACRpkdZNQZyx-HZjzyMctpUQJtNYMwq5KsdE6RTFwKcHuz_X+w@mail.gmail.com>
	<Pine.LNX.4.64.1203170036590.20979@axis700.grange>
	<CACRpkdZFobGAqO-8xe_JqA9stc=S6SHBCNEN4DSXy1AN5Ro8HQ@mail.gmail.com>
	<20120320144054.930D03E2834@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120320144054.930D03E2834@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant

On Tue, 20 Mar 2012, Grant Likely wrote:

> On Mon, 19 Mar 2012 00:33:14 +0100, Linus Walleij <linus.walleij@linaro.o=
rg> wrote:
> > On Sat, Mar 17, 2012 at 12:39 AM, Guennadi Liakhovetski
> > <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> > =

> > > The SPI subsystem core now manages message queues internally. Remove =
the
> > > local message queue implementation from the spi-bitbang driver and
> > > migrate to the common one.
> > >
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > =

> > This is great stuff!
> > Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > =

> > (Since I've never really used the bitbang driver I wouldn't trust me to
> > do any deeper review.)
> =

> In hindsite; I should have asked you to make the pl driver use bitbang
> queueing since that was already used for generic queuing by a number
> of drivers; and then refactored that to perform better.  Doing that
> would have been refactoring better tested code, but oh well.
> =

> I'm going to ignore this series for the moment; please remind me to
> look at it after the merge window has closed.

Seems to be time:-)

Thanks
Guennadi

> =

> g.
> =

> > =

> > Quick thought:
> > =

> > > +static int spi_bitbang_dummy_prepare(struct spi_master *master)
> > > +{
> > > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > (...)
> > > + =C2=A0 =C2=A0 =C2=A0 master->prepare_transfer_hardware =3D spi_bitb=
ang_dummy_prepare;
> > > + =C2=A0 =C2=A0 =C2=A0 master->unprepare_transfer_hardware =3D spi_bi=
tbang_dummy_prepare;
> > =

> > Maybe we should think about making these two hooks optional if this
> > pattern turns up a lot. I'll try to fix some refactoring further down t=
he
> > road if nobody beats me to it.
> > =

> > Yours,
> > Linus Walleij
> From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Subject: Re: [PATCH] spi: bitbang: convert to using core message queue
> To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Linus Walleij <linus.w=
alleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Magnus Damm <magnus.damm@gma=
il.com>
> In-Reply-To: <Pine.LNX.4.64.1203170036590.20979-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
> References: <Pine.LNX.4.64.1203141837170.30291-0199iw4Nj15frtckUFj5Ag@public.gmane.org> <201203150=
92923.951203E04FD@localhost> <CACRpkdZNQZyx-HZjzyMctpUQJtNYMwq5KsdE6RTFwKcH=
uz_X+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> <Pine.LNX.4.64.1203170036590.20979-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
> =

> On Sat, 17 Mar 2012 00:39:44 +0100 (CET), Guennadi Liakhovetski <g.liakho=
vetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> > The SPI subsystem core now manages message queues internally. Remove the
> > local message queue implementation from the spi-bitbang driver and
> > migrate to the common one.
> > =

> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > ---
> > =

> > On Fri, 16 Mar 2012, Linus Walleij wrote:
> > =

> > > On Thu, Mar 15, 2012 at 10:29 AM, Grant Likely
> > > <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> > > > On Wed, 14 Mar 2012 22:04:25 +0100 (CET), Guennadi Liakhovetski <g.=
liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> > > >> This patch adds a PM QoS requirement to the spi-bitbang driver, pr=
eventing
> > > >> the underlying SPI hardware driver to suspend for too long a time,=
 as long
> > > >> as there are transfers on the queue.
> > > >>
> > > >> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > > >
> > > > Shouldn't this be part of the core spi infrastructure? =C2=A0Partic=
ularly since queuing
> > > > is moving into the core.
> > > =

> > > Hm, the spi-bitbang driver needs to be converted to use the central
> > > message queue, Guennadi can you look into that since you're using it?
> > > =

> > > The spi-pl022.c and also Samsung spi-s3c64xx.c is converted showing
> > > examples on how go about with that.
> > =

> > Something like this? Tested with spi-sh-msiof on SuperH and sh-mobile A=
RM =

> > and with spi-gpio.
> > =

> >  drivers/spi/spi-bitbang.c       |  280 +++++++++++++++----------------=
--------
> >  include/linux/spi/spi_bitbang.h |    7 -
> >  2 files changed, 108 insertions(+), 179 deletions(-)
> > =

> > diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> > index 6c0ec81..5f163d9 100644
> > --- a/drivers/spi/spi-bitbang.c
> > +++ b/drivers/spi/spi-bitbang.c
> > @@ -244,162 +244,125 @@ static int spi_bitbang_bufs(struct spi_device *=
spi, struct spi_transfer *t)
> >  =

> >  /*--------------------------------------------------------------------=
--*/
> >  =

> > -/*
> > - * SECOND PART ... simple transfer queue runner.
> > - *
> > - * This costs a task context per controller, running the queue by
> > - * performing each transfer in sequence.  Smarter hardware can queue
> > - * several DMA transfers at once, and process several controller queues
> > - * in parallel; this driver doesn't match such hardware very well.
> > - *
> > - * Drivers can provide word-at-a-time i/o primitives, or provide
> > - * transfer-at-a-time ones to leverage dma or fifo hardware.
> > - */
> > -static void bitbang_work(struct work_struct *work)
> > +static int spi_bitbang_transfer_one_message(struct spi_master *master,
> > +					    struct spi_message *msg)
> >  {
> > -	struct spi_bitbang	*bitbang =3D
> > -		container_of(work, struct spi_bitbang, work);
> > +	struct spi_bitbang	*bitbang =3D spi_master_get_devdata(master);
> > +	struct spi_device	*spi =3D msg->spi;
> > +	unsigned		nsecs;
> > +	struct spi_transfer	*t =3D NULL;
> >  	unsigned long		flags;
> > -	struct spi_message	*m, *_m;
> > +	unsigned		cs_change;
> > +	int			status;
> > +	int			do_setup =3D -1;
> >  =

> > +	/* Protect against chip-select release in .setup() */
> >  	spin_lock_irqsave(&bitbang->lock, flags);
> >  	bitbang->busy =3D 1;
> > -	list_for_each_entry_safe(m, _m, &bitbang->queue, queue) {
> > -		struct spi_device	*spi;
> > -		unsigned		nsecs;
> > -		struct spi_transfer	*t =3D NULL;
> > -		unsigned		tmp;
> > -		unsigned		cs_change;
> > -		int			status;
> > -		int			do_setup =3D -1;
> > -
> > -		list_del(&m->queue);
> > -		spin_unlock_irqrestore(&bitbang->lock, flags);
> > -
> > -		/* FIXME this is made-up ... the correct value is known to
> > -		 * word-at-a-time bitbang code, and presumably chipselect()
> > -		 * should enforce these requirements too?
> > -		 */
> > -		nsecs =3D 100;
> > +	spin_unlock_irqrestore(&bitbang->lock, flags);
> >  =

> > -		spi =3D m->spi;
> > -		tmp =3D 0;
> > -		cs_change =3D 1;
> > -		status =3D 0;
> > +	/* FIXME this is made-up ... the correct value is known to
> > +	 * word-at-a-time bitbang code, and presumably chipselect()
> > +	 * should enforce these requirements too?
> > +	 */
> > +	nsecs =3D 100;
> >  =

> > -		list_for_each_entry (t, &m->transfers, transfer_list) {
> > -
> > -			/* override speed or wordsize? */
> > -			if (t->speed_hz || t->bits_per_word)
> > -				do_setup =3D 1;
> > -
> > -			/* init (-1) or override (1) transfer params */
> > -			if (do_setup !=3D 0) {
> > -				status =3D bitbang->setup_transfer(spi, t);
> > -				if (status < 0)
> > -					break;
> > -				if (do_setup =3D=3D -1)
> > -					do_setup =3D 0;
> > -			}
> > -
> > -			/* set up default clock polarity, and activate chip;
> > -			 * this implicitly updates clock and spi modes as
> > -			 * previously recorded for this device via setup().
> > -			 * (and also deselects any other chip that might be
> > -			 * selected ...)
> > -			 */
> > -			if (cs_change) {
> > -				bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
> > -				ndelay(nsecs);
> > -			}
> > -			cs_change =3D t->cs_change;
> > -			if (!t->tx_buf && !t->rx_buf && t->len) {
> > -				status =3D -EINVAL;
> > -				break;
> > -			}
> > +	cs_change =3D 1;
> > +	status =3D 0;
> >  =

> > -			/* transfer data.  the lower level code handles any
> > -			 * new dma mappings it needs. our caller always gave
> > -			 * us dma-safe buffers.
> > -			 */
> > -			if (t->len) {
> > -				/* REVISIT dma API still needs a designated
> > -				 * DMA_ADDR_INVALID; ~0 might be better.
> > -				 */
> > -				if (!m->is_dma_mapped)
> > -					t->rx_dma =3D t->tx_dma =3D 0;
> > -				status =3D bitbang->txrx_bufs(spi, t);
> > -			}
> > -			if (status > 0)
> > -				m->actual_length +=3D status;
> > -			if (status !=3D t->len) {
> > -				/* always report some kind of error */
> > -				if (status >=3D 0)
> > -					status =3D -EREMOTEIO;
> > +	list_for_each_entry (t, &msg->transfers, transfer_list) {
> > +
> > +		/* override speed or wordsize? */
> > +		if (t->speed_hz || t->bits_per_word)
> > +			do_setup =3D 1;
> > +
> > +		/* init (-1) or override (1) transfer params */
> > +		if (do_setup !=3D 0) {
> > +			status =3D bitbang->setup_transfer(spi, t);
> > +			if (status < 0)
> >  				break;
> > -			}
> > -			status =3D 0;
> > -
> > -			/* protocol tweaks before next transfer */
> > -			if (t->delay_usecs)
> > -				udelay(t->delay_usecs);
> > -
> > -			if (cs_change && !list_is_last(&t->transfer_list, &m->transfers)) {
> > -				/* sometimes a short mid-message deselect of the chip
> > -				 * may be needed to terminate a mode or command
> > -				 */
> > -				ndelay(nsecs);
> > -				bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> > -				ndelay(nsecs);
> > -			}
> > +			if (do_setup =3D=3D -1)
> > +				do_setup =3D 0;
> >  		}
> >  =

> > -		m->status =3D status;
> > -		m->complete(m->context);
> > +		/* set up default clock polarity, and activate chip;
> > +		 * this implicitly updates clock and spi modes as
> > +		 * previously recorded for this device via setup().
> > +		 * (and also deselects any other chip that might be
> > +		 * selected ...)
> > +		 */
> > +		if (cs_change) {
> > +			bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
> > +			ndelay(nsecs);
> > +		}
> > +		cs_change =3D t->cs_change;
> > +		if (!t->tx_buf && !t->rx_buf && t->len) {
> > +			status =3D -EINVAL;
> > +			break;
> > +		}
> >  =

> > -		/* normally deactivate chipselect ... unless no error and
> > -		 * cs_change has hinted that the next message will probably
> > -		 * be for this chip too.
> > +		/* transfer data.  the lower level code handles any
> > +		 * new dma mappings it needs. our caller always gave
> > +		 * us dma-safe buffers.
> >  		 */
> > -		if (!(status =3D=3D 0 && cs_change) ||
> > -		    spi->flags & SPI_BOARD_FLAG_RELEASE_CS) {
> > +		if (t->len) {
> > +			/* REVISIT dma API still needs a designated
> > +			 * DMA_ADDR_INVALID; ~0 might be better.
> > +			 */
> > +			if (!msg->is_dma_mapped)
> > +				t->rx_dma =3D t->tx_dma =3D 0;
> > +			status =3D bitbang->txrx_bufs(spi, t);
> > +		}
> > +		if (status > 0)
> > +			msg->actual_length +=3D status;
> > +		if (status !=3D t->len) {
> > +			/* always report some kind of error */
> > +			if (status >=3D 0)
> > +				status =3D -EREMOTEIO;
> > +			break;
> > +		}
> > +		status =3D 0;
> > +
> > +		/* protocol tweaks before next transfer */
> > +		if (t->delay_usecs)
> > +			udelay(t->delay_usecs);
> > +
> > +		if (cs_change && !list_is_last(&t->transfer_list, &msg->transfers)) {
> > +			/* sometimes a short mid-message deselect of the chip
> > +			 * may be needed to terminate a mode or command
> > +			 */
> >  			ndelay(nsecs);
> >  			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> >  			ndelay(nsecs);
> >  		}
> > -
> > -		spin_lock_irqsave(&bitbang->lock, flags);
> >  	}
> > -	bitbang->busy =3D 0;
> > -	spin_unlock_irqrestore(&bitbang->lock, flags);
> > -}
> >  =

> > -/**
> > - * spi_bitbang_transfer - default submit to transfer queue
> > - */
> > -int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m)
> > -{
> > -	struct spi_bitbang	*bitbang;
> > -	unsigned long		flags;
> > -	int			status =3D 0;
> > -
> > -	m->actual_length =3D 0;
> > -	m->status =3D -EINPROGRESS;
> > +	msg->status =3D status;
> >  =

> > -	bitbang =3D spi_master_get_devdata(spi->master);
> > +	/* normally deactivate chipselect ... unless no error and
> > +	 * cs_change has hinted that the next message will probably
> > +	 * be for this chip too.
> > +	 */
> > +	if (!(status =3D=3D 0 && cs_change) ||
> > +	    spi->flags & SPI_BOARD_FLAG_RELEASE_CS) {
> > +		ndelay(nsecs);
> > +		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> > +		ndelay(nsecs);
> > +	}
> >  =

> >  	spin_lock_irqsave(&bitbang->lock, flags);
> > -	if (!spi->max_speed_hz)
> > -		status =3D -ENETDOWN;
> > -	else {
> > -		list_add_tail(&m->queue, &bitbang->queue);
> > -		queue_work(bitbang->workqueue, &bitbang->work);
> > -	}
> > +	bitbang->busy =3D 0;
> >  	spin_unlock_irqrestore(&bitbang->lock, flags);
> >  =

> > -	return status;
> > +	spi_finalize_current_message(master);
> > +
> > +	return 0;
> > +}
> > +
> > +static int spi_bitbang_dummy_prepare(struct spi_master *master)
> > +{
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
> >  =

> >  /*--------------------------------------------------------------------=
--*/
> >  =

> > @@ -408,9 +371,7 @@ EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
> >   * @bitbang: driver handle
> >   *
> >   * Caller should have zero-initialized all parts of the structure, and=
 then
> > - * provided callbacks for chip selection and I/O loops.  If the master=
 has
> > - * a transfer method, its final step should call spi_bitbang_transfer;=
 or,
> > - * that's the default if the transfer routine is not initialized.  It =
should
> > + * provided callbacks for chip selection and I/O loops.  It should
> >   * also set up the bus number and number of chipselects.
> >   *
> >   * For i/o loops, provide callbacks either per-word (for bitbanging, o=
r for
> > @@ -428,58 +389,37 @@ EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
> >   */
> >  int spi_bitbang_start(struct spi_bitbang *bitbang)
> >  {
> > -	int	status;
> > +	struct spi_master *master =3D bitbang->master;
> >  =

> > -	if (!bitbang->master || !bitbang->chipselect)
> > +	if (!master || !bitbang->chipselect)
> >  		return -EINVAL;
> >  =

> > -	INIT_WORK(&bitbang->work, bitbang_work);
> >  	spin_lock_init(&bitbang->lock);
> > -	INIT_LIST_HEAD(&bitbang->queue);
> >  =

> > -	if (!bitbang->master->mode_bits)
> > -		bitbang->master->mode_bits =3D SPI_CPOL | SPI_CPHA | bitbang->flags;
> > +	if (!master->mode_bits)
> > +		master->mode_bits =3D SPI_CPOL | SPI_CPHA | bitbang->flags;
> > +
> > +	master->transfer_one_message =3D spi_bitbang_transfer_one_message;
> > +	master->prepare_transfer_hardware =3D spi_bitbang_dummy_prepare;
> > +	master->unprepare_transfer_hardware =3D spi_bitbang_dummy_prepare;
> >  =

> > -	if (!bitbang->master->transfer)
> > -		bitbang->master->transfer =3D spi_bitbang_transfer;
> >  	if (!bitbang->txrx_bufs) {
> >  		bitbang->use_dma =3D 0;
> >  		bitbang->txrx_bufs =3D spi_bitbang_bufs;
> > -		if (!bitbang->master->setup) {
> > +		if (!master->setup) {
> >  			if (!bitbang->setup_transfer)
> >  				bitbang->setup_transfer =3D
> >  					 spi_bitbang_setup_transfer;
> > -			bitbang->master->setup =3D spi_bitbang_setup;
> > -			bitbang->master->cleanup =3D spi_bitbang_cleanup;
> > +			master->setup =3D spi_bitbang_setup;
> > +			master->cleanup =3D spi_bitbang_cleanup;
> >  		}
> > -	} else if (!bitbang->master->setup)
> > -		return -EINVAL;
> > -	if (bitbang->master->transfer =3D=3D spi_bitbang_transfer &&
> > -			!bitbang->setup_transfer)
> > +	} else if (!master->setup)
> >  		return -EINVAL;
> >  =

> > -	/* this task is the only thing to touch the SPI bits */
> > -	bitbang->busy =3D 0;
> > -	bitbang->workqueue =3D create_singlethread_workqueue(
> > -			dev_name(bitbang->master->dev.parent));
> > -	if (bitbang->workqueue =3D=3D NULL) {
> > -		status =3D -EBUSY;
> > -		goto err1;
> > -	}
> > -
> >  	/* driver may get busy before register() returns, especially
> >  	 * if someone registered boardinfo for devices
> >  	 */
> > -	status =3D spi_register_master(bitbang->master);
> > -	if (status < 0)
> > -		goto err2;
> > -
> > -	return status;
> > -
> > -err2:
> > -	destroy_workqueue(bitbang->workqueue);
> > -err1:
> > -	return status;
> > +	return spi_register_master(master);
> >  }
> >  EXPORT_SYMBOL_GPL(spi_bitbang_start);
> >  =

> > @@ -490,10 +430,6 @@ int spi_bitbang_stop(struct spi_bitbang *bitbang)
> >  {
> >  	spi_unregister_master(bitbang->master);
> >  =

> > -	WARN_ON(!list_empty(&bitbang->queue));
> > -
> > -	destroy_workqueue(bitbang->workqueue);
> > -
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(spi_bitbang_stop);
> > diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bi=
tbang.h
> > index f987a2b..f85a7b8 100644
> > --- a/include/linux/spi/spi_bitbang.h
> > +++ b/include/linux/spi/spi_bitbang.h
> > @@ -1,14 +1,8 @@
> >  #ifndef	__SPI_BITBANG_H
> >  #define	__SPI_BITBANG_H
> >  =

> > -#include <linux/workqueue.h>
> > -
> >  struct spi_bitbang {
> > -	struct workqueue_struct	*workqueue;
> > -	struct work_struct	work;
> > -
> >  	spinlock_t		lock;
> > -	struct list_head	queue;
> >  	u8			busy;
> >  	u8			use_dma;
> >  	u8			flags;		/* extra spi->mode support */
> > @@ -41,7 +35,6 @@ struct spi_bitbang {
> >   */
> >  extern int spi_bitbang_setup(struct spi_device *spi);
> >  extern void spi_bitbang_cleanup(struct spi_device *spi);
> > -extern int spi_bitbang_transfer(struct spi_device *spi, struct spi_mes=
sage *m);
> >  extern int spi_bitbang_setup_transfer(struct spi_device *spi,
> >  				      struct spi_transfer *t);
> >  =

> > -- =

> > 1.7.2.5
> > =

> =

> -- =

> Grant Likely, B.Sc, P.Eng.
> Secret Lab Technologies,Ltd.
> =


---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
