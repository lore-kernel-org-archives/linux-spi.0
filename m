From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Problems with suspend/resume of pxa2xx_spi
Date: Thu, 21 Feb 2008 11:38:01 -0800
Message-ID: <20080221193801.E0069235007@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <33e9dd1c0802201932v6873415bm9202ad478f192b7f@mail.gmail.com>
	<47BCFEA4.1090105@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org, nforrester-/d+BM93fTQY@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47BCFEA4.1090105-/d+BM93fTQY@public.gmane.org>
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

> Does the whole system hang (deadlock in kernel) or is it only the spi
> that is stuck?

Yeah, speicifally *what* is going wrong?


> David:
> Should there be a message if there is an error on suspend, or are
> suspending devices supposed to be silent and do the best they can?

It's fair to issue error message.  Doesn't the PM core do that
automatically though?

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
