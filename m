From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Fri, 15 Aug 2008 15:09:01 -0400
Message-ID: <48A5D44D.6040106@whoi.edu>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
	<48A44F77.1020908@whoi.edu> <48A4ED85.1030803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A4ED85.1030803-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Resend due to bad cc: address...

Vernon Sauder wrote:

> This is another problem. The thresholds and timeouts are taken from the 
> pxa2xx_spi_chip structure where cs_control is specified. So once I tried 
> to use cs_control, the timeout and thresholds were wrong. They driver 
> does not use defaults if these are zero. If timeout is zero, the kernel 
> hangs while trying to read the trailing bytes. Here is a patch to use 
> defaults if the timeout or thresholds are zero. (It is also attached due 
> to my poor mailer.)
> 
> --- linux-2.6.24.4/drivers/spi/pxa2xx_spi.c    2008-03-24 
> 14:49:18.000000000 -0400
> +++ src.cache/drivers/spi/pxa2xx_spi.c    2008-08-14 20:52:15.000000000 
> -0400
> @@ -1142,11 +1142,12 @@
>          if (chip_info->cs_control)
>              chip->cs_control = chip_info->cs_control;
>  
> +        if (chip_info->timeout)
>          chip->timeout = chip_info->timeout;
>  
> -        chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
> +        chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold ? : 12) &
>                                  SSCR1_RFT) |
> -                (SSCR1_TxTresh(chip_info->tx_threshold) &
> +                (SSCR1_TxTresh(chip_info->tx_threshold ? : 4) &
>                                  SSCR1_TFT);
>  
>          chip->enable_dma = chip_info->dma_burst_size != 0
> 
> I can submit this more formally if you like. Let me know where.

I'm not sure that implementing defaults is a good idea.  I prefer the
current scheme of forcing the user to make a considered choice.  In
particular, 0 is a valid value for the timeout and thresholds (it means
none in the case of timeout and one in the case of thresholds), so if
these structure elements weren't already defined as unsigned, -1 would
be a better flag to trigger use of a default.

More specifically, I don't see in the patch where there is a default for
timeout; you simply leave it undefined if a value of 0 was specified;
there is no "else" for "if (chip_info->timeout)".  In any case, it would
be difficult at best to offer a default value, since this is a division
of an unspecified clock.  It turns out that the developer's manuals for
both PXA255 and PXA270 do not adequately specify what clock is used for
the timer.  Thus a numerical value that is appropriate for one may not
be appropriate for another, nor for the new PXA3xx processors.  We just
don't know.  Furthermore, an appropriate default depends on the rate of
SSPSCLK, which is a variable.  There are also application specific
considerations.

The defaults of 12 and 4 that you specified above for thresholds are not
actually the preferred values.  When I was working with Stephen on some
issues with this driver, we concluded that 8 and 8 were better choices.
 When Stephen submitted the patches, he corrected this in the example
structures in Documentation/spi/pxa2xx_spi, but forgot to do so in the
text describing the threshold values.  You can see the changes he made at:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8d94cc50aa4f1448a6483975097805eb8d6be0e0

I am curious about the kernel hanging with a zero timeout.  I would
expect that the trailing bytes would never be read, but this driver
should not hang waiting for them, because it simply is not responding to
an interrupt that never happens.  Perhaps the hang occurs at a higher
level when the message is never given back.  Do you really mean that the
kernel hangs (all processes stop) or just that the MMC operation never
finishes?  Are you using PIO (interrupt) mode or DMA when you access the
driver (or is that hidden from you by the MMC drivers that you are using)?

> Here are the new register values:
> 
> 
> SSP1 Control Register 0 (0x41000000)
> SSP1_SSCR0               0x00002087  00000000 00000000 00100000 10000111
> SSP1_SSCR0_MOD                    0  Network Mode
> SSP1_SSCR0_ACS                    0  Audio Clock Select
> SSP1_SSCR0_FRDC                   0  Frame Rate Divider Control
> SSP1_SSCR0_TIM                    0  Tx FIFO Underrun IRQ Mask
> SSP1_SSCR0_RIM                    0  Rx FIFO Underrun IRQ Mask
> SSP1_SSCR0_NCS                    0  Nework Clock Select
> SSP1_SSCR0_EDSS                   0  Extended Data Size Select
> SSP1_SSCR0_SCR                   20  Serial Clock Rate
> SSP1_SSCR0_SSE                    1  SSP Enable
> SSP1_SSCR0_ECS                    0  External Clock Select
> SSP1_SSCR0_FRF                    0  Frame Format 0=SPI 1=TI 2=Microwire 
> 3=PSP
> SSP1_SSCR0_DSS                    3  Data Size Select (-1) hi bit is EDSS
> 
> ** SSE is always set. The driver only clears it if it sees an error. Is 
> this a bad thing?

My mistake.  I was looking at my expanded version of the driver, but
even there, SSE is cleared in xxx_transfer_complete() only on certain
errors.  Your behavior is normal.  Sorry.

> SSP1 Control Register 1 (0x41000004)
> SSP1_SSCR1               0x00000ec0  00000000 00000000 00001110 11000000
> SSP1_SSCR1_TTELP                  0  TXD Tristate on Last Phase
> SSP1_SSCR1_TTE                    0  TXD Tristate Enable
> SSP1_SSCR1_EBCEI                  0  Enable Bit Count Error IRQ
> SSP1_SSCR1_SCFR                   0  Slave Clock Free Running
> SSP1_SSCR1_ECRA                   0  Enable Clock Request A
> SSP1_SSCR1_ECRB                   0  Enable Clock Request B
> SSP1_SSCR1_SCLKDIR                0  SSPSCLKx Direction
> SSP1_SSCR1_SFRMDIR                0  SFRM Direction
> SSP1_SSCR1_RWOT                   0  Receive w/o Tx
> SSP1_SSCR1_TRAIL                  0  Trailing Byte
> SSP1_SSCR1_TSRE                   0  Tx Service Request Enable
> SSP1_SSCR1_RSRE                   0  Rx Service Request Enable
> SSP1_SSCR1_TINTE                  0  Receiver Time-out IRQ Enable
> SSP1_SSCR1_PINTE                  0  Peripheral Trailing Byte IRQ Enable
> SSP1_SSCR1_IFS                    0  Invert Frame Signal
> SSP1_SSCR1_STRF                   0  Select FIFO for EFWR
> SSP1_SSCR1_EFWR                   0  Enable FIFO Write/Read (test mode)
> SSP1_SSCR1_RFT                    3  Rx FIFO Threshold
> SSP1_SSCR1_TFT                    b  Tx FIFO Threshold
> SSP1_SSCR1_MWDS                   0  Microwire Tx Data Size
> SSP1_SSCR1_SPH                    0  SPI SSPSCLK Phase
> SSP1_SSCR1_SPO                    0  SPI SSPSCLK Polarity
> SSP1_SSCR1_LBM                    0  Loop-back test mode
> SSP1_SSCR1_TIE                    0  Tx FIFO IRQ Enable
> SSP1_SSCR1_RIE                    0  Rx FIFO IRQ Enable
> 
> ** Thresholds are now as set by defaults. Do you have a good way to 
> figure out what they should be?

See comments above about good values of thresholds, and defaults as
policy.  In general, I found the driver fairly robust for all values of
the thresholds when in PIO mode.  Personally, I use 8 and 8 for
11Mbit/sec DMA mode. I think it is fair to use whatever works in your
application.  Here is a slightly relevant comment from my discussion
with Stephen on Oct 1, 2006 (which somehow never made onto the spi-devel
mailing list, in spite of being addressed there):

>> 5. Coding of threshold as a function of bits/word and dma burst size:
>> 
>> This change was a lot more complicated than I thought, partly because 
>> there are two places in the driver where this computation needs to be 
>> done: in setup, and also in pump_transfers if a new bits/word is 
>> attached to an spi_transfer.  I have created a new routine that computes 
>> the proper dma_threshold from bits/word and burst_size, and I have 
>> called it from setup and pump_transfers.  In setup, it changes the 
>> values stored in struct chip_data, but in pump_transfers it only changes 
>> local "use once" values.  It is possible for a combination of bits/word 
>> and burst_size to yield invalid threshold settings (any threshold more 
>> than 1/2 the fifo, 8 words, because only 2, 4, 8 and 16 would match the 
>> burst size, but 16 causes overruns).  To deal with this, the burst size 
>> is reduced as required to keep the threshold at 8.  If this reduction 
>> occurs in setup, a dev_warn is issued to let the user know; if the 
>> reduction happens in pump_transfers, the change is silent.  Change the 
>> reporting if you think something else is better.
>> 
>> [snip] 
>>
>> ----Testing
>> 
>> This patch has been tested for reading the correct number of bytes 
>> without overruns or permanent timeouts; I did not use loopback and pass 
>> test data to verify on read, but I could do that.  The test was done 
>> with randomized transfer lengths between 4 and >4096 bytes (in multiples 
>> of 4 bytes, I suppose I could do it in integer bytes), with all word 
>> sizes from 4 to 32 bits.  Baud rate was changed from 3.6864MHZ to 
>> 100kHz.  Both DMA and PIO mode were tested.  In DMA mode various 
>> combinations of word size and burst size were used.  In PIO mode various 
>> threshold settings from tx=1 and rx=15, to tx=15 and rx=1 were tested. 
>> All modes worked.  With PIO mode fixed to prevent overruns, the 
>> operation becomes insensitive to values of threshold and timeout.  In 
>> DMA mode, it is necessary to keep timeout longer than one word time

I think the  "1" and "15" above correspond to threshold register values
of "0" and "14"; that is the above numbers are the number of words in
the FIFO that trigger the interrupt/service request.

OK on the rest of the register contents.

> On a side note, there is an MTD error when using the SPI Flash with the 
> pxa2xx_spi driver.
> 
> root@inhand-ft4 [~] # flash_erase /dev/mtd_spi
> Erase Total 1 Units
> Performing Flash Erase of length 65536 at offset 0x0 done # <- why *64K* ??
> root@inhand-ft4 [~] # echo -n hithere123 > /dev/mtd_spi
> root@inhand-ft4 [~] # hexdump -C -n512 /dev/mtdblock_spi
> 00000000  68 69 74 68 65 72 65 31  32 33 ff ff ff ff ff ff  
> |hithere123......|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
> |................|
> *
> 00000200
> root@inhand-ft4 [~] # echo -n hithere444xxx > /dev/mtdblock_spi
> [  231.370000] pxa2xx-spi pxa2xx-spi.1: pump_transfers: transfer length 
> greater than 8191

This message is issued by the driver in pump_transfers() if the transfer
length is illegal.  You may have uncovered a bug here.  I think the 8191
limitation on transfer length only applies to DMA, as that is the length
of the DMA counter.  The test for this should probably be performed only
if DMA is in use.  I don't think Stephen or I ever expected any transfer
to approach that length, in either PIO or DMA mode.  Is this really a
legitimate transfer request?  Something that can only work in PIO mode
and not in DMA mode?  That seems improper to me.

As noted in the comments in pxa2xx_spi.c, this test really belongs in
transfer(), not in pump_transfers(), so that a "bad" transfer in a
message is never accepted, rather than been dropped after a message has
been started.  I figured the test location was not important if it never
failed anyway.

>  # maybe 64K??
> [  231.380000] end_request: I/O error, dev mtdblock_spi, sector 0
> [  231.380000] Buffer I/O error on device mtdblock_spi, logical block 0
> [  231.380000] lost page write due to I/O error on mtdblock_spi
> root@inhand-ft4 [~] # hexdump -C -n512 /dev/mtdblock_spi
> 00000000  68 69 74 68 65 72 65 31  32 33 ff ff ff ff ff ff  
> |hithere123......|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
> |................|
> *
> 00000200
> 
> I have not done a great deal of testing with MTD yet but I can read and 
> write a small test file. I was hoping to use the mtdblock interface for 
> this application. I will take a little time and see if I can figure out 
> what part is wrong here.
> 
> 
> Thanks again for your help.
> Vern

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
