From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Wed, 18 Jul 2007 18:05:10 +0400
Message-ID: <20070718140510.GA27534@localhost.localdomain>
References: <200707141504.51950.david-b@pacbell.net>
	<200707161154.54728.david-b@pacbell.net>
	<20070717151350.GA3752@localhost.localdomain>
	<200707170911.16715.david-b@pacbell.net>
	<20070718100047.GA9544@localhost.localdomain>
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
In-Reply-To: <20070718100047.GA9544-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

On Wed, Jul 18, 2007 at 02:00:47PM +0400, Anton Vorontsov wrote:
> > Later today two patches to mpc83xx_spi should merge into the
> > kernel.org GIT tree but they don't look like they'd relate
> > to this SPI mode issue.  (And the CRC7 patch should also be
> > merging...)
[...] 
> > Could you post your changes to that driver?
> 
> Sure, you'll see them shortly. Just need a bit of time.

Dammit. I've done git pull from Linus' tree, and this commit
already fixes most of things (major ones).

- - -
commit f29ba280ecb46331c1f6842b094808af01131422
Author: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Date:   Tue Jul 17 04:04:12 2007 -0700

    spi_mpc83xx.c: support QE enabled 83xx CPU's like mpc832x

    Quicc Engine enabled mpc83xx CPU's has a somewhat different HW interface to
    the SPI controller.  This patch adds a qe_mode knob that sees to that
    needed adaptions are performed.
- - -

I'm working on mpc832x too. Heh.. much time wasted... It haven't
been in -mm. :-(

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
