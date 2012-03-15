From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH v3 6/6] mfd: mc13xxx: Add i2c driver
Date: Fri, 16 Mar 2012 07:59:20 +1100
Message-ID: <201203160759.20837.marc@cpdesign.com.au>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
	<1331757790-10583-7-git-send-email-marc@cpdesign.com.au>
	<CAM=Q2cssNF2TSWHjcbG4wsABBXhquYoKq_scC6bDcq8kdoosyQ@mail.gmail.com>
Reply-To: marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2cssNF2TSWHjcbG4wsABBXhquYoKq_scC6bDcq8kdoosyQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

> <snip>
> 
> > +static int mc13xxx_i2c_probe(struct i2c_client *client,
> > +               const struct i2c_device_id *id)
> > +{
> > +       const struct of_device_id *of_id;
> > +       struct i2c_driver *idrv = to_i2c_driver(client->dev.driver);
> > +       struct mc13xxx *mc13xxx;
> > +       struct mc13xxx_platform_data *pdata =
> > dev_get_platdata(&client->dev); +       int ret;
> > +
> > +       of_id = of_match_device(mc13xxx_dt_ids, &client->dev);
> > +       if (of_id)
> > +               idrv->id_table =
> > +                       &mc13xxx_i2c_device_id[(enum mc13xxx_id)
> > of_id->data]; +
> > +       mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
> > +       if (!mc13xxx)
> > +               return -ENOMEM;
> > +
> > +       dev_set_drvdata(&client->dev, mc13xxx);
> > +
> > +       mc13xxx->dev = &client->dev;
> > +       mutex_init(&mc13xxx->lock);
> > +
> > +       mc13xxx->regmap = regmap_init_i2c(client,
> > &mc13xxx_regmap_i2c_config); +       if (IS_ERR(mc13xxx->regmap)) {
> > +               ret = PTR_ERR(mc13xxx->regmap);
> > +               dev_err(mc13xxx->dev, "Failed to initialize register map:
> > %d\n", +                               ret);
> > +               dev_set_drvdata(&client->dev, NULL);
> 
> Are we  leaking mc13xxx here
> May be you can consider using devm* functions ?

Good catch, this also applies the spi driver as well I think.

Cheers,
Marc
------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
