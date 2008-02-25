From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: support zero length
 transfer
Date: Mon, 25 Feb 2008 09:25:15 +0900 (JST)
Message-ID: <20080225.092515.126141645.anemo@mba.ocn.ne.jp>
References: <47BED734.5030002@whoi.edu>
	<20080222190228.2B0CB28E363@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<47BF2455.8030904@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.pignat-7TsPiqsLilE@public.gmane.org
To: nforrester-/d+BM93fTQY@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47BF2455.8030904-/d+BM93fTQY@public.gmane.org>
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

On Fri, 22 Feb 2008 14:36:53 -0500, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> Or are you and Atsushi talking about using spi_transfer.delay_usecs
> *with* a zero length transfer to effectively put a delay between the
> assertion of CS and the start of the first clock?  If so, then I guess I
> missed the original point.  Sorry.

Yes.  I want to use zero length transfer with delay_usecs to achieve
CS-CLK delay for my funny device.  And I was too lazy to reject true
nop transfer.

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
