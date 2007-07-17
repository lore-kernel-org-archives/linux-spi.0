From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Tue, 17 Jul 2007 19:13:50 +0400
Message-ID: <20070717151350.GA3752@localhost.localdomain>
References: <200707141504.51950.david-b@pacbell.net>
	<20070716164837.GA18707@localhost.localdomain>
	<200707161154.54728.david-b@pacbell.net>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
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
Content-Disposition: inline
In-Reply-To: <200707161154.54728.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Mon, Jul 16, 2007 at 11:54:54AM -0700, David Brownell wrote:
> On Monday 16 July 2007, Anton Vorontsov wrote:
> > Hello David,
> > 
> > On Sat, Jul 14, 2007 at 03:04:51PM -0700, David Brownell wrote:
> > > Here's an updated version of the MMC-over-SPI patches, reworked to
> > > address most of Pierre's issues (moving even more code into the MMC
> > > core) and to clean up the I/O paths.
> > > 
> > > ...
> > 
> > Much thanks for the patches!
> > 
> > Though, I still have some troubles with getting MMC(SD)-over-SPI to
> > work.
> > 
> > I'm using slightly patched spi_mpc83xx.c driver + these four mmc
> > patches.
> > 
> > spi_mpc83xx.c tested only in loopback mode and using oscilloscope.
> > It _seem_ to work fine, but as I didn't tested it on real hardware
> > (other than MMC/SD), I can't say if it's fault of spi_mpc83xx or
> > mmc_spi.
> 
> I can't say either, but my first thought is that it might be a
> card-specific quirk.  I already found one in that particular place,
> and the messages below look fine until the very end.

Uhh.. can you believe?

mmc_spi spi1.0: ASSUMING unshared SPI bus!
mmc_spi spi1.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
mmcblk0: mmc0:0000 SD01G 1006080KiB
 mmcblk0: p1
root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# mount /dev/mmcblk0p1 /mnt/
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# ls /mnt/
bin  etc  include  lib  libexec  lost+found  man  sbin  share  var
root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~#

Yup, I've turned debugging off, it's plainly working.


The only change I've made is:

--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1184,7 +1184,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * Docs are very explicit that sampling is on the rising edge, so
 	 * SPI_MODE_0 and SPI_MODE_3 having different CPOL may not matter.
 	 */
-	spi->mode |= SPI_CPOL | SPI_CPHA;
+	spi->mode = 0;
 	spi->bits_per_word = 8;
 
 	status = spi_setup(spi);


Am I understanding correctly that SPI_CPOL is:

  ~~~| |~~| |~~~~
     | |  | |
0    |_|  |_|
(does not work for me)

While !SPI_CPOL is:

     |~|  |~|
     | |  | |
0 ___| |__| |____
(works great for me)

Is that correct? Not vice versa?

At least that is what I'm observing on oscilloscope. Maybe it's
something still messed in mpc83xx_spi.c (I've already fixed a lot),
or maybe something else. So, if mmc_spi modes are correct, then
mpc83xx_spi having inversed values, and should be fixed.

With only SPI_CPHA that thing does not work also.


Today I've tested it on bunch of cards, MMC Transcend 64MB,
MMC SanDisk 16MB, SD Kingston 128MB and 1GB. All of them work.

Thus, despite minor issues, mmc_spi works great, much thanks!

-- 
Anton Vorontsov
email: cbou-JGs/UdohzUI@public.gmane.org
backup email: ya-cbou-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
