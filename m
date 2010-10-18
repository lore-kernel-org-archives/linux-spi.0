From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 06/12] regulator: add driver for tps6524x regulator
Date: Mon, 18 Oct 2010 08:50:55 -0400
Message-ID: <4CBC42AF.5000803@ti.com>
References: <1287081535-2864-1-git-send-email-cyril@ti.com>
	<1287081535-2864-7-git-send-email-cyril@ti.com>
	<20101014210323.GB14479@opensource.wolfsonmicro.com>
Reply-To: cyril-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	"dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101014210323.GB14479-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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

Thanks for the feedback.  I agree with your comments, and I will make
the necessary changes before posting a v2.

The one exception being...

[...]
>> +static const int dcdc1_voltages[] = {
>> +	 800000,  825000,  850000,  875000,
>> +	 900000,  925000,  950000,  975000,
>> +	1000000, 1025000, 1050000, 1075000,
>> +	1100000, 1125000, 1150000, 1175000,
>> +	1200000, 1225000, 1250000, 1275000,
>> +	1300000, 1325000, 1350000, 1375000,
>> +	1400000, 1425000, 1450000, 1475000,
>> +	1500000, 1525000, 1550000, 1575000,
> 
> Looks like you could just do the maths for most of these tables, might
> be a bit clearer/simpler?  Not a major issue either way, though.

... not all of the supplies are linear (e.g. ldo2).  Rather than have to
deal with both cases (linear and non-linear), enumerating the list of
voltages appeared to be simpler.

[...]

Regards
Cyril.

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
