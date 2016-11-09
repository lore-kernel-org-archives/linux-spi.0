From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] spi: atmel: use managed resource for gpio chip select
Date: Wed, 9 Nov 2016 10:34:17 +0100
Message-ID: <20161109093417.kgcm27o3jwivageq@piout.net>
References: <20161108174852.14311-1-nicolas.ferre@atmel.com>
 <20161108174909.vnsw3zppiwpv2npo@piout.net>
 <8756e0f4-de7b-5d89-2561-ace18d157d91@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux@meltdown.ru, Mark Brown <broonie@kernel.org>,
 geert@linux-m68k.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Wenyou Yang <wenyou.yang@atmel.com>, linux-arm-kernel@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8756e0f4-de7b-5d89-2561-ace18d157d91@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 09/11/2016 at 10:16:18 +0100, Nicolas Ferre wrote :
> Le 08/11/2016 =E0 18:49, Alexandre Belloni a =E9crit :
> > On 08/11/2016 at 18:48:52 +0100, Nicolas Ferre wrote :
> >> Use the managed gpio CS pin request so that we avoid having trouble
> >> in the cleanup code.
> >> In fact, if module was configured with DT, cleanup code released
> >> invalid pin.  Since resource wasn't freed, module cannot be reinserted.
> >>
> >> This require to extract the gpio request call from the "setup" function
> >> and call it in the appropriate probe function.
> >>
> >> Reported-by: Alexander Morozov <linux@meltdown.ru>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > =

> > I think that's fine but I still have that item on my todo list
> > (discussion in july 2014 with Mark):
> > =

> > ---
> >>> Mark: maybe it would make sense to do devm_gpio_request_one() in
> >>> of_spi_register_master(), after of_get_named_gpio.
> > =

> >> You need to transition all the drivers doing things manually but yes.
> >> As I keep saying all the GPIO handling needs to be completely
> >> refactored.
> > ---
> =

> Would make sense indeed as we are currently doing the same node scanning
> twice...
> =

> But this patch actually fixes an issue with module unloading/re-loading
> and freeing of a wrong gpio. So I do think that we shouldn't hold its
> adoption while thinking about this enhancement...
> =


Yes, this patch is still useful as-is and fixes a bug.

> Regards,
> =

> >> ---
> >> v2: fix devm_gpio_request location: the setup code for device was not =
proper
> >>     location. Move it to the probe function and add needed DT routines=
 to
> >>     handle all CS gpio specified.
> >>
> >>  drivers/spi/spi-atmel.c | 50 ++++++++++++++++++++++++++++++++++++++--=
---------
> >>  1 file changed, 39 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> >> index 32683a13dd60..a60925614480 100644
> >> --- a/drivers/spi/spi-atmel.c
> >> +++ b/drivers/spi/spi-atmel.c
> >> @@ -24,6 +24,7 @@
> >>  =

> >>  #include <linux/io.h>
> >>  #include <linux/gpio.h>
> >> +#include <linux/of_gpio.h>
> >>  #include <linux/pinctrl/consumer.h>
> >>  #include <linux/pm_runtime.h>
> >>  =

> >> @@ -1204,7 +1205,6 @@ static int atmel_spi_setup(struct spi_device *sp=
i)
> >>  	u32			csr;
> >>  	unsigned int		bits =3D spi->bits_per_word;
> >>  	unsigned int		npcs_pin;
> >> -	int			ret;
> >>  =

> >>  	as =3D spi_master_get_devdata(spi->master);
> >>  =

> >> @@ -1247,16 +1247,9 @@ static int atmel_spi_setup(struct spi_device *s=
pi)
> >>  		if (!asd)
> >>  			return -ENOMEM;
> >>  =

> >> -		if (as->use_cs_gpios) {
> >> -			ret =3D gpio_request(npcs_pin, dev_name(&spi->dev));
> >> -			if (ret) {
> >> -				kfree(asd);
> >> -				return ret;
> >> -			}
> >> -
> >> +		if (as->use_cs_gpios)
> >>  			gpio_direction_output(npcs_pin,
> >>  					      !(spi->mode & SPI_CS_HIGH));
> >> -		}
> >>  =

> >>  		asd->npcs_pin =3D npcs_pin;
> >>  		spi->controller_state =3D asd;
> >> @@ -1471,13 +1464,11 @@ static int atmel_spi_transfer_one_message(stru=
ct spi_master *master,
> >>  static void atmel_spi_cleanup(struct spi_device *spi)
> >>  {
> >>  	struct atmel_spi_device	*asd =3D spi->controller_state;
> >> -	unsigned		gpio =3D (unsigned long) spi->controller_data;
> >>  =

> >>  	if (!asd)
> >>  		return;
> >>  =

> >>  	spi->controller_state =3D NULL;
> >> -	gpio_free(gpio);
> >>  	kfree(asd);
> >>  }
> >>  =

> >> @@ -1499,6 +1490,39 @@ static void atmel_get_caps(struct atmel_spi *as)
> >>  }
> >>  =

> >>  /*-------------------------------------------------------------------=
------*/
> >> +static int atmel_spi_gpio_cs(struct platform_device *pdev)
> >> +{
> >> +	struct spi_master	*master =3D platform_get_drvdata(pdev);
> >> +	struct atmel_spi	*as =3D spi_master_get_devdata(master);
> >> +	struct device_node	*np =3D master->dev.of_node;
> >> +	int			i;
> >> +	int			ret =3D 0;
> >> +	int			nb =3D 0;
> >> +
> >> +	if (!as->use_cs_gpios)
> >> +		return 0;
> >> +
> >> +	if (!np)
> >> +		return 0;
> >> +
> >> +	nb =3D of_gpio_named_count(np, "cs-gpios");
> >> +	for (i =3D 0; i < nb; i++) {
> >> +		int cs_gpio =3D of_get_named_gpio(pdev->dev.of_node,
> >> +						"cs-gpios", i);
> >> +
> >> +			if (cs_gpio =3D=3D -EPROBE_DEFER)
> >> +				return cs_gpio;
> >> +
> >> +			if (gpio_is_valid(cs_gpio)) {
> >> +				ret =3D devm_gpio_request(&pdev->dev, cs_gpio,
> >> +							dev_name(&pdev->dev));
> >> +				if (ret)
> >> +					return ret;
> >> +			}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >>  =

> >>  static int atmel_spi_probe(struct platform_device *pdev)
> >>  {
> >> @@ -1577,6 +1601,10 @@ static int atmel_spi_probe(struct platform_devi=
ce *pdev)
> >>  		master->num_chipselect =3D 4;
> >>  	}
> >>  =

> >> +	ret =3D atmel_spi_gpio_cs(pdev);
> >> +	if (ret)
> >> +		goto out_unmap_regs;
> >> +
> >>  	as->use_dma =3D false;
> >>  	as->use_pdc =3D false;
> >>  	if (as->caps.has_dma_support) {
> >> -- =

> >> 2.9.0
> >>
> > =

> =

> =

> -- =

> Nicolas Ferre

-- =

Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
