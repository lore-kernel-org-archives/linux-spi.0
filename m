From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI-ADC
Date: Mon, 26 Apr 2010 09:26:46 +0200
Message-ID: <20100426092646.11d8d71c@hskinnemoen-d830>
References: <o2idc6d3181004212320neaf99b0az27938c369e1a5557@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D940B1C@AUSP01VMBX24.collaborationhost.net>
	<y2tdc6d3181004222208uf6f4a9ecl7d0e2f084fd56a08@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D941949@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B0270842697636D941949-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
> The max124[0|1] is still a spi device so using the atmel_spi driver is
> the correct route.  You just need to add the necessary support to the
> driver to handle the SPI_READY mode.

If there's only one master driver which supports this flag, it sounds
to me like it would be a _lot_ easier in the long run to instead teach
the device driver to deal with drivers which don't support this mode.

The atmel_spi hardware doesn't have any hardware support for this mode
as far as I know, so the implementation will be very CPU-intensive
either way.

But the best solution is probably to replace the ADC with one that
doesn't have a completely boneheaded interface.

Haavard

------------------------------------------------------------------------------
