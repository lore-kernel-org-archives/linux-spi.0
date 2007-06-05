From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4 0/7] latest MMC-over-SPI
	patchset
Date: Mon, 4 Jun 2007 20:25:17 -0700
Message-ID: <200706042025.18252.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

It's been a while since the mmc-over-spi host driver has been
updated, and I think it's time to do so ... and start getting
it mergeable.  Hence the following series of patches.

Kudos to Mike Lavender, original author; Hans-Peter Nilsson,
who got this version to really work; Jan Nikitenko, who made
more rough edges vanish and added CRC support; and Pierre Ossman,
who has supported the notion of a bit more surgery on mmc-core
to help keep some crap out of the host driver!

The first few patches are pretty separable:

  - CRC7 support (already in MM)
  - SD 4wire bugfix (submitted to Pierre)
  - SPI "exclusive mode" patch ... experimental, optional

The rest are the guts of the MMC-over-SPI support, following
Pierre's suggestion to teach the mmc core about SPI so that
the host adapter doesn't have so much work to do.

  - MMC headers expose SPI constants; add mmc_host_is_spi()
  - MMC core uses those to support MMC or SD enumeration
  - MMC block needed tweaks too
  - Last but not least ... mmc_spi host adapter.

This is distributed for testing and comments.  I believe that
Pierre will have a few issues with the core patches.  The SPI
"exclusive mode" patch will remain experimental for some time.

I'd also like to see someone sign up as mmc_spi maintainer;
ideally that person would start sheparding this the rest of
the way upstream.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
