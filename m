From: =?UTF-8?Q?L=c3=a9o_Serre?= <leo-fx4xgHRsvDuU6xZXA0faPpqQE7yCjDx5@public.gmane.org>
Subject: Single SPI Protocol Driver with multiple SPI Slaves
Date: Tue, 5 Sep 2017 11:13:22 +0200
Message-ID: <faa18de5-545a-4be1-eaf0-a0374a75d7e2@naio-technologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: fr
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

I have written three SPI drivers for BMX055 sensor (accelerometer + 
gyroscope + magnetometer). It appears that in that case, it was perfect 
to write three different drivers as the different components were 
independants.

I'm now working on a driver for MRF89XA (Microchip's radio chip) that is 
composed of two SPI slaves (one for config and one for data). The device 
is attached to the driver using a Device Tree.

Is that possible to write a single driver, that works with a pair of SPI 
slaves?

Regards,

Léo Serre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
