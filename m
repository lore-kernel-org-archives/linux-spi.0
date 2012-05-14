From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: refactor spi-coldfire-qspi to use SPI queue
	framework.
Date: Mon, 14 May 2012 21:50:27 +0200
Message-ID: <CACRpkdYgCVm7+7fcf7tBE4dtQGdJ8CUJGFMga9Ssok0UsRXdBw@mail.gmail.com>
References: <201205100926.55444.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201205100926.55444.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 10, 2012 at 6:26 PM, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org> wrote:

> Use the new SPI queue framework; remove use of workqueue, replace
> mcfqspi_transfer with mcfqspi_transfer_one_message, add
> mcfqspi_prepare_transfer_hw and mcfqspi_unprepare_transfer_hw, update power
> management routines.
>
> Signed-off-by: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>

Looks good to me, the PM runtime stuff could have been in a separate patch
but that's no big deal to me.
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
