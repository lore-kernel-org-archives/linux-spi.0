From: Stan Hu <stanhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: omap2-mcspi: add option to configure output line
	for McSPI driver
Date: Tue, 9 Oct 2012 11:40:04 -0700
Message-ID: <CAMBWrQmuTchn-Hp_AsFGPscT37CWuFSOGWOjNnXEXQUiWvNoWQ@mail.gmail.com>
References: <1349735980-17015-1-git-send-email-stanhu@gmail.com>
	<CAM=Q2csxH_Mjq1WGR+0xHg8jVVbgGUJ-qP_8UEQ84Ex48fvWwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2csxH_Mjq1WGR+0xHg8jVVbgGUJ-qP_8UEQ84Ex48fvWwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The other configuration is used in the case when you have SPI devices wired
opposite to the default case.  This was the case for a custom board using
the McSPI driver.

I tested it by just passing in the parameter in the device config data when
registering the device under the spidev driver.

I noticed a similar patch was submitted recently:

http://sourceforge.net/mailarchive/forum.php?thread_name=1349626784-22035-1-git-send-email-zonque%40gmail.com&forum_name=spi-devel-general

The reason I put it in the device config because I reasoned you could in
theory configure MOSI and MISO differently for each SPI device on the bus.
 This seems unlikely, though, but it is within the power of a hardware
designer to do that.

Feel free to use the other patch if it's more complete.

On Tue, Oct 9, 2012 at 11:28 AM, Shubhrajyoti Datta <
omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Tue, Oct 9, 2012 at 4:09 AM, Stan Hu <stanhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > McSPI driver previously assumed that D0 was input (MISO) and D1 was
> output (MOSI).
> > This forces the hardware designer to wire all SPI peripherals in this
> way when
> > it should be a software configuration option.
>
> Your change looks good.
>
> What is the other configuration used for?
>
> Also are you using a dt patch to test it?
>
> >
> > Signed-off-by: Stan Hu <stanhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
>
------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
