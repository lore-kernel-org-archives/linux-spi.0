From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: how to speed up the spi speed ?
Date: Wed, 30 Jan 2008 10:47:51 -0800
Message-ID: <200801301047.51896.david-b@pacbell.net>
References: <f45effa60801300200t390936bdmefc8f5f5b8995669@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: zhang zhilong <zhang.zhilong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f45effa60801300200t390936bdmefc8f5f5b8995669-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wednesday 30 January 2008, zhang zhilong wrote:
> hi,everyone.
> 
> i found the spi speed can't set like this:
> 
> void iodata_transfer(int fd,int len)
> {
>    ...
>     struct spi_ioc_transfer xfer[1];
>     memset(xfer,0,sizeof xfer);
>     xfer[0].rx_buf=(__u64) buf;
>     xfer[0].delay_usecs=0;
>     xfer[0].len=len;
>     xfer[0].speed_hz=12*1000*1000;//this will make error.

What do you mean "this will make error"?
The compiler complains?

> 
> }
> the max speed is 15000000hz;
> how can i do?

Were you trying to do what SPI_IOC_WR_MAX_SPEED_HZ does?


- Dave


> thanks a lot;
> -- 
> zhang.zhilong
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
