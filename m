From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 1/4] MMC-over-SPI header updates
Date: Wed, 13 Jun 2007 10:25:48 +0200
Message-ID: <466FAA0C.9020102@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706101305.53151.david-b@pacbell.net>
	<466ED661.1010407@drzeus.cx>
	<200706121106.42067.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706121106.42067.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> The point is that this way we can keep the host driver out of the business
> of deciding whether or not to enable CRC mode.  The main alternative would
> be to move that module parameter into the MMC core.
> 

Why would we want to turn it off?

> 
> This directly matches every MMC spec I've seen ... they define the response
> format in those terms.  And I made this change per your request ... the host
> driver checks for "R1", "R2", etc which are built up from those components.
> 

The components we defined for native mode cannot be found in the specs, we
derived them from the descriptions. So the same thing goes for SPI.

The point of this exercise is that we do not have to modify host drivers when
new response types show up (which it has when MMC got extended to SD, and SD to
SDIO).

So when R666 shows up, which happens to contain the anti-christ and be 5 bytes
long, we can describe this using existing defines and not have to modify the
host drivers. Having a name like "OCR" then does not describe properly what we
want the host to do.

> I'll note that the "native" bits include meaning too ... opcode is most
> certainly meaning, as is CRC.
> 

Granted, this is a bit fuzzy in some areas. These two are sometimes not reported
by hw, we can only tell it to check that they are correct. And there is no real
variation what we want to do with these values. Compare that to the payload
where it is difficult, if not impossible, for the host driver to determine what
we want to do with it.

Just trust me on this, we do _not_ want semantics in the host drivers. It has
caused problems with at least three host drivers so far, and omap is still
unable to use SD cards because it tries to parse responses by itself.

The rule of thumb is, data the core wants back should not be parsed by the host
driver. Things the core just wants validated is ok to parse in the host driver.

> 
> OK, I can remove that stuff now that the raw SPI status bytes are being
> returned in resp[] ... I'll have to update the spi_mmc driver though,
> and I'll hold off on that for a bit since I expect you'll send comments
> specifically on that driver.
> 

Great. I'll ignore the mapping parts in there for now then and review the rest
of the code.

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
