From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
Date: Tue, 25 Aug 2015 13:24:20 +0200
Message-ID: <55DC5064.6050500@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com> <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com> <A765B125120D1346A63912DDE6D8B6310BF47A26@NTXXIAMBX02.xacn.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: =?UTF-8?B?IkJlYW4gSHVvIOmcjeaWjOaWjCAoYmVhbmh1byki?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	"nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org" <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	"marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>,
	"shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org" <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A765B125120D1346A63912DDE6D8B6310BF47A26-xjs9rfTec9KBtk7LW/CC8tTcztV8WXajQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi!

Le 25/08/2015 03:44, Bean Huo =E9=9C=8D=E6=96=8C=E6=96=8C (beanhuo) a =C3=
=A9crit :
>=20
>> +	nor->read_reg =3D atmel_qspi_read_reg;
>> +	nor->write_reg =3D atmel_qspi_write_reg;
>> +	nor->read =3D atmel_qspi_read;
>> +	nor->write =3D atmel_qspi_write;
>> +	nor->erase =3D atmel_qspi_erase;
>> +	nor->set_protocol =3D atmel_qspi_set_protocol;
>=20
> This is very good, the structure of spi_nor should add a hook functio=
n to notify spi controller=20
> That spi nor transfer protocol already changed.
>=20
>> +
>> +	if (of_modalias_node(child, modalias, sizeof(modalias)) < 0) {
>> +		err =3D -ENODEV;
>> +		goto release_channel;
>> +	}
>> +
>> +	err =3D of_property_read_u32(child, "spi-max-frequency", &aq->clk_=
rate);
>> +	if (err < 0)
>> +		goto release_channel;
>> +
>> +	err =3D atmel_qspi_init(aq);
>> +	if (err)
>> +		goto release_channel;
>> +
>> +	nor->dev->of_node =3D child;
>> +	err =3D spi_nor_scan(nor, modalias, SPI_NOR_QUAD);
>> 		goto release_channel;
>> +
>=20
>=20
> .......
>=20
>> static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)  =
{
>  	return mtd->priv;
>> @@ -944,6 +960,11 @@ static int micron_quad_enable(struct spi_nor *n=
or)
>> 		return ret;
>> 	}
>>
>> +	/* switch protocol to Quad CMD 4-4-4 */
>> +	ret =3D spi_nor_set_protocol(nor, SPI_PROTO_4_4_4);
>> +	if (ret)
>> +		return ret;
>> +
>=20
> This make sense,from spi nor side,once its protocol being changed,
> Mtd layer must notify this status to spi nor controller immediately,
> And spi nor controller also should re-adjust its protocol.
> Otherwise, following reading SR operation will fail.=20
>=20
>>
>> 	ret =3D spi_nor_wait_till_ready(nor);
>> 	if (ret)
>> 		return ret;
>=20
> If my ack has any value in here, feel free to add it.
>=20
> Acked-by: Bean Huo <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
>=20

Since your comments deal with the protocol change, I'll add your ack to=
 the
first patch of the series:
"mtd: spi-nor: notify (Q)SPI controller about protocol change"

Thanks for your review!

Best regards,

Cyrille

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
