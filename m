From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Wed, 23 Mar 2016 14:26:37 +0100
Message-ID: <20160323132637.GC19953@lunn.ch>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de>
 <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F295E1.4030505-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 23, 2016 at 02:10:57PM +0100, Stefan Roese wrote:
> Hi Mark,
> 
> On 23.03.2016 13:54, Mark Brown wrote:
> > On Wed, Mar 23, 2016 at 12:59:40PM +0100, Stefan Roese wrote:
> >> On 23.03.2016 12:33, Mark Brown wrote:
> > 
> >>> No, there's two separate things here.  The big problem with what you
> >>> originally sent was that you were defining a window per SPI device but
> >>> this is a part of the SPI controller so having to change windows per
> >>> device is just going to make the code more complex.
> > 
> >> I'm sorry, but this sentence is not totally clear to me: Do you mean
> >> that the "more complex" code in v2 with the MBus window reconfiguration
> >> is not good? Or do you mean that in the RFC version, the switching
> >> between the SPI devices was too complex?
> > 
> > I haven't looked at your new code at all.  What I'm saying is that
> > specifying a per-device MBus window seems like pointless complexity.
> 
> I don't necessarily share this opinions. Code-wise, its less complex
> that re-configuring (removing the old and creating the new) the MBus
> window. But I have no strong feeling here. Whatever is decided that
> should be used, I can go with.
> 
> Thomas, Arnd (or anyone else?), do you have any comments or preferences
> which way to go here?

Hi Stefan

The number of windows is limited. On i think the Armada XP, if you put
a PCIe device on every available PCIe bus, you can run out of
windows. This is why Thomas implemented dynamic allocation of the
Windows, so that only those that are needed are used.

So i would not statically and globally allocate as many windows as
possible SPI devices.

The fact that SPI can fall back to another mechanism if there are no
available windows, were as PCIe cannot, suggests that SPI should
dynamically allocate a window, and be prepared for it to fail.

Since only one SPI device can be active at once on a SPI bus, one
window per bus makes sense, and keeps the required number of windows
to a minimum.

   Andrew
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
