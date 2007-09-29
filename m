From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: IT8716F SPI driver submission?
Date: Sat, 29 Sep 2007 13:39:43 -0700
Message-ID: <20070929203942.4302D20F0A2@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <46FE5701.2030000@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	c-d.hailfinger.devel.2006-hi6Y0CQ0nG0@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46FE5701.2030000-hi6Y0CQ0nG0@public.gmane.org>
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

> The IT8716F accepts commands byte-wise and does all of the lifting on
> the SPI bus as well. There are limitations, though:
> - It can send 1,2,4,5 bytes (including command byte) to the slave and
> read 0,1,2,3 bytes back. Other values are not possible.
> - Bus clock rate is either 33 MHz or 16.5 MHz.
>
> Is there any driver I can start from as reference?

None that I know of.  You might find it's easier to just work with
a bastardized version of the (latest, with the 2.6.24 MTD updates
so it handleds even more chips) m25p80 driver and not go through the
SPI framework.  It doesn't look like you could even bitbang SPI there,
since not all those pins are usable for bit-level I/O.

As you note, that hardware doesn't support all that a SPI controller
does.  It's provided for accessing a single serial flash chip; and
not even to do that very smoothly.  You'd have to somehow prevent that
driver from reading or writing normal size blocks.  And you'd need to
defend against drivers trying to do full duplex or multi-segment I/O
requests, etc.  Lots more work than a bastardized m25p80 driver.  ;)

My limited exposure to SPI on PC hardware -- LPC chips like this, and
newer southbridges -- suggests they tend to be just as, erm, "limited"
as this one in terms of supporting anything other than one particular
variety of serial flash interface.  I think the idea was just to let
board makers use cheaper flash chips when loading the BIOS.  For that,
they don't need the kind of flexible expansion bus SPI is on most SOC
chips; or much throughput.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
