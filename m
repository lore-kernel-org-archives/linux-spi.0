From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
Subject: Re: [patch 2.6.24-rc8] spi: omap2_mcspi PIO RX
	fix
Date: Fri, 25 Jan 2008 10:46:31 +0530
Message-ID: <029301c85f11$736dfd50$988818ac@ent.ti.com>
References: <200801241340.25207.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'Kalle Valo' <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"'Andrew Morton'" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200801241340.25207.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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


>-----Original Message-----
>From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org] 
>Sent: Friday, January 25, 2008 3:10 AM
>To: Andrew Morton; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Kalle Valo; Girish
>Subject: [patch 2.6.24-rc8] spi: omap2_mcspi PIO RX fix
>
>From: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>
>Before transmission of the last word in PIO RX_ONLY mode rx+tx 
>mode is enabled:
>


Yes, I had missed out this patch. Thanks dave.

Regards,
Girish


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
