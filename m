From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: Single SPI Protocol Driver with multiple SPI Slaves
Date: Wed, 6 Sep 2017 13:49:25 +0200
Message-ID: <af912d1d-a036-ebc3-5439-09a44e98f437@metafoo.de>
References: <faa18de5-545a-4be1-eaf0-a0374a75d7e2@naio-technologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?L=c3=a9o_Serre?= <leo-fx4xgHRsvDuU6xZXA0faPpqQE7yCjDx5@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <faa18de5-545a-4be1-eaf0-a0374a75d7e2-fx4xgHRsvDuU6xZXA0faPpqQE7yCjDx5@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/05/2017 11:13 AM, Léo Serre wrote:
> Hello,
> 
> I have written three SPI drivers for BMX055 sensor (accelerometer +
> gyroscope + magnetometer). It appears that in that case, it was perfect to
> write three different drivers as the different components were independants.
> 
> I'm now working on a driver for MRF89XA (Microchip's radio chip) that is
> composed of two SPI slaves (one for config and one for data). The device is
> attached to the driver using a Device Tree.
> 
> Is that possible to write a single driver, that works with a pair of SPI
> slaves?

There are currently no facilities in the kernel to do this. I've have had a
similar problem with a different driver and given this some thought.

Conceptually I think the best approach is to have something like
i2c_new_dummy() that creates a second slave device with a different address
for an existing device.

The main issue with implementing this is the global spi_add_lock mutex which
prevents a SPI device from being created from within the probe() callback of
another SPI device.

The lock is used to prevent two SPI devices with the same chip-select being
registered on the same master concurrently and overwriting each others
configuration.

One way to remove the need for the lock could be to use a per master atomic
bitmap that keeps track of the chip-selects that are in use. But this would
require some additional memory in the spi_master struct.

- Lars
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
