From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: SPI bridge
Date: Fri, 9 May 2008 20:28:04 -0600
Message-ID: <fa686aa40805091928w1b3e50d7le9452f668f411a5e@mail.gmail.com>
References: <fa686aa40805090924r1b6f06fhb0369f18958bd8a6@mail.gmail.com>
	<1210375330.5773.26.camel@timing-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Erwin Authried" <eauth-T13/FXdtSm+ALaLeEb27IQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1210375330.5773.26.camel@timing-laptop>
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

On Fri, May 9, 2008 at 5:22 PM, Erwin Authried <eauth-T13/FXdtSm+ALaLeEb27IQ@public.gmane.org> wrote:
> I'm I'm using something close to your description. On the SPI master, I
> have one chipselect (SS)only. When the master starts a transfer to SPI
> device N, it activates SS and sends the slave address as the first byte.
> When the SPI bridge receives the address byte, it activates the
> chipselect for the required peripheral. When the SPI transfer is
> finished and SS is deselected, the SPI bridge deactivates the
> peripheral's chipselect.
> I have used this with the bitbang driver. In spi_gpio, I have modified
> the chipselect function so that it sends the address byte each time
> chipselect goes active. I have used this with success for SD-card, RTC
> and LCD sharing the same SPI bus.

Can you send me your patch?  (Mostly for interest sake, I'd just like
to see how you've done it.  From your description, it sounds like you
made a board specific change to the driver itself.  Am I correct?

What I'm hoping to do is define a 'shim' interface that makes the SPI
bridge transparent to the SPI master device (ie; the SPI bridge is
both a master and a device; the devices are registered with the
bridge, and the bridge is registered with the SPI master.  Devices
issues their SPI messages to the bridge and the bridge reissues them
to the master).  That way the master drivers don't need to be hacked
for board specific layouts.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
