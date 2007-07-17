From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Tue, 17 Jul 2007 09:11:15 -0700
Message-ID: <200707170911.16715.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<200707161154.54728.david-b@pacbell.net>
	<20070717151350.GA3752@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070717151350.GA3752-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
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

On Tuesday 17 July 2007, Anton Vorontsov wrote:

> Uhh.. can you believe?
> 
> mmc_spi spi1.0: ASSUMING unshared SPI bus!
> mmc_spi spi1.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
> mmcblk0: mmc0:0000 SD01G 1006080KiB
>  mmcblk0: p1
> root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# mount /dev/mmcblk0p1 /mnt/
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# ls /mnt/
> bin  etc  include  lib  libexec  lost+found  man  sbin  share  var
> root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~#

Good!


> Yup, I've turned debugging off, it's plainly working.

And presumably it works with debugging enabled, too ...


> The only change I've made is:
> 
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1184,7 +1184,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>  	 * Docs are very explicit that sampling is on the rising edge, so
>  	 * SPI_MODE_0 and SPI_MODE_3 having different CPOL may not matter.
>  	 */
> -	spi->mode |= SPI_CPOL | SPI_CPHA;
> +	spi->mode = 0;
>  	spi->bits_per_word = 8;
>  
>  	status = spi_setup(spi);

Curious.  I think it was Jan Nikitenko who reported mode 0 not
working for SD, while mode 3 did work.  All my recent testing
used mode 3, but I started with mode 0...

Ideally, someone with access to full MMC and SD specs can see
what they say about the SPI clocking.  The simplified SD specs
omit the timing diagrams.
 

> Am I understanding correctly that SPI_CPOL is:
> 
>   ~~~| |~~| |~~~~
>      | |  | |
> 0    |_|  |_|
> (does not work for me)
> 
> While !SPI_CPOL is:
> 
>      |~|  |~|
>      | |  | |
> 0 ___| |__| |____
> (works great for me)
> 
> Is that correct? Not vice versa?

That's for the clock, I take it ... yes.  There's a pretty
good timing diagram at Wikipedia, which should make the two
bits (CPOL, CPHA) clear:

  http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus

CPOL=0 means the clock starts at idle=low (vs high if CPOL=1).
CPHA=0 means capture on leading clock edge (vs trailing if CPHA=1).


> At least that is what I'm observing on oscilloscope. Maybe it's
> something still messed in mpc83xx_spi.c (I've already fixed a lot),

Could you post your changes to that driver?


> or maybe something else. So, if mmc_spi modes are correct, then
> mpc83xx_spi having inversed values, and should be fixed.
> 
> With only SPI_CPHA that thing does not work also.

Later today two patches to mpc83xx_spi should merge into the
kernel.org GIT tree but they don't look like they'd relate
to this SPI mode issue.  (And the CRC7 patch should also be
merging...)

It's not inconceivable that the SPI controller driver is a
bit confused with respect to interpreting the mode bits.
We've seen that problem before.

 
> Today I've tested it on bunch of cards, MMC Transcend 64MB,
> MMC SanDisk 16MB, SD Kingston 128MB and 1GB. All of them work.

Presumably you tested all of them with mode 0 ... which of them
work with mode 3?  Does it work better in mode 3 if you use
a lower clock speed ceiling in the spi board info for that card
slot?


> Thus, despite minor issues, mmc_spi works great, much thanks!

Glad to hear it!  Now, to sort out why mode 3 fails for you ...

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
