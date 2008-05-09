From: Erwin Authried <eauth-T13/FXdtSm+ALaLeEb27IQ@public.gmane.org>
Subject: Re: SPI bridge
Date: Sat, 10 May 2008 01:22:10 +0200
Message-ID: <1210375330.5773.26.camel@timing-laptop>
References: <fa686aa40805090924r1b6f06fhb0369f18958bd8a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40805090924r1b6f06fhb0369f18958bd8a6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

I'm I'm using something close to your description. On the SPI master, I
have one chipselect (SS)only. When the master starts a transfer to SPI
device N, it activates SS and sends the slave address as the first byte.
When the SPI bridge receives the address byte, it activates the
chipselect for the required peripheral. When the SPI transfer is
finished and SS is deselected, the SPI bridge deactivates the
peripheral's chipselect.
I have used this with the bitbang driver. In spi_gpio, I have modified
the chipselect function so that it sends the address byte each time
chipselect goes active. I have used this with success for SD-card, RTC
and LCD sharing the same SPI bus.

Regards,
Erwin

Am Freitag, den 09.05.2008, 10:24 -0600 schrieb Grant Likely:
> I don't see anything in the SPI documentation about this... has any
> work been done on supporting drivers for SPI bridges?  Specifically,
> an SPI device that has local registers, but can also pass through the
> SPI signals to child devices.
> 
> As an example; imagine the following configuration:
> 
> +------------+
> | SPI Master |
> +------------+
>  |
>  |MDIO,MISO,MCK,SS0,SS1
>  |
> +-------------+  SS2  +--------------+
> |             |-------| SPI Device 1 |
> | SPI Bridge  |       +--------------+
> |             |
> |             |  SS3  +--------------+
> |             |-------| SPI Device 1 |
> |             |       +--------------+
> |             |
> |             |  SS4  +--------------+
> |             |-------| SPI Device 1 |
> +-------------+       +--------------+
> 
> So, SS0 access registers on the SPI bridge
> SS1 is passed through so SS2, SS3 or SS4 based on a register value in
> the SPI bridge.  I thought about just overriding the SPI controller's
> SS activate function, but that leaves a bit of a chicken and egg
> problem.  The message has already been dequeued when the CS is called,
> but the new SPI message so set the SS register needs to be inserted
> before the current message.  I could hack it to make it work, but I'd
> like to do this in a reusable/adaptable way.
> 
> Cheers,
> g.
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
