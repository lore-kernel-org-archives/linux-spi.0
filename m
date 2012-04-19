From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: RE: [PATCH v2] spi/ep93xx: clean probe/remove routines
Date: Thu, 19 Apr 2012 11:03:34 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206987A4555@AUSP01VMBX24.collaborationhost.net>
References: <1334818807-4473-1-git-send-email-hannuxx@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "mika.westerberg-X3B1VOXEql0@public.gmane.org" <mika.westerberg-X3B1VOXEql0@public.gmane.org>
To: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334818807-4473-1-git-send-email-hannuxx-X3B1VOXEql0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday, April 19, 2012 12:00 AM, Hannu Heikkinen wrote:
>
> Use devm_* functions for managing devres resources.
>
> Also use local variable irq and remove irq variable from
> struct ep93xx_spi, as it is needed only in probe routine.
>
> Acked-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
> Signed-off-by: Hannu Heikkinen <hannuxx-X3B1VOXEql0@public.gmane.org>
> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>

Oops.. My bad. My sign off should be:

Acked-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
