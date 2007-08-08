From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: spi_async and heavy CPU occupation by
	ksoftirqd
Date: Wed, 8 Aug 2007 09:27:36 -0700
Message-ID: <200708080927.36737.david-b@pacbell.net>
References: <46B97D01.5000208@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46B97D01.5000208-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Content-Disposition: inline
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

On Wednesday 08 August 2007, llandre wrote:
> The actual SPI transaction is perfomed by invoking spi_async. SPI 
> transactions work fine but the kernel daemon ksoftirqd eats about 18% of 
> CPU time.

That's excessive.


> With the help of debug pin, I measured the execution time of  
> function work that is around 70us. Then I commented out the call of 
> spi_async and the ksoftirqd CPU occupation drops to 0%. Am I doing 
> something wrong?

Are your transfers large enough to kick in DMA, or is it doing PIO?

At a first glance, I wonder if you're not spending too much time
in the spi_imx "pump_transfers" tasklet.  I have no idea how well
tuned that driver is...

I'd expect that using spi_sync() wouldn't save much, but it might
be worth verifying that.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
