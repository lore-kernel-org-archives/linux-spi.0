From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: XR20M1172 -SPI-UART
Date: Tue, 4 Aug 2009 15:38:26 +0100
Message-ID: <20090804143826.GJ16303@trinity.fluff.org>
References: <dc6d3180908040618n714df95v210cd14a07b1ec01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dc6d3180908040618n714df95v210cd14a07b1ec01-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 04, 2009 at 06:48:14PM +0530, arjun rath wrote:
> Hi all,
> 
> I am working on XR20M1172 which is a two channel SPI uart with 64 byte
> FIFO.Currently i am working on S3C2450 Processor
> where it has given HSPI instead of SPI.And there is no link between spi.c
> file and hspi.c.And one more file is being given i.e spi_s3c24xx.c file
> which is generic to all samsung .

I've not got any up to date information about the 2450, but I belive the
newer HSPI block is not compatible with the older spi_s3c24xx.c driver.
 
> So my question is  my XR20M1172(slave spi) will communicate with hspi or
> spi_s3c24xx file because i am registering my slave chip with spi.c file
> which is talking with spi_s3c24xx.c file.

The registeration of SPI devices is seperate from the registration of the
SPI bus master.

The SPI bus master is registered from a platform device that attaches
the master controller to a SPI bus. The SPI bus is specified in a number
passed in to the driver via platform_data supplied when the master is
registered.

> I am using linux 2.6.21 kernel source.

I might be persuaded to do an HSPI driver, but it will be a patch
against a much newer kernel, since it will be useful for other devices
that are being actively maintained.


> Any help will be greatful.
> 
> Regards
> 
> Arjun

> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general


-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
