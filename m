From: "Bryan Wu" <cooloney.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] [Blackfin] SPI driver: Use SPI
	device name to do gpio peripheral request
Date: Thu, 31 Jan 2008 11:12:26 +0800
Message-ID: <386072610801301912u696310d1q55e90a0d93f4f16c@mail.gmail.com>
References: <1201684421-26124-1-git-send-email-bryan.wu@analog.com>
	<1201684421-26124-3-git-send-email-bryan.wu@analog.com>
	<200801301348.43275.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200801301348.43275.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Jan 31, 2008 5:48 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 30 January 2008, Bryan Wu wrote:
> > When got some gpio conflict, it is easy to know which SPI device driver not just got "bfin-spi"
> >
> > Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/spi/spi_bfin5xx.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> > index 8fd1365..c3f9ed4 100644
> > --- a/drivers/spi/spi_bfin5xx.c
> > +++ b/drivers/spi/spi_bfin5xx.c
> > @@ -1176,7 +1176,7 @@ static int setup(struct spi_device *spi)
> >       if ((chip->chip_select_num > 0)
> >               && (chip->chip_select_num <= spi->master->num_chipselect))
> >               peripheral_request(ssel[spi->master->bus_num]
> > -                     [chip->chip_select_num-1], DRV_NAME);
> > +                     [chip->chip_select_num-1], spi->modalias);
>
> Better:  spi->dev.bus_id (always unique) not spi->modalias (isn't) ...
>

spi->dev.bus_id is just  number, while spi->modalias usually is a
string name which it is more meaningful.
In most time, modalias is easier for us to locate the gpio conflict.

Thanks
-Bryan Wu

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
