From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Subject: Re: [PATCH v2] spi/pl022: add devicetree support
Date: Tue, 26 Jun 2012 10:49:27 -0300
Message-ID: <CAAAP30HU8jyFFgzo39RozrOGvpSwVZRUkKsbJVe_ffEu27K-Fw@mail.gmail.com>
References: <1340658390-29569-1-git-send-email-aletes.xgr@gmail.com>
	<20120626060936.GA12229@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Roland Stigge <stigge@antcom.de>, linux-doc@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>,
	spi-devel-general@lists.sourceforge.net
To: Thierry Reding <thierry.reding@avionic-design.de>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20120626060936.GA12229@avionic-0098.adnet.avionic-design.de>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 26, 2012 at 3:09 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Mon, Jun 25, 2012 at 06:06:28PM -0300, Alexandre Pereira da Silva =
wrote:
> [...]
>> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> [...]
>> @@ -1733,7 +1744,7 @@ static int calculate_effective_freq(struct pl0=
22 *pl022, int freq, struct
>> =A0 * A piece of default chip info unless the platform
>> =A0 * supplies it.
>> =A0 */
>> -static const struct pl022_config_chip pl022_default_chip_info =3D {
>> +static struct pl022_config_chip pl022_default_chip_info =3D {
>> =A0 =A0 =A0 .com_mode =3D POLLING_TRANSFER,
>> =A0 =A0 =A0 .iface =3D SSP_INTERFACE_MOTOROLA_SPI,
>> =A0 =A0 =A0 .hierarchy =3D SSP_SLAVE,
>
> What's the reason for removing the const? You're only reading data fr=
om
> the structure.

I are right. I will remove this change. It was a left-over from an
older version.

> [...]
>> @@ -1998,8 +2039,14 @@ pl022_probe(struct amba_device *adev, const s=
truct amba_id *id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_no_pdata;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 num_cs =3D platform_info->num_chipselect;
>> +#ifdef CONFIG_OF
>> + =A0 =A0 of_property_read_u32(np, "pl022,num-chipselects", &num_cs)=
;
>> +#endif
>
> This...
>
> [...]
>> @@ -2017,13 +2064,40 @@ pl022_probe(struct amba_device *adev, const =
struct amba_id *id)
>> =A0 =A0 =A0 =A0* on this board
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 master->bus_num =3D platform_info->bus_id;
>> - =A0 =A0 master->num_chipselect =3D platform_info->num_chipselect;
>> + =A0 =A0 master->num_chipselect =3D num_cs;
>> =A0 =A0 =A0 master->cleanup =3D pl022_cleanup;
>> =A0 =A0 =A0 master->setup =3D pl022_setup;
>> =A0 =A0 =A0 master->prepare_transfer_hardware =3D pl022_prepare_tran=
sfer_hardware;
>> =A0 =A0 =A0 master->transfer_one_message =3D pl022_transfer_one_mess=
age;
>> =A0 =A0 =A0 master->unprepare_transfer_hardware =3D pl022_unprepare_=
transfer_hardware;
>> =A0 =A0 =A0 master->rt =3D platform_info->rt;
>> + =A0 =A0 master->dev.of_node =3D dev->of_node;
>> +
>> +#ifdef CONFIG_OF
>> + =A0 =A0 for (i =3D 0; i < num_cs; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int cs_gpio =3D of_get_named_gpio(np, "cs-=
gpios", i);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cs_gpio =3D=3D -EPROBE_DEFER) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -EPROBE_DEFER;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_no_gpio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pl022->chipselect[i] =3D cs_gpio;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(cs_gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_request(cs_gpio, =
"ssp-pl022"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&a=
dev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "could not request %d gpio\n", cs_gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (gpio_direction_ou=
tput(cs_gpio, 1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&a=
dev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "could set gpio %d as output\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 cs_gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +#else
>> + =A0 =A0 for (i =3D 0; i < num_cs; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pl022->chipselect[i] =3D -EINVAL;
>> +#endif
>
> ... and this would be good candidates for IS_ENABLED(CONFIG_OF).
>
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Supports mode 0-3, loopback, and active low CS. Tra=
nsfers are
>> @@ -2130,6 +2204,9 @@ pl022_probe(struct amba_device *adev, const st=
ruct amba_id *id)
>> =A0 err_no_ioremap:
>> =A0 =A0 =A0 amba_release_regions(adev);
>> =A0 err_no_ioregion:
>> + #ifdef CONFIG_OF
>> + err_no_gpio:
>> + #endif
>
> If you use the IS_ENABLED() macro, then you no longer need these eith=
er.

Thanks for the suggestion, looks cleaner.
