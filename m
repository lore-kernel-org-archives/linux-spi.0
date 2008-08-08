From: nforrester-/d+BM93fTQY@public.gmane.org
Subject: Re: pxa2xx_spi with SFRM
Date: Fri,  8 Aug 2008 04:02:19 -0400
Message-ID: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I am as sea right now, with very limited email access.  If you can
wait until Wed or Thursday of next week, I might be of more help.  In
the mean time perhaps someone else will reply.

Since the orignal author, Stephen Steet, became silent on this driver,
I and several others have submitted patches for it.  I use an
extensivley modified version of pxa2xx_spi.c for one of my projects
and thus I have some familiarity with the driver, though somewhat less
with the details of SPI (I use the TI synchonous mode) and none at all
with flash on SPI.  I also work on a PXA255, and the PXA270 has some
differences.

> I am using a custom PXA270 board and tried to use the SSP port to
> communication with a SPI Flash. After reading docs on how to configure
> the spi_master and spi devices, I have the device driver's probe being
> called. But I cannot get the pxa2xx_spi driver to work correctly. I
> can connect either a SD card or a M26P16 Flash chip to the SPI port on
> my board. Neither device driver can completely operate their device.
>
> It looks like it is impossible for the device drivers to control the
> chip select (CS) line. If I use the manual cs_control callback, the
> timing is invalid because the SSP clock keeps running.

The cs_control() callback is the normal way of controlling chip select
with this driver.  That allows you to assign any GPIO pin or polarity.
I understand that this differs from way that the spi core expects chip
select to be handeled; in particular, the driver does not honor the
SPI_CS_HIGH nor SPI_LSB_FIRST bits in the spi_device.mode.  The PXA
SSP controllers do not have a dedicated chipselect mechanism
associated with the SSP controllers (outside of the single FRAME pin,
which may or may not do what you want), thus the use of GPIO lines is
required.

What version of the kernel/driver are you using?  There have been some
recent changes, and there may still be a bug regarding CS changes that
was discussed in:
Re: [spi-devel-general] odd behaviour of chipselect with bitbang driver?
on about 04/24/08 15:55.  I raised the question but, since I don't use
chipselect at all, I have not produced a patch.

The fact that the clock free runs strikes me as strange, I don't think
any of the supported SPI_MODE_n combinations can produce a free
running clock, though they do control polarity and phase of the clock.
If your problem involves one extra clock edge, you may have the wrong
setting for SPI_MODE_n.`

> That means that
> several bits are clocked out before the SSP controller starts to drive
> the TX line correctly. If the SFRM signal is used, it does not allow
> the driver to keep CS active for multiple transactions as they expect
> and assume. The spi_sync call takes an spi_message which contains a
> list of transactions to send. Normally, the device will need the CS
> active during the complete message. But the SSP controller deactivates
> SFRM when it is done with each buffer. For instance, the M25P16
> datasheet indicates that CS has to stay active from the READ command
> through the complete data transfer. When it goes high, it resets the
> command interface.

The driver should honor the per-transfer spi_transfer.cs_change flag
when used with a cs_control routine.  If you want the CS to stay
asserted between transfers, be sure the cs_change flag is 0.

> It looks like the SSP port needs to have a register bit to turn off
> the clock when there is nothing to transmit. Or a bit to tell the SSP
> controller to leave CS active. Or I can change the HW so CS gates the
> clock and a manual CS chip operates the device CS pin. I might also
> try the bitbanging SPI driver next to see if that can operate with the
> Flash chip.

pxa2xx_spi.c uses format SSCR0_Motorola.  I think, as I said above,
that this mode does not allow the clock to free run.  I expect that
you have some other problem.  As I understand it (and I may be wrong,
since I don't use Motorola SPI format) the clock is only active if
data is being transfered, and data is only transferred if there is
something the in the transmit FIFO to go out (and thus something to
receive at the same time).  I wonder if you have a zero byte in the TX
FIFO when you think you have nothing.  Perhaps spi_transfer.len is not
set right.

> Is there some other setting I am missing here? Is anyone else using
> the M25P16 chip with PXA270 SPI driver?



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
