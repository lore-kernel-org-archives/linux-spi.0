From: =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: spi-sun4i: how/where to set the bus number of spi_master ?
Date: Tue, 7 Mar 2017 19:21:14 +0100
Message-ID: <d8190d82-c2bc-2ed0-79d6-d326248944aa@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi,

trying to get a TFT display working on a Banana Pi M1 board, I noticed 
that the spi-sun4i driver doesn't set the bus number of the spi_master 
(which leaves it at its default value -1).
fbtft_device driver fails to load for that reason.
What's the right fix for this ? Is this something that needs to be added 
to the boards device tree file ?

Regards,
Frank
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
