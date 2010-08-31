From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Suggested Patch for 'amba-pl022.c' to solve
	the problem of running 'spidev_test' on Phytec LPC3250 board.
Date: Tue, 31 Aug 2010 16:06:59 -0700
Message-ID: <AANLkTi=e53=8VNHv=5gSfujYN0XU0NYJTu3=Aq2FS5VZ@mail.gmail.com>
References: <AANLkTinQFQMXXBh7bq5ce_iwOzGvYCZxud6QWb-S71yQ@mail.gmail.com>
	<AANLkTimsoUUJihk8j48KkJ1YPdAttLHPuJ19i0W0BkpD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Quentin YANG <quentinyang05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimsoUUJihk8j48KkJ1YPdAttLHPuJ19i0W0BkpD-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>> =A0 =A0 =A0 =A0/* Quentin Added 2010-AUG-19 */
>> =A0 =A0 =A0 =A0master->mode_bits=3DMODEBITS;
>> =A0 =A0.........................
>>

>
> It looks like some additional setup is needed in pl022_setup() to setup t=
hese
> modes in hardware. Setting the mode_bits mask alone only tricks the
> application into thinking SPI mode 3 has been set, but nothing will change
> in hardware on the next setup if the passed mode isn't handled there too.
>
> Some of the transfer setup config - data width, clock rate, SPI mode,
> etc - are actually setup on a per transfer basis and may vary based on how
> spidev (and in this case the spidev_test app) configures it. For these sp=
ecific
> setup items, we probably shouldn't use the static chip_info version of the
> transfer config - maybe we can use the config passed in 'struct spi_trans=
fer'
> instead.
>
> This would also reduce the size of the struct pl022_config_chip controller
> data structure since some of those fields would now be handled in the
> spi_transfer structure.
>
> I guess this change is bigger than anticipated :(
>

Hi Linus,

I use this driver quite a bit here - Is it ok if try to get the setup based=
 on
spi->mode instead of the controller_data info?

thanks,
Kevin

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
