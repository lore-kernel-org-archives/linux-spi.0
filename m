From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Trying to use spidev to send an spi message,
	result from spidev_test.c "Illegal argument" . (i.mx23, kernel 3.7)
Date: Tue, 05 Feb 2013 17:28:11 +0000
Message-ID: <20130205172811.601A53E15C2@localhost>
References: <50E0060F.8060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <50E0060F.8060604-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 30 Dec 2012 18:14:55 +0900, Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
> 
> I am having issues communicating with a micro controller connected to 
> SPI bus, using spidev.
> I would like to send messages to my MSP430 from user land, but so far no 
> luck.
> 
> At least I know that my SPI bus should be ok, since in the same bus I 
> have a SPI flash chip that works.
> In my DTS I have added my 2 SPI devices as such:

It looks to me like the SPI master doesn't know how to drive the CS line
for the second device.

g.


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
