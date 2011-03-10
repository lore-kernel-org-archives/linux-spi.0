From: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Getting alot of zero values from ads7846 using atmel_spi
Date: Thu, 10 Mar 2011 15:41:45 +0100
Message-ID: <20110310144145.GB4093601@jupiter.n2.diac24.net>
References: <1299577496.13486.13.camel@SESTOWS194>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Niclas Karlsson <niclas.karlsson-h3aQMNCITb4@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1299577496.13486.13.camel@SESTOWS194>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 08, 2011 at 10:44:56AM +0100, Niclas Karlsson wrote:
> Do anyone know why I read so many zeroes?

You're probably reading values faster than the chip supports. Check the
chip documentation for a maximum readout frequency or a ready flag.

> I have made some printk in ads7846.c to trace the problem. It seemed to
> read more correct values when I added the printks.

A printk takes quite some time on an ARM like yours. The throttle makes
it work...


David

P.S.: you're lucky to not get crap values - seems they got the chip
design right...


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
