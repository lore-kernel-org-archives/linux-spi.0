From: Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi & enable gpio
Date: Wed, 13 Apr 2016 09:55:09 +0200
Message-ID: <CAF+MRtkHKuN_bCXaShsnVCJ7i_P2AiM7WCdWpbS0jX2vfvrwYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

In my board, I have two component that are not enabled at the boot and
need to be enabled when the spi driver start, to do that, I had to
modify the driver spi. I would like to know if it's possible to add
this possibility for the driver ?

        /* activate child device before talking to them*/
        enable_gpio = of_get_named_gpio_flags( master->dev.of_node,
"enable-gpio", 0, &flags);
        if (gpio_is_valid(enable_gpio)) {
                dev_warn(dev,"spi found reset gpio, request gpio
%d\n", enable_gpio);
               ret = gpio_request( enable_gpio, "spi-gpio-reset");
               if (ret != 0){
                        dev_warn(dev,"spi reset gpio : failed to
request gpio\n");
                        return ret;
                }
                ret = gpio_direction_output(enable_gpio, 0);
                if (ret != 0){
                        dev_warn(dev,"spi reset gpio : failed to put
direction\n");
                        return ret;
                }
                gpio_set_value(enable_gpio, 0);
                dev_warn(dev,"spi reset gpio : set gpio to 1");
                gpio_set_value(enable_gpio, 1);
        }

michael musset,
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
