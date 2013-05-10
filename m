From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: Qspi flash device  driver - framework to use?
Date: Sat, 11 May 2013 00:25:11 +0530
Message-ID: <518D428F.9020008@ti.com>
References: <518CD57E.2020705@ti.com> <20130510111757.GS3200@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>,
	Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130510111757.GS3200-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 10 May 2013 04:47 PM, Mark Brown wrote:
> On Fri, May 10, 2013 at 04:39:50PM +0530, Sourav Poddar wrote:
> 
>> I saw a device(m25p80) using mtd framework for some similar usecase.
>> Is it the mtd which should be used? OR will it be a
>> good idea to go for a generic qspi framework(drivers/qspi) which can be
>> used by qspi flash devices having a memory mapped interface. ?
> 
> MTD does seem like a much better fit here - if you're memory mapping
> things the whole goal is to make the fact that there's SPI involved
> totally transparent to the processor so there shouldn't really be
> anything for the SPI subsystem to do.
> 
+1 for MTD

Regards,
Santosh

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
