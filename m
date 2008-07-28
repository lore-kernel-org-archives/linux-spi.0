From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.26-git] mpc52xx_psc_spi: fix
	block transfer
Date: Sun, 27 Jul 2008 19:40:55 -0700
Message-ID: <20080727194055.7d3b839d.akpm@linux-foundation.org>
References: <200807271522.05967.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200807271522.05967.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sun, 27 Jul 2008 15:22:05 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> From: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> The block transfer routine in the mpc52xx psc spi driver misinterpret the
> datasheet. According to the processor datasheet the chipselect is held as
> long as the EOF is not written. Theoretically block of any sizes can be
> transferred in this way. The old routine however writes an EOF after every
> word, which has the size of size_of_word. This makes the transfer slow.
> Also fixed some duplicate code.
> 
> Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

The patch applies to 2.6.25 and 2.6.26.  Should we backport it?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
