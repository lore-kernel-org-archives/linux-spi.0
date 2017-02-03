From: "Giuseppe Lippolis" <giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: adding si3210 driver
Date: Fri, 3 Feb 2017 08:08:11 +0100
Message-ID: <001101d27dec$47f2bd10$d7d83730$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: de
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi All,
I have a router running linux (LEDE distribution) with an embedded 3G modem
and a POTS telephone interface.
The telephone interface uses the si3210 device interfaced with the uP
through an spi IF.
The si3210 ProSLIC integrates a subscriber line interface circuit (SLIC) and
is commonly found in several router with telephone functions.

Because I was unable to find a driver for the si3210, I'm now using the
spidev interface to control the device from the userspace. 

Now I'm thinking to add a spi protocol char driver for that device.

My first question is if make sense to do this; I see other similar tentative
never embedded in the mainstream:
https://github.com/stelhs/slic_tdm
https://github.com/opennetworklinux/linux-3.8.13/tree/master/drivers/tdm/lin
e_ctrl

Second question is: What class the driver belong to? (in which drivers/
subfolder shall I add the driver)?

Thanks for the support.
Bye.



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
