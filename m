From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Thu, 14 Aug 2008 11:29:59 -0400
Message-ID: <48A44F77.1020908@whoi.edu>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A0C35D.5010606-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Vernon Sauder wrote:
> First, thanks for your replies. I am sorry. I left town for the weekend 
> and I forgot to include all the details.
> 
> Jonathan Cameron wrote:
>> nforrester-/d+BM93fTQY@public.gmane.org wrote:
>>>> I am using a custom PXA270 board and tried to use the SSP port to
>>>> communication with a SPI Flash. After reading docs on how to configure
>>>> the spi_master and spi devices, I have the device driver's probe being
>>>> called. But I cannot get the pxa2xx_spi driver to work correctly. I
>>>> can connect either a SD card or a M26P16 Flash chip to the SPI port on
>>>> my board. Neither device driver can completely operate their device.
>>>>
>>>> It looks like it is impossible for the device drivers to control the
>>>> chip select (CS) line. If I use the manual cs_control callback, the
>>>> timing is invalid because the SSP clock keeps running.
>>>>       
>>> The cs_control() callback is the normal way of controlling chip select
>>> with this driver.  That allows you to assign any GPIO pin or polarity.
>>> I understand that this differs from way that the spi core expects chip
>>> select to be handeled; in particular, the driver does not honor the
>>> SPI_CS_HIGH nor SPI_LSB_FIRST bits in the spi_device.mode.  The PXA
>>> SSP controllers do not have a dedicated chipselect mechanism
>>> associated with the SSP controllers (outside of the single FRAME pin,
>>> which may or may not do what you want), thus the use of GPIO lines is
>>> required.
>>>
>>> What version of the kernel/driver are you using?  There have been some
>>> recent changes, and there may still be a bug regarding CS changes that
>>> was discussed in:
>>> Re: [spi-devel-general] odd behaviour of chipselect with bitbang driver?
>>> on about 04/24/08 15:55.  I raised the question but, since I don't use
>>> chipselect at all, I have not produced a patch.
>>>
>>>     
> I am using 2.6.24.4 on custom HW. I am using the FRAME pin as the chip 
> select so I was hoping I did not have to use cs_control().

I agree with Cameron (below) that the Frame pin cannot be controlled to
maintain CS across transfers.  I think you will need to switch to a GPIO
pin and use the cs_control callback.  If your hardware is cast in stone,
you might be able to selectively set the Frame pin as a GPIO for use
with cs_control(), and leave the clock and the two data pins attached to
the SSP peripheral.

I don't see any functional patches that were applied after 3/24/08 when
2.6.24.4 was released, other than one that affects suspend/resume.  As
long as you are not resuming, you don't need the latest.

