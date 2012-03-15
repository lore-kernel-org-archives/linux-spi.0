From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 6/6] mfd: mc13xxx: Add i2c driver
Date: Thu, 15 Mar 2012 19:10:42 +0530
Message-ID: <CAM=Q2cssNF2TSWHjcbG4wsABBXhquYoKq_scC6bDcq8kdoosyQ@mail.gmail.com>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
	<1331757790-10583-7-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1331757790-10583-7-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Marc,

On Thu, Mar 15, 2012 at 2:13 AM, Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org> wrote:
> Adds support for mc13xxx family ICs connected via i2c.
>
> Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> ---
<snip>

> +static int mc13xxx_i2c_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_id *id)
> +{
> + =A0 =A0 =A0 const struct of_device_id *of_id;
> + =A0 =A0 =A0 struct i2c_driver *idrv =3D to_i2c_driver(client->dev.drive=
r);
> + =A0 =A0 =A0 struct mc13xxx *mc13xxx;
> + =A0 =A0 =A0 struct mc13xxx_platform_data *pdata =3D dev_get_platdata(&c=
lient->dev);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 of_id =3D of_match_device(mc13xxx_dt_ids, &client->dev);
> + =A0 =A0 =A0 if (of_id)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idrv->id_table =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &mc13xxx_i2c_device_id[(enu=
m mc13xxx_id) of_id->data];
> +
> + =A0 =A0 =A0 mc13xxx =3D kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> + =A0 =A0 =A0 if (!mc13xxx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 dev_set_drvdata(&client->dev, mc13xxx);
> +
> + =A0 =A0 =A0 mc13xxx->dev =3D &client->dev;
> + =A0 =A0 =A0 mutex_init(&mc13xxx->lock);
> +
> + =A0 =A0 =A0 mc13xxx->regmap =3D regmap_init_i2c(client, &mc13xxx_regmap=
_i2c_config);
> + =A0 =A0 =A0 if (IS_ERR(mc13xxx->regmap)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(mc13xxx->regmap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mc13xxx->dev, "Failed to initialize=
 register map: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_set_drvdata(&client->dev, NULL);
Are we  leaking mc13xxx here
May be you can consider using devm* functions ?

>  + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
