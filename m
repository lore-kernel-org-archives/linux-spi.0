From: Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] spi: add spi multiplexing functions for dt
Date: Wed, 24 Jan 2018 14:01:55 +0000
Message-ID: <CAF3==it=5_YQVJ9xg8CLzSPw7LQZbCHQHfsufYwwCb=n7x3L0g@mail.gmail.com>
References: <1516661472-16452-1-git-send-email-ben.whitten@gmail.com>
 <1516661472-16452-2-git-send-email-ben.whitten@gmail.com> <20180123111123.GB7600@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180123111123.GB7600-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 23 January 2018 at 11:11, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jan 22, 2018 at 10:51:12PM +0000, Ben Whitten wrote:
>
>> Like I2C busses SPI devices can also sit behind multiplexers.
>> This patch adds is based off the I2C implementation and allows
>> description in the devicetree.
>
> Why is this not sitting at either the chip select level or just having
> the individual devices be SPI controllers?
In the situation I have, the end devices are not attached to an SPI bus
that attaches to the host so I dont think I could just override the hosts
chip select.
This module is a set of helpers for my 'mux' SPI device to register itself
as a series of SPI controllers, one for each bus leaf. It could also have
been just one SPI controller using its own chip select to switch busses,
but I used the design patern from I2C.

>>  drivers/spi/Makefile    |   3 +
>>  drivers/spi/spi-mux.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/spi-mux.h |  55 +++++++++++++++
>>  4 files changed, 249 insertions(+)
>>  create mode 100644 drivers/spi/spi-mux.c
>>  create mode 100644 include/linux/spi-mux.h
>
> No binding documentation...
Appologies, will be included in the next itteration.
Essentially it's presented like this in DT, where my-mux is a device using
the controller registration helpers in this module;
my-mux: muxdevice@0 {

    spi@0 {

        muxed-devices@0 {
              .....
        };
    };

    spi@1 {
        .......
    };
};

