From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: amba_pl022: Fix section mismatch warnings
Date: Wed, 28 Jul 2010 00:32:49 +0200
Message-ID: <AANLkTi=EEy5kToWXaNh1LZo7Dnzio+F1eeHgdaP4T_B3@mail.gmail.com>
References: <083DF309106F364B939360100EC290F80AC392A206@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <083DF309106F364B939360100EC290F80AC392A206-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/7/27 Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>:

> Changed __init to __devinit and __exit_p to __devexit_p per other
> AMBA drivers. Fixes section mismatch warning.
>
> Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Yours,
Linus Walleij

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
