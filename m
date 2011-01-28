From: Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Regd: SPI Slave Select
Date: Fri, 28 Jan 2011 13:28:54 +0530
Message-ID: <AANLkTimpC8Atvves=r+CLQYZKByLpyo8bm+xfnKvXAas@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi All,

I have a SPI slave device which expects the slave select line to be active
(low) during the entire message (e.g: say for a two byte transfer, the SS
should be low for until both the bytes have been written, and should not go
inactive in-between bytes being transfered).
But, I notice, this is not the case. The SS goes inactive in between bytes
transfer.

Does the spi framework provide any support to avoid SS being deactivated
between byte transfer ?

I have multiple slave devices on the same bus, so I can't keep the slave
always selected.

My master driver is dw_spi.c and linunx kernel version is 2.6.35.

Regards,
Tom
------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
