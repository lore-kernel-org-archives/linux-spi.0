From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Sat, 4 Aug 2007 23:32:48 +0200
Message-ID: <20070804233248.4e855743@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200708021334.50670.david-b@pacbell.net>
	<20070804151452.0efaa5a9@poseidon.drzeus.cx>
	<200708041032.10001.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708041032.10001.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sat, 4 Aug 2007 10:32:09 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> 
> There's always writing negative tests ... i.e. issue requests
> that will fail, and make sure they fail "correctly".  One of
> those might be an alternative to the current block driver.
> 

I've thought about it, and the interesting cases are difficult to
achieve with a standard card. If you have some ideas, I'd love to hear
them.

Also, a common problem is drivers that break layering. So my number one
wanted test is to issue a command opcode that doesn't match what the
spec says in terms of response and semantics.

> One expects that code developed outside any test framework
> will have fair coverage for success paths (e.g. whatever is
> needed to make MMC and SD memory cards work), and the most
> common fault paths (e.g. what's triggered during enumeration).
> But beyond that ... passing illegal params, reading past end
> of card, "unusual" write sizes, and other things are unlikely
> to behave consistently between drivers.
> 

Now if only there was time. :)

> > 
> > It should just be a matter of replacing MMC_ERR_ codes with
> > -Esomething.
> 
> Or MMC_ERR_NONE with zero.  Almost ... thing is, the new SDIO stuff
> seems to bork things in some cases, more with SD cards than MMC.
> 

Well, the sdio code so far hasn't paid any attention to sdio. Perhaps
it's best to just avoid that detection on a spi host for now.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
