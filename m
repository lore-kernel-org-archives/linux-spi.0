From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length
	transfer
Date: Thu, 21 Feb 2008 10:26:16 +0100
Message-ID: <200802211026.17816.marc.pignat@hevs.ch>
References: <20080221.005432.07645461.anemo@mba.ocn.ne.jp>
	<200802201855.02605.marc.pignat@hevs.ch>
	<20080221.105233.41199605.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080221.105233.41199605.nemoto-IGagC74glE2asRnM1LW+pc8NsWr+9BEh@public.gmane.org>
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

Hi!

On Thursday 21 February 2008, Atsushi Nemoto wrote:
...
> Yes.  I tested it on AT91SAM9260 and it seems ENDRX rises soon.
> Though it can be possible to avoid starting DMA for zero length
> transfer, I think it is not worth to optimize for such a rare case.
Ok, verified to work on at91rm9200, should be tested on AVR32.

David, do you think writing 0 bytes is a valid use of this API?
IMHO, we should add a fied to the spi_transfer struct.

Regards

Marc


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
