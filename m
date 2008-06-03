From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: Driver for ADC088S052
Date: Tue, 03 Jun 2008 18:49:50 +0100
Message-ID: <4845843E.2040000@cam.ac.uk>
References: <20080603145927.GA2338@local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Hans J. Koch" <hjk-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080603145927.GA2338@local>
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

Hi Hans,
> Hi,
> I need a driver for an ADC088S052 (National Semiconductor). This is an
> 8-bit successive-approximation A/D converter with 8 multiplexed inputs
> and an SPI interface.
> It's relatively new, and Google doesn't report anything useful for
> Linux. So I don't have much hope, but I try it anyway:
> 
> Is anybody working on a driver for that chip, or knows of such a
> project? Any other hints?
Whilst I'm not aware of a driver for that particular chip, it has a very
simple interface so a basic driver would be relatively straight forward.
As far as I can tell from a quick read it's just a case of doing full 
duplex 16 bit transfers with a few bits on the send specifying which 
channel to grab next?

However, as per the recent thread on this list and lkml, there are some 
issues with how and where to integrate such a driver with the main kernel
that are somewhat dependent on what you want to do with it.  (search
for "accelerometer" to get the relevant discussion).

If your application is of the simple poll all inputs every now and then
variety where a sysfs "readall" attribute would do the job then it should
be straight forward to write such a driver from scratch.  Perhaps you
could give us a few more details of the application / requirements?

Jonathan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
