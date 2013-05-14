From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: Qspi flash device  driver - framework to use?
Date: Tue, 14 May 2013 17:43:14 +0530
Message-ID: <51922A5A.9040501@ti.com>
References: <518CD57E.2020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>,
	Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <518CD57E.2020705-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

+ linux-mtd list
On Friday 10 May 2013 04:39 PM, Sourav Poddar wrote:
> Hi,
>
> I am trying to work out a way to write a QSPI serial flash interface 
> driver
> for my IP. The idea is to have an execute in place usecase.
>
> We have a configuration port from which the spi core can be configured 
> and a
> memory mapped port from which the data can be read/write from/to serial
> flash device.
>
> As far as I can understand, I dont think it will be correct/possible 
> to write this
> driver making use of the generice spi framework(drivers/spi/spi.c) as 
> that
> framework is more suited for generic spi use case, where in you can load
> your Image from external SPI devices into DDR and then execute. ?
>
> But for cases, where qspi is connected to serial flash device (XIP is 
> needed) what
> we might need is some framework which just passes the buffers and its 
> length to
> our driver which in turn will configure the qspi to initiate the 
> transfer.
>
> What can be the best framework to use for the above use case?
>
> I saw a device(m25p80) using mtd framework for some similar usecase.
> Is it the mtd which should be used? OR will it be a
> good idea to go for a generic qspi framework(drivers/qspi) which can be
> used by qspi flash devices having a memory mapped interface. ?
>
> Thanks,
> Sourav


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
