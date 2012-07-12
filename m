From: Hui Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] spi/imx: two spi-imx cleanup
Date: Thu, 12 Jul 2012 17:53:42 +0800
Message-ID: <4FFE9EA6.5040708@gmail.com>
References: <1341913463-10128-1-git-send-email-jason77.wang@gmail.com>
	<20120710172011.GC30009@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hui Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120710172011.GC30009-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

Understand from Grant's mail's discussion that you are picking up the spi change, Could you please queue these two patches in your tree?

Regards,
Hui.



Sascha Hauer wrote:
> On Tue, Jul 10, 2012 at 05:44:21PM +0800, Hui Wang wrote:
>   
>> Two straight-forward cleanup
>>
>> Hui Wang (2):
>>   spi/imx: remove redundant config.speed_hz setting
>>   spi/imx: use gpio_is_valid to determine if a gpio is valid
>>     
>
> both:
>
> Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>
>
>   
>>  drivers/spi/spi-imx.c |   14 ++++++--------
>>  1 files changed, 6 insertions(+), 8 deletions(-)
>>
>> -- 
>> 1.7.6
>>
>>
>>     
>
>   


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
