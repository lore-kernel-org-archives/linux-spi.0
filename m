From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: PATCH [1/1] SPI: AMBA_PL022: Limit TX FIFO
	fills based on current RX FIFO used
Date: Fri, 22 Jan 2010 13:56:26 +0100
Message-ID: <63386a3d1001220456p484efc7fm811ae2240698cbdf@mail.gmail.com>
References: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <083DF309106F364B939360100EC290F805C4BF1E97-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/1/20 Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>:

> Added logic to cap TX FIFO fill size based on current free RX
> FIFO entries instead of TX status flags. This is to prevent
> an issue with RX FIFO overflows

Excellent patch and works like a charm on the U300. My loopback code
would generate
spurious overfill errors before and now it *never* fails so you hit
exactly the right spot.
I remember being intrigued by this when I worked on the driver and now
it is finally
nailed.

As some sort of maintainer of this file I have signed it off and put
it into Russells
patch tracker for inclusion, OK? See;
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5893/1

Linus Walleij

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
