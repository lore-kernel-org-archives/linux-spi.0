From: Paulius Zaleckas <paulius.zaleckas-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Thu, 26 Feb 2009 12:07:46 +0200
Message-ID: <49A669F2.3040802@teltonika.lt>
References: <20090220144126.GA9203@pengutronix.de>
	<49A264DE.8080805@teltonika.lt>
	<20090226095825.GA3058@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Wolfram Sang <public-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>,
	linux-arm <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090226095825.GA3058-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Wolfram Sang wrote:
>>> @@ -1659,10 +1721,13 @@ static int __exit spi_imx_remove(struct platform_device *pdev)
>>>  		return status;
>>>  	}
>>>  
>>> +	if (platform_info->exit)
>>> +		platform_info->exit(pdev);
>> platform_info can be NULL here if when declaring platform_device platform data was not set.
>> In this case you will get crash here.
>> Should be if (platform_info && platform_info->exit)
> 
> Well, that is the first thing the probe function checks :) It will fail
> if there is no platform_data. 

OK then. I missed that check :|

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
