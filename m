From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc6] pxa2xx_spi: dma bugfixes
Date: Thu, 11 Sep 2008 02:53:42 -0700
Message-ID: <200809110253.42941.david-b@pacbell.net>
References: <200809101742.05535.david-b@pacbell.net>
	<20080910192610.f62488ac.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080910192610.f62488ac.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

On Wednesday 10 September 2008, Andrew Morton wrote:
> help.
> 
> Which of these:
> 
> mpc52xx_psc_spi-remove-code-associated-with-config_ppc_merge.patch
> spi-simplify-spi_write_then_read.patch

Those two seem non-essential to me, but if you're
merging many of those "remove-code"... patches you
should include that one.


> spi_mpc83xx-reject-invalid-transfer-sizes.patch
> pxa2xx_spi-chipselect-bugfixes.patch
> pxa2xx_spi-dma-bugfixes.patch
> 
> might be 2.6.27 material?

spi_mpc83xx-reject-invalid-transfer-sizes.patch
pxa2xx_spi-chipselect-bugfixes.patch
pxa2xx_spi-dma-bugfixes.patch

> 2.6.26.x?

pxa2xx_spi-chipselect-bugfixes.patch
pxa2xx_spi-dma-bugfixes.patch

> 2.6.25.x?  

pxa2xx_spi-chipselect-bugfixes.patch
pxa2xx_spi-dma-bugfixes.patch

... assuming folk still maintain that!  :)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
