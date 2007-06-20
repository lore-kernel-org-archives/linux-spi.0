From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 3/4] MMC-over-SPI core updates
Date: Wed, 20 Jun 2007 17:56:11 +0200
Message-ID: <46794E1B.6010907@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706131753.47453.david-b@pacbell.net>
	<4672D474.4060707@drzeus.cx>
	<200706161416.17802.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706161416.17802.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

David Brownell wrote:
> 
> I can't see it that way.  It's just a different way of managing
> that status than you currently expect.
> 

You seem to be stuck in the idea that we want some voodoo translation layer
between native MMC and the SPI version. That is not desirable for a multitude of
reasons, so make sure the core knows SPI and the host driver is just a hardware
interface (like the other host drivers).

> 
> So, get rid of all R1_APP_CMD checks in the MMC stack?
> That's what I'll do for now.
> 
> I count two of them, and they are both superfluous since
> they follow successful completion of MMC_APP_CMD.  The
> only way that can succeed is if the card supports APP_CMD
> and enters that mode...
> 

The specs that was coded against suggested it was prudent to check the bit. It's
not like it's a measurable performance hit to do it.

> (The alternative would be to do the superfluous checks
> only for non-SPI hosts, but that'd seem pointless.)

I don't agree. Preferably we would always check it, but we can't with SPI so
we'll have to cross our fingers there.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