>>> The fact that the clock free runs strikes me as strange, I don't think
>>> any of the supported SPI_MODE_n combinations can produce a free
>>> running clock, though they do control polarity and phase of the clock.
>>> If your problem involves one extra clock edge, you may have the wrong
>>> setting for SPI_MODE_n.`
>>>     
>> Although the clock can free run in some of the other (non spi modes)
>> the driver doesn't support this which means the behaviour is somewhat
>> odd!  Any chance you can make available a picture of an oscilloscope trace
>> showing SFRM and the clock?  That'll probably give sufficient clues to
>> allow us to figure out what is going wrong.  I've used gpio based chip
>> selects on the pxa271 wihout problems (though it does tend to slow down
>> your transfers somewhat so is best avoided where possible).
>>   
> I attached a Logic Analyzer screen shot of m25p80 driver starting to 
> query the device. The RX line is floating when the m25pxx chip is not 
> driving it. But notice that the clocks are running before the FRM/CS 
> line is active. If I use cs_control(), then there would be several clock 
> edges (when using high speeds) before the PXA SSP controller would start 
> clocking data.

I can see from your logic analyzer trace, that the clock is running
before the transfer starts, but it should not be doing this, and such a
problem has not been reported by others, so far as I know.  You really
need to find out why this is happening.  Are you sure that you are using
the correct pins on the chip?  What pins and Alternate Function settings
are you using?

>>>> That means that
>>>> several bits are clocked out before the SSP controller starts to drive
>>>> the TX line correctly. If the SFRM signal is used, it does not allow
>>>> the driver to keep CS active for multiple transactions as they expect
>>>> and assume. The spi_sync call takes an spi_message which contains a
>>>> list of transactions to send. Normally, the device will need the CS
>>>> active during the complete message. But the SSP controller deactivates
>>>> SFRM when it is done with each buffer. For instance, the M25P16
>>>> datasheet indicates that CS has to stay active from the READ command
>>>> through the complete data transfer. When it goes high, it resets the
>>>> command interface.
>>>>       
>>> The driver should honor the per-transfer spi_transfer.cs_change flag
>>> when used with a cs_control routine.  If you want the CS to stay
>>> asserted between transfers, be sure the cs_change flag is 0.
>>>     
>> Indeed it should but it doesn't.  Unfortunately the hardware doesn't
>> seem to have the ability to do this, so it will only work if using
>> a gpio as the chip select.  Guess we really ought to add some stuff to
>> the docs to make this clear (it wasted a good few hours of my time
>> failing to understand why it didn't do anything!)  For short
>> transfers (sub 16 x 32bits) you can get away with doing the endianess
>> changes necessary and sending as a single multiword transfer.
>> Afraid I'm usually dealing with sensors, adc's etc and they don't
>> tend to need larger transfers than this between deasserting the chip
>> select.

I agree that the Frame pin cannot be used to hold CS across transfers,
and that is why I said "The driver should honor the per-transfer
spi_transfer.cs_change flag when used with a cs_control routine.",
meaning: only with use of a GPIO pin for CS.

>>>> It looks like the SSP port needs to have a register bit to turn off
>>>> the clock when there is nothing to transmit. Or a bit to tell the SSP
>>>> controller to leave CS active. Or I can change the HW so CS gates the
>>>> clock and a manual CS chip operates the device CS pin. I might also
>>>> try the bitbanging SPI driver next to see if that can operate with the
>>>> Flash chip.
>>>>       
>>> pxa2xx_spi.c uses format SSCR0_Motorola.  I think, as I said above,
>>> that this mode does not allow the clock to free run.  I expect that
>>> you have some other problem.  As I understand it (and I may be wrong,
>>> since I don't use Motorola SPI format) the clock is only active if
>>> data is being transfered, and data is only transferred if there is
>>> something the in the transmit FIFO to go out (and thus something to
>>> receive at the same time).
>>>     
>> That should certainly be the case.  I guess it's just possible that SSCR1 
>> is preset by something else to continuous clock mode? Don't think the driver
>> explicitly clears it and a quick glance suggests elements of that register
>> are set from chip specific data.

The driver explicitly loads the SSCR1 register, and all un-specified
bits are set to zero.

> Here are the registers:
> 
> root@inhand-ft4 [~] # md 0x41000000 0x3f
> 00000000  87 19 00 00 00 00 00 00  24 f0 00 00 00 00 00 00  |........$.......|
> 00000010  70 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |p...............|
> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000030

My translation is that you are using SSP1 on the pxa270, and that the
register values are:

Name	Addr		Value
SSCR0	0x41000000	0x00001987
			clock divisor=1a (19+1)
			on-board 13MHz clock source
			SSE=1 (enabled)
			Motorola SPI format
			NOT Network mode

SSCR1	0x41000004	0x00000000
			No external clock or ROWT set
			No interrupts or service requests enabled
			Master mode
			TX and RX thresholds = 1
I'm surprised that bits not set in this register.  It is normal for an
idle interface to have the timeout interrupt, and either service
requests or interrupts clear, but then I would expect SSE to be clear in
SSCR0.  Also I would expect the TX and RX thresholds to be set to the
mid point = 8; you can set other values, but I wonder if you did.

SSSR	0x41000008	0x0000f024
			Rx and Tx fifos empty
			no interrupts pending
SSITR	0x4100000c	0x00000000
			off = normal
SSDR	0x41000010	0x00000070
			last data read
SSTO	0x41000028	0x00000000
			timeout of 0 means no timeout
This is normal for an idle interface, as the driver zeros the timeout
when activity is complete.

SSPSP	0x4100002c	0x00000000
			Not used, 0=normal
SSTSA	0x41000030	unknown
SSRSA	0x41000034	unknown
SSTSS	0x41000038	unknown
These registers are not listed above, but I think they are not used,
except in network mode, which is disabled in SSCR0.

SSACD	0x4100003c	unknown
I'm not sure if this register is used when not in network mode.  It
affects the clock selection and clock rate, and appears to be mutually
exclusive with the SCR value in SSCR0.

I don't see anything above that would cause the SSPSCLK to free run.  Be
sure you are using SSPSCLK and not SSPSYSCLK, though the latter does not
seem possible, based on your logic analyzer trace.  The only strange
thing about the register state is that SSE is enabled, while every other
register implies that the interface should be idle.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
