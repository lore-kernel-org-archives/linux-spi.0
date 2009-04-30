From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 0/9] Some work for spi_mpc83xx driver,
	spi-mmc support for	MPC8610HPCD
Date: Fri, 1 May 2009 03:47:39 +0400
Message-ID: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi all,

Here are few patches that are needed to support spi-mmc slot on
MPC8610HPCD PowerPC boards:

[1/9] spi_mpc83xx: Handles other Freescale processors
[2/9] spi_mpc83xx: Quieten down the "Requested speed is too low" message
[3/9] spi_mpc83xx: Add small delay after asserting chip-select line
[4/9] powerpc/86xx: Add MMC SPI support for MPC8610HPCD boards

The rest are cleanups, initially Kumar suggested to rename
spi_mpc83xx.c to spi_mpc8xxx.c, but checkpatch told me to fix
some other issues. So the following cleanups were prepared:

[5/9] spi_mpc83xx: Fix checkpatch issues
[6/9] spi_mpc83xx: Split mpc83xx_spi_work() into two routines
[7/9] spi_mpc83xx: Remove dead code
[8/9] spi_mpc83xx: Rename spi_83xx.c to spi_8xxx.c
[9/9] spi_mpc8xxx: s/83xx/8xxx/g

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
