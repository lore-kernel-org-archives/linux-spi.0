From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Wed, 1 Aug 2012 15:50:12 +0800
Message-ID: <20120801075010.GI1672@S2100-06.ap.freescale.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
	<201208010810.37652.marex@denx.de>
	<20120801063936.GC2764@roeck-us.net>
	<201208010845.19361.marex@denx.de>
	<20120801065650.GA2928@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Dong,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120801065650.GA2928-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 31, 2012 at 11:56:50PM -0700, Guenter Roeck wrote:
> Guess we are in violent agreement. The sequence would then either be
> 	master = spi_alloc_device();

The discussion is around spi_alloc_master rather than spi_alloc_device,
isn't it?

Regards,
Shawn

> 	...
> 	spi_master_put(master);
> or
> 	master = spi_alloc_device();
> 	...
> 	kfree(master);
> 
> which makes sense to me. Question still is why most drivers neither call kfree()
> nor spi_master_put() in the remove function.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