>> +static int spi_mux_transfer_one_message(struct spi_controller *controller,
>> +                                     struct spi_message *msg)
>> +{
>> +     struct spi_mux_priv *priv = spi_controller_get_devdata(controller);
>> +     struct spi_mux_core *muxc = priv->muxc;
>> +     struct spi_device *spi = to_spi_device(muxc->dev);
>> +     int ret;
>> +
>> +     ret = muxc->select(muxc, priv->chan_id);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     /* If we have a custom transfer, use it */
>> +     if (muxc->transfer_one_message)
>> +             ret = muxc->transfer_one_message(controller, msg);
>> +     else
>> +             ret = spi_sync(spi, msg);
>> +
>> +     if (muxc->deselect)
>> +             muxc->deselect(muxc, priv->chan_id);
>
> This all looks pretty much like the normal set of controller operations
> but perhaps I'm missing something - the only extra thing I'm seeing is
> an ability to have something sitting in front of the chip select lines
> which seems like it'd be more effective if implemented directly at that
> level.  Things that have their own transfer function would be better off
> just being first order SPI controllers I think so that they get access
> to everything the framework offers and can correctly advertise
> capabilities and so on.
This runs as a very simple fake SPI controller per bus that the mux is
controlling. Having this custom transfer message allowed me to pop
in the way my device exposes the downstream devices, through its
regmap.
However if a mux device didn't register a custom transfer with this module
then it will select the downstream bus then pass the message back to the
host SPI for transfer.

>> +
>> +     return ret;
>> +}
>> +
>> +static int spi_mux_add_controller(struct spi_mux_core *muxc, u32 chan_id)
>> +{
>> +     struct spi_controller *controller;
>> +     struct spi_mux_priv *priv;
>> +     int ret;
>> +
>> +     if (muxc->num_controllers >= muxc->max_controllers) {
>> +             dev_err(muxc->dev, "No room for more spi-mux controllers");
>> +             return -EINVAL;
>> +     }
>> +
>> +     controller = spi_alloc_master(muxc->dev, sizeof(*priv));
>> +     if (!controller)
>> +             return -ENOMEM;
>> +     priv = spi_controller_get_devdata(controller);
>> +
>> +     /* Setup private controller data */
>> +     priv->muxc = muxc;
>> +     priv->controller = controller;
>> +     priv->chan_id = chan_id;
>> +
>> +     priv->controller->transfer_one_message = spi_mux_transfer_one_message;
>> +
>> +     /* Look for the child of this controller */
>> +     if (muxc->dev->of_node) {
>> +             struct device_node *dev_node = muxc->dev->of_node;
>> +             struct device_node *mux_node, *child = NULL;
>> +             u32 reg;
>> +
>> +             mux_node = of_get_child_by_name(dev_node, "spi-mux");
>> +             if (!mux_node)
>> +                     mux_node = of_node_get(dev_node);
>> +
>> +             for_each_child_of_node(mux_node, child) {
>> +                     ret = of_property_read_u32(child, "reg", &reg);
>> +                     if (ret)
>> +                             continue;
>> +                     if (chan_id == reg)
>> +                             break;
>> +             }
>> +
>> +             priv->controller->dev.of_node = child;
>> +             of_node_put(mux_node);
>> +     }
>> +
>> +     ret = devm_spi_register_controller(muxc->dev, priv->controller);
>> +     if (ret) {
>> +             spi_controller_put(priv->controller);
>> +             dev_err(muxc->dev, "Problem registering spi controller: %d\n",
>> +                     ret);
>> +             return ret;
>> +     }
>> +
>> +     muxc->controller[muxc->num_controllers++] = priv->controller;
>> +
>> +     return ret;
>> +}
>> +
>> +static void spi_mux_del_controllers(struct spi_mux_core *muxc)
>> +{
>> +     struct spi_controller *controller =
>> +         muxc->controller[--muxc->num_controllers];
>> +     struct device_node *np = controller->dev.of_node;
>> +
>> +     muxc->controller[muxc->num_controllers] = NULL;
>> +     of_node_put(np);
>> +}
>> +
>> +static void devm_spi_mux_del_controllers(struct device *dev, void *res)
>> +{
>> +     spi_mux_del_controllers(*(struct spi_mux_core **)res);
>> +}
>> +
>> +int devm_spi_mux_add_controller(struct spi_mux_core *muxc, u32 chan_id)
>> +{
>> +     struct spi_mux_core **ptr;
>> +     int ret;
>> +
>> +     ptr = devres_alloc(devm_spi_mux_del_controllers, sizeof(*ptr),
>> +                        GFP_KERNEL);
>> +     if (!ptr)
>> +             return -ENOMEM;
>> +
>> +     ret = spi_mux_add_controller(muxc, chan_id);
>> +     if (!ret) {
>> +             *ptr = muxc;
>> +             devres_add(muxc->dev, ptr);
>> +     } else {
>> +             devres_free(ptr);
>> +     }
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_spi_mux_add_controller);
>> +
>> +MODULE_AUTHOR("Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
>> +MODULE_DESCRIPTION("SPI driver for multiplexed SPI busses");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/spi-mux.h b/include/linux/spi-mux.h
>> new file mode 100644
>> index 0000000..5978f86
>> --- /dev/null
>> +++ b/include/linux/spi-mux.h
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for an SPI multiplexer
>> + *
>> + * Copyright (c) 2018   Ben Whitten
>> + */
>> +
>> +#ifndef _LINUX_SPI_MUX_H_
>> +#define _LINUX_SPI_MUX_H_
>> +
>> +#ifdef __KERNEL__
>> +
>> +struct spi_mux_core {
>> +     struct spi_controller *parent;
>> +     struct device *dev;
>> +
>> +     void *priv;
>> +
>> +     int (*select)(struct spi_mux_core *, u32 chan_id);
>> +     int (*deselect)(struct spi_mux_core *, u32 chan_id);
>> +     int (*transfer_one_message)(struct spi_controller *controller,
>> +                                 struct spi_message *msg);
>> +
>> +     int num_controllers;
>> +     int max_controllers;
>> +     struct spi_controller *controller[0];
>> +};
>> +
>> +struct spi_mux_core *spi_mux_alloc(struct spi_controller *parent,
>> +                                struct device *dev,
>> +                                int max_controllers,
>> +                                int sizeof_priv,
>> +                                int (*select)(struct spi_mux_core *, u32),
>> +                                int (*deselect)(struct spi_mux_core *, u32),
>> +                                int (*transfer_one_message)
>> +                                     (struct spi_controller *controller,
>> +                                      struct spi_message *msg));
>> +
>> +static inline void *spi_mux_priv(struct spi_mux_core *muxc)
>> +{
>> +     return muxc->priv;
>> +}
>> +
>> +u32 spi_mux_get_chan_id(struct spi_controller *controller);
>> +
>> +/*
>> + * Called to create an spi bus on a multiplexed bus segment.
>> + * The chan_id parameter is passed to the select and deselect
>> + * callback functions to perform hardware-specific mux control.
>> + */
>> +int devm_spi_mux_add_controller(struct spi_mux_core *muxc, u32 chan_id);
>> +
>> +#endif /* __KERNEL__ */
>> +
>> +#endif /* _LINUX_SPI_MUX_H_ */
>> --
>> 2.7.4
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
