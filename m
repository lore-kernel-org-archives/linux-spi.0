From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length
	transfer
Date: Thu, 21 Feb 2008 10:52:33 +0900 (JST)
Message-ID: <20080221.105233.41199605.nemoto@toshiba-tops.co.jp>
References: <20080221.005432.07645461.anemo@mba.ocn.ne.jp>
	<200802201855.02605.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marc.pignat-7TsPiqsLilE@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802201855.02605.marc.pignat-7TsPiqsLilE@public.gmane.org>
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

On Wed, 20 Feb 2008 18:55:01 +0100, Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org> wrote:
> > A spi transfer with zero length is not invalid.  Such transfer can be
> > used to achieve delay before first CLK edge after chipselect assertion.
> How long will be that delay?

My funny custom device requires 100us or so.  Unfortunately atmel_spi
can not use such a slow bitrate.

> If they are really users of that kind of thing, this should be fixed by adding
> a "delay_us_before_xfer" field in the  struct spi_transfer.

Yes, it would be an another way to achieve it.  But as long as zero
length transfer is legal on this API, I don't want to add other
fields.

> Have you tested it? I think if you start a transfer with 0 len, the ENDRX bit
> will never rise, however, I'm not sure about this.

Yes.  I tested it on AT91SAM9260 and it seems ENDRX rises soon.
Though it can be possible to avoid starting DMA for zero length
transfer, I think it is not worth to optimize for such a rare case.

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
