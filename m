From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] spi: add driver for BCM2835
Date: Thu, 07 Mar 2013 23:12:46 -0700
Message-ID: <5139815E.7020502@wwwdotorg.org>
References: <1362538142-19246-1-git-send-email-swarren@wwwdotorg.org>
	<20130306040520.GA4896@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130306040520.GA4896-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/05/2013 09:05 PM, Mark Brown wrote:
> On Tue, Mar 05, 2013 at 07:49:02PM -0700, Stephen Warren wrote:

>> +	switch (bpw) { +	case 8: +		break; +	default: +
>> dev_err(&spi->dev, "unsupported bits_per_word=%d\n", bpw); +
>> return -EINVAL; +	}

Is there an assumption in the SPI core that bpw will never be >32? The
value is stored in a u8 in the controller and transfer structs, so
large values are physically possible. So if there is no such
assumption, then representing all of an SPI controller's supported BPW
in a mask/list would be a little unwieldy, so doing central checking
might not work well.

>> +	if (!(spi->mode & SPI_NO_CS) && +			(spi->chip_select >
>> spi->master->num_chipselect)) { +		dev_err(&spi->dev, +
>> "invalid chipselect %u\n", +				spi->chip_select); +		return
>> -EINVAL; ` +	}
> 
> This seems like stuff the core should be able to do for you.

It looks like the core always validates the chip-select value, so I'll
remove that.

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
