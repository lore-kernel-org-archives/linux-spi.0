From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Wed, 18 Jul 2007 09:35:24 +0200
Message-ID: <469DC2BC.5070305@gmail.com>
References: <200707141504.51950.david-b@pacbell.net>
	<200707161154.54728.david-b@pacbell.net>
	<20070717151350.GA3752@localhost.localdomain>
	<200707170911.16715.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707170911.16715.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

David Brownell wrote:
> On Tuesday 17 July 2007, Anton Vorontsov wrote:
> 
>> Uhh.. can you believe?
>>
>> mmc_spi spi1.0: ASSUMING unshared SPI bus!
>> mmc_spi spi1.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
>> mmcblk0: mmc0:0000 SD01G 1006080KiB
>>  mmcblk0: p1
>> root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# mount /dev/mmcblk0p1 /mnt/
>> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
>> root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# ls /mnt/
>> bin  etc  include  lib  libexec  lost+found  man  sbin  share  var
>> root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~#
> 
> Good!
> 
> 
>> Yup, I've turned debugging off, it's plainly working.
> 
> And presumably it works with debugging enabled, too ...

I had the same issues with debugging on in the past, mainly if it went
directly to serial console - could it be the changed timing?

> 
> 
>> The only change I've made is:
>>
>> --- a/drivers/mmc/host/mmc_spi.c
>> +++ b/drivers/mmc/host/mmc_spi.c
>> @@ -1184,7 +1184,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>>  	 * Docs are very explicit that sampling is on the rising edge, so
>>  	 * SPI_MODE_0 and SPI_MODE_3 having different CPOL may not matter.
>>  	 */
>> -	spi->mode |= SPI_CPOL | SPI_CPHA;
>> +	spi->mode = 0;
>>  	spi->bits_per_word = 8;
>>  
>>  	status = spi_setup(spi);
> 
> Curious.  I think it was Jan Nikitenko who reported mode 0 not
> working for SD, while mode 3 did work.  All my recent testing
> used mode 3, but I started with mode 0...

I do not recall anything about that, I had mode 3 there since the very
first version of mmc-spi patch posted by David here:
http://www.google.com/search?q=cache%3Awww.gossamer-threads.com%2Flists%2Flinux%2Fkernel%2F671939#671939

Just tried mode 0 today, and it seems to work as well, if I did not
overlook something (talking about some old version of mmc-spi, could not
get to test the latest releases yet, sorry)

> 
> Ideally, someone with access to full MMC and SD specs can see
> what they say about the SPI clocking.  The simplified SD specs
> omit the timing diagrams.

Someone with access to full mmc and sd specs told me, that the timing
diagrams there do not show needed spi mode, because the diagrams there
are like in a table form, with only CS, DataIN and DataOut signals (no
clock signal at all).

Jan

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
