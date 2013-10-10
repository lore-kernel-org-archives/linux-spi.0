From: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] spi/xilinx: Use DT information for bits_per_word value,
	fix bus_num value
Date: Thu, 10 Oct 2013 16:50:37 +0200
Message-ID: <5256BEBD.1090907@efe-gmbh.de>
References: <5256A186.5030708@efe-gmbh.de>
	<20131010141221.GN21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Renaud Muller <muller-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131010141221.GN21581-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Am 10.10.2013 16:12, schrieb Mark Brown:
> On Thu, Oct 10, 2013 at 02:45:58PM +0200, Jens Renner wrote:
> 
>> +		of_property_read_u32(pdev->dev.of_node, "xlnx,num-transfer-bits",
>> +					&bits_per_word);
> 
> This new property needs to be documented in the binding document (and
> sent to the DT maintainers for review though in this case it's probably
> OK).

So far there is no binding documentation for spi/xilinx at all, but I prepared
a file spi-xilinx.txt which documents everything. I will send it to the DT
maintainers.

>> @@ -385,7 +387,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>>  		goto put_master;
>>  	}
>>  
>> -	master->bus_num = pdev->dev.id;
>> +	master->bus_num = pdev->id;
>>  	master->num_chipselect = num_cs;
>>  	master->dev.of_node = pdev->dev.of_node;
> 
> This looks like an unrelated change (and buggy?).
> 

Related insofar as I mentioned the modification in the patch title and
description. Buggy, yes, I resent the patch ...


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
