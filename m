From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Limitations on transfer length [was: pxa2xx_spi
	with SFRM]
Date: Fri, 15 Aug 2008 15:01:06 -0400
Message-ID: <48A5D272.1070804@whoi.edu>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
	<48A44F77.1020908@whoi.edu> <48A4ED85.1030803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Vernon Sauder wrote:
> Ned Forrester wrote:

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

This message is issued by pxa2xx_spi.c in pump_transfers() if the
transfer length is illegal.  You may have uncovered a bug here.  I think
the 8191 limitation on transfer length only applies to DMA, as that is
the length of the DMA counter.  The test for this should probably be
performed only if DMA is in use.  I don't think Stephen or I ever
expected any transfer to approach that length, in either PIO or DMA
mode.  Is this really a legitimate transfer request?  Something that can
only work in PIO mode and not in DMA mode?  That seems improper to me.

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

David,

Is there supposed to be any practical limit to the length of a transfer?
 It seems that the /dev/mtdblock_spi driver has requested a transfer in
excess of 8191 bytes (though I don't know how long a transfer it
requested).

In this case, I think pxa2xx_spi.c could handle long transfers in PIO
mode, but not if DMA has been requested.  It looks like we may have put
a bug in pxa2xx_spi by performing the length test even when DMA is not
requested.

Is it proper to require that PIO mode be used if long transfers will be
requested?

I see several possibilities (and there are probably more):

1. Make long transfers illegal (probably both undesirable and
unenforceable).

2. Require PIO mode to be used by protocol drivers for long transfers
(but how would they know how long is too long?).

3. Simply reject the call to transfer() if too long a transfer is
requested with DMA.

4. Silently, or with warning, revert to PIO mode if a long transfer is
requested with DMA.

5. Require that pxa2xx_spi break long DMA transfers into the required
number of pieces to be performed in separate DMAs, silently giving back
the message after it has completed all of it (this requires a lot of
extra book-keeping in pxa2xx_spi).



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
