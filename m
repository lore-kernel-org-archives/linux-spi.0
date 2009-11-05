From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: PXA270 SPI + SD card
Date: Thu, 5 Nov 2009 08:17:21 +0200
Message-ID: <20091105061721.GA13519@jasper.tkos.co.il>
References: <f96d234e0911041353o25aeee4aqbb482f162aaeac5f@mail.gmail.com>
	<f96d234e0911041354p1f11e415g427ec9b74ff4d25b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Cliff Brake <cliff.brake-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f96d234e0911041354p1f11e415g427ec9b74ff4d25b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Cliff,

On Wed, Nov 04, 2009 at 04:54:18PM -0500, Cliff Brake wrote:
> Also, what SPI mode is typically used for SD?  Looks like 0 and 3 are
> the closest (http://elm-chan.org/docs/spi_e.html).

I've found this in drivers/mmc/host/mmc_spi.c:mmc_spi_probe():

        /* MMC and SD specs only seem to care that sampling is on the
         * rising edge ... meaning SPI modes 0 or 3.  So either SPI mode
         * should be legit.  We'll use mode 0 since the steady state is 0,
         * which is appropriate for hotplugging, unless the platform data
         * specify mode 3 (if hardware is not compatible to mode 0).
         */
        if (spi->mode != SPI_MODE_3)
                spi->mode = SPI_MODE_0;

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
