From: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Fri, 11 Oct 2013 09:30:48 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA211D8@DBDE04.ent.ti.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
	<1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
	<20131009160759.GQ21581@sirena.org.uk>	<52558A49.5090904@ti.com>
	<20131009174027.GS21581@sirena.org.uk>	<87hacq1d5k.fsf@dell.be.48ers.dk>
	<CA+7tXii4J_Hie2v-DaSevFHn-YqriiVowhpXCP9H+U51_tbhvQ@mail.gmail.com>
	<52566ACC.1080100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
To: "Poddar, Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <52566ACC.1080100-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

> From: Poddar, Sourav
> > On Thursday 10 October 2013 07:57 AM, Trent Piepho wrote:
> > I've found that the SPI layer adds rather a lot of overhead to SPI
> > transactions.  It appears to come mostly from using another thread to
> > run the queue.  A fast SPI message of a few dozen bytes ends up having
> > more overhead from the SPI layer than the time it takes the driver to
> > do the actual transfer.
> >
> > So memory mapped mode via some kind of SPI hack seems like a bad
> > design.  All the SPI layer overhead and you don't get DMA.  Memory
> > mapped SPI could be a win, but I think you'd need to do it at the MTD
> > layer with a mapping driver that could read the mmapped SPI flash
> > directly.
> Yes, you are correct in all your comments above. I also feel that SPI
> framework
> should be bypassed. But the subject patch is derived based on the
> following points/limitation:
> 
> 1. There is a setup register in QSPI, that need to be filled, as of now
> I am filling it
>      in my driver as a MACRO.
> 
Based on you previous information of set_up_register..
> > What is "set_up_register"?
> > set_up_register is a memory mapped specific register with the
> > following fields:
> > - RCMD (Read command, which is actually the flash read command)
> > - NUmber of Address bytes
> > - Number of dummy bytes
> > - Read type(Single, dual and quad read).
> > - Write command.

set_up_register should be filled from DT not from Macros, as these
value change from NAND device to device, and based on that
populate 'struct m25p' in m25p_probe().Otherwise it might end-up
in similar situation as in fsl_spinor driver.
Refer below as an example.
http://lists.infradead.org/pipermail/linux-mtd/2013-September/048552.html



> 2. Controller repsonds to memory mapped read for read opcodes,
>  so during the read path we should tell the controller to switch to
>  memory mapped port.
> 
As you would be know from DT when to enable MMODE, so you  can
actually make MM_MODE as your *default mode*. And only when
SPI framework is used you selectively switch to SPI_MODE and
revert back to MM_MODE while returning.

This way you can use memcpy() or dma_copy() directly in flash driver
like m25p80.c, and avoid getting SPI generic framework delays.
So, it should be like this..

/* Make MM_MODE your default mode in controller driver */
qspi_driver.c: configure_qspi_controller(mode) {
if (mode == MM_MODE)
	- do all your controller configurations for MM_MODE
	- do all OPCODE selections for MM_MODE
}

qspi_controller_probe()
	if (of_mode_property("spi-flash-memory-map") {
		spi->mode |= MM_MODE;
		/* configure_qspi_controller (MM_MODE) */
	} else {
		/* configure_qspi_controller(SPI_MODE) */
	}


/* Case 1: MM_MODE=enabled: Flash driver calls memcpy() */
m25p80.c: m25p80_quad_read() {
	if (flash->mmap_read)
		/* controller is already in MM_MODE by default */
		memcpy(*from, *to, length);
	else
		/* usual call to spi_framework */
}


/* Case 2: SPI_MODE=enabled: Flash driver follows spi framework */
m25p80.c: m25p80_quad_read() {
	if (flash->mmap_read)
		/* ignored */
	else
		spi_add_message_to_tail();
}	

qspi_driver.c: prepare_transfer_hardware()
	if (spi->mode & MM_MODE) {
		/* controller is in MM_MODE by default, so switch
		  * to controller to SPI_MODE */
		configure_qspi_controller (SPI_MODE);
	} else {
		/* controller is already in SPI_MODE always */
	}

qspi_driver.c: transfer_one_message ()
	if (spi->mode & MM_MODE) {
		/* controller was switched to SPI_MODE in
		* prepare_transfer_hardware(),so revert back
		  * back to MM_MODE */
		configure_qspi_controller (MM_MODE);
	} else {
		/* controller is already in SPI_MODE always*/
	}
}

*Important*
But you need to be careful, because  you need to synchronize
with kthread_worker running inside SPI generic framework.
So, lock your spi_controller while doing MMODE accesses.
else you might end up in situation where a starving kthead_worker
suddenly woke-up  and changed your configurations from MMODE to
SPI_MODE in between ongoing memcpy() or dma_cpy().

(Request David W, and Mark B to please review this proposal
 based on m25p80.c and SPI generic framework, as I may be
 missing some understanding here).


with regards, pekon

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
