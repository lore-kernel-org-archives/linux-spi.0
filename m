From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 0/9] Some work for spi_mpc83xx
	driver, spi-mmc support	for MPC8610HPCD
Date: Tue, 5 May 2009 03:36:48 +0400
Message-ID: <20090504233648.GA6973@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
	<20090504135504.a6a6afcf.akpm@linux-foundation.org>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090504135504.a6a6afcf.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 04, 2009 at 01:55:04PM -0700, Andrew Morton wrote:
> On Fri, 1 May 2009 03:47:39 +0400
> Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org> wrote:
> 
> > Here are few patches that are needed to support spi-mmc slot on
> > MPC8610HPCD PowerPC boards:
> > 
> > [1/9] spi_mpc83xx: Handles other Freescale processors
> > [2/9] spi_mpc83xx: Quieten down the "Requested speed is too low" message
> > [3/9] spi_mpc83xx: Add small delay after asserting chip-select line
> > [4/9] powerpc/86xx: Add MMC SPI support for MPC8610HPCD boards
> > 
> 
> Some or all of these seem appropriate to 2.6.30 and perhaps even -stable?

I'd say no, we don't need the fixes for MPC8323E-RDB boards
(currently the only mainline user of that driver), and support
for MPC8610HPCD boards is a new feature, so I think all these
patches can wait for 2.6.31.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
