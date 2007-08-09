From: llandre <r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Subject: Re: spi_async and heavy CPU occupation by
	ksoftirqd
Date: Thu, 09 Aug 2007 16:05:04 +0200
Message-ID: <46BB1F10.3030608@dave-tech.it>
References: <46B97D01.5000208@dave-tech.it>
	<200708080927.36737.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708080927.36737.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>> With the help of debug pin, I measured the execution time of  
>> function work that is around 70us. Then I commented out the call of 
>> spi_async and the ksoftirqd CPU occupation drops to 0%. Am I doing 
>> something wrong?
> 
> Are your transfers large enough to kick in DMA, or is it doing PIO?
I transfer just 1 byte every time the work is executed (HZ/10). I tried
to turn on and off DMA by setting/clearing enable_dma field but nothing 
changed:

/* SPI Controller configuration */
static struct spi_imx_master spi_imx1_master_info = {
	.num_chipselect = SPI_NUM_CHIPSELECT,
	.enable_dma = 0
};


> At a first glance, I wonder if you're not spending too much time
> in the spi_imx "pump_transfers" tasklet.  I have no idea how well
> tuned that driver is...
Hmmm ... how do you suggest me to investigate around this tasklet? Do I 
need to use the toggling pin technique or does the kernel provides some 
tools to do that? Could oprofile come to help?


> I'd expect that using spi_sync() wouldn't save much, but it might
> be worth verifying that.
Initially my driver used spi_sync. When I realized the huge CPU 
occupation I modified it in order to use spi_async instead but, again, 
nothing changed.




-- 
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
