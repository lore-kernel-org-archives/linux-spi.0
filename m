From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: 5088/3: the SPI dependency
Date: Mon, 21 Jul 2008 12:46:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807211243060.15255@axis700.grange>
References: <20080721095850.GB2264@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080721095850.GB2264-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
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

David, what are your plans wrt SPI changes? I think the required patches 
(max7301) are already in -mm, can we merge them, please? It is a new 
driver, so should not make any damage.

Thanks
Guennadi

On Mon, 21 Jul 2008, Russell King - ARM Linux wrote:

> Since we are over a week into the merge window, and I see no sign of
> the SPI tree merging, it's time to make a decision on what to do about
> the outstanding changes in my tree which depend on the SPI tree having
> been merged first (iow, the presence of linux/spi/max7301.h.)
> 
> One solution is to continue twiddling my thumbs waiting for the SPI
> tree to merge, which frankly is utterly boring and is just a waste of
> my time.
> 
> Another solution is to back out the change, but that's extremely
> painful to do because soo much other stuff relies on that commit.
> 
> Or we could commit a change on top of everything backing out the changes
> to pcm027.c which require the SPI tree to merge first, and have the bits
> which rely on max7301.h submitted later (which is, imho, what should've
> happened.)
> 
> Or we could ignore the issue entirely and just merge the remaining
> changes.
> 
> Unless I hear otherwise, I shall be intending to back out the troublesome
> changes to pcm027.c and merge that.
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
