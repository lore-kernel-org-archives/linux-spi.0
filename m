From: Jens Gehrlein <sew_s-77yLcl8UjJQ@public.gmane.org>
Subject: Re: [RFC PATCH V2] generic SPI driver for all
	i.MX-platforms
Date: Fri, 27 Feb 2009 07:40:51 +0100
Message-ID: <49A78AF3.1000606@tqs.de>
References: <1235665315-2792-1-git-send-email-w.sang@pengutronix.de>
	<20090226163721.GD3058@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>,
	a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090226163721.GD3058-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Wolfram,

Wolfram Sang schrieb:

> - ATTENTION: The original FSL-driver has a bug regarding the polarity
>   CPOL which got flipped. So, if you used the FSL-driver before, then
>   the SPI_MODE of your spi_device has to be corrected. Just toggle
>   SPI_CPOL or make SPI_MODE_0 out of SPI_MODE_2, SPI_MODE_1 out of
>   SPI_MODE_3 or vice versa.

Do I understand it right: the driver has a bug, not the CPU?
Just for clarification.
Thanks.

Kind regards,
Jens Gehrlein

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
